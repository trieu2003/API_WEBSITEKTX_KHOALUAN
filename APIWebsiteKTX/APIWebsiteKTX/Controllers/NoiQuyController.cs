
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
    public class NoiQuyController : ControllerBase
    {
        private readonly KTXContext _context;

        public NoiQuyController(KTXContext context)
        {
            _context = context;
        }
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NoiQuyDTO>>> GetRules()
        {
            try
            {
                var rules = await _context.NoiQuy
                    .Select(nq => new NoiQuyDTO
                    {
                        MaNoiQuy = nq.MaNoiQuy,
                        NoiDung = nq.NoiDung
                    })
                    .ToListAsync();

                if (!rules.Any())
                {
                    return Ok(new { status = "success", message = "Không có nội quy nào", data = new List<NoiQuyDTO>() });
                }

                return Ok(new { status = "success", data = rules });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { status = "error", message = "Lỗi server", error = ex.Message });
            }
        }

        // trieeu
        //API 1 – Lấy danh sách tầng
        [HttpGet("tang")]
        public IActionResult GetAllTang()
        {
            var tangs = _context.Tang
                .Select(t => new
                {
                    t.MaTang,
                    t.TenTang
                })
                .ToList();
            return Ok(tangs);
        }
        // API 2 – Lấy danh sách phòng theo tầng
        [HttpGet("phong-by-tang/{maTang}")]
        public IActionResult GetPhongByTang(string maTang)
        {
            var phongList = _context.Phong
                .Where(p => p.MaTang == maTang && p.TrangThai == "Trống")
                .Select(p => new
                {
                    p.MaPhong,
                    p.TenPhong,
                    p.TrangThai
                })
                .ToList();

            return Ok(phongList);
        }
        //API lấy tất cả phòng(theo tầng hoặc tất cả tầng)
        // Lấy tất cả phòng (có thể thêm lọc tầng nếu cần)
        [HttpGet("phong")]
        public IActionResult GetAllPhong()
        {
            var phongList = _context.Phong
                .Select(p => new
                {
                    p.MaPhong,
                    p.TenPhong,
                    p.MaTang,
                    p.TrangThai
                })
                .ToList();

            return Ok(phongList);
        }
        //API lấy tất cả chi tiết phòng theo phòng
        // Lấy chi tiết phòng theo MaPhong
        [HttpGet("chitietphong-by-phong/{maPhong}")]
        public IActionResult GetChiTietPhongByPhong(string maPhong)
        {
            var chiTietPhongList = _context.ChiTietPhong
                .Where(ct => ct.MaPhong == maPhong)
            .Select(ct => new
            {
                ct.MaChiTietPhong,
                ct.MaPhong,
                ct.MaThietBi,
                TenThietBi = _context.TrangThietBi.FirstOrDefault(tb => tb.MaThietBi == ct.MaThietBi).TenThietBi,
                //MaGiuong = _context.Giuong.FirstOrDefault(g => g.MaGiuong == ct.Giuong).MaGiuong,
                //TrangThai = _context.Giuong.FirstOrDefault(g => g.MaGiuong == ct.Giuong).TrangThai == "Trống"
            }).ToList();


            if (chiTietPhongList.Count == 0)
                return NotFound("Không tìm thấy chi tiết phòng cho phòng này.");

            return Ok(chiTietPhongList);
        }
        // API lấy giường trống theo chi tiết phòng (hoặc theo giường trong chi tiết phòng)// Lấy giường trống theo MaChiTietPhong (nếu có bảng Giường hoặc dựa vào thuộc tính Giuong trong ChiTietPhong)
        [HttpGet("giuong-trong-by-chitietphong/{maChiTietPhong}")]
        public IActionResult GetGiuongTrongByChiTietPhong(int maChiTietPhong)
        {
            var giuongTrongList = _context.ChiTietPhong
                .Where(ct => ct.MaChiTietPhong == maChiTietPhong)
                .Select(ct => new
                {
                    ct.MaChiTietPhong,
                    ct.MaPhong,
                    ct.MaThietBi,
                    ct.Giuong
                })
                .ToList();

            if (giuongTrongList.Count == 0)
                return NotFound("Không tìm thấy giường trống.");

            return Ok(giuongTrongList);
        }


        // API 3 – Lấy danh sách giường theo phòng
        [HttpGet("giuong-by-chitietphong/{maChiTietPhong}")]
        public IActionResult GetGiuongByChiTietPhong(int maChiTietPhong)
        {
            var chitiet = _context.ChiTietPhong
                .Where(ct => ct.MaChiTietPhong == maChiTietPhong)
                .Select(ct => new
                {
                    ct.MaChiTietPhong,
                    ct.MaPhong,
                    ct.MaThietBi,
                    ct.Giuong
                })
                .ToList();

            if (chitiet == null || chitiet.Count == 0)
            {
                return NotFound("Không tìm thấy giường trong chi tiết phòng này.");
            }

            return Ok(chitiet);
        }

        [HttpPost("dang-ky")]
        public IActionResult DangKyGiuong([FromBody] HopDongNoiTru hopDong)
        {
            if (hopDong == null || string.IsNullOrEmpty(hopDong.MaSV) || string.IsNullOrEmpty(hopDong.MaGiuong))
                return BadRequest("Thiếu thông tin sinh viên hoặc giường.");

            var giuong = _context.Giuong.FirstOrDefault(g => g.MaGiuong == hopDong.MaGiuong);
            if (giuong == null || giuong.TrangThai != "Trống")
                return BadRequest("Giường không tồn tại hoặc không còn trống.");

            // Lấy thông tin phòng từ giường
            var phong = _context.Phong.FirstOrDefault(p => p.MaPhong == giuong.MaGiuong);
            if (phong == null)
                return BadRequest("Không tìm thấy thông tin phòng.");

            // Cập nhật trạng thái giường thành "Đã đăng ký"
            giuong.TrangThai = "Đã đăng ký";
            _context.Giuong.Update(giuong);

            // Tạo hợp đồng mới
            hopDong.MaPhong = phong.MaPhong;
            hopDong.TrangThai = "Chờ duyệt";
            hopDong.TrangThaiDuyet = "Chưa duyệt";
            hopDong.NgayDangKy = DateTime.Now;
            hopDong.NgayBatDau ??= DateTime.Now;
            hopDong.NgayKetThuc ??= DateTime.Now.AddMonths(6); // mặc định 6 tháng

            _context.HopDongNoiTru.Add(hopDong);
            _context.SaveChanges();

            return Ok(new
            {
                success = true,
                message = "Đăng ký thành công. Hợp đồng đang chờ duyệt.",
                hopDongId = hopDong.MaHopDong
            });
        }


        // Model nhận dữ liệu đăng ký
        public class DangKyRequest
        {
            public string SinhVienId { get; set; }
            public int GiuongId { get; set; }
            public DateTime NgayBatDau { get; set; }
            public DateTime NgayKetThuc { get; set; }
        }

    }
}
