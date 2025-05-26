using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebsiteKTX.Models
{
    public class ChiTietPhong
    {
        [Key]
        public int MaChiTietPhong { get; set; }

        [ForeignKey("Phong")]
        public string MaPhong { get; set; }

        public string MaThietBi { get; set; }
        [ForeignKey("Giuong")]
        [Column("Giuong")]
        public string MaGiuong { get; set; }
        public Phong Phong { get; set; }
        public TrangThietBi TrangThietBi { get; set; }
        public Giuong Giuong { get; set; }
    }
}

