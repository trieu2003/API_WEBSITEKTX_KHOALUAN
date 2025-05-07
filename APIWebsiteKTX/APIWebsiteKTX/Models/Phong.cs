using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class Phong
    {
        [Key]
        public string MaPhong { get; set; }  // Room ID
        public string TenPhong { get; set; }  // Room Name or Type
        public string MaLoaiPhong { get; set; }  // Room Type ID
        public int MaTang { get; set; }  // Capacity
   //     public decimal MucPhi { get; set; }  // Fee
        public string TrangThai { get; set; }  // Room Status (e.g., Available, Occupied)
    //    public string MaKhoa { get; set; }  // Associated Faculty or Department
    }
}
