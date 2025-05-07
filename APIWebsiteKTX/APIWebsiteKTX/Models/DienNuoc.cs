using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class DienNuoc
    {
        [Key]
        public int MaDN { get; set; }
        public string MaPhong { get; set; }
        public DateTime? NgayBatDau { get; set; }
        public DateTime? NgayKetThuc { get; set; }
        public int? SoDienCu { get; set; }
        public int? SoNuocCu { get; set; }
        public int? SoDienMoi { get; set; }
        public int? SoNuocMoi { get; set; }
        public int? MaMucGia { get; set; }
        public string MaNV { get; set; }
    }
}
