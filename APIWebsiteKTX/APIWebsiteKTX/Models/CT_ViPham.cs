using Microsoft.EntityFrameworkCore;

[Keyless]
public class CT_ViPham
{
    public int MaViPham { get; set; }
    public string MaSV { get; set; }
    public string? HinhThucXuLy { get; set; }
    public string? MucDoXuLy { get; set; }
    public string? GhiChu { get; set; }
    public string? MaNV { get; set; }
}
