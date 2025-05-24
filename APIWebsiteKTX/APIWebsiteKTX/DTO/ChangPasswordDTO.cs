namespace APIWebsiteKTX.DTO
{
    public class ChangPasswordDTO
    {
        public string MaSV { get; set; }
        public string OldPassword { get; set; }
        public string NewPassword { get; set; }
    }
    public class ChangePasswordResponseDTO
    {
        internal string Error;
        public string Status { get; set; }
        public string Message { get; set; }
    }
}

