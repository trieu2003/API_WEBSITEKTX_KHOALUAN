
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
    public class DienNuocController : ControllerBase
    {
        private readonly KTXContext _context;

        public DienNuocController(KTXContext context)
        {
            _context = context;
        }
        [HttpGet("sinhvien/{maSV}/dien-nuoc")]
        public async Task<IActionResult> XemDienNuocCuaPhong(string maSV)
        {
            // Tìm hợp đồng hiện tại của sinh viên
            var hopDong = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV && h.TrangThai == "Đang Sử Dụng")
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound("Vui lòng nhận phòng để xem điện nước.");

            var maPhong = hopDong.MaPhong;

            // Truy vấn các bản ghi điện nước của phòng
            var dienNuocList = await _context.DienNuoc
                .Where(d => d.MaPhong == maPhong)
                .Select(d => new DienNuocDTO
                {
                    MaDN = d.MaDN,
                    NgayBatDau = d.NgayBatDau ?? DateTime.MinValue,
                    NgayKetThuc = d.NgayKetThuc ?? DateTime.MinValue,
                    SoDienCu = d.SoDienCu ?? 0,
                    SoDienMoi = d.SoDienMoi ?? 0,
                    SoNuocCu = d.SoNuocCu ?? 0,
                    SoNuocMoi = d.SoNuocMoi ?? 0
                }).ToListAsync();

            return Ok(dienNuocList);
        }

    }
}
