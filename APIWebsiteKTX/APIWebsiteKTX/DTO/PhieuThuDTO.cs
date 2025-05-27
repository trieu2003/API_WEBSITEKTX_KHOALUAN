namespace APIWebsiteKTX.DTO
{
    public class ChiTietPhieuThuDTO
    {
        public string LoaiKhoanThu { get; set; }
        public decimal SoTien { get; set; }
    }

    public class PhieuThuDTO
    {
        public int MaPhieuThu { get; set; }
        public DateTime NgayLap { get; set; }
        public decimal TongTien { get; set; }
        public string TrangThai { get; set; }
        public string MaNV { get; set; }
        public List<ChiTietPhieuThuDTO> ChiTietPhieuThu { get; set; }
    }
}