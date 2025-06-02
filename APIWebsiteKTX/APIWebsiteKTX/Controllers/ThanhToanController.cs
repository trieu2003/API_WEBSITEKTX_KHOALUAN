
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
    public class ThanhToanController : ControllerBase
    {
        private readonly KTXContext _context;

        public ThanhToanController(KTXContext context)
        {
            _context = context;
        }
        [HttpPost("process-payment")]
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
                            .Where(h => h.MaSV == request.MaSV && h.TrangThaiDuyet == "Đã duyệt" && h.TrangThai == "Chờ Thanh Toán")
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
                            LoaiKhoanThu = "Phí phòng",
                            SoTien = tongTien // Simplified, adjust as needed
                        }
                        // Add more ChiTietPhieuThu items if needed based on actual fee structure
                    };
                        _context.ChiTietPhieuThu.AddRange(chiTietPhieuThus);

                        // Update HopDongNoiTru
                        contract.TrangThai = "Đã thanh toán";
                        contract.MinhChungThanhToan = "Đã minh chứng";
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
