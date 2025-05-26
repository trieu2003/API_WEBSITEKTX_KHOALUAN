using APIWebsiteKTX.Models;
using System.Security.Cryptography.Xml;

namespace APIWebsiteKTX.DTO
{
    public class NhanPhongRequestDTO
    {
        public string MaSV { get; set; }
    }
    public class NhanPhongResponseDTO
    {
        public string MaPhong { get; set; }
        public string TenPhong { get; set; }
        public string TenTang { get; set; }
        public string TenLoaiPhong { get; set; }
        public int? SucChua { get; set; }
        public string MaGiuong { get; set; }
        public List<TrangThietBi> DanhSachThietBi { get; set; }
    }
}

