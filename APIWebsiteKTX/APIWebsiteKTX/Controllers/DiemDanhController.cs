
using APIWebsiteKTX.Data;
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
    public class DiemDanhController : ControllerBase
    {
        private readonly KTXContext _context;

        public DiemDanhController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet("sinhvien/{maSV}")]
        public async Task<IActionResult> GetDiemDanhTheoSinhVien(string maSV)
        {
            var danhSachDiemDanh = await _context.DiemDanh
                .Where(dd => dd.MaSV == maSV)
                .OrderByDescending(dd => dd.ThoiGian)
                .Select(dd => new DiemDanhResponseDTO
                {
                    MaDiemDanh = dd.MaDiemDanh,
                    MaSV = dd.MaSV,
                    ThoiGian = dd.ThoiGian,
                    TrangThai = dd.TrangThai ?? ""
                })
                .ToListAsync();

            return Ok(danhSachDiemDanh);
        }
        [HttpPost("/tim-kiem")]
        public async Task<IActionResult> TimKiemDiemDanhTheoSinhVien([FromBody] DiemDanhFilterRequestDTO request)
        {
            if (string.IsNullOrWhiteSpace(request.MaSV))
                return BadRequest("MaSV là bắt buộc.");

            var query = _context.DiemDanh
                .Where(dd => dd.MaSV == request.MaSV);

            if (request.TuNgay.HasValue)
                query = query.Where(dd => dd.ThoiGian >= request.TuNgay.Value);

            if (request.DenNgay.HasValue)
                query = query.Where(dd => dd.ThoiGian <= request.DenNgay.Value);

            if (!string.IsNullOrWhiteSpace(request.TrangThai))
                query = query.Where(dd => dd.TrangThai == request.TrangThai);

            var ketQua = await query
                .OrderByDescending(dd => dd.ThoiGian)
                .Select(dd => new DiemDanhResponseDTO
                {
                    MaDiemDanh = dd.MaDiemDanh,
                    MaSV = dd.MaSV,
                    ThoiGian = dd.ThoiGian,
                    TrangThai = dd.TrangThai ?? ""
                })
                .ToListAsync();

            return Ok(ketQua);
        }
    }
}
