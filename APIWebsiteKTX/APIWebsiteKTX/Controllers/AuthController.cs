using Microsoft.AspNetCore.Mvc;
using APIWebsiteKTX.Models;
using Microsoft.EntityFrameworkCore;
using APIWebsiteKTX.Data;

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

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDto loginDto)
        {
            var user = await _context.NguoiDung
                .FirstOrDefaultAsync(u => u.TenDangNhap == loginDto.TenDangNhap && u.MatKhau == loginDto.MatKhau);

            if (user == null)
            {
                return Unauthorized("Tên đăng nhập hoặc mật khẩu không đúng.");
            }

            object userInfo = null;

            if (user.VaiTro == "Sinh viên")
            {
                   
                userInfo = await _context.SinhVien
                    .Where(sv => sv.MaNguoiDung == user.MaNguoiDung)
                    .Select(sv => new
                    {
                        sv.MaSV,
                        sv.MaNguoiDung,
                        sv.HoTen,
                        sv.NgaySinh,
                        sv.Lop,
                        sv.SDT,
                        sv.Email,
                        sv.SoCanCuoc,
                        sv.SDTGiaDinh,
                        sv.SoHoKhau,
                        sv.TrangThai,
                        sv.AnhDaiDien,  // <- sửa dòng này
                        sv.MaKhoa
                    })
                    .FirstOrDefaultAsync();
            }
            else if (user.VaiTro == "Nhân viên")
            {
                userInfo = await _context.NhanVien
                    .Where(nv => nv.MaNguoiDung == user.MaNguoiDung)
                    .Select(nv => new {
                        nv.MaNV,
                        nv.MaNguoiDung,
                        nv.HoTen,
                        nv.NgaySinh,
                        nv.GioiTinh,
                        nv.TrinhDo,
                        nv.ChucVu,
                        nv.Email,
                        nv.SDT
                    })
                    .FirstOrDefaultAsync();
            }
            else if (user.VaiTro == "Admin")
            {
                userInfo = new
                {
                    HoTen = "Quản trị viên",
                    QuyenHan = "Tất cả chức năng"
                };
            }

            if (userInfo == null)
            {
                //return NotFound("Không tìm thấy thông tin người dùng tương ứng.");
                return NotFound($"Không tìm thấy thông tin sinh viên cho mã người dùng: {user.MaNguoiDung}");
            }

            return Ok(new
            {
                message = "Đăng nhập thành công",
                vaitro = user.VaiTro,
                thongTin = userInfo
            });
        }




    }
}
