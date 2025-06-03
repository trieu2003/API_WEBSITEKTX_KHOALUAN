
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
    public class MucGiaDienNuocController : ControllerBase
    {
        private readonly KTXContext _context;

        public MucGiaDienNuocController(KTXContext context)
        {
            _context = context;
        }
        [HttpGet("muc-gia-dien-nuoc")]
        public async Task<IActionResult> GetDanhSachMucGiaDienNuoc()
        {
            var danhSach = await _context.MucGiaDienNuoc
                .OrderByDescending(m => m.ThoiGianApDung)
                .Select(m => new MucGiaDienNuocDTO
                {
                    MaMucGia = m.MaMucGia,
                    ThoiGianApDung = m.ThoiGianApDung,
                    DonGiaDien = m.DonGiaDien ?? 0,
                    DonGiaNuoc = m.DonGiaNuoc ?? 0
                })
                .ToListAsync();

            return Ok(danhSach);
        }
    }
}
