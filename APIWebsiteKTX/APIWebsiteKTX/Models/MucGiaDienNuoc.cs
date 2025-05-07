using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{

    public class MucGiaDienNuoc
    {
        [Key]
        public int MaMucGia { get; set; }
        public DateTime? ThoiGianApDung { get; set; }
        public decimal? DonGiaDien { get; set; }
        public decimal? DonGiaNuoc { get; set; }
    }
}
