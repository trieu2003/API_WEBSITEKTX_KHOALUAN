public class DiemDanhResponseDTO
{
    public int MaDiemDanh { get; set; }
    public string MaSV { get; set; }
    public DateTime? ThoiGian { get; set; }
    public string TrangThai { get; set; }
}
public class DiemDanhFilterRequestDTO
{
    public string MaSV { get; set; }                  // Bắt buộc
    public DateTime? TuNgay { get; set; }             // Optional
    public DateTime? DenNgay { get; set; }            // Optional
    public string? TrangThai { get; set; }            // Optional
}