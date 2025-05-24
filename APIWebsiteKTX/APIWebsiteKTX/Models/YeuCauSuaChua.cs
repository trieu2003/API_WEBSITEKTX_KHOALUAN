using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class YeuCauSuaChua
    {

        public int MaYCSC { get; set; }
        public string MaSV { get; set; }
        public string MaPhong { get; set; } // Scalar foreign key property
        public string MoTa { get; set; }
        public DateTime? NgayGui { get; set; }
        public string TrangThai { get; set; }
        public string MaNV { get; set; }
        public SinhVien SinhVien { get; set; } // Navigation property
        public Phong Phong { get; set; } // Navigation property     // Mã nhân viên xử lý yêu cầu sửa chữa
        public NhanVien NhanVien { get; set; }
    }
}
