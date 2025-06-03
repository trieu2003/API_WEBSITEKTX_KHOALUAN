
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

            var hopDong = await _context.HopDongNoiTru
                .FirstOrDefaultAsync(h => h.MaSV == maSV && h.TrangThai == "Đã nhận phòng");

            if (hopDong == null)
                return NotFound("Không tìm thấy hợp đồng hiện tại của sinh viên.");
            var maPhong = hopDong.MaPhong;
            // Lấy danh sách sinh viên cùng phòng
            var danhSachHopDong = await _context.HopDongNoiTru
                .Where(h => h.MaPhong == maPhong && h.TrangThai == "Đã nhận phòng")
                .ToListAsync();

            var maSVs = danhSachHopDong.Select(h => h.MaSV).ToList();

            // Lọc theo tên sinh viên nếu có yêu cầu
            if (!string.IsNullOrWhiteSpace(request.TenSinhVien))
            {
                var tenLower = request.TenSinhVien.Trim().ToLower();

                var matchedMaSVs = await _context.SinhVien
                    .Where(sv => maSVs.Contains(sv.MaSV) && sv.HoTen.ToLower().Contains(tenLower))
                    .Select(sv => sv.MaSV)
                    .ToListAsync();

                // Chỉ giữ những MaSV khớp tên
                maSVs = matchedMaSVs;
            }
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
                .Where(h => maSVs.Contains(h.MaSV))
                .Select(h => new { h.MaHopDong, h.MaSV })
                .ToListAsync();

            var maHopDongs = hopDongs.Select(h => h.MaHopDong).ToList();
            var maSVTheoHopDong = hopDongs.ToDictionary(h => h.MaHopDong, h => h.MaSV);

            // Truy vấn phiếu thu chính
            var query = _context.PhieuThu
                .Where(p => maHopDongs.Contains(p.MaHopDong));

            if (!string.IsNullOrWhiteSpace(request.TrangThai))
                query = query.Where(p => p.TrangThai == request.TrangThai);

            if (request.NgayLapTu.HasValue)
                query = query.Where(p => p.NgayLap >= request.NgayLapTu);

            if (request.NgayLapDen.HasValue)
                query = query.Where(p => p.NgayLap <= request.NgayLapDen);

            var totalRecords = await query.CountAsync(); // tổng bản ghi trước phân trang

            var phieuThuList = await query
                .OrderByDescending(p => p.NgayLap)
                .Skip((request.Page - 1) * request.PageSize)
                .Take(request.PageSize)
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

            foreach (var p in phieuThuList)
            {
                var chiTietQuery = _context.ChiTietPhieuThu
                    .Where(c => c.MaPhieuThu == p.MaPhieuThu);

                if (request.LoaiKhoanThu != null && request.LoaiKhoanThu.Any())
                {
                    chiTietQuery = chiTietQuery
                        .Where(c => request.LoaiKhoanThu.Contains(c.LoaiKhoanThu));
                }

                var chiTiet = await chiTietQuery
                    .Select(c => new ChiTietPhieuThuDTO
                    {
                        LoaiKhoanThu = c.LoaiKhoanThu,
                        SoTien = c.SoTien
                    }).ToListAsync();

                if (!chiTiet.Any()) continue;

                var maSinhVien = maSVTheoHopDong.TryGetValue(p.MaHopDong, out var msv) ? msv : "";

                result.Add(new PhieuThuResponseDTO
                {
                    HoTen = await _context.SinhVien
                        .Where(sv => sv.MaSV == maSinhVien)
                        .Select(sv => sv.HoTen)
                        .FirstOrDefaultAsync(),
                    MaPhieuThu = p.MaPhieuThu,
                    NgayLap = p.NgayLap,
                    TongTien = p.TongTien,
                    TrangThai = p.TrangThai,
                    MaNV = p.MaNV,
                    MaSV = maSinhVien,
                    ChiTietPhieuThu = chiTiet
                });
            }

            return Ok(new
            {
                currentPage = request.Page,
                pageSize = request.PageSize,
                totalRecords,
                data = result
            });
        }
    }
}
