using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class PhongDTO
    {
        public string MaPhong { get; set; }
        public string TenPhong { get; set; }
        public string MaLoaiPhong { get; set; }
        public string TenLoaiPhong { get; set; }
        public int? SucChua { get; set; }
        public decimal? MucPhi { get; set; }
        public string MaTang { get; set; }
        public string TenTang { get; set; }
        public string TrangThai { get; set; }
        public List<TrangThietBiDTO> ThietBis { get; set; }
        public List<GiuongDTO> Giuongs { get; set; }
    }
}
