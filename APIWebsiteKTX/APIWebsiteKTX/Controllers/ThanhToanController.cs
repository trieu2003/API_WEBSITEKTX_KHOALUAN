
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Net.payOS;
using Net.payOS.Types;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController] 
    public class ThanhToanController : ControllerBase
    {
        private readonly KTXContext _context;

        public ThanhToanController(KTXContext context)
        {
            _context = context;
        }
        [HttpPost("truongnhom/thanh-toan-dien-nuoc")]
        public async Task<IActionResult> TruongNhomThanhToanDienNuoc([FromBody] PhieuThuRequestDTO request)
        {
            var maSV = request.MaSV;

            // 1. Xác minh trưởng nhóm
            var hopDongTruongNhom = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV && h.TrangThai == "Đang Sử Dụng" && h.NhomTruong.Trim().ToLower() == "1")
                .FirstOrDefaultAsync();

            if (hopDongTruongNhom == null)
                return BadRequest("Sinh viên không phải là trưởng nhóm hoặc chưa nhận phòng.");

            var maPhong = hopDongTruongNhom.MaPhong;

            // 2. Lấy danh sách sinh viên cùng phòng
            var danhSachHopDong = await _context.HopDongNoiTru
                .Where(h => h.MaPhong == maPhong && h.TrangThai == "Đang Sử Dụng")
                .ToListAsync();

            var danhSachMaHopDong = danhSachHopDong.Select(h => h.MaHopDong).ToList();
            var maSVTheoHopDong = danhSachHopDong.ToDictionary(h => h.MaHopDong, h => h.MaSV);

            // 3. Lấy các phiếu thu có "Tiền điện nước"
            var phieuThuDienNuoc = await _context.PhieuThu
                .Where(p => danhSachMaHopDong.Contains(p.MaHopDong))
                .Where(p => _context.ChiTietPhieuThu
                    .Any(c => c.MaPhieuThu == p.MaPhieuThu && (c.LoaiKhoanThu == "Tiền Điện" || c.LoaiKhoanThu == "Tiền Nước")))
                .ToListAsync();

            if (!phieuThuDienNuoc.Any())
                return BadRequest("Không có phiếu thu điện nước nào cần thanh toán.");

            // 4. Tổng tiền và danh sách item
            var tongTien = 0;
            var items = new List<ItemData>();
            var ketQua = new List<ThanhToanDienNuocReponseDTO>();

            foreach (var pt in phieuThuDienNuoc)
            {
                pt.TrangThai = "Đã thanh toán";

                tongTien += (int)(pt.TongTien);
                var maHopDong = pt.MaHopDong;
                var maSinhVien = maSVTheoHopDong.ContainsKey(maHopDong) ? maSVTheoHopDong[maHopDong] : "";

                // Ghi chi tiết đầy đủ vào item
                items.Add(new ItemData(
                    name: $"PT{pt.MaPhieuThu}_SV{maSinhVien}", // <= tối đa 100 ký tự tuỳ PayOS
                    quantity: 1,
                    price: (int)(pt.TongTien)
                ));

                ketQua.Add(new ThanhToanDienNuocReponseDTO
                {
                    MaPhieuThu = pt.MaPhieuThu,
                    MaSV = maSinhVien,
                    TongTien = pt.TongTien
                });
            }

            // 5. Cấu hình PayOS
            var payos = new PayOS(
                "32542182-51db-48cf-8d7a-6d8a18d599b5",  // clientId
                "dc3def5d-79e6-4b24-9c21-5ab24f9481c2",  // apiKey
                "162ea9960c0fb31f3f6267f89d5c2788da5cfc623ad1311e1baa800f386ef229" // checksumKey
            );
            var moTaThanhToan = $"Dien nuoc P{maPhong}";
            if (moTaThanhToan.Length > 25)
                moTaThanhToan = moTaThanhToan.Substring(0, 25);

            var orderCode = new Random().Next(100000, 999999);
            var paymentData = new PaymentData(
                orderCode: orderCode,
                amount: tongTien,
                description: moTaThanhToan,
                items: items,
                cancelUrl: "http://localhost:5173/huy",
                returnUrl: "http://localhost:5173/ket-qua"
            );

            var result = await payos.createPaymentLink(paymentData);

            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Tạo liên kết thanh toán thành công.",
                tongSoPhieu = ketQua.Count,
                tongTienThanhToan = tongTien,
                chiTiet = ketQua,
                url = result.checkoutUrl
            });
        }

        [HttpGet("{maSV}/hopdong-phong-phieuthu")]
        public async Task<IActionResult> XemHopDongVaPhieuThuPhong(string maSV)
        {
            // Tìm hợp đồng với trạng thái "Đang sử dụng"
            var hopDong = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV && h.TrangThai != "Hủy")
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound("Không thể thanh toán vì hợp động của bạn bị hủy!.");

            // Tìm các mã phiếu thu thuộc hợp đồng
            var maPhieuThuPhong = await _context.ChiTietPhieuThu
                .Where(c => c.LoaiKhoanThu == "Hợp Đồng Nội Trú")
                .Join(_context.PhieuThu,
                      c => c.MaPhieuThu,
                      p => p.MaPhieuThu,
                      (c, p) => new { c, p })
                .Where(cp => cp.p.MaHopDong == hopDong.MaHopDong)
                .Select(cp => cp.p.MaPhieuThu)
                .Distinct()
                .ToListAsync();

            // Lấy danh sách phiếu thu liên quan đến khoản "Hợp Đồng Nội Trú"
            var phieuThus = await _context.PhieuThu
                .Where(p => maPhieuThuPhong.Contains(p.MaPhieuThu))
                .Select(p => new PhieuThuResponseDTO
                {
                    MaPhieuThu = p.MaPhieuThu,
                    NgayLap = p.NgayLap ,
                    TongTien = p.TongTien,
                    TrangThai = p.TrangThai,
                    MaNV = p.MaNV,
                    ChiTietPhieuThu = _context.ChiTietPhieuThu
                        .Where(c => c.MaPhieuThu == p.MaPhieuThu && c.LoaiKhoanThu == "Hợp Đồng Nội Trú")
                        .Select(c => new ChiTietPhieuThuDTO
                        {
                            LoaiKhoanThu = c.LoaiKhoanThu,
                            SoTien = c.SoTien
                        }).ToList()
                }).ToListAsync();

            // Ghép hợp đồng và phiếu thu
            var result = new HopDongVaPhieuThuDTO
            {
                MaHopDong = hopDong.MaHopDong,
                MaPhong = hopDong.MaPhong,
                MaGiuong = hopDong.MaGiuong,
                NgayBatDau = hopDong.NgayBatDau ?? DateTime.MinValue,
                NgayKetThuc = hopDong.NgayKetThuc ?? DateTime.MinValue,
                PhuongThucThanhToan = hopDong.PhuongThucThanhToan,
                DanhSachPhieuThu = phieuThus
            };

            return Ok(result);
        }
        [HttpPost("room-payment")]
        public async Task<IActionResult> ProcessPayment([FromBody] ThanhToanRequestDTO request)
        {
            try
            {
                using (var transaction = await _context.Database.BeginTransactionAsync())
                {
                    try
                    {
                        // Verify student and contract
                        var contract = await _context.HopDongNoiTru
                            .Where(h => h.MaSV == request.MaSV && h.TrangThaiDuyet == "Đã duyệt" && h.TrangThai == "Chờ duyệt")
                            .FirstOrDefaultAsync();

                        if (contract == null)
                            return BadRequest("No valid contract found");

                        // Validate payment proof
                        if (!IsValidPaymentProof(request.MinhChungThanhToan))
                            return BadRequest("Invalid payment proof");

                        // Calculate total amount (example logic, adjust based on actual requirements)
                        decimal tongTien = await CalculateTotalAmount(contract.MaHopDong);

                        // Create PhieuThu
                        var phieuThu = new PhieuThu
                        {
                            MaHopDong = contract.MaHopDong,
                            NgayLap = DateTime.Now,
                            TongTien = tongTien,
                            TrangThai = "Đã thanh toán",
                            MaNV = null // Assuming no staff verification for simplicity
                        };
                        _context.PhieuThu.Add(phieuThu);
                        await _context.SaveChangesAsync();

                        // Create ChiTietPhieuThu (example logic, adjust based on actual fee types)
                        var chiTietPhieuThus = new List<ChiTietPhieuThu>
                    {
                        new ChiTietPhieuThu
                        {
                            MaPhieuThu = phieuThu.MaPhieuThu,
                            LoaiKhoanThu = "Hợp Đồng Nội Trú",
                            SoTien = tongTien // Simplified, adjust as needed
                        }
                        // Add more ChiTietPhieuThu items if needed based on actual fee structure
                    };
                        _context.ChiTietPhieuThu.AddRange(chiTietPhieuThus);

                        // Update HopDongNoiTru
                        //contract.TrangThai = "Đã thanh toán";
                        //contract.MinhChungThanhToan = "Đã minh chứng";
                        contract.PhuongThucThanhToan = request.PhuongThucThanhToan;

                        await _context.SaveChangesAsync();
                        await transaction.CommitAsync();

                        return Ok(new { MaPhieuThu = phieuThu.MaPhieuThu, Message = "Payment processed successfully" });
                    }
                    catch
                    {
                        await transaction.RollbackAsync();
                        return StatusCode(500, "Payment processing failed");
                    }
                }
            }
            catch
            {
                return StatusCode(500, "Internal server error");
            }
        }

        private bool IsValidPaymentProof(string minhChung)
        {
            return !string.IsNullOrEmpty(minhChung) && minhChung.Length > 0;
        }

        private async Task<decimal> CalculateTotalAmount(int maHopDong)
        {
            // Example logic to calculate total amount, adjust based on actual fee structure
            var loaiPhong = await _context.HopDongNoiTru
                .Where(h => h.MaHopDong == maHopDong)
                .Join(_context.Phong,
                    h => h.MaPhong,
                    p => p.MaPhong,
                    (h, p) => p.MaLoaiPhong)
                .Join(_context.LoaiPhong,
                    p => p,
                    lp => lp.MaLoaiPhong,
                    (p, lp) => lp.MucPhi)
                .FirstOrDefaultAsync();

            return loaiPhong ?? 0; // Simplified, add more fee calculations as needed
        }
    }
}
