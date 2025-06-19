
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
    public class ViPhamController : ControllerBase
    {
        private readonly KTXContext _context;

        public ViPhamController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet("sinhvien/{maSV}/ds-chi-tiet-vi-pham")]
        public async Task<IActionResult> LayDanhSachChiTietViPhamTheoMaSV(string maSV)
        {
            if (string.IsNullOrEmpty(maSV))
                return BadRequest(new { message = "Mã sinh viên không được để trống." });

            var chiTietViPhams = await _context.CT_ViPham
                .Where(ct => ct.MaSV == maSV)
                .OrderByDescending(ct => ct.MaViPham)
                .Select(ct => new
                {
                    ct.MaViPham,
                    ct.MaSV,
                    ct.HinhThucXuLy,
                    ct.MucDoXuLy,
                    ct.GhiChu,
                    ct.MaNV
                })
                .ToListAsync();

            if (chiTietViPhams == null || !chiTietViPhams.Any())
                return NotFound(new { message = "Không tìm thấy vi phạm nào cho sinh viên này." });

            return Ok(chiTietViPhams);
        }

        [HttpGet("chi-tiet/{maChiTietViPham}")]
        public async Task<IActionResult> LayChiTietViPhamTheoMa(int maChiTietViPham)
        {
            var chiTiet = await _context.CT_ViPham
                .Where(ct => ct.MaViPham == maChiTietViPham)
                .Select(ct => new
                {
                    ct.MaViPham,
                    ct.MaSV,
                    ct.HinhThucXuLy,
                    ct.MucDoXuLy,
                    ct.GhiChu,
                    ct.MaNV
                })
                .FirstOrDefaultAsync();

            if (chiTiet == null)
                return NotFound(new { message = "Không tìm thấy chi tiết vi phạm với mã này." });

            return Ok(chiTiet);
        }

    }
}
