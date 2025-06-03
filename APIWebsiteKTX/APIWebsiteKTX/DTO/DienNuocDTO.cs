public class DienNuocDTO
{
    public int MaDN { get; set; }
    public DateTime NgayBatDau { get; set; }
    public DateTime NgayKetThuc { get; set; }
    public int SoDienCu { get; set; }
    public int SoDienMoi { get; set; }
    public int SoNuocCu { get; set; }
    public int SoNuocMoi { get; set; }
}
public class ThanhToanDienNuocRequestDTO
{
    public string MaSV { get; set; }          // Mã sinh viên nhóm trưởng
}
public class ThanhToanDienNuocReponseDTO
{
    public int MaPhieuThu { get; set; }
    public string MaSV { get; set; }
    public decimal TongTien { get; set; }
}
public class MucGiaDienNuocDTO
{
    public int MaMucGia { get; set; }
    public DateTime? ThoiGianApDung { get; set; }
    public decimal DonGiaDien { get; set; }
    public decimal DonGiaNuoc { get; set; }
}