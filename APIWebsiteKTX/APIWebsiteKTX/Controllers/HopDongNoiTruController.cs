﻿
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
        [HttpPost("DangKyHopDong")]
        public async Task<IActionResult> DangKyHopDong([FromBody] HopDongNoiTruRequest model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var ngayDangKy = DateTime.Now;
            var ngayBatDau = ngayDangKy;

            // ✅ Tự động xác định DotDangKy theo tháng
            string dotDangKy;
            int thang = ngayDangKy.Month;
            if (thang >= 9 && thang <= 12)
                dotDangKy = "Học kỳ 1";
            else if (thang >= 1 && thang <= 6)
                dotDangKy = "Học kỳ 2";
            else
                dotDangKy = "Học kỳ hè";

            // ✅ Lấy mã năm học từ bảng NamHoc dựa trên năm hiện tại
            string maNamHoc = "NH" + ngayDangKy.Year;
            var namHoc = await _context.NamHoc.FirstOrDefaultAsync(n => n.MaNamHoc == maNamHoc);
            if (namHoc == null)
            {
                return BadRequest(new
                {
                    message = $"Không tìm thấy mã năm học '{maNamHoc}' trong hệ thống."
                });
            }

            try
            {
                var hopDong = new HopDongNoiTru
                {
                    MaSV = model.MaSV,
                    MaGiuong = model.MaGiuong,
                    MaPhong = model.MaPhong,
                    NgayDangKy = ngayDangKy,
                    NgayBatDau = ngayBatDau,
                    NgayKetThuc = ngayBatDau.AddYears(1),
                    DotDangKy = dotDangKy,
                    NhomTruong = null,
                    TrangThai = "Chưa duyệt",
                    TrangThaiDuyet = "Chờ duyệt",
                    MaNamHoc = maNamHoc
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
            if (request == null)
            {
                return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
            }

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
            //sau 30 ngày nếu hợp đồng đã kết thúc thì không thể gia hạn
            var maxExtensionDate = hopDong.NgayKetThuc?.AddDays(30) ?? DateTime.MaxValue;
            if (DateTime.Today > maxExtensionDate)
            {
                return BadRequest(new { message = "Hợp đồng đã hết hạn và không thể gia hạn. Vui lòng đăng ký nội trú mới." });
            }
            //thời gian gia hạn phải lớn hơn ngày kết thúc hiện tại
            if (request.NgayKetThucMoi <= DateTime.Today)
            {
                return BadRequest(new { message = "Thời gian gia hạn không hợp lệ. Vui lòng nhập lại." });
            }
            //thời gian gia hạn không được vượt quá 12 tháng kể từ ngày kết thúc hiện tại
            var maxExtensionPeriod = hopDong.NgayKetThuc?.AddMonths(12) ?? DateTime.MaxValue;
            if (request.NgayKetThucMoi > maxExtensionPeriod)
            {
                return BadRequest(new { message = "Thời gian gia hạn vượt quá giới hạn tối đa (12 tháng)." });
            }
            //không thể gia hạn nếu phòng đã đủ chỗ hoặc đang sửa chữa
            var phong = hopDong.Phong;
            if (phong == null || phong.TrangThai == "Đã đủ chỗ" || phong.TrangThai == "Đang sửa chữa")
            {
                return BadRequest(new { message = "Phòng hiện không khả dụng để gia hạn." });
            }

            // Tự động gán Mã năm học và Đợt đăng ký
            var currentYear = DateTime.Now.Year;
            var dotDangKy = DateTime.Now.Month switch
            {
                >= 9 and <= 12 => "Học kỳ 1",
                >= 1 and <= 6 => "Học kỳ 2",
                _ => "Học kỳ hè"
            };
            var maNamHoc = $"NH{currentYear}";

            // Kiểm tra mã năm học tồn tại
            var namHoc = await _context.NamHoc
                .FirstOrDefaultAsync(nh => nh.MaNamHoc == maNamHoc);
            if (namHoc == null)
            {
                return BadRequest(new { message = $"Mã năm học '{maNamHoc}' không tồn tại trong hệ thống." });
            }

            // Cập nhật hợp đồng
            hopDong.NgayKetThuc = request.NgayKetThucMoi;
            hopDong.TrangThaiDuyet = "Chờ duyệt";
            hopDong.TrangThai = "Chờ Thanh Toán";
            hopDong.DotDangKy = dotDangKy;
            hopDong.MaNamHoc = maNamHoc;
            hopDong.MaNV = null; // reset người duyệt

            await _context.SaveChangesAsync();

            return Ok(new { message = "Yêu cầu gia hạn đã được gửi thành công và đang chờ duyệt." });
        }


    }
}
