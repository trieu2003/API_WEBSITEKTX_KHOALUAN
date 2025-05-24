using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class ChiTietSuaChua
    {
        

        [Key]
        public int MaChiTiet { get; set; }
        public int? MaYCSC { get; set; }
        public string MaThietBi { get; set; }
        public string MoTaLoi { get; set; }
        public YeuCauSuaChua YeuCauSuaChua;
        public TrangThietBi TrangThietBi { get; set; }
    }
}
