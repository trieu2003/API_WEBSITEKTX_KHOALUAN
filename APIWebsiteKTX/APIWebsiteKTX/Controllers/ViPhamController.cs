
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

        [HttpGet("vipham/sinhvien/{maSV}")]
        public async Task<IActionResult> GetViPhamCuaSinhVien(string maSV)
        {
            var danhSachViPham = await _context.ViPham
                .Where(v => v.MaSV == maSV)
                .Join(
                    _context.NoiQuy,
                    v => v.MaNoiQuy,
                    nq => nq.MaNoiQuy,
                    (v, nq) => new ViPhamResponseDTO
                    {
                        MaViPham = v.MaViPham,
                        MaSV = v.MaSV,
                        NoiDung = nq.NoiDung ?? "",
                        GhiChu = v.GhiChu ?? "",
                        HinhThucXuLy = v.HinhThucXuLy ?? "",
                        MucDoXuLy = v.MucDoXuLy ?? "",
                        MaNV = v.MaNV ?? "",
                        FileBienBan = v.FileBienBan ?? ""
                    }
                )
                .ToListAsync();

            return Ok(danhSachViPham);
        }
    }
}
