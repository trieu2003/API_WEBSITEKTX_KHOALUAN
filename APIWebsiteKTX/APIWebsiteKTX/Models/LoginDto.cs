using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class LoginDto
    {
        [Required]
        public string TenDangNhap { get; set; }

        [Required]
        public string MatKhau { get; set; }
    }
}
