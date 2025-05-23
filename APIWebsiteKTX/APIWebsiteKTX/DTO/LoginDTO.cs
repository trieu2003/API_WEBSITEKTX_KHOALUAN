using System.ComponentModel.DataAnnotations;
namespace KTXApi.DTO
{
    public class LoginRequestDTO
    {
        [Required] 
        public string TenDangNhap { get; set; }
        [Required] 
        public string MatKhau { get; set; }
    }
    public class LoginResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string VaiTro { get; set; }
    }
}