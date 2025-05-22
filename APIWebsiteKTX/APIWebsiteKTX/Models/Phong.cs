using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace APIWebsiteKTX.Models
{
    public class Phong
    {
        [Key] public string MaPhong { get; set; }
        public string TenPhong { get; set; }
        public string MaLoaiPhong { get; set; }
        public string MaTang { get; set; }
        public string TrangThai { get; set; }
        [ForeignKey("MaLoaiPhong")]
        public LoaiPhong LoaiPhong { get; set; }

        [ForeignKey("MaTang")]
        public Tang Tang { get; set; }

        public ICollection<ChiTietPhong> ChiTietPhongs { get; set; }
    }
}
