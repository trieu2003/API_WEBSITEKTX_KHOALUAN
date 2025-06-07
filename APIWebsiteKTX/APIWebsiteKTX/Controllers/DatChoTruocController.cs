
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata;
using System.Text.RegularExpressions;
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


        [HttpPost("dat-cho")]
        public async Task<IActionResult> DatChoTruoc([FromBody] DatChoTruocRequestDTO request)
        {
            try
            {
                if (request == null || string.IsNullOrEmpty(request.MaSV)
                    || string.IsNullOrEmpty(request.SDT)
                    || string.IsNullOrEmpty(request.Email)
                    || string.IsNullOrEmpty(request.HanDat))
                {
                    return BadRequest(new { message = "Dữ liệu không hợp lệ." });
                }

                var sinhVien = await _context.SinhVien
                    .FirstOrDefaultAsync(sv => sv.MaSV == request.MaSV
                                            && sv.SDT == request.SDT
                                            && sv.Email == request.Email);

                if (sinhVien == null)
                {
                    return NotFound(new { message = "Không tìm thấy sinh viên với thông tin đã cung cấp." });
                }

                // --- Bước 1: Lấy đặt chỗ trước của sinh viên có trạng thái "Chờ duyệt"
                var datChoHienTai = await _context.DatChoTruoc
                    .Where(dc => dc.MaSV == request.MaSV && dc.TrangThai == "Chờ duyệt")
                    .OrderByDescending(dc => dc.HanDat) // ưu tiên hạn đặt mới nhất
                    .FirstOrDefaultAsync();

                // --- Bước 2: Kiểm tra hạn đặt có còn hiệu lực không
                if (datChoHienTai != null)
                {
                    // Lấy hạn đặt kiểu string từ DB, giả sử HanDat kiểu DateTime (nếu vẫn giữ string, parse như dưới)
                    // Nếu HanDat là DateTime? thì so sánh luôn
                    if (datChoHienTai.HanDat.HasValue && datChoHienTai.HanDat.Value >= DateTime.Today)
                    {
                        return BadRequest(new { message = "Sinh viên đã có một yêu cầu đặt chỗ còn hiệu lực đến " + datChoHienTai.HanDat.Value.ToString("dd/MM/yyyy") + " Vui lòng hủy hoặc chờ hết hạn." });
                    }
                }

                // --- Bước 3: Xử lý chuyển "HanDat" dạng string sang DateTime
                var ngayHanDat = ParseHanDatTuChuoi(request.HanDat);

                if (ngayHanDat == null)
                {
                    return BadRequest(new { message = "Hạn đặt không hợp lệ. Vui lòng nhập định dạng như: '3 tháng', '2 tuần', '10 ngày'." });
                }

                var datCho = new DatChoTruoc
                {
                    MaSV = request.MaSV,
                    MaChiTietPhong = null,
                    NgayDat = DateTime.Today,
                    HanDat = ngayHanDat.Value,
                    TrangThai = "Chờ duyệt"
                };

                _context.DatChoTruoc.Add(datCho);
                await _context.SaveChangesAsync();

                return Ok(new { message = "Đặt chỗ thành công.", maDatCho = datCho.MaDatCho });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ nhân viên.",
                    error = ex.Message,
                    innerError = ex.InnerException?.Message
                });
            }
        }



        private DateTime? ParseHanDatTuChuoi(string hanDat)
        {
            if (string.IsNullOrEmpty(hanDat)) return null;

            hanDat = hanDat.Trim().ToLower();

            var today = DateTime.Today;

            // Regex để tách số và đơn vị
            var match = System.Text.RegularExpressions.Regex.Match(hanDat, @"(\d+)\s*(ngày|tuần|tháng)");

            if (!match.Success)
                return null;

            int soLuong = int.Parse(match.Groups[1].Value);
            string donVi = match.Groups[2].Value;

            return donVi switch
            {
                "ngày" => today.AddDays(soLuong),
                "tuần" => today.AddDays(soLuong * 7),
                "tháng" => today.AddMonths(soLuong),
                _ => null
            };
        }




    }
}
