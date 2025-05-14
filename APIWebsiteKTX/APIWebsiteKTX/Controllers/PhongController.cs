
using APIWebsiteKTX.Data;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

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


        // DTO cho kết quả sp_GetRooms
        public class RoomDto
        {
            public string MaPhong { get; set; }
            public string TenPhong { get; set; }
            public string MaLoaiPhong { get; set; }
            public string LoaiPhong { get; set; }
            public int? SucChua { get; set; }
            public decimal? MucPhi { get; set; }
            public string MaTang { get; set; }
            public string TenTang { get; set; }
            public string TrangThai { get; set; }
        }

        // DTO cho kết quả sp_GetRoomDetails
        public class RoomDetailDto
        {
            public string MaPhong { get; set; }
            public string TenPhong { get; set; }
            public string MaLoaiPhong { get; set; }
            public string LoaiPhong { get; set; }
            public int? SucChua { get; set; }
            public decimal? MucPhi { get; set; }
            public string MaTang { get; set; }
            public string TenTang { get; set; }
            public string TrangThai { get; set; }

            public List<RoomBedDto> Beds { get; set; }
        }

        public class RoomBedDto
        {
            public int MaChiTietPhong { get; set; }
            public string MaGiuong { get; set; }
            public string TenGiuong { get; set; }
            public string MaThietBi { get; set; }
            public string TenThietBi { get; set; }
            public string TrangThaiChiTiet { get; set; }
        }

        // PhongController.cs

        [HttpGet]
        public async Task<ActionResult<IEnumerable<RoomDto>>> GetRooms([FromQuery] string trangThai = null)
        {
            // EF Core sẽ sinh câu: EXEC sp_GetRooms @TrangThai = N'Hoạt động' hoặc EXEC sp_GetRooms NULL
            var sql = string.IsNullOrEmpty(trangThai)
                ? "EXEC sp_GetRooms"
                : "EXEC sp_GetRooms @TrangThai = {0}";

            var list = string.IsNullOrEmpty(trangThai)
                ? await _context.RoomDtos.FromSqlRaw(sql).ToListAsync()
                : await _context.RoomDtos.FromSqlRaw(sql, trangThai).ToListAsync();

            return list;
        }
        // PhongController.cs

        [HttpGet("{maPhong}")]
        public async Task<ActionResult<RoomDetailDto>> GetRoomDetails(string maPhong)
        {
            // Dùng ADO.NET để xử lý multiple resultsets
            using var conn = (SqlConnection)_context.Database.GetDbConnection();
            await conn.OpenAsync();
            using var cmd = new SqlCommand("sp_GetRoomDetails", conn)
            {
                CommandType = CommandType.StoredProcedure
            };
            cmd.Parameters.AddWithValue("@MaPhong", maPhong);

            RoomDetailDto detail = null;
            using var reader = await cmd.ExecuteReaderAsync();

            // ResultSet #1: Thông tin chung
            if (await reader.ReadAsync())
            {
                detail = new RoomDetailDto
                {
                    MaPhong = reader.GetString("MaPhong"),
                    TenPhong = reader.GetString("TenPhong"),
                    MaLoaiPhong = reader.GetString("MaLoaiPhong"),
                    LoaiPhong = reader.GetString("LoaiPhong"),
                    SucChua = reader.IsDBNull("SucChua") ? null : reader.GetInt32("SucChua"),
                    MucPhi = reader.IsDBNull("MucPhi") ? null : reader.GetDecimal("MucPhi"),
                    MaTang = reader.GetString("MaTang"),
                    TenTang = reader.GetString("TenTang"),
                    TrangThai = reader.GetString("TrangThai"),
                    Beds = new List<RoomBedDto>()
                };
            }

            // Move to ResultSet #2: Beds & Equipment
            if (detail != null && await reader.NextResultAsync())
            {
                while (await reader.ReadAsync())
                {
                    detail.Beds.Add(new RoomBedDto
                    {
                        MaChiTietPhong = reader.GetInt32("MaChiTietPhong"),
                        MaGiuong = reader.IsDBNull("MaGiuong") ? null : reader.GetString("MaGiuong"),
                        TenGiuong = reader.IsDBNull("TenGiuong") ? null : reader.GetString("TenGiuong"),
                        MaThietBi = reader.IsDBNull("MaThietBi") ? null : reader.GetString("MaThietBi"),
                        TenThietBi = reader.IsDBNull("TenThietBi") ? null : reader.GetString("TenThietBi"),
                        TrangThaiChiTiet = reader.GetString("TrangThaiChiTiet")
                    });
                }
            }

            if (detail == null)
                return NotFound();

            return detail;
        }

    }
}
