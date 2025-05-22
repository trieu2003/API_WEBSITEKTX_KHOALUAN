using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class TrangThietBiDTO
    {
        public string MaThietBi { get; set; }
        public string TenThietBi { get; set; }
        public string MoTa { get; set; }
        public int? SoLuong { get; set; }
        public string TrangThai { get; set; }
    }
}
