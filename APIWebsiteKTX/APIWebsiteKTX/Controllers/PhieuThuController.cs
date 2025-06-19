
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Net.payOS;
using Net.payOS.Types;
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
                .Where(h => h.MaSV == maSV && h.TrangThai != "Hủy" && h.TrangThaiDuyet != "Từ chối")
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound("Hợp đồng bạn đã hủy hoặc đã kết thúc.");

            List<string> danhSachMaSV;

            if (hopDong.NhomTruong.Trim().ToLower() == "1")
            {
                danhSachMaSV = await _context.HopDongNoiTru
                    .Where(h => h.MaPhong == hopDong.MaPhong && h.TrangThai != "Hủy" && h.TrangThaiDuyet != "Từ chối")
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

            // Chỉ lấy phiếu thu ở trạng thái "Chưa thanh toán"
            var phieuThus = await _context.PhieuThu
                .Where(p => maHopDongs.Contains(p.MaHopDong) && p.TrangThai == "Chưa thanh toán")
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
        [HttpPost("xem-hoa-don")]
        public async Task<IActionResult> XemHoaDon([FromBody] PhieuThuRequestDTO request)
        {
            var maSV = request.MaSV;

            // Lấy hợp đồng hiện tại của sinh viên
            var hopDong = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV && h.TrangThai != "Hủy" && h.TrangThaiDuyet != "Từ chối")
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound(new { message = "Sinh viên chưa có hợp đồng." });

            List<string> danhSachMaSV;

            // Nếu là nhóm trưởng thì lấy tất cả thành viên cùng phòng
            if (!string.IsNullOrEmpty(hopDong.NhomTruong) && hopDong.NhomTruong.Trim().ToLower() == "1")
            {
                danhSachMaSV = await _context.HopDongNoiTru
                    .Where(h => h.MaPhong == hopDong.MaPhong && h.TrangThai != "Hủy" && h.TrangThaiDuyet != "Từ chối")
                    .Select(h => h.MaSV)
                    .ToListAsync();
            }
            else
            {
                danhSachMaSV = new List<string> { maSV };
            }

            // Lấy các hợp đồng của các thành viên
            var hopDongs = await _context.HopDongNoiTru
                .Where(h => danhSachMaSV.Contains(h.MaSV))
                .Select(h => new { h.MaHopDong, h.MaSV })
                .ToListAsync();

            var maHopDongs = hopDongs.Select(h => h.MaHopDong).ToList();

            if (maHopDongs == null || maHopDongs.Count == 0)
            {
                return NotFound(new { message = "Không tìm thấy hợp đồng phù hợp." });
            }

            // Lấy phiếu thu đã thanh toán
            var danhSachPhieuThu = await _context.PhieuThu
                .Where(p => p.TrangThai == "Đã thanh toán" && maHopDongs.Contains(p.MaHopDong))
                .OrderByDescending(p => p.NgayLap)
                .ToListAsync();

            if (danhSachPhieuThu == null || danhSachPhieuThu.Count == 0)
            {
                return NotFound(new { message = "Không có phiếu thu đã thanh toán nào." });
            }

            var maPhieuThus = danhSachPhieuThu.Select(p => p.MaPhieuThu).ToList();

            var chiTietPhieuThus = await _context.ChiTietPhieuThu
                .Where(c => maPhieuThus.Contains(c.MaPhieuThu))
                .ToListAsync();

            var maNVs = danhSachPhieuThu.Select(p => p.MaNV).Distinct().ToList();

            var nhanViens = await _context.NhanVien
                .Where(nv => maNVs.Contains(nv.MaNV))
                .ToDictionaryAsync(nv => nv.MaNV, nv => nv.HoTen);

            // Lấy thông tin sinh viên để trả về tên
            var svInfo = await _context.SinhVien
                .Where(sv => danhSachMaSV.Contains(sv.MaSV))
                .ToDictionaryAsync(sv => sv.MaSV, sv => sv.HoTen);

            var result = danhSachPhieuThu.Select(p =>
            {
                var maSVPhieu = hopDongs.FirstOrDefault(h => h.MaHopDong == p.MaHopDong)?.MaSV;
                var hoTen = maSVPhieu != null && svInfo.ContainsKey(maSVPhieu) ? svInfo[maSVPhieu] : "";

                return new
                {
                    p.MaPhieuThu,
                    p.NgayLap,
                    p.TongTien,
                    p.TrangThai,
                    p.MaHopDong,
                    p.MaNV,
                    TenNhanVien = nhanViens.ContainsKey(p.MaNV) ? nhanViens[p.MaNV] : null,
                    MaSV = maSVPhieu,
                    HoTen = hoTen,
                    LoaiKhoanThu = chiTietPhieuThus
                        .Where(c => c.MaPhieuThu == p.MaPhieuThu)
                        .Select(c => c.LoaiKhoanThu)
                        .ToList()
                };
            }).ToList();

            return Ok(result);
        }


        [HttpGet("sinh-vien/{maSV}")]
        public async Task<IActionResult> GetPhieuThuTheoSinhVien(string maSV)
        {
            // Tìm tất cả hợp đồng của sinh viên đó
            var maHopDongs = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV)
                .Select(h => h.MaHopDong)
                .ToListAsync();

            if (maHopDongs == null || maHopDongs.Count == 0)
            {
                return NotFound(new { message = "Sinh viên chưa có hợp đồng." });
            }

            // Lấy các phiếu thu ứng với các hợp đồng đó và chưa thanh toán
            var danhSachPhieuThu = await _context.PhieuThu
                .Where(p => p.MaHopDong != null
                    && maHopDongs.Contains(p.MaHopDong)
                    && p.TrangThai == "Chưa thanh toán")
                .OrderByDescending(p => p.NgayLap)
                .ToListAsync();

            if (danhSachPhieuThu == null || danhSachPhieuThu.Count == 0)
            {
                return NotFound(new { message = "Không có phiếu thu chưa thanh toán nào." });
            }

            // Lấy mã phiếu thu để truy vấn chi tiết và nhân viên
            var maPhieuThus = danhSachPhieuThu.Select(p => p.MaPhieuThu).ToList();

            // Lấy chi tiết phiếu thu
            var chiTietPhieuThus = await _context.ChiTietPhieuThu
                .Where(c => maPhieuThus.Contains(c.MaPhieuThu))
                .ToListAsync();

            // Lấy danh sách mã nhân viên
            var maNVs = danhSachPhieuThu.Select(p => p.MaNV).Distinct().ToList();

            // Lấy tên nhân viên
            var nhanViens = await _context.Set<NhanVien>()
                .Where(nv => maNVs.Contains(nv.MaNV))
                .ToDictionaryAsync(nv => nv.MaNV, nv => nv.HoTen);

            // Chuẩn bị kết quả trả về
            var result = danhSachPhieuThu.Select(p => new
            {
                p.MaPhieuThu,
                p.NgayLap,
                p.TongTien,
                p.TrangThai,
                p.MaNV,
                TenNhanVien = nhanViens.ContainsKey(p.MaNV) ? nhanViens[p.MaNV] : null,
                LoaiKhoanThu = chiTietPhieuThus
                    .Where(c => c.MaPhieuThu == p.MaPhieuThu)
                    .Select(c => c.LoaiKhoanThu)
                    .ToList()
            }).ToList();

            return Ok(result);
        }

        [HttpPost("phieuthu/loc-nang-cao")]
        public async Task<IActionResult> LocPhieuThuNangCao([FromBody] LocPhieuThuRequestDTO request)
        {
            var maSV = request.MaSV;

            var hopDong = await _context.HopDongNoiTru
                .FirstOrDefaultAsync(h => h.MaSV == maSV && h.TrangThai == "Đang Sử Dụng");

            if (hopDong == null)
                return NotFound("Không tìm thấy hợp đồng hiện tại của sinh viên.");
            var maPhong = hopDong.MaPhong;
            // Lấy danh sách sinh viên cùng phòng
            var danhSachHopDong = await _context.HopDongNoiTru
                .Where(h => h.MaPhong == maPhong && h.TrangThai == "Đang Sử Dụng")
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

            if (hopDong.NhomTruong.Trim().ToLower() == "1")
            {
                danhSachMaSV = await _context.HopDongNoiTru
                    .Where(h => h.MaPhong == hopDong.MaPhong && h.TrangThai == "Đang Sử Dụng")
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
        [HttpPost("thanh-toan/{maPhieuThu}")]
        public async Task<IActionResult> ThanhToanTheoPhieuThu(int maPhieuThu)
        {
            var phieuThu = await _context.PhieuThu.FindAsync(maPhieuThu);
            if (phieuThu == null)
            {
                return NotFound(new { message = "Không tìm thấy phiếu thu." });
            }

            if (phieuThu.TongTien == null || phieuThu.TongTien <= 0)
            {
                return BadRequest(new { message = "Tổng tiền không hợp lệ." });
            }

            // Cấu hình PayOS
            var payos = new PayOS(
                "32542182-51db-48cf-8d7a-6d8a18d599b5",  // clientId
                "dc3def5d-79e6-4b24-9c21-5ab24f9481c2",  // apiKey
                "162ea9960c0fb31f3f6267f89d5c2788da5cfc623ad1311e1baa800f386ef229" // checksumKey
            );

            var orderCode = new Random().Next(100000, 999999);
            var items = new List<ItemData>
            {
                new ItemData($"Thanh toán phiếu thu #{phieuThu.MaPhieuThu}", 1, (int)phieuThu.TongTien)
            };

            var paymentData = new PaymentData(
                orderCode: orderCode,
                amount: (int)phieuThu.TongTien,
                description: $"Thanh toán phiếu thu #{phieuThu.MaPhieuThu}",
                items: items,
                cancelUrl: "http://localhost:5173/huy",
                returnUrl: $"http://localhost:5173/ket-qua?maPhieuThu={phieuThu.MaPhieuThu}" // ✅ THÊM MA PHIẾU
            );


            var result = await payos.createPaymentLink(paymentData);

            return Ok(new
            {
                url = result.checkoutUrl,
                maPhieuThu = phieuThu.MaPhieuThu,
                tongTien = phieuThu.TongTien,
                trangThai = phieuThu.TrangThai
            });
        }
        [HttpPost("xac-nhan-thanh-toan")]
        public async Task<IActionResult> XacNhanThanhToan([FromBody] int maPhieuThu)
        {
            var phieuThu = await _context.PhieuThu.FindAsync(maPhieuThu);
            if (phieuThu == null)
            {
                return NotFound(new { message = "Không tìm thấy phiếu thu." });
            }

            // Cập nhật trạng thái sau khi người dùng quay lại từ PayOS
            phieuThu.TrangThai = "Đã thanh toán";
            await _context.SaveChangesAsync();

            return Ok(new { message = "Đã cập nhật trạng thái phiếu thu thành công." });
        }
        //[HttpPost("xac-nhan-thanh-toan")]
        //public async Task<IActionResult> XacNhanThanhToan([FromBody] XacNhanThanhToanRequest request)
        //{
        //    if (request == null || request.MaPhieuThu <= 0)
        //    {
        //        return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
        //    }

        //    var phieuThu = await _context.PhieuThu.FindAsync(request.MaPhieuThu);
        //    if (phieuThu == null)
        //    {
        //        return NotFound(new { message = "Không tìm thấy phiếu thu." });
        //    }

        //    // Cập nhật trạng thái
        //    phieuThu.TrangThai = "Đã thanh toán";

        //    try
        //    {
        //        // Kiểm tra loại khoản thu có phải là "Hợp Đồng Nội Trú"
        //        var chiTiet = await _context.ChiTietPhieuThu
        //            .Where(c => c.MaPhieuThu == request.MaPhieuThu && c.LoaiKhoanThu == "Hợp Đồng Nội Trú")
        //            .FirstOrDefaultAsync();

        //        if (chiTiet != null)
        //        {
        //            // Tìm hợp đồng từ mã hợp đồng trong phiếu thu
        //            var hopDong = await _context.HopDongNoiTru
        //                .FirstOrDefaultAsync(h => h.MaHopDong == phieuThu.MaHopDong);

        //            if (hopDong != null)
        //            {
        //                hopDong.PhuongThucThanhToan = "Chuyển khoản";
        //                hopDong.MinhChungThanhToan = request.TransactionId;
        //            }
        //            else
        //            {
        //                return NotFound(new { message = "Không tìm thấy hợp đồng nội trú liên quan." });
        //            }
        //        }

        //        await _context.SaveChangesAsync();
        //        return Ok(new { message = "Đã cập nhật trạng thái phiếu thu thành công." });
        //    }
        //    catch (Exception ex)
        //    {
        //        // Ghi log nếu cần thiết
        //        return StatusCode(500, new { message = "Đã xảy ra lỗi khi cập nhật dữ liệu.", error = ex.Message });
        //    }
        //}


        [HttpGet("phieu-thu-da-thanh-toan")]
        public async Task<IActionResult> GetPhieuThuDaThanhToan([FromQuery] string maSV)
        {
            // Lấy tất cả hợp đồng của sinh viên đó
            var maHopDongs = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV)
                .Select(h => h.MaHopDong)
                .ToListAsync();

            if (maHopDongs == null || maHopDongs.Count == 0)
            {
                return NotFound(new { message = "Sinh viên chưa có hợp đồng." });
            }

            // Lấy tất cả phiếu thu đã thanh toán của các hợp đồng này
            var danhSachPhieuThu = await _context.PhieuThu
                .Where(p => p.TrangThai == "Đã thanh toán" && maHopDongs.Contains(p.MaHopDong))
                .OrderByDescending(p => p.NgayLap)
                .ToListAsync();

            if (danhSachPhieuThu == null || danhSachPhieuThu.Count == 0)
            {
                return NotFound(new { message = "Không có phiếu thu đã thanh toán nào." });
            }

            // Lấy mã phiếu thu để truy vấn chi tiết và nhân viên
            var maPhieuThus = danhSachPhieuThu.Select(p => p.MaPhieuThu).ToList();

            // Lấy chi tiết phiếu thu
            var chiTietPhieuThus = await _context.ChiTietPhieuThu
                .Where(c => maPhieuThus.Contains(c.MaPhieuThu))
                .ToListAsync();

            // Lấy danh sách mã nhân viên
            var maNVs = danhSachPhieuThu.Select(p => p.MaNV).Distinct().ToList();

            // Lấy tên nhân viên
            var nhanViens = await _context.NhanVien
                .Where(nv => maNVs.Contains(nv.MaNV))
                .ToDictionaryAsync(nv => nv.MaNV, nv => nv.HoTen);

            // Chuẩn bị kết quả trả về
            var result = danhSachPhieuThu.Select(p => new
            {
                p.MaPhieuThu,
                p.NgayLap,
                p.TongTien,
                p.TrangThai,
                p.MaHopDong,
                p.MaNV,
                TenNhanVien = nhanViens.ContainsKey(p.MaNV) ? nhanViens[p.MaNV] : null,
                LoaiKhoanThu = chiTietPhieuThus
                    .Where(c => c.MaPhieuThu == p.MaPhieuThu)
                    .Select(c => c.LoaiKhoanThu)
                    .ToList()
            }).ToList();

            return Ok(result);
        }

        [HttpGet("chi-tiet-phieu-thu/{maPhieuThu}")]
        public async Task<IActionResult> GetChiTietPhieuThu(int maPhieuThu)
        {
            // Lấy phiếu thu
            var phieuThu = await _context.PhieuThu
                .FirstOrDefaultAsync(p => p.MaPhieuThu == maPhieuThu);

            if (phieuThu == null)
            {
                return NotFound(new { message = "Không tìm thấy phiếu thu." });
            }

            // Lấy hợp đồng liên quan
            var hopDong = await _context.HopDongNoiTru
                .FirstOrDefaultAsync(h => h.MaHopDong == phieuThu.MaHopDong);

            // Lấy chi tiết phiếu thu
            var chiTietPhieuThu = await _context.ChiTietPhieuThu
                .Where(c => c.MaPhieuThu == maPhieuThu)
                .Select(c => new
                {
                    c.LoaiKhoanThu,
                    c.SoTien
                })
                .ToListAsync();

            // Lấy tên nhân viên lập phiếu (nếu có)
            string tenNhanVien = null;
            if (!string.IsNullOrEmpty(phieuThu.MaNV))
            {
                tenNhanVien = await _context.NhanVien
                    .Where(nv => nv.MaNV == phieuThu.MaNV)
                    .Select(nv => nv.HoTen)
                    .FirstOrDefaultAsync();
            }

            return Ok(new
            {
                PhieuThu = new
                {
                    phieuThu.MaPhieuThu,
                    phieuThu.NgayLap,
                    phieuThu.TongTien,
                    phieuThu.TrangThai,
                    phieuThu.MaNV,
                    TenNhanVien = tenNhanVien,
                    phieuThu.MaHopDong,
                    ChiTietPhieuThu = chiTietPhieuThu
                },
                HopDong = hopDong // trả về toàn bộ thông tin hợp đồng, có thể chọn lọc trường nếu muốn
            });
        }
    }
}

