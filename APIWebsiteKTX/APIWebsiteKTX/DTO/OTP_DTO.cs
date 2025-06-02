namespace APIWebsiteKTX.DTO
{
    public class RequestOtpDTO
    {
        public string TenDangNhap { get; set; }
    }
    public class VerifyOtpDTO
    {
        public string TenDangNhap { get; set; }
        public string OTP { get; set; }
        public string NewPassword { get; set; }
    }
}