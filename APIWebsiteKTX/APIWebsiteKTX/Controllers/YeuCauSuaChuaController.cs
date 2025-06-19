
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
                    && hd.TrangThai == "Đang Sử Dụng"
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
        [HttpPost("cancel")]
        public async Task<ActionResult<CancelRepairResponse>> CancelRepairRequest([FromBody] CancelRepairRequest request)
        {
            // Kiểm tra request hợp lệ
            if (string.IsNullOrEmpty(request.MaSV) || request.MaYCSC <= 0)
            {
                return BadRequest(new CancelRepairResponse
                {
                    Success = false,
                    Message = "Mã sinh viên hoặc mã yêu cầu sửa chữa không hợp lệ."
                });
            }

            // Tìm yêu cầu sửa chữa
            var repairRequest = await _context.YeuCauSuaChua
                .FirstOrDefaultAsync(y => y.MaYCSC == request.MaYCSC && y.MaSV == request.MaSV);

            if (repairRequest == null)
            {
                return NotFound(new CancelRepairResponse
                {
                    Success = false,
                    Message = "Không tìm thấy yêu cầu sửa chữa hoặc yêu cầu không thuộc sinh viên này."
                });
            }

            // Kiểm tra trạng thái yêu cầu
            if (repairRequest.TrangThai != "Chờ xử lý")
            {
                return BadRequest(new CancelRepairResponse
                {
                    Success = false,
                    Message = "Yêu cầu sửa chữa không thể hủy vì đã được xử lý hoặc đã hủy."
                });
            }

            // Cập nhật trạng thái thành "Đã hủy"
            repairRequest.TrangThai = "Đã hủy";
            _context.YeuCauSuaChua.Update(repairRequest);

            // Xóa các bản ghi trong ChiTietSuaChua liên quan
            var repairDetails = _context.ChiTietSuaChua.Where(c => c.MaYCSC == request.MaYCSC); 
            _context.ChiTietSuaChua.RemoveRange(repairDetails);

            // Lưu thay đổi vào cơ sở dữ liệu
            await _context.SaveChangesAsync();

            return Ok(new CancelRepairResponse
            {
                Success = true,
                Message = "Yêu cầu sửa chữa đã được hủy thành công."
            });
        }
        [HttpGet("list/{maSV}")]
        public async Task<ActionResult<IEnumerable<RepairRequestResponse>>> GetRepairRequests(string maSV)
        {
            if (string.IsNullOrEmpty(maSV))
            {
                return BadRequest("Mã sinh viên không hợp lệ.");
            }

            // Lấy danh sách yêu cầu sửa chữa và chi tiết
            var repairRequests = await (
                from ycsc in _context.YeuCauSuaChua
                where ycsc.MaSV == maSV
                select new RepairRequestResponse
                {
                    MaYCSC = ycsc.MaYCSC,
                    MaPhong = ycsc.MaPhong,
                    MoTa = ycsc.MoTa,
                    NgayGui = ycsc.NgayGui,
                    TrangThai = ycsc.TrangThai,
                    MaNV = ycsc.MaNV,
                    ChiTietSuaChua = (
                        from ctsc in _context.ChiTietSuaChua
                        where ctsc.MaYCSC == ycsc.MaYCSC
                        select new RepairDetailResponse
                        {
                            MaChiTiet = ctsc.MaChiTiet,
                            MaThietBi = ctsc.MaThietBi,
                            MoTaLoi = ctsc.MoTaLoi
                        }).ToList()
                }).ToListAsync();

            if (!repairRequests.Any())
            {
                return NotFound("Không tìm thấy yêu cầu sửa chữa nào của sinh viên này.");
            }

            return Ok(repairRequests);
        }
    }
}
