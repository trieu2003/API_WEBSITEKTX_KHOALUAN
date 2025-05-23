using Microsoft.AspNetCore.Mvc;
using APIWebsiteKTX.Models;
using Microsoft.EntityFrameworkCore;
using APIWebsiteKTX.Data;
using Microsoft.AspNetCore.Identity.Data;
using KTXApi.DTO;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly KTXContext _context;

        public AuthController(KTXContext context)
        {
            _context = context;
        }
        [HttpPost("update-passwords")]
        public async Task<IActionResult> UpdatePasswords()
        {
            var users = await _context.NguoiDung
                .Where(u => u.VaiTro == "Sinh viên")
                .ToListAsync();

            foreach (var user in users)
            {
                // Check if MatKhau is not a valid BCrypt hash
                if (!user.MatKhau.StartsWith("$2a$") && !user.MatKhau.StartsWith("$2b$") && !user.MatKhau.StartsWith("$2y$"))
                {
                    // Assume MatKhau is plaintext and rehash it
                    user.MatKhau = BCrypt.Net.BCrypt.HashPassword(user.MatKhau);
                }
            }

            await _context.SaveChangesAsync();
            return Ok(new { message = "Passwords updated successfully" });
        }
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequestDTO request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // Find user in NguoiDung table and check role
            var user = await _context.NguoiDung
                .FirstOrDefaultAsync(u => u.TenDangNhap == request.TenDangNhap && u.VaiTro == "Sinh viên");

            if (user == null)
            {
                return Unauthorized(new { message = "Invalid username or user is not a student" });
            }

            // Verify password
            try
            {
                if (!BCrypt.Net.BCrypt.Verify(request.MatKhau, user.MatKhau))
                {
                    return Unauthorized(new { message = "Invalid password" });
                }
            }
            catch (BCrypt.Net.SaltParseException)
            {
                return Unauthorized(new { message = "Invalid password hash format. Please contact support to reset your password." });
            }

            // Check if user is a student (exists in SinhVien table)
            var student = await _context.SinhVien
                .Include(s => s.Khoa)
                .FirstOrDefaultAsync(s => s.MaNguoiDung == user.MaNguoiDung);

            if (student == null)
            {
                return Unauthorized(new { message = "User is not registered as a student" });
            }

            // Create response with student information
            var response = new StudentResponse
            {
                MaSV = student.MaSV,
                HoTen = student.HoTen,
                GioiTinh = student.GioiTinh,
                NgaySinh = student.NgaySinh,
                Lop = student.Lop,
                SDT = student.SDT,
                Email = student.Email,
                SoCanCuoc = student.SoCanCuoc,
                SDTGiaDinh = student.SDTGiaDinh,
                SoHoKhau = student.SoHoKhau,
                TrangThai = student.TrangThai,
                AnhDaiDien = student.AnhDaiDien,
                MaKhoa = student.MaKhoa,
                TenKhoa = student.Khoa?.TenKhoa
            };

            return Ok(response);
        }




    }
}
