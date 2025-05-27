using Microsoft.AspNetCore.Mvc;
using APIWebsiteKTX.Models;
using Microsoft.EntityFrameworkCore;
using APIWebsiteKTX.Data;
using KTXApi.DTO;
using APIWebsiteKTX.DTO;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using MimeKit;
using MailKit.Net.Smtp;
using MailKit.Security;
using System.Net.Mail;
using System.Security.Cryptography;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly KTXContext _context;
        private readonly IConfiguration _configuration;
        private readonly EmailService _emailService;

        public AuthController(KTXContext context, IConfiguration configuration, EmailService emailService)
        {
            _context = context;
            _configuration = configuration;
            _emailService = emailService;
        }
        [HttpPost("request-otp")]
        public async Task<IActionResult> RequestOtp([FromBody] RequestOtpDTO request)
        {
            try
            {
                // Validate input
                if (request == null || string.IsNullOrEmpty(request.TenDangNhap))
                {
                    return BadRequest(new { message = "Tên đăng nhập không hợp lệ." });
                }

                // Find user
                var user = await _context.NguoiDung
                    .FirstOrDefaultAsync(u => u.TenDangNhap == request.TenDangNhap);

                if (user == null)
                {
                    return NotFound(new { message = "Tên đăng nhập không tồn tại." });
                }

                // Find associated student
                var student = await _context.SinhVien
                    .FirstOrDefaultAsync(sv => sv.MaNguoiDung == user.MaNguoiDung);

                if (student == null || string.IsNullOrEmpty(student.Email))
                {
                    return BadRequest(new { message = "Không tìm thấy email liên kết với tài khoản này. Vui lòng liên hệ nhân viên." });
                }

                // Generate OTP
                var otp = GenerateOtp();
                user.OTP = $"{otp}|{DateTime.UtcNow.AddMinutes(5):yyyy-MM-dd HH:mm:ss}";

                // Save OTP
                await _context.SaveChangesAsync();

                // Send OTP via email
                await _emailService.SendOtpEmail(student.Email, otp);

                return Ok(new { message = "OTP đã được gửi đến email của bạn. Vui lòng kiểm tra hộp thư." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ nhân viên.", error = ex.Message });
            }
        }

        [HttpPost("verify-otp")]
        public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpDTO request)
        {
            try
            {
                // Validate input
                if (request == null || string.IsNullOrEmpty(request.TenDangNhap) || string.IsNullOrEmpty(request.OTP) || string.IsNullOrEmpty(request.NewPassword))
                {
                    return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
                }

                // Find user
                var user = await _context.NguoiDung
                    .FirstOrDefaultAsync(u => u.TenDangNhap == request.TenDangNhap);

                if (user == null)
                {
                    return NotFound(new { message = "Tên đăng nhập không tồn tại." });
                }

                // Validate OTP
                if (string.IsNullOrEmpty(user.OTP))
                {
                    return BadRequest(new { message = "OTP không hợp lệ hoặc chưa được yêu cầu." });
                }

                var otpParts = user.OTP.Split('|');
                if (otpParts.Length != 2 || otpParts[0] != request.OTP)
                {
                    return BadRequest(new { message = "OTP không đúng." });
                }

                if (!DateTime.TryParse(otpParts[1], out var expiryTime) || expiryTime < DateTime.UtcNow)
                {
                    user.OTP = null; // Clear expired OTP
                    await _context.SaveChangesAsync();
                    return BadRequest(new { message = "OTP đã hết hạn. Vui lòng yêu cầu OTP mới." });
                }

                // Update password
                user.MatKhau = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
                user.OTP = null; // Clear OTP

                await _context.SaveChangesAsync();

                return Ok(new { message = "Mật khẩu đã được đặt lại thành công." });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ nhân viên.", error = ex.Message });
            }
        }

        private static string GenerateOtp()
        {
            using var rng = RandomNumberGenerator.Create();
            var bytes = new byte[4];
            rng.GetBytes(bytes);
            var random = BitConverter.ToUInt32(bytes, 0);
            return (random % 1000000).ToString("D6"); // 6-digit OTP
        }

        [HttpPost("MaHoa-MatKhau")]//đây là api mã hóa tất cả mật khẩu trong csdl trong trường hợp chưa mã hóa
        public async Task<IActionResult> UpdatePasswords()
        {
            var users = await _context.NguoiDung
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

            // Generate JWT token
            var token = GenerateJwtToken(user);

            // Create response with student information and token
            var response = new SinhVienResponseDTO
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
                TenKhoa = student.Khoa?.TenKhoa,
                Token = token
            };

            return Ok(response);
        }

        private string GenerateJwtToken(NguoiDung user)
        {
            var claims = new[]
            {
            new Claim(JwtRegisteredClaimNames.Sub, user.MaNguoiDung.ToString()),
            new Claim(JwtRegisteredClaimNames.Name, user.TenDangNhap),
            new Claim(ClaimTypes.Role, user.VaiTro ?? "Sinh viên"),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

            var token = new JwtSecurityToken(
                issuer: _configuration["Jwt:Issuer"],
                audience: _configuration["Jwt:Audience"],
                claims: claims,
                expires: DateTime.Now.AddMinutes(int.Parse(_configuration["Jwt:ExpiryMinutes"])),
                signingCredentials: creds);

            return new JwtSecurityTokenHandler().WriteToken(token);
        }

        [HttpPut("change-password")]
        public async Task<ActionResult<ChangePasswordResponseDTO>> ChangePassword([FromBody] DoiMatKhauDTO request)
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
