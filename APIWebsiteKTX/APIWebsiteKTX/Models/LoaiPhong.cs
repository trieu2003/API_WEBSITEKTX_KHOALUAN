using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class LoaiPhong
    {
        [Key]
        public string MaLoaiPhong { get; set; }
        public string TenLoai { get; set; }
        public int? SucChua { get; set; }
        public decimal? MucPhi { get; set; }
    }
}
