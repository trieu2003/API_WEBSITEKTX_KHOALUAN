using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class SinhVien
    {
        [Key]
        public string MaSV { get; set; }        // Mã sinh viên
        public int? MaNguoiDung { get; set; }   // Mã người dùng (nullable)
        public string? HoTen { get; set; }       // Họ tên

        public string GioiTinh { get; set; }       // Giới tính
        public string NgaySinh { get; set; } // Ngày sinh (nullable, kiểu DateTime)
        public string Lop { get; set; }         // Lớp
        public string SDT { get; set; }         // Số điện thoại
        public string Email { get; set; }       // Email
        public string SoCanCuoc { get; set; }   // Số căn cước công dân
        public string SDTGiaDinh { get; set; } // Số điện thoại gia đình
        public string SoHoKhau { get; set; }    // Số hộ khẩu
        public string TrangThai { get; set; }   // Trạng thái
        public string ? AnhDaiDien { get; set; }  // Đường dẫn ảnh đại diện
        public string MaKhoa { get; set; }      // Mã khoa
    }

    public class SinhVienDto
    {
        public string MaSV { get; set; }                // Mã sinh viên
        public int? MaNguoiDung { get; set; }           // Mã người dùng
        public string HoTen { get; set; }               // Họ tên
        public string GioiTinh { get; set; }            // Giới tính
        public string NgaySinh { get; set; }         // Ngày sinh
        public string Lop { get; set; }                 // Lớp
        public string SDT { get; set; }                 // Số điện thoại
        public string Email { get; set; }               // Email
        public string SoCanCuoc { get; set; }           // Số căn cước công dân
        public string SDTGiaDinh { get; set; }          // Số điện thoại gia đình
        public string SoHoKhau { get; set; }            // Số hộ khẩu
        public string TrangThai { get; set; }           // Trạng thái
        public string? AnhDaiDien { get; set; }          // Ảnh đại diện
        public string MaKhoa { get; set; }              // Mã khoa
    }
}
