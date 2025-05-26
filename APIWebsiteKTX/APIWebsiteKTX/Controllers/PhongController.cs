
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PhongController : ControllerBase
    {
        private readonly KTXContext _context;

        public PhongController(KTXContext context)
        {
            _context = context;
        }


        [HttpGet("{maPhong}")]
        public async Task<ActionResult<PhongDTO>> GetRoomDetails(string maPhong)
        {
            try
            {
                var room = await _context.Phong
                    .Include(p => p.LoaiPhong)
                    .Include(p => p.Tang)
                    .Include(p => p.ChiTietPhongs)
                        .ThenInclude(ctp => ctp.TrangThietBi)
                    .Include(p => p.ChiTietPhongs)
                        .ThenInclude(ctp => ctp.Giuong)
                    .FirstOrDefaultAsync(p => p.MaPhong == maPhong);

                if (room == null)
                {
                    return NotFound(new { message = "Phòng không tồn tại" });
                }

                var roomDto = new PhongDTO
                {
                    MaPhong = room.MaPhong,
                    TenPhong = room.TenPhong,
                    MaLoaiPhong = room.MaLoaiPhong,
                    TenLoaiPhong = room.LoaiPhong?.TenLoai,
                    SucChua = room.LoaiPhong?.SucChua,
                    MucPhi = room.LoaiPhong?.MucPhi,
                    MaTang = room.MaTang,
                    TenTang = room.Tang?.TenTang,
                    TrangThai = room.TrangThai,
                    ThietBis = room.ChiTietPhongs
                        .Where(ctp => ctp.MaThietBi != null && ctp.TrangThietBi != null)
                        .Select(ctp => new TrangThietBiDTO
                        {
                            MaThietBi = ctp.TrangThietBi.MaThietBi,
                            TenThietBi = ctp.TrangThietBi.TenThietBi,
                            MoTa = ctp.TrangThietBi.MoTa,
                            SoLuong = ctp.TrangThietBi.SoLuong,
                            TrangThai = ctp.TrangThietBi.TrangThai
                        }).Distinct().ToList(),
                    Giuongs = room.ChiTietPhongs
                        .Where(ctp => ctp.Giuong != null && ctp.Giuong != null)
                        .Select(ctp => new GiuongDTO
                        {
                            MaGiuong = ctp.Giuong.MaGiuong,
                            TrangThai = ctp.Giuong.TrangThai
                        }).Distinct().ToList()
                };

                return Ok(new { status = "success", data = roomDto });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { message = "Lỗi server", error = ex.Message });
            }
        }

    }
}
