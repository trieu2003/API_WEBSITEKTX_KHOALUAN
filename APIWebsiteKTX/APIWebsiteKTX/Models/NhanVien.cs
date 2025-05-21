using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class NhanVien
    {
        [Key]
        public string MaNV { get; set; }
        public int? MaNguoiDung { get; set; }
        public string HoTen { get; set; }
        public string GioiTinh { get; set; }
        public DateTime? NgaySinh { get; set; }
        public String AnhDaiDien { get; set; }
        public string Email { get; set; }
        public string SDT { get; set; }
        public string ChucVu { get; set; }
        public string TrinhDo { get; set; }
    }
}
