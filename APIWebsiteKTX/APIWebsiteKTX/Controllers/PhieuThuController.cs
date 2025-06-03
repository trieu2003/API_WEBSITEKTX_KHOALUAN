
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
        [HttpPost("phieuthu/loc-nang-cao")]
        public async Task<IActionResult> LocPhieuThuNangCao([FromBody] LocPhieuThuRequestDTO request)
        {
            var maSV = request.MaSV;

            // Lấy hợp đồng đang ở
            var hopDong = await _context.HopDongNoiTru
                .FirstOrDefaultAsync(h => h.MaSV == maSV && h.TrangThai == "Đã nhận phòng");

            if (hopDong == null)
                return NotFound("Không tìm thấy hợp đồng hiện tại của sinh viên.");

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
            var maSVTheoHopDong = hopDongs.ToDictionary(h => h.MaHopDong, h => h.MaSV);

            // Lọc phiếu thu theo điều kiện
            var phieuThuQuery = _context.PhieuThu
                .Where(p => maHopDongs.Contains(p.MaHopDong));

            if (!string.IsNullOrWhiteSpace(request.TrangThai))
            {
                phieuThuQuery = phieuThuQuery.Where(p => p.TrangThai == request.TrangThai);
            }

            if (request.NgayLapTu.HasValue)
            {
                phieuThuQuery = phieuThuQuery.Where(p => p.NgayLap >= request.NgayLapTu);
            }

            if (request.NgayLapDen.HasValue)
            {
                phieuThuQuery = phieuThuQuery.Where(p => p.NgayLap <= request.NgayLapDen);
            }


            // Truy vấn phiếu thu thỏa điều kiện
            var danhSachPhieu = await phieuThuQuery
                .Select(p => new
                {
                    p.MaPhieuThu,
                    p.MaHopDong,
                    p.NgayLap,
                    p.TongTien,
                    p.TrangThai,
                    p.MaNV
                }).ToListAsync();

            var result = new List<PhieuThuResponseDTO>();

            foreach (var p in danhSachPhieu)
            {
                var chiTietQuery = _context.ChiTietPhieuThu
                    .Where(c => c.MaPhieuThu == p.MaPhieuThu);

                if (!string.IsNullOrWhiteSpace(request.LoaiKhoanThu))
                {
                    chiTietQuery = chiTietQuery.Where(c => c.LoaiKhoanThu == request.LoaiKhoanThu);
                }

                var chiTiet = await chiTietQuery
                    .Select(c => new ChiTietPhieuThuDTO
                    {
                        LoaiKhoanThu = c.LoaiKhoanThu,
                        SoTien = c.SoTien
                    }).ToListAsync();

                // Bỏ qua nếu không có chi tiết khớp loại khoản thu
                if (!chiTiet.Any()) continue;

                var maSinhVien = maSVTheoHopDong.ContainsKey(p.MaHopDong) ? maSVTheoHopDong[p.MaHopDong] : "";

                result.Add(new PhieuThuResponseDTO
                {
                    MaPhieuThu = p.MaPhieuThu,
                    MaNV = p.MaNV,
                    MaSV = maSinhVien,
                    NgayLap = p.NgayLap,
                    HoTen = await _context.SinhVien
                        .Where(sv => sv.MaSV == maSinhVien)
                        .Select(sv => sv.HoTen)
                        .FirstOrDefaultAsync(),
                    TongTien = p.TongTien,
                    TrangThai = p.TrangThai,
                    ChiTietPhieuThu = chiTiet
                });
            }

            return Ok(result);
        }
    }
}
