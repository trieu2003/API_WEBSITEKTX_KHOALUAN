
using APIWebsiteKTX.Data;
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
    public class GiuongController : ControllerBase
    {
        private readonly KTXContext _context;

        public GiuongController(KTXContext context)
        {   
            _context = context;
        }
        // lấy giường trống
        [HttpGet("available")]
        public async Task<ActionResult<IEnumerable<object>>> GetAvailableBeds()
        {
            // Bước 1: Lấy danh sách giường trống và thông tin phòng, loại phòng, tầng
            var beds = await (
                    from g in _context.Giuong
                    where g.TrangThai == "Trống"
                    join ctp in _context.ChiTietPhong on g.MaGiuong equals ctp.MaGiuong
                    join p in _context.Phong on ctp.MaPhong equals p.MaPhong
                    join lp in _context.LoaiPhong on p.MaLoaiPhong equals lp.MaLoaiPhong
                    join t in _context.Tang on p.MaTang equals t.MaTang // Thêm JOIN với bảng Tang
                    select new
                    {
                        MaGiuong = g.MaGiuong,
                        MaPhong = p.MaPhong,
                        TenPhong = p.TenPhong,
                        TenLoai = lp.TenLoai,
                        TenTang = t.TenTang, // Thêm cột TenTang
                        TrangThai = g.TrangThai
                    }).Distinct().ToListAsync();

            // Bước 2: Lấy tất cả thiết bị liên kết với giường
            var thietBiTheoGiuong = await (
                from ctp in _context.ChiTietPhong
                where ctp.MaThietBi != null
                join tb in _context.TrangThietBi on ctp.MaThietBi equals tb.MaThietBi
                select new
                {
                    MaGiuong = ctp.MaGiuong,
                    TenThietBi = tb.TenThietBi
                }).ToListAsync();

            // Bước 3: Kết hợp lại
            var result = beds.Select(b => new
            {
                b.MaGiuong,
                b.MaPhong,
                b.TenPhong,
                b.TenLoai,
                b.TenTang, // Thêm TenTang vào kết quả
                b.TrangThai,
                DanhSachThietBi = thietBiTheoGiuong
                    .Where(t => t.MaGiuong == b.MaGiuong)
                    .Select(t => t.TenThietBi)
                    .Distinct()
                    .ToList()
            });

            return Ok(result);
        }
    }
}
