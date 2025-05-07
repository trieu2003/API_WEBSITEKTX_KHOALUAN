using APIWebsiteKTX.Data;
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

        // GET: api/SinhVien
    
        [HttpGet]
        public async Task<ActionResult<IEnumerable<SinhVienDto>>> GetSinhViens()
        {
            var sinhViens = await _context.SinhVien
                .Select(sv => new SinhVienDto
                {
                    MaSV = sv.MaSV,
                    MaNguoiDung = sv.MaNguoiDung,
                    HoTen = sv.HoTen,
                    // Kiểm tra kiểu dữ liệu của NgaySinh và xử lý nếu không hợp lệ
                    // Kiểm tra giá trị NULL của NgaySinh
                    NgaySinh = sv.NgaySinh,
                    Lop = sv.Lop,
                    SDT = sv.SDT,
                    Email = sv.Email,
                    SoCanCuoc = sv.SoCanCuoc,
                    SDTGiaDinh = sv.SDTGiaDinh,
                    SoHoKhau = sv.SoHoKhau,
                    TrangThai = sv.TrangThai,
                    AnhDaiDien = sv.AnhDaiDien,
                    MaKhoa = sv.MaKhoa
                })
                .ToListAsync();

            return Ok(sinhViens);
        }


        // GET: api/SinhVien/{id}
        [HttpGet("{id}")]
        public async Task<ActionResult<SinhVienDto>> GetSinhVien(string id)
        {
            var sinhVien = await _context.SinhVien
                .Where(sv => sv.MaSV == id)
                .Select(sv => new SinhVienDto
                {
                    MaSV = sv.MaSV,
                    MaNguoiDung = sv.MaNguoiDung,
                    HoTen = sv.HoTen,
                    NgaySinh = sv.NgaySinh,
                    Lop = sv.Lop,
                    SDT = sv.SDT,
                    Email = sv.Email,
                    SoCanCuoc = sv.SoCanCuoc,
                    SDTGiaDinh = sv.SDTGiaDinh,
                    SoHoKhau = sv.SoHoKhau,
                    TrangThai = sv.TrangThai,
                    AnhDaiDien = sv.AnhDaiDien,
                    MaKhoa = sv.MaKhoa
                })
                .FirstOrDefaultAsync();

            if (sinhVien == null)
            {
                return NotFound();
            }

            return Ok(sinhVien);
        }

        // POST: api/SinhVien
        [HttpPost]
        public async Task<ActionResult<SinhVien>> PostSinhVien(SinhVien sinhVien)
        {
            _context.SinhVien.Add(sinhVien);
            await _context.SaveChangesAsync();

            return CreatedAtAction(nameof(GetSinhVien), new { id = sinhVien.MaSV }, sinhVien);
        }

        // PUT: api/SinhVien/{id}
        [HttpPut("{id}")]
        public async Task<IActionResult> PutSinhVien(string id, SinhVien sinhVien)
        {
            if (id != sinhVien.MaSV)
            {
                return BadRequest();
            }

            _context.Entry(sinhVien).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SinhVienExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // DELETE: api/SinhVien/{id}
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteSinhVien(string id)
        {
            var sinhVien = await _context.SinhVien.FindAsync(id);
            if (sinhVien == null)
            {
                return NotFound();
            }

            _context.SinhVien.Remove(sinhVien);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool SinhVienExists(string id)
        {
            return _context.SinhVien.Any(e => e.MaSV == id);
        }
    }
}
