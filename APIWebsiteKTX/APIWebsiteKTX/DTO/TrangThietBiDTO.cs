using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace APIWebsiteKTX.DTO
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
