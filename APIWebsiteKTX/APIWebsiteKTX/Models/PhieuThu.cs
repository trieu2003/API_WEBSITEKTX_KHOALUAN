using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class PhieuThu
    {
        [Key]
        public int MaPhieuThu { get; set; }
        public int? MaHopDong { get; set; }
        public DateTime? NgayLap { get; set; }
        public decimal? TongTien { get; set; }
        public string TrangThai { get; set; }
        public string MaNV { get; set; }
    }
}
