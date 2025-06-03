
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
        [HttpPost("xem-phieu-thu")]
        public async Task<IActionResult> XemPhieuThu([FromBody] PhieuThuRequestDTO request)
        {
            var maSV = request.MaSV;

            var hopDong = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV && h.TrangThai == "Đã nhận phòng")
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound("Hợp đồng bạn đã hủy hoặc đã kết thúc.");

            List<string> danhSachMaSV;

            if (hopDong.NhomTruong.Trim().ToLower() == "true")
            {
                danhSachMaSV = await _context.HopDongNoiTru
                    .Where(h => h.MaPhong == hopDong.MaPhong && h.TrangThai == "Đã nhận phòng")
                    .Select(h => h.MaSV)
                    .ToListAsync();
            }
            else
            {
                danhSachMaSV = new List<string> { maSV };
            }

            var hopDongs = await _context.HopDongNoiTru
                .Where(h => danhSachMaSV.Contains(h.MaSV))
                .Select(h => new { h.MaHopDong, h.MaSV })
                .ToListAsync();

            var maHopDongs = hopDongs.Select(h => h.MaHopDong).ToList();

            var svInfo = await _context.SinhVien
                .Where(sv => danhSachMaSV.Contains(sv.MaSV))
                .ToDictionaryAsync(sv => sv.MaSV, sv => sv.HoTen);

            var phieuThus = await _context.PhieuThu
                .Where(p => maHopDongs.Contains(p.MaHopDong))
                .Select(p => new
                {
                    p.MaPhieuThu,
                    p.NgayLap,
                    p.TongTien,
                    p.TrangThai,
                    p.MaNV,
                    p.MaHopDong
                })
                .ToListAsync();

            var result = phieuThus.Select(p =>
            {
                var maSV = hopDongs.FirstOrDefault(h => h.MaHopDong == p.MaHopDong)?.MaSV;
                var hoTen = maSV != null && svInfo.ContainsKey(maSV) ? svInfo[maSV] : "";

                var chiTiet = _context.ChiTietPhieuThu
                    .Where(c => c.MaPhieuThu == p.MaPhieuThu)
                    .Select(c => new ChiTietPhieuThuDTO
                    {
                        LoaiKhoanThu = c.LoaiKhoanThu,
                        SoTien = c.SoTien
                    }).ToList();

                return new PhieuThuResponseDTO
                {
                    MaPhieuThu = p.MaPhieuThu,
                    NgayLap = p.NgayLap,
                    TongTien = p.TongTien,
                    TrangThai = p.TrangThai,
                    MaNV = p.MaNV,
                    MaSV = maSV,
                    HoTen = hoTen,
                    ChiTietPhieuThu = chiTiet
                };
            }).ToList();

            return Ok(result);
        }
        [HttpPost("loc-theo-trangthai")]
        public async Task<IActionResult> LocPhieuThuTheoTrangThai([FromBody] LocPhieuThuRequestDTO request)
        {
            var maSV = request.MaSV;
            var trangThai = request.TrangThai;

            // 1. Tìm hợp đồng hiện tại
            var hopDong = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV && h.TrangThai == "Đã nhận phòng")
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound("Sinh viên không có hợp đồng đang ở.");

            List<string> danhSachMaSV;

            // 2. Nếu là nhóm trưởng, lấy tất cả SV cùng phòng
            if (hopDong.NhomTruong.Trim().ToLower() == "true")
            {
                danhSachMaSV = await _context.HopDongNoiTru
                    .Where(h => h.MaPhong == hopDong.MaPhong && h.TrangThai == "Đã nhận phòng")
                    .Select(h => h.MaSV)
                    .ToListAsync();
            }
            else
            {
                danhSachMaSV = new List<string> { maSV };
            }

            // 3. Lấy hợp đồng của các SV
            var hopDongs = await _context.HopDongNoiTru
                .Where(h => danhSachMaSV.Contains(h.MaSV))
                .Select(h => new { h.MaHopDong, h.MaSV })
                .ToListAsync();

            var maHopDongs = hopDongs.Select(h => h.MaHopDong).ToList();
            var maSVTheoHopDong = hopDongs.ToDictionary(h => h.MaHopDong, h => h.MaSV);

            // 4. Lọc phiếu thu theo trạng thái
            var phieuThus = await _context.PhieuThu
                .Where(p => maHopDongs.Contains(p.MaHopDong) && p.TrangThai == trangThai)
                .Select(p => new
                {
                    p.MaPhieuThu,
                    p.NgayLap,
                    p.TongTien,
                    p.TrangThai,
                    p.MaNV,
                    p.MaHopDong
                }).ToListAsync();

            var result = phieuThus.Select(p =>
            {
                var maSinhVien = maSVTheoHopDong.ContainsKey(p.MaHopDong) ? maSVTheoHopDong[p.MaHopDong] : "";

                var chiTiet = _context.ChiTietPhieuThu
                    .Where(c => c.MaPhieuThu == p.MaPhieuThu)
                    .Select(c => new ChiTietPhieuThuDTO
                    {
                        LoaiKhoanThu = c.LoaiKhoanThu,
                        SoTien = c.SoTien
                    }).ToList();

                return new PhieuThuResponseDTO
                {
                    MaPhieuThu = p.MaPhieuThu,
                    NgayLap = p.NgayLap,
                    TongTien = p.TongTien,
                    TrangThai = p.TrangThai,
                    MaNV = p.MaNV,
                    HoTen = _context.SinhVien
                        .Where(sv => sv.MaSV == maSinhVien)
                        .Select(sv => sv.HoTen)
                        .FirstOrDefault(),
                    MaSV = maSinhVien,
                    ChiTietPhieuThu = chiTiet
                };
            }).ToList();

            return Ok(result);
        }
    }
}
