using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace APIWebsiteKTX.Models
{
    public class SinhVien
    {
        public string MaSV { get; set; }
        public int? MaNguoiDung { get; set; }
        public string? HoTen { get; set; }
        public string? GioiTinh { get; set; }
        public string? NgaySinh { get; set; }
        public string? Lop { get; set; }
        public string? SDT { get; set; }
        public string? Email { get; set; }
        public string? SoCanCuoc { get; set; }
        public string? SDTGiaDinh { get; set; }
        public string? SoHoKhau { get; set; }
        public string? TrangThai { get; set; }
        public string? AnhDaiDien { get; set; }
        public string? MaKhoa { get; set; } // Nullable to match schema

        public Khoa?  Khoa { get; set; } // Navigation property
        [ForeignKey("MaNguoiDung")]
        public NguoiDung? NguoiDung { get; set; } // Navigation property
    }

    public class StudentResponse
    {
        public string? MaSV { get; set; }
        public string? HoTen { get; set; }
        public string? GioiTinh { get; set; }
        public string? NgaySinh { get; set; }
        public string? Lop { get; set; }
        public string? SDT { get; set; }
        public string? Email { get; set; }
        public string? SoCanCuoc { get; set; }
        public string? SDTGiaDinh { get; set; }
        public string? SoHoKhau { get; set; }
        public string? TrangThai { get; set; }
        public string? AnhDaiDien { get; set; }
        public string? MaKhoa { get; set; }
        public string? TenKhoa { get; set; }
        public string Token { get; set; }
    }
}
