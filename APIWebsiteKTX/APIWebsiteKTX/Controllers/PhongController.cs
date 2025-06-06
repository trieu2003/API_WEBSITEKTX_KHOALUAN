
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
using static System.Runtime.InteropServices.JavaScript.JSType;

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


        [HttpPost("nhan-phong")]
        public async Task<IActionResult> CheckIn([FromBody] NhanPhongRequestDTO request)
        {
            try
            {
                // Validate input
                if (request == null || string.IsNullOrEmpty(request.MaSV))
                {
                    return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
                }

                // Validate student
                var sinhVien = await _context.SinhVien
                    .Where(sv => sv.MaSV == request.MaSV)
                    .FirstOrDefaultAsync();

                if (sinhVien == null)
                {
                    return BadRequest(new { message = "Sinh viên không tồn tại." });
                }

                // Check for valid contract
                var hopDong = await _context.HopDongNoiTru
                    .Where(hd => hd.MaSV == request.MaSV
                        && hd.TrangThaiDuyet == "Đã duyệt"
                        && hd.TrangThai != "Đang sử dụng")// 3 trạng thái Đang sử dụng, Hủy, Kết thúc
                    .Include(hd => hd.Phong)
                        .ThenInclude(p => p.LoaiPhong)
                    .Include(hd => hd.Phong)
                        .ThenInclude(p => p.Tang)
                    .FirstOrDefaultAsync();

                if (hopDong == null)
                {
                    return BadRequest(new { message = "Bạn chưa có hợp đồng nội trú hợp lệ hoặc hợp đồng chưa được duyệt. Vui lòng liên hệ nhân viên." });
                }

                // Check if already checked in
                if (hopDong.TrangThai == "Đang sử dụng")
                {
                    return BadRequest(new { message = "Bạn đã nhận phòng trước đó. Không thể thực hiện lại thao tác." });
                }

                // Validate check-in date
                if (hopDong.NgayBatDau > DateTime.Today || (hopDong.NgayKetThuc != null && hopDong.NgayKetThuc < DateTime.Today))
                {
                    return BadRequest(new { message = $"Thời gian nhận phòng không hợp lệ. Vui lòng nhận phòng trong khoảng từ {hopDong.NgayBatDau:yyyy-MM-dd} đến {hopDong.NgayKetThuc:yyyy-MM-dd}." });
                }

                // Check payment status
                var phieuThu = await _context.PhieuThu
                    .Where(pt => pt.MaHopDong == hopDong.MaHopDong && pt.TrangThai == "Đã thanh toán")
                    .AnyAsync();

                if (!phieuThu)
                {
                    return BadRequest(new { message = "Hợp đồng chưa được thanh toán. Vui lòng hoàn tất thanh toán trước khi nhận phòng." });
                }

                // Check reservation if applicable
                //var datChoTruoc = await _context.DatChoTruoc
                //    .Where(dct => dct.MaSV == request.MaSV && dct.TrangThai == "Đã xác nhận" && dct.HanDat >= DateTime.Today)
                //    .FirstOrDefaultAsync();

                //if (datChoTruoc != null && datChoTruoc.MaChiTietPhong.HasValue)
                //{
                //    var chiTietPhong = await _context.ChiTietPhong
                //        .Where(ctp => ctp.MaChiTietPhong == datChoTruoc.MaChiTietPhong)
                //        .FirstOrDefaultAsync();

                //    if (chiTietPhong == null || chiTietPhong.TrangThai == "Đang sử dụng")
                //    {
                //        return BadRequest(new { message = "Giường được phân từ đặt trước đã được sử dụng. Vui lòng liên hệ nhân viên." });
                //    }
                //}

                // Check room status
                if (hopDong.Phong.TrangThai == "2")
                {
                    return BadRequest(new { message = "Phòng đã đủ người. Vui lòng liên hệ nhân viên." });
                }
                // Update bed status if assigned
                if (!string.IsNullOrEmpty(hopDong.MaGiuong))
                {
                    var chiTietPhong = await _context.ChiTietPhong
                        .Include(ctp => ctp.Giuong)
                        .FirstOrDefaultAsync(ctp =>
                            ctp.MaPhong == hopDong.MaPhong &&
                            ctp.MaGiuong == hopDong.MaGiuong);

                    if (chiTietPhong == null || chiTietPhong.Giuong.TrangThai == "Đã sử dụng")
                    {
                        return BadRequest(new { message = "Giường được phân đã được sử dụng. Vui lòng liên hệ nhân viên." });
                    }

                    chiTietPhong.Giuong.TrangThai = "Đã sử dụng";
                }

                // Update contract status
                hopDong.TrangThai = "Đang sử dụng";

                // Update reservation status if applicable
                //if (datChoTruoc != null)
                //{
                //    datChoTruoc.TrangThai = "Đã nhận phòng";
                //}

                // Update room status
                var currentOccupants = await _context.HopDongNoiTru
                    .Where(hd => hd.MaPhong == hopDong.MaPhong && hd.TrangThai == "Đang sử dụng")
                    .CountAsync();

                // Include the current student in the count
                currentOccupants += 1;

                if (hopDong.Phong.LoaiPhong?.SucChua != null && currentOccupants >= hopDong.Phong.LoaiPhong.SucChua)
                {
                    hopDong.Phong.TrangThai = "2";//Đã đủ người (đầy)
                }
                else
                {
                    hopDong.Phong.TrangThai = "1";//Chưa đầy
                }

                await _context.SaveChangesAsync();

                // Prepare room details response
                var giuong = await _context.ChiTietPhong
                    .Include(ctp => ctp.Giuong)
                    .Where(ctp => ctp.MaPhong == hopDong.MaPhong && ctp.MaGiuong == hopDong.MaGiuong)
                    .Select(ctp => new Giuong
                    {
                        MaGiuong = ctp.MaGiuong,
                        TrangThai = ctp.Giuong.TrangThai
                    })
                    .FirstOrDefaultAsync();

                var danhSachThietBi = await _context.ChiTietPhong
                        .Where(ctp => ctp.MaPhong == hopDong.MaPhong && ctp.MaThietBi != null)
                        .Select(ctp => ctp.TrangThietBi)
                        .Distinct()
                        .ToListAsync();

                var response = new NhanPhongResponseDTO
                {
                    MaPhong = hopDong.MaPhong,
                    TenPhong = hopDong.Phong.TenPhong,
                    TenTang = hopDong.Phong.Tang.TenTang,
                    TenLoaiPhong = hopDong.Phong.LoaiPhong.TenLoai,
                    SucChua = hopDong.Phong.LoaiPhong.SucChua,
                    MaGiuong = giuong?.MaGiuong,
                    DanhSachThietBi = danhSachThietBi
                };

                return Ok(new { message = "Nhận phòng thành công.", details = response });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ nhân viên.",
                    //error = ex.Message,
                    //stackTrace = ex.StackTrace // ✅ Chỉ nên bật khi debug
                });

            }
        }

        [HttpPost("tra-phong")]
        public async Task<IActionResult> Post([FromBody] TraPhongRequestDTO request)
        {
            try
            {
                // Validate input
                if (request == null || string.IsNullOrEmpty(request.MaSV))
                {
                    return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
                }

                // Validate student
                var student = await _context.SinhVien
                    .FirstOrDefaultAsync(sv => sv.MaSV == request.MaSV);

                if (student == null)
                {
                    return NotFound(new { message = "Sinh viên không tồn tại." });
                }

                // Check for valid contract
                var contract = await _context.HopDongNoiTru
                    .Include(hd => hd.Phong)
                    .FirstOrDefaultAsync(hd => hd.MaSV == request.MaSV
                        && hd.TrangThaiDuyet == "Đã duyệt"
                        && hd.TrangThai != "Kết thúc");

                if (contract == null)
                {
                    return BadRequest(new { message = "Bạn chưa có hợp đồng nội trú hợp lệ hoặc hợp đồng đã kết thúc." });
                }

                // Validate contract validity
                if (contract.TrangThai == "Kết thúc" || (contract.NgayKetThuc != null && contract.NgayKetThuc < DateTime.Today))
                {
                    return BadRequest(new { message = "Hợp đồng không hợp lệ hoặc đã kết thúc." });
                }

                // Check for outstanding payments
                var hasPendingPayments = await _context.PhieuThu
                    .AnyAsync(pt => pt.MaHopDong == contract.MaHopDong && pt.TrangThai == "Chưa thanh toán");

                if (hasPendingPayments)
                {
                    return BadRequest(new { message = "Bạn còn khoản nợ phí. Vui lòng thanh toán trước khi trả phòng." });
                }

                // Start transaction
                using var transaction = await _context.Database.BeginTransactionAsync();
                try
                {
                    // Update contract status
                    contract.TrangThai = "Kết thúc";
                    contract.NgayKetThuc = DateTime.Today; // Adjust end date to current date

                    // Update bed status if assigned
                    if (!string.IsNullOrEmpty(contract.MaGiuong))
                    {
                        var bedDetail = await _context.ChiTietPhong
                            .Include(ctp => ctp.Giuong)
                            .FirstOrDefaultAsync(ctp =>
                                ctp.MaPhong == contract.MaPhong &&
                                ctp.MaGiuong == contract.MaGiuong);

                        if (bedDetail?.Giuong != null)
                        {
                            bedDetail.Giuong.TrangThai = "1";
                        }
                    }

                    // Update room status
                    var remainingOccupants = await _context.HopDongNoiTru
                        .CountAsync(hd => hd.MaPhong == contract.MaPhong
                            && hd.TrangThai != "Kết thúc"
                            && (hd.NgayKetThuc == null || hd.NgayKetThuc >= DateTime.Today));

                    if (remainingOccupants == 0 && contract.Phong != null)
                    {
                        contract.Phong.TrangThai = "1";
                    }

                    // Remove or cancel reservation if applicable
                    //var reservations = await _context.DatChoTruoc
                    //    .Where(dct => dct.MaSV == request.MaSV)
                    //    .ToListAsync();

                    //if (reservations.Any())
                    //{
                    //    _context.DatChoTruoc.RemoveRange(reservations);
                    //}

                    // Save changes
                    await _context.SaveChangesAsync();
                    await transaction.CommitAsync();

                    return Ok(new { message = "Trả phòng thành công." });
                }
                catch
                {
                    await transaction.RollbackAsync();
                    throw;
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Lỗi hệ thống. Vui lòng thử lại sau hoặc liên hệ nhân viên.",
                    error = ex.Message,
                    stackTrace = ex.StackTrace // ✅ Chỉ nên bật khi debug
                });
            }
        }
    }
}
