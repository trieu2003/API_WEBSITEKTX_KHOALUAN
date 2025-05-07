using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class ViPham
    {
        [Key]
        public int MaViPham { get; set; }        // Mã vi phạm (khóa chính, tự động tăng)
        public string MaSV { get; set; }          // Mã sinh viên (liên kết với SinhVien)
        public int? MaNoiQuy { get; set; }       // Mã nội quy (liên kết với bảng Nội Quy, có thể là null)
        public DateTime? NgayViPham { get; set; } // Ngày vi phạm (có thể là null)
        public string GhiChu { get; set; }       // Ghi chú thêm (có thể là null)
        public string HinhThucXuLy { get; set; } // Hình thức xử lý vi phạm
        public string MucDoXuLy { get; set; }    // Mức độ xử lý
        public string MaNV { get; set; }         // Mã nhân viên xử lý vi phạm (liên kết với nhân viên)
        public string FileBienBan { get; set; }  // Đường dẫn file biên bản (có thể là null)
    }
}
