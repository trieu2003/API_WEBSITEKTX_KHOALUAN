using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class DiemDanh
    {
        [Key]
        public int MaDiemDanh { get; set; }
        public string MaSV { get; set; }
        public DateTime ThoiGian { get; set; }
        public string TrangThai { get; set; } // "Có mặt", "Vắng mặt", "Nghỉ phép"
    }
}
