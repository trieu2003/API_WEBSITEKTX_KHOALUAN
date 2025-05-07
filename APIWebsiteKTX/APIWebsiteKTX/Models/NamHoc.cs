using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class NamHoc
    {
        [Key]
        public string MaNamHoc { get; set; }
        public string TenNamHoc { get; set; }
    }
}
