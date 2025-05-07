using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class Giuong
    {
        [Key]
        public string MaGiuong { get; set; }
        public string TenGiuong { get; set; }
    }
}
