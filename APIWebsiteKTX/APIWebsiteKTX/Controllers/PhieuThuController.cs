
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
    public class PhieuThuController : ControllerBase
    {
        private readonly KTXContext _context;

        public PhieuThuController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet("sinhvien/{maSV}")]
        public async Task<IActionResult> GetPhieuThuBySinhVien(string maSV)
        {
            try
            {
                // Tìm tất cả hợp đồng của sinh viên
                var hopDongIds = await _context.HopDongNoiTru
                    .Where(hd => hd.MaSV == maSV)
                    .Select(hd => hd.MaHopDong)
                    .ToListAsync();

                if (!hopDongIds.Any())
                {
                    return NotFound(new { message = "Sinh viên không có hợp đồng nội trú nào." });
                }

                // Lấy phiếu thu theo hợp đồng
                var phieuThus = await _context.PhieuThu
                    .Where(pt => hopDongIds.Contains(pt.MaHopDong))
                    .Select(pt => new PhieuThuDTO
                    {
                        MaPhieuThu = pt.MaPhieuThu,
                        NgayLap = pt.NgayLap,
                        TongTien = pt.TongTien,
                        TrangThai = pt.TrangThai,
                        MaNV = pt.MaNV,
                        ChiTietPhieuThu = _context.ChiTietPhieuThu
                            .Where(ct => ct.MaPhieuThu == pt.MaPhieuThu)
                            .Select(ct => new ChiTietPhieuThuDTO
                            {
                                LoaiKhoanThu = ct.LoaiKhoanThu,
                                SoTien = ct.SoTien
                            }).ToList()
                    })
                    .ToListAsync();

                return Ok(new { status = "success", data = phieuThus });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi hệ thống", error = ex.Message });
            }
        }
    }
}
