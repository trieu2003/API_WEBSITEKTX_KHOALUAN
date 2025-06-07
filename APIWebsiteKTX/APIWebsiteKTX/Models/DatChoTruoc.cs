using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class DatChoTruoc
    {
        [Key]
        public int MaDatCho { get; set; }
        public string MaSV { get; set; }
        public int? MaChiTietPhong { get; set; }
        public DateTime? NgayDat { get; set; }
        public DateTime? HanDat { get; set; }
        public string? TrangThai { get; set; }
    }
}
