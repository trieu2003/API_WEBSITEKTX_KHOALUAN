
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
    public class HopDongNoiTruController : ControllerBase
    {
        private readonly KTXContext _context;

        public HopDongNoiTruController(KTXContext context)
        {
            _context = context;
        }
        // ràng buộc ngày kết thúc nhỏ hơn hoặc bằng 1 năm kể từ ngày kết thúc đăng ký hợp đồng
        [HttpPost("DangKyHopDong")]
        public async Task<IActionResult> DangKyHopDong([FromBody] HopDongNoiTruRequest model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            // Gán ngày đăng ký và ngày bắt đầu nếu chưa có
            model.NgayDangKy ??= DateTime.Now;
            model.NgayBatDau ??= DateTime.Now;

            // Kiểm tra ràng buộc ngày kết thúc >= 1 năm so với ngày đăng ký
            if (model.NgayKetThuc.HasValue)
            {
                var khoangCach = model.NgayKetThuc.Value - model.NgayDangKy.Value;
                if (khoangCach.TotalDays < 365)
                {
                    return BadRequest(new
                    {
                        message = "Ngày kết thúc phải cách ít nhất 1 năm so với ngày đăng ký."
                    });
                }
            }

            try
            {
                var hopDong = new HopDongNoiTru
                {
                    MaSV = model.MaSV,
                    MaGiuong = model.MaGiuong,
                    MaPhong = model.MaPhong,
                    NgayDangKy = model.NgayDangKy.Value,
                    NgayBatDau = model.NgayBatDau.Value,
                    NgayKetThuc = model.NgayKetThuc,
                    DotDangKy = model.DotDangKy,
                    NhomTruong = model.NhomTruong,
                    TrangThai = model.TrangThai ?? "Chưa duyệt",
                    TrangThaiDuyet = model.TrangThaiDuyet ?? "Chờ duyệt",
                    PhuongThucThanhToan = model.PhuongThucThanhToan,
                    MinhChungThanhToan = model.MinhChungThanhToan,// khúc này cho thể cho sinh viên upload file minh chứng thanh toán hoặc để thanh toán sau
                    MaNamHoc = model.MaNamHoc
                };

                _context.HopDongNoiTru.Add(hopDong);
                await _context.SaveChangesAsync();

                return Ok(new { message = "Đăng ký hợp đồng thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Đã xảy ra lỗi",
                    error = ex.InnerException?.Message ?? ex.Message
                });
            }
        }


        // r 
        [HttpPost("GiaHanHopDong")]
        public async Task<IActionResult> ExtendContract([FromBody] ExtendContractRequestDto request)
        {
            // Validate input
            if (request == null)
            {
                return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
            }

            // Check if student exists and has a valid contract
            var hopDong = await _context.HopDongNoiTru
                .Where(hd => hd.MaSV == request.MaSV
                    && hd.TrangThaiDuyet == "Đã duyệt"
                    && hd.TrangThai != "Đã kết thúc"
                    && hd.NgayBatDau <= DateTime.Today)
                .Include(hd => hd.Phong)
                .FirstOrDefaultAsync();

            if (hopDong == null)
            {
                return BadRequest(new { message = "Sinh viên không có hợp đồng nội trú hợp lệ." });
            }

            // Check if contract is within the allowed extension period (e.g., within 30 days after NgayKetThuc)
            var maxExtensionDate = hopDong.NgayKetThuc?.AddDays(30) ?? DateTime.MaxValue;
            if (DateTime.Today > maxExtensionDate)
            {
                return BadRequest(new { message = "Hợp đồng đã hết hạn và không thể gia hạn. Vui lòng đăng ký nội trú mới." });
            }

            // Validate new end date
            if (request.NgayKetThucMoi <= DateTime.Today)
            {
                return BadRequest(new { message = "Thời gian gia hạn không hợp lệ. Vui lòng nhập lại thời gian phù hợp." });
            }

            // Check maximum extension period (e.g., 6 months)
            var maxExtensionPeriod = hopDong.NgayKetThuc?.AddMonths(6) ?? DateTime.MaxValue;
            if (request.NgayKetThucMoi > maxExtensionPeriod)
            {
                return BadRequest(new { message = "Thời gian gia hạn vượt quá giới hạn tối đa (6 tháng)." });
            }

            // Check room availability
            var phong = await _context.Phong
                .Where(p => p.MaPhong == hopDong.MaPhong)
                .FirstOrDefaultAsync();

            if (phong == null || phong.TrangThai == "Đã đủ chỗ" || phong.TrangThai == "Đang sửa chữa")
            {
                return BadRequest(new { message = "Phòng hiện không khả dụng để gia hạn. Vui lòng liên hệ nhân viên." });
            }

            // Validate MaNamHoc
            var namHoc = await _context.NamHoc
                .Where(nh => nh.MaNamHoc == request.MaNamHoc)
                .FirstOrDefaultAsync();

            if (namHoc == null)
            {
                return BadRequest(new { message = "Mã năm học không hợp lệ." });
            }

            // Update contract
            hopDong.NgayKetThuc = request.NgayKetThucMoi;
            hopDong.TrangThaiDuyet = "Chờ duyệt";
            hopDong.TrangThai = string.IsNullOrEmpty(request.PhuongThucThanhToan) ? hopDong.TrangThai : "Chờ Thanh Toán";
            hopDong.PhuongThucThanhToan = request.PhuongThucThanhToan ?? hopDong.PhuongThucThanhToan;
            hopDong.DotDangKy = request.DotDangKy ?? hopDong.DotDangKy;
            hopDong.MaNamHoc = request.MaNamHoc;
            hopDong.MaNV = null;

            await _context.SaveChangesAsync();

            return Ok(new { message = "Yêu cầu gia hạn đã được gửi thành công và đang chờ duyệt." });
        }
        
    }
}
