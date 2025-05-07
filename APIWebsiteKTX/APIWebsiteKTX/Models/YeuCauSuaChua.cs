using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class YeuCauSuaChua
    {
        [Key]
        public int MaYCSC { get; set; }        // Mã yêu cầu sửa chữa (khóa chính, tự động tăng)
        public string MaSV { get; set; }       // Mã sinh viên (liên kết với bảng SinhVien)
        public string MaPhong { get; set; }    // Mã phòng (liên kết với bảng Phong)
        public string MoTa { get; set; }       // Mô tả yêu cầu sửa chữa
        public DateTime? NgayGui { get; set; } // Ngày gửi yêu cầu
        public string TrangThai { get; set; }  // Trạng thái yêu cầu sửa chữa
        public string MaNV { get; set; }       // Mã nhân viên xử lý yêu cầu sửa chữa
    }
}
