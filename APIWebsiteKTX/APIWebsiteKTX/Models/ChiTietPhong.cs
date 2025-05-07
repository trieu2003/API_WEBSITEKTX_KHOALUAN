using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class ChiTietPhong
    {
        [Key]
        public int MaChiTietPhong { get; set; }
        public string MaPhong { get; set; }
        public string MaThietBi { get; set; }
        public string Giuong { get; set; }
        public string TrangThai { get; set; }
    }
}

