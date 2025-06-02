using APIWebsiteKTX.Models;

namespace APIWebsiteKTX.DTO
{
    public class ThanhToanRequestDTO
    {
        public string MaSV { get; set; }
        public string PhuongThucThanhToan { get; set; }
        public string MinhChungThanhToan { get; set; }
    }
    public class ChiTietPhieuThuItem
    {
        public string LoaiKhoanThu { get; set; }
        public decimal SoTien { get; set; }
    }
    public class ThanhToanResponseDTO
    {
        public int MaPhieuThu { get; set; }
        public int MaHopDong { get; set; }
        public DateTime NgayLap { get; set; }
        public decimal TongTien { get; set; }
        public string TrangThai { get; set; }
        public string MaNV { get; set; }
        public List<PhieuThu> PhieuThus { get; set; }
        public string Message { get; set; }
    }
}