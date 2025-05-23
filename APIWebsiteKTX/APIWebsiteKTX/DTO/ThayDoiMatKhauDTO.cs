namespace APIWebsiteKTX.DTO
{
    public class ThayDoiMatKhauDTO
    {
        public string MaSV { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }
    public class ThayDoiMatKhauPhanHoiDTO
    {
        internal string Error;
        public string Status { get; set; }
        public string Message { get; set; }
    }
}

