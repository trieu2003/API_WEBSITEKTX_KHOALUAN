using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class Tang
    {
        // Các thuộc tính của tầng
        [Key]
        public int MaTang { get; set; }   // Mã tầng
        public string TenTang { get; set; } // Tên tầng (Ví dụ: Tầng 1, Tầng 2)
     //   public int SoPhong { get; set; }   // Số phòng trên tầng
     //   public string GhiChu { get; set; }  // Ghi chú (ví dụ: thông tin bổ sung)
    }
}
