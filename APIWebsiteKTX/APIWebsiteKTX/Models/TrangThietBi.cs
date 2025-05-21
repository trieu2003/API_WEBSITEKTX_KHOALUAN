using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class TrangThietBi
    {
        // Các thuộc tính của thiết bị
        [Key]
        public string MaThietBi { get; set; }    // Mã thiết bị
        public string TenThietBi { get; set; } // Tên thiết bị
        public string MoTa { get; set; } // Loại thiết bị (ví dụ: máy lạnh, tủ lạnh, quạt...)
        public int SoLuong { get; set; }    // Tình trạng thiết bị (true - đang sử dụng, false - không sử dụng)
        public string TrangThai { get; set; } // Phòng sử dụng thiết bị
    }
}
