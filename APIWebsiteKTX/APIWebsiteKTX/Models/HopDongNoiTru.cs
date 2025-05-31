using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebsiteKTX.Models
{
    public class HopDongNoiTru
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int MaHopDong { get; set; } // Không gán khi thêm mới

        public string MaSV { get; set; }
        public string MaGiuong { get; set; }
        public string MaPhong { get; set; }
        public DateTime? NgayDangKy { get; set; }
        public DateTime? NgayBatDau { get; set; }
        public DateTime? NgayKetThuc { get; set; }
        public string? DotDangKy { get; set; }
        public string? NhomTruong { get; set; }
        public string? TrangThai { get; set; }
        public string? TrangThaiDuyet { get; set; }
        public string? PhuongThucThanhToan { get; set; }
        public string? MinhChungThanhToan { get; set; }
        public string? MaNamHoc { get; set; }
        public string? MaNV { get; set; }
        public Phong Phong { get; set; }
    }
    public class HopDongNoiTruRequest
    {
        [Key]
        public string MaSV { get; set; }
        public string MaGiuong { get; set; }
        public string MaPhong { get; set; }
    }
}
