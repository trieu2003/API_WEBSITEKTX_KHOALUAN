
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class YeuCauSuaChuaController : ControllerBase
    {
        private readonly KTXContext _context;

        public YeuCauSuaChuaController(KTXContext context)
        {
            _context = context;
        }

        [HttpPost("submit")]
        public async Task<IActionResult> SubmitRepairRequest([FromBody] RepairRequestDTO request)
        {
            if (request == null || request.ChiTietSuaChua == null || !request.ChiTietSuaChua.Any())
            {
                return BadRequest(new { message = "Vui lòng chọn ít nhất một thiết bị cần sửa chữa." });
            }

            // Validate MoTaLoi for each repair detail
            if (request.ChiTietSuaChua.Any(ct => string.IsNullOrWhiteSpace(ct.MoTaLoi)))
            {
                return BadRequest(new { message = "Vui lòng nhập nội dung mô tả lỗi cho thiết bị." });
            }

            // Check if student exists and has a valid contract
            var hopDong = await _context.HopDongNoiTru
                .Where(hd => hd.MaSV == request.MaSV
                    && hd.TrangThaiDuyet == "Đã duyệt"
                    && hd.TrangThai == "Đang sử dụng"
                    && hd.NgayBatDau <= DateTime.Today
                    && (hd.NgayKetThuc == null || hd.NgayKetThuc >= DateTime.Today))
                .FirstOrDefaultAsync();

            if (hopDong == null)
            {
                return BadRequest(new { message = "Sinh viên không có hợp đồng nội trú hợp lệ." });
            }

            // Validate equipment belongs to the student's room
            var chiTietPhong = await _context.ChiTietPhong
                .Where(ctp => ctp.MaPhong == hopDong.MaPhong)
                .Select(ctp => ctp.MaThietBi)
                .ToListAsync();

            var invalidThietBi = request.ChiTietSuaChua
                .Where(ct => !chiTietPhong.Contains(ct.MaThietBi))
                .Select(ct => ct.MaThietBi)
                .ToList();

            if (invalidThietBi.Any())
            {
                return BadRequest(new { message = $"Thiết bị {string.Join(", ", invalidThietBi)} không thuộc phòng của bạn, vui lòng chọn lại." });
            }

            // Validate equipment status
            var thietBi = await _context.TrangThietBi
                .Where(tb => request.ChiTietSuaChua.Select(ct => ct.MaThietBi).Contains(tb.MaThietBi))
                .ToListAsync();

            var invalidStatus = thietBi
                .Where(tb => tb.TrangThai == "Hỏng hoàn toàn" || tb.TrangThai == "Đã loại bỏ")
                .Select(tb => tb.MaThietBi)
                .ToList();

            if (invalidStatus.Any())
            {
                return BadRequest(new { message = $"Thiết bị {string.Join(", ", invalidStatus)} không thể sửa chữa do trạng thái không hợp lệ." });
            }

            // Create new repair request
            var yeuCauSuaChua = new YeuCauSuaChua
            {
                MaSV = request.MaSV,
                MaPhong = hopDong.MaPhong,
                MoTa = request.MoTa,
                NgayGui = DateTime.Today,
                TrangThai = "Chờ xử lý",
                MaNV = null
            };

            _context.YeuCauSuaChua.Add(yeuCauSuaChua);
            await _context.SaveChangesAsync();

            // Add repair details
            foreach (var chiTiet in request.ChiTietSuaChua)
            {
                var chiTietSuaChua = new ChiTietSuaChua
                {
                    MaYCSC = yeuCauSuaChua.MaYCSC,
                    MaThietBi = chiTiet.MaThietBi,
                    MoTaLoi = chiTiet.MoTaLoi
                };
                _context.ChiTietSuaChua.Add(chiTietSuaChua);
            }

            await _context.SaveChangesAsync();

            return Ok(new { message = "Yêu cầu sửa chữa đã được gửi thành công và đang chờ xử lý." });
        }
    }
}
