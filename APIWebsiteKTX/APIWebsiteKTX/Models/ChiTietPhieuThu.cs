using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class ChiTietPhieuThu
    {
        public int MaChiTiet { get; set; }
        public int MaPhieuThu { get; set; }
        public string LoaiKhoanThu { get; set; }
        public decimal SoTien { get; set; }
        public PhieuThu PhieuThu { get; set; }
    }
}
