using APIWebsiteKTX.DTO;

public class HopDongVaPhieuThuDTO
{
    public int MaHopDong { get; set; }
    public string MaPhong { get; set; }
    public string MaGiuong { get; set; }
    public DateTime NgayBatDau { get; set; }
    public DateTime NgayKetThuc { get; set; }
    public string PhuongThucThanhToan { get; set; }
    public List<PhieuThuResponseDTO> DanhSachPhieuThu { get; set; }
}