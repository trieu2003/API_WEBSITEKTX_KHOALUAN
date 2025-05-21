
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
            var availableBeds = await _context.Giuong
                .Where(g => g.TrangThai == "Trống")
                .Join(_context.ChiTietPhong,
                    giuong => giuong.MaGiuong,
                    chiTietPhong => chiTietPhong.Giuong,
                    (giuong, chiTietPhong) => new { giuong, chiTietPhong })
                .Join(_context.Phong,
                    gct => gct.chiTietPhong.MaPhong,
                    phong => phong.MaPhong,
                    (gct, phong) => new { gct.giuong, phong })
                .Join(_context.LoaiPhong,
                    gp => gp.phong.MaLoaiPhong,
                    loaiPhong => loaiPhong.MaLoaiPhong,
                    (gp, loaiPhong) => new
                    {
                        maGiuong = gp.giuong.MaGiuong,
                        maPhong = gp.phong.MaPhong,
                        tenPhong = gp.phong.TenPhong,
                        tenLoaiPhong = loaiPhong.TenLoai,
                        trangThai = gp.giuong.TrangThai,
                        tenThietBi = _context.ChiTietPhong
                            .Where(ctp => ctp.Giuong == gp.giuong.MaGiuong)
                            .Join(_context.TrangThietBi,
                                ctp => ctp.MaThietBi,
                                thietBi => thietBi.MaThietBi,
                                (ctp, thietBi) => thietBi.TenThietBi)
                            .ToList()
                    })
                .ToListAsync();
            return Ok(availableBeds); // Ensures application/json
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
