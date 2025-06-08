using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SinhVienController : ControllerBase
    {
        private readonly KTXContext _context;

        public SinhVienController(KTXContext context)
        {
            _context = context;
        }
        [HttpPut("cap-nhat")]
        public async Task<IActionResult> CapNhatSinhVien([FromBody] SinhVienRequestDTO request)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(request.MaSV))
                {
                    return BadRequest(new { message = "Mã sinh viên không hợp lệ." });
                }

                var sinhVien = await _context.SinhVien
                    .FirstOrDefaultAsync(sv => sv.MaSV == request.MaSV);

                if (sinhVien == null)
                {
                    return NotFound(new { message = "Không tìm thấy sinh viên." });
                }

                // Chỉ cập nhật các trường được cho phép
                sinhVien.SDT = request.SDT ?? sinhVien.SDT;
                sinhVien.Email = request.Email ?? sinhVien.Email;
                sinhVien.SDTGiaDinh = request.SDTGiaDinh ?? sinhVien.SDTGiaDinh;

                await _context.SaveChangesAsync();

                return Ok(new { message = "Cập nhật thông tin sinh viên thành công." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi hệ thống.",
                    error = ex.Message,
                    inner = ex.InnerException?.Message
                });
            }
        }


    }
}
