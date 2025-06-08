namespace APIWebsiteKTX.DTO
{
    public class SinhVienRequestDTO
    {

        public string? MaSV { get; set; }
        public string? SDT { get; set; }
        public string? Email { get; set; }
        public string? SDTGiaDinh { get; set; }
    }
    public class SinhVienResponseDTO
    {
        public int MaNguoiDung { get; set; }
        public string TenNguoiDung { get; set; } = string.Empty; // Assuming this is required, otherwise make it nullable
        public string? VaiTro { get; set; }
        public string? MaSV { get; set; }
        public string? HoTen { get; set; }
        public string? GioiTinh { get; set; }
        public string? NgaySinh { get; set; }
        public string? Lop { get; set; }
        public string? SDT { get; set; }
        public string? Email { get; set; }
        public string? SoCanCuoc { get; set; }
        public string? SDTGiaDinh { get; set; }
        public string? SoHoKhau { get; set; }
        public string? TrangThai { get; set; }
        public string? AnhDaiDien { get; set; }
        public string? MaKhoa { get; set; }
        public string? TenKhoa { get; set; }
    }
}
