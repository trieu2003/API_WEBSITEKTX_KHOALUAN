using Microsoft.AspNetCore.Mvc;
using APIWebsiteKTX.Models;
using Microsoft.EntityFrameworkCore;
using APIWebsiteKTX.Data;
using Microsoft.AspNetCore.Identity.Data;
using KTXApi.DTO;
using APIWebsiteKTX.DTO;

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

        [HttpPut("change-password")]
        public async Task<ActionResult<ChangePasswordResponseDTO>> ChangePassword([FromBody] ChangPasswordDTO request)
        {
            try
            {
                // Kiểm tra dữ liệu đầu vào
                if (string.IsNullOrEmpty(request.MaSV) || string.IsNullOrEmpty(request.OldPassword) || string.IsNullOrEmpty(request.NewPassword))
                {
                    return BadRequest(new ChangePasswordResponseDTO
                    {
                        Status = "error",
                        Message = "Mã sinh viên, mật khẩu cũ và mật khẩu mới không được để trống"
                    });
                }

                // Tìm sinh viên dựa trên MaSV
                var sinhVien = await _context.SinhVien
                    .Include(sv => sv.NguoiDung)
                    .FirstOrDefaultAsync(sv => sv.MaSV == request.MaSV);

                if (sinhVien == null || sinhVien.NguoiDung == null)
                {
                    return NotFound(new ChangePasswordResponseDTO
                    {
                        Status = "error",
                        Message = "Mã sinh viên không tồn tại"
                    });
                }

                // Xác thực mật khẩu cũ
                if (!BCrypt.Net.BCrypt.Verify(request.OldPassword, sinhVien.NguoiDung.MatKhau))
                {
                    return BadRequest(new ChangePasswordResponseDTO
                    {
                        Status = "error",
                        Message = "Mật khẩu cũ không đúng"
                    });
                }

                // Kiểm tra mật khẩu mới (ví dụ: tối thiểu 6 ký tự)
                if (request.NewPassword.Length < 6)
                {
                    return BadRequest(new ChangePasswordResponseDTO
                    {
                        Status = "error",
                        Message = "Mật khẩu mới phải có ít nhất 6 ký tự"
                    });
                }

                // Mã hóa mật khẩu mới và cập nhật
                sinhVien.NguoiDung.MatKhau = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
                _context.NguoiDung.Update(sinhVien.NguoiDung);
                await _context.SaveChangesAsync();

                return Ok(new ChangePasswordResponseDTO
                {
                    Status = "success",
                    Message = "Đổi mật khẩu thành công"
                });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new ChangePasswordResponseDTO
                {
                    Status = "error",
                    Message = "Lỗi server",
                    // Chỉ trả về chi tiết lỗi trong môi trường phát triển
                    Error = ex.Message
                });
            }
        }


    }
}
