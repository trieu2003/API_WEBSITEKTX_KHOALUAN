    
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
    public class HopDongNoiTruController : ControllerBase
    {
        private readonly KTXContext _context;

        public HopDongNoiTruController(KTXContext context)
        {
            _context = context;
        }
        [HttpPost("DangKyHopDong")]
        public async Task<IActionResult> DangKyHopDong([FromBody] HopDongNoiTruRequest model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            // Kiểm tra input
            if (string.IsNullOrEmpty(model.MaSV) || string.IsNullOrEmpty(model.MaGiuong) || string.IsNullOrEmpty(model.MaPhong))
            {
                return BadRequest(new { message = "Mã sinh viên, mã giường hoặc mã phòng không hợp lệ." });
            }
            // Kiểm tra sinh viên đã tồn tài hợp đồng chưa
            var hopdong = await _context.HopDongNoiTru.FirstOrDefaultAsync(s => s.MaSV == model.MaSV && s.TrangThai != "Hủy" && s.TrangThai != "Hết hạn sử dụng");
            if (hopdong != null)
            {
                return BadRequest(new { message = "Sinh viên đang có hợp và không đăng kí thêm." });
            }
            // Kiểm tra giường
            var giuong = await _context.Giuong.FirstOrDefaultAsync(g => g.MaGiuong == model.MaGiuong);
            if (giuong == null)
            {
                return NotFound(new { message = "Giường không tồn tại." });
            }
            if (giuong.TrangThai != "Trống")
            {
                return BadRequest(new { message = "Giường đã được đăng ký hoặc không ở trạng thái trống." });
            }

            var ngayDangKy = DateTime.Now;
            var ngayBatDau = ngayDangKy;

            // Tự động xác định DotDangKy theo tháng
            string dotDangKy;
            int thang = ngayDangKy.Month;
            if (thang >= 9 && thang <= 12)
                dotDangKy = "Học kỳ 1";
            else if (thang >= 1 && thang <= 6)
                dotDangKy = "Học kỳ 2";
            else
                dotDangKy = "Học kỳ hè";

            // Lấy mã năm học từ bảng NamHoc dựa trên năm hiện tại
            string maNamHoc = "NH" + ngayDangKy.Year;
            var namHoc = await _context.NamHoc.FirstOrDefaultAsync(n => n.MaNamHoc == maNamHoc);

            if (namHoc == null)
            {
                // Tạo bản ghi mới
                var tenNamHoc = $"{ngayDangKy.Year}-{ngayDangKy.Year + 1}";
                var newNamHoc = new NamHoc
                {
                    MaNamHoc = maNamHoc,
                    TenNamHoc = tenNamHoc
                };

                _context.NamHoc.Add(newNamHoc);
            }

            using var transaction = await _context.Database.BeginTransactionAsync();
            try
            {
                // Tạo hợp đồng
                var hopDong = new HopDongNoiTru
                {
                    MaSV = model.MaSV,
                    MaGiuong = model.MaGiuong,
                    MaPhong = model.MaPhong,
                    NgayDangKy = ngayDangKy,
                    NgayBatDau = ngayBatDau,
                    NgayKetThuc = ngayBatDau.AddYears(1),
                    DotDangKy = dotDangKy,
                    NhomTruong = "0",
                    TrangThai = "Chờ nhận phòng",
                    TrangThaiDuyet = "Chờ duyệt",
                    MaNamHoc = maNamHoc,
                    MaNV = "NV001",
                    PhuongThucThanhToan = "",
                    MinhChungThanhToan = ""
                };

                _context.HopDongNoiTru.Add(hopDong);

                // Cập nhật trạng thái giường
                giuong.TrangThai = "Đang chờ duyệt";
                _context.Giuong.Update(giuong);

                // Lưu thay đổi
                await _context.SaveChangesAsync();
                await transaction.CommitAsync();



                return Ok(new { message = "Đăng ký hợp đồng và cập nhật trạng thái giường thành công." });
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                return StatusCode(500, new
                {
                    message = "Đã xảy ra lỗi khi đăng ký hợp đồng.",
                    error = ex.InnerException?.Message ?? ex.Message
                });
            }
        }


        // r 
        [HttpPost("GiaHanHopDong")]
        public async Task<IActionResult> ExtendContract([FromBody] ExtendContractRequestDto request)
        {
            if (request == null)
            {
                return BadRequest(new { message = "Dữ liệu yêu cầu không hợp lệ." });
            }

            var hopDong = await _context.HopDongNoiTru
                .Where(hd => hd.MaSV == request.MaSV
                    && hd.TrangThaiDuyet == "Đã duyệt"
                    && hd.TrangThai != "Kết thúc"
                    && hd.NgayBatDau <= DateTime.Today)
                .Include(hd => hd.Phong)
                .FirstOrDefaultAsync();

            if (hopDong == null)
            {
                return BadRequest(new { message = "Sinh viên không có hợp đồng nội trú hợp lệ." });
            }
            //sau 30 ngày nếu hợp đồng đã kết thúc thì không thể gia hạn
            var maxExtensionDate = hopDong.NgayKetThuc?.AddDays(30) ?? DateTime.MaxValue;
            if (DateTime.Today > maxExtensionDate)
            {
                return BadRequest(new { message = "Hợp đồng đã hết hạn và không thể gia hạn. Vui lòng đăng ký nội trú mới." });
            }
            //thời gian gia hạn phải lớn hơn ngày kết thúc hiện tại
            if (request.NgayKetThucMoi <= DateTime.Today)
            {
                return BadRequest(new { message = "Thời gian gia hạn không hợp lệ. Vui lòng nhập lại." });
            }
            //thời gian gia hạn không được vượt quá 12 tháng kể từ ngày kết thúc hiện tại
            var maxExtensionPeriod = hopDong.NgayKetThuc?.AddMonths(12) ?? DateTime.MaxValue;
            if (request.NgayKetThucMoi > maxExtensionPeriod)
            {
                return BadRequest(new { message = "Thời gian gia hạn vượt quá giới hạn tối đa (12 tháng)." });
            }
            //không thể gia hạn nếu phòng đã đủ chỗ hoặc ngừng hoạt động
            var phong = hopDong.Phong;
            if (phong == null || phong.TrangThai == "2" || phong.TrangThai == "0")
            {
                return BadRequest(new { message = "Phòng hiện không khả dụng để gia hạn." });
            }

            // Tự động gán Mã năm học và Đợt đăng ký
            var currentYear = DateTime.Now.Year;
            var dotDangKy = DateTime.Now.Month switch
            {
                >= 9 and <= 12 => "Học kỳ 1",
                >= 1 and <= 6 => "Học kỳ 2",
                _ => "Học kỳ hè"
            };
            var maNamHoc = $"NH{currentYear}";

            // Kiểm tra mã năm học tồn tại
            var namHoc = await _context.NamHoc
                .FirstOrDefaultAsync(nh => nh.MaNamHoc == maNamHoc);

            if (namHoc == null)
            {
                // Tự động thêm năm học mới
                var tenNamHoc = $"{currentYear}-{currentYear + 1}";

                namHoc = new NamHoc
                {
                    MaNamHoc = maNamHoc,
                    TenNamHoc = tenNamHoc
                };

                _context.NamHoc.Add(namHoc);
                await _context.SaveChangesAsync();
            }

            // Cập nhật hợp đồng
            hopDong.NgayKetThuc = request.NgayKetThucMoi;
            hopDong.TrangThaiDuyet = "Chờ duyệt";
            hopDong.TrangThai = "Chờ nhận phòng";
            hopDong.DotDangKy = dotDangKy;
            hopDong.MaNamHoc = maNamHoc;
            hopDong.MaNV = null; // reset người duyệt

            await _context.SaveChangesAsync();

            return Ok(new { message = "Yêu cầu gia hạn đã được gửi thành công và đang chờ duyệt." });
        }

        [HttpGet("check/{maSV}")]
        public async Task<ActionResult<ContractStatusResponse>> CheckContract(string maSV)
        {
            var contract = await _context.HopDongNoiTru
                .Where(h => h.MaSV == maSV)
                .Select(h => new
                {
                    h.MaHopDong,
                    h.MaPhong,
                    h.MaGiuong,
                    h.NgayBatDau,
                    h.NgayKetThuc,
                    h.TrangThai,
                    h.TrangThaiDuyet
                })
                .FirstOrDefaultAsync();

            var response = new ContractStatusResponse();

            if (contract == null)
            {
                response.HasContract = false;
                response.Message = "Sinh viên chưa có hợp đồng nội trú.";
                response.ContractDetails = null;
            }
            else
            {
                response.HasContract = true;
                response.Message = "Sinh viên đã có hợp đồng nội trú.";
                response.ContractDetails = contract;
            }

            return Ok(response);
        }

        [HttpGet("GetAllByMaSV/{maSV}")]
        public async Task<IActionResult> GetAllContractsByMaSV(string maSV)
        {
            if (string.IsNullOrEmpty(maSV))
            {
                return BadRequest(new { message = "Mã sinh viên không được để trống." });
            }

            // Lấy danh sách hợp đồng của sinh viên
            var hopDongList = await _context.HopDongNoiTru
                .Where(hd => hd.MaSV == maSV)
                .ToListAsync();

            if (hopDongList == null || hopDongList.Count == 0)
            {
                return NotFound(new { message = "Không tìm thấy hợp đồng nội trú nào của sinh viên này." });
            }

            var maHopDongList = hopDongList.Select(hd => hd.MaHopDong).ToList();

            // Lấy các phiếu thu liên quan đến các hợp đồng này
            var phieuThus = await _context.PhieuThu
                .Where(pt => maHopDongList.Contains(pt.MaHopDong))
                .Select(pt => new { pt.MaPhieuThu, pt.MaHopDong, pt.TrangThai })
                .ToListAsync();

            if (phieuThus == null || phieuThus.Count == 0)
            {
                return NotFound(new { message = "Không tìm thấy phiếu thu nào liên quan đến hợp đồng của sinh viên này." });
            }

            var maPhieuThuList = phieuThus.Select(pt => pt.MaPhieuThu).ToList();

            // Lấy chi tiết phiếu thu loại "Hợp Đồng Nội Trú"
            var chiTietPhieuThus = await _context.ChiTietPhieuThu
                .Where(ct => maPhieuThuList.Contains(ct.MaPhieuThu) && ct.LoaiKhoanThu == "Hợp Đồng Nội Trú")
                .Select(ct => new { ct.MaPhieuThu })
                .ToListAsync();

            // Xác định hợp đồng nào đã thanh toán khoản "Hợp Đồng Nội Trú"
            var hopDongDaThanhToan = phieuThus
                .Where(pt => pt.TrangThai == "Đã thanh toán" && chiTietPhieuThus.Any(ct => ct.MaPhieuThu == pt.MaPhieuThu))
                .Select(pt => pt.MaHopDong)
                .Distinct()
                .ToHashSet();

            // Gộp kết quả trả về
            var result = hopDongList.Select(hd => new
            {
                hd.MaHopDong,
                hd.MaSV,
                hd.MaGiuong,
                hd.MaPhong,
                hd.NgayDangKy,
                hd.NgayBatDau,
                hd.NgayKetThuc,
                hd.DotDangKy,
                hd.NhomTruong,
                hd.TrangThai,
                hd.TrangThaiDuyet,
                hd.PhuongThucThanhToan,
                hd.MinhChungThanhToan,
                hd.MaNamHoc,
                DaThanhToanHopDongNoiTru = hopDongDaThanhToan.Contains(hd.MaHopDong)
            }).ToList();

            return Ok(result);
        }
        [HttpGet("GetContractIfFullyPaid/{maSV}")]
        public async Task<IActionResult> GetContractIfFullyPaid(string maSV)
        {
            if (string.IsNullOrEmpty(maSV))
                return BadRequest(new { message = "Mã sinh viên không được để trống." });

            // Lấy hợp đồng nội trú mới nhất của sinh viên
            var hopDong = await _context.HopDongNoiTru
                .Where(hd => hd.MaSV == maSV)
                .OrderByDescending(hd => hd.NgayDangKy)
                .FirstOrDefaultAsync();

            if (hopDong == null)
                return NotFound(new { message = "Không tìm thấy hợp đồng nội trú cho sinh viên này." });

            // Lấy các phiếu thu liên quan đến hợp đồng này
            var phieuThus = await _context.PhieuThu
                .Where(pt => pt.MaHopDong == hopDong.MaHopDong)
                .ToListAsync();

            if (phieuThus == null || phieuThus.Count == 0)
                return NotFound(new { message = "Không tìm thấy phiếu thu cho hợp đồng này." });

            var maPhieuThuList = phieuThus.Select(pt => pt.MaPhieuThu).ToList();

            // Lấy chi tiết phiếu thu loại "Hợp Đồng Nội Trú"
            var chiTietPhieuThus = await _context.ChiTietPhieuThu
                .Where(ct => maPhieuThuList.Contains(ct.MaPhieuThu) && ct.LoaiKhoanThu == "Hợp Đồng Nội Trú")
                .ToListAsync();

            if (chiTietPhieuThus == null || chiTietPhieuThus.Count == 0)
                return NotFound(new { message = "Không có khoản thu 'Hợp Đồng Nội Trú' nào cho hợp đồng này." });

            // Kiểm tra tất cả các phiếu thu loại "Hợp Đồng Nội Trú" đã được thanh toán chưa
            var phieuThuIdsWithHDNT = chiTietPhieuThus.Select(ct => ct.MaPhieuThu).Distinct().ToList();
            var allPaid = phieuThus
                .Where(pt => phieuThuIdsWithHDNT.Contains(pt.MaPhieuThu))
                .All(pt => pt.TrangThai == "Đã thanh toán");

            if (!allPaid)
                return BadRequest(new { message = "Sinh viên chưa thanh toán đầy đủ các khoản 'Hợp Đồng Nội Trú'." });

            // Lấy thông tin sinh viên
            var sinhVien = await _context.SinhVien
                .FirstOrDefaultAsync(sv => sv.MaSV == hopDong.MaSV);

            // Lấy thông tin phòng và loại phòng để lấy MucPhi
            var phong = await _context.Phong
                .FirstOrDefaultAsync(p => p.MaPhong == hopDong.MaPhong);

            decimal? mucPhi = null;
            if (phong != null)
            {
                var loaiPhong = await _context.LoaiPhong
                    .FirstOrDefaultAsync(lp => lp.MaLoaiPhong == phong.MaLoaiPhong);
                mucPhi = loaiPhong?.MucPhi;
            }

            // Trả về thông tin hợp đồng + sinh viên + mức phí phòng
            return Ok(new
            {
                hopDong.MaHopDong,
                hopDong.MaSV,
                hopDong.MaGiuong,
                hopDong.MaPhong,
                hopDong.NgayDangKy,
                hopDong.NgayBatDau,
                hopDong.NgayKetThuc,
                hopDong.DotDangKy,
                hopDong.NhomTruong,
                hopDong.TrangThai,
                hopDong.TrangThaiDuyet,
                hopDong.PhuongThucThanhToan,
                hopDong.MinhChungThanhToan,
                hopDong.MaNamHoc,
                // Thông tin sinh viên
                GioiTinh = sinhVien?.GioiTinh,
                SoHoKhau = sinhVien?.SoHoKhau,
                SoCanCuoc = sinhVien?.SoCanCuoc,
                Lop = sinhVien?.Lop,
                MaKhoa = sinhVien?.MaKhoa,
                SDT = sinhVien?.SDT,
                Email = sinhVien?.Email,
                // Mức phí phòng
                MucPhi = mucPhi
            });
        }


    }
}
