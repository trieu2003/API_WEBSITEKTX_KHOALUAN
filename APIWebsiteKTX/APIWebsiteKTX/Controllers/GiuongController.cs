
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
        // New endpoint to get all available beds
        [HttpGet("available")]
        public async Task<ActionResult<IEnumerable<object>>> GetAvailableBeds()
        {
            // Bước 1: Lấy danh sách giường trống kèm thông tin phòng và loại phòng
            var beds = await (
                from g in _context.Giuong
                where g.TrangThai == "Trống"
                join ctp in _context.ChiTietPhong on g.MaGiuong equals ctp.Giuong
                join p in _context.Phong on ctp.MaPhong equals p.MaPhong
                join lp in _context.LoaiPhong on p.MaLoaiPhong equals lp.MaLoaiPhong
                select new
                {
                    MaGiuong = g.MaGiuong,
                    MaPhong = p.MaPhong,
                    TenPhong = p.TenPhong,
                    TenLoai = lp.TenLoai,
                    TrangThai = g.TrangThai
                }).ToListAsync();

            // Bước 2: Sau khi lấy về, truy vấn thiết bị cho từng giường
            var result = beds.Select(b => new
            {
                b.MaGiuong,
                b.MaPhong,
                b.TenPhong,
                b.TenLoai,
                b.TrangThai,
                TenThietBi = _context.ChiTietPhong
                    .Where(ctp => ctp.Giuong == b.MaGiuong)
                    .Join(_context.TrangThietBi,
                        ctp => ctp.MaThietBi,
                        tb => tb.MaThietBi,
                        (ctp, tb) => tb.TenThietBi)
                    .Distinct()
                    .ToList()
            });

            return Ok(result);
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Giuong>>> GetAll()
        {
            return await _context.Giuong.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Giuong>> Get(int id)
        {
            var item = await _context.Giuong.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<Giuong>> Post(Giuong model)
        {
            _context.Giuong.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, Giuong model)
        {
            if (!ModelExists(id))
            {
                return NotFound();
            }
            _context.Entry(model).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var model = await _context.Giuong.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.Giuong.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.Giuong.Find(id) != null;
        }

        private object GetKey(Giuong model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
