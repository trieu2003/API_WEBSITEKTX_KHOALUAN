
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
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
    public class TrangThietBiController : ControllerBase
    {
        private readonly KTXContext _context;

        public TrangThietBiController(KTXContext context)
        {
            _context = context;
        }
        [HttpGet("thietbi-phong-sinhvien/{maSV}")]
        public async Task<ActionResult<IEnumerable<TrangThietBiDTO>>> GetThietBiBySinhVien(string maSV)
        {
            try
            {
                // Find the active contract for the student to get MaPhong
                var hopDong = await _context.HopDongNoiTru
                    .Where(hd => hd.MaSV == maSV && hd.TrangThai == "Đang sử dụng")
                    .Select(hd => hd.MaPhong)
                    .FirstOrDefaultAsync();

                if (hopDong == null)
                {
                    return NotFound(new { message = "Không tìm thấy hợp đồng nội trú hợp lệ cho sinh viên." });
                }

                // Get distinct equipment assigned to the student's room via ChiTietPhong
                var thietBiList = await _context.ChiTietPhong
                    .Where(ct => ct.MaPhong == hopDong && ct.MaThietBi != null) // Ensure MaThietBi is not null
                    .Join(
                        _context.TrangThietBi,
                        ct => ct.MaThietBi,
                        tb => tb.MaThietBi,
                        (ct, tb) => new { tb.MaThietBi, tb.TenThietBi, tb.MoTa, tb.SoLuong, tb.TrangThai }
                    )
                    .GroupBy(tb => tb.MaThietBi) // Group by MaThietBi to remove duplicates
                    .Select(g => new TrangThietBiDTO
                    {
                        MaThietBi = g.Key,
                        TenThietBi = g.First().TenThietBi,
                        MoTa = g.First().MoTa,
                        SoLuong = g.Sum(x => x.SoLuong ?? 0), // Sum SoLuong for the same MaThietBi
                        TrangThai = g.First().TrangThai
                    })
                    .ToListAsync();

                if (!thietBiList.Any())
                {
                    return Ok(new { message = "Không có thiết bị trong phòng của sinh viên.", data = new List<TrangThietBiDTO>() });
                }

                return Ok(new { message = "Lấy danh sách thiết bị thành công.", data = thietBiList });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi khi lấy danh sách thiết bị.", error = ex.Message });
            }
        }
    }
}
