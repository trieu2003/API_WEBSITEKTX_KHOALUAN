using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class NguoiDung
    {
        public int MaNguoiDung { get; set; }
        public string TenDangNhap { get; set; }
        public string MatKhau { get; set; }
        public string? VaiTro { get; set; }
        public string? OTP { get; set; }
    }
}
