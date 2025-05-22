using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class Tang
    {
        [Key]
        public string MaTang { get; set; }
        public string TenTang { get; set; }
    }
}
