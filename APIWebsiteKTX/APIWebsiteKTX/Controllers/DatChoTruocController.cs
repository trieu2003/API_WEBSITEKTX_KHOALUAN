
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


        [HttpPost("dat-cho")]
        public async Task<IActionResult> DatChoTruoc([FromBody] DatChoTruocRequestDTO request)
        {
            try
            {
                // Validate đầu vào
                if (request == null || string.IsNullOrEmpty(request.MaSV) || string.IsNullOrEmpty(request.SDT) || string.IsNullOrEmpty(request.HanDat))
                {
                    return BadRequest(new { message = "Dữ liệu không hợp lệ." });
                }

                // Khởi tạo thông tin đặt chỗ mới
                var datCho = new DatChoTruoc
                {
                    MaSV = request.MaSV,
                    SDT = request.SDT,
                    Email = request.Email,
                    MaChiTietPhong = null, // chưa chỉ định giường
                    NgayDat = DateTime.Today,
                    HanDat = request.HanDat,
                    TrangThai = "Đang chờ xác nhận"
                };

                // Lưu vào database
                _context.DatChoTruoc.Add(datCho);
                await _context.SaveChangesAsync();

                return Ok(new { message = "Đặt chỗ thành công.", maDatCho = datCho.MaDatCho });
            }
            catch (Exception ex)
            {
                var inner = ex.InnerException?.Message;

                return StatusCode(500, new
                {
                    message = "Lỗi hệ thống.",
                    error = ex.Message,
                    innerError = inner
                });
            }
        }

    }
}
