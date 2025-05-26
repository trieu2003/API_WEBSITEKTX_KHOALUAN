
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
    public class DatChoTruocController : ControllerBase
    {
        private readonly KTXContext _context;

        public DatChoTruocController(KTXContext context)
        {
            _context = context;
        }

        // done  chưa chốt
        [HttpPost("DatChoTruoc")]
        public async Task<IActionResult> ReserveDormitory([FromBody] DatChoTruocRequestDTO request)
        {
            // Validate input
            if (request == null)
            {
                return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
            }

            // Validate student
            var sinhVien = await _context.SinhVien
                .Where(sv => sv.MaSV == request.MaSV && sv.MaKhoa != null)
                .FirstOrDefaultAsync();

            if (sinhVien == null)
            {
                return BadRequest(new { message = "Sinh viên không thuộc trường, không thể đặt chỗ trước." });
            }

            // Validate stay period
            if (request.HanDat <= DateTime.Today)
            {
                return BadRequest(new { message = "Hạn đặt không hợp lệ. Vui lòng chọn ngày trong tương lai." });
            }

            // Validate MaChiTietPhong if provided
            //if (request.MaChiTietPhong.HasValue)
            //{
            //    var chiTietPhong = await _context.ChiTietPhong
            //        .Where(ctp => ctp.MaChiTietPhong == request.MaChiTietPhong && ctp.Giuong == "Trống")
            //        .Include(ctp => ctp.Phong)
            //        .FirstOrDefaultAsync();

            //    if (chiTietPhong == null)
            //    {
            //        return BadRequest(new { message = "Giường không khả dụng hoặc không tồn tại." });
            //    }

            //    if (chiTietPhong.Phong.TrangThai == "Đã đủ chỗ" || chiTietPhong.Phong.TrangThai == "Đang sửa chữa")
            //    {
            //        return BadRequest(new { message = "Phòng không khả dụng để đặt chỗ trước." });
            //    }
            //}

            // Create reservation
            var datChoTruoc = new DatChoTruoc
            {
                MaSV = request.MaSV,
                MaChiTietPhong = request.MaChiTietPhong,
                NgayDat = DateTime.Today,
                HanDat = request.HanDat,
                TrangThai = "Chờ xác nhận"
            };

            _context.DatChoTruoc.Add(datChoTruoc);
            await _context.SaveChangesAsync();

            // Optional: Send email notification (implementation omitted for brevity)
            return Ok(new { message = "Yêu cầu đặt chỗ trước đã được gửi thành công và đang chờ xử lý." });
        }
    }
}
