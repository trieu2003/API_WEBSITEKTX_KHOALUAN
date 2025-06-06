
namespace APIWebsiteKTX.DTO
{
    public class RepairRequestDTO
    {
        public string MaSV { get; set; }
        public string MoTa { get; set; }
        public List<RepairDetailDTO> ChiTietSuaChua { get; set; }
    }
    public class RepairDetailDTO
    {
        public string MaThietBi { get; set; }
        public string MoTaLoi { get; set; }
    }
    public class RepairDetailResponse
    {
        public int MaChiTiet { get; set; }
        public string MaThietBi { get; set; }
        public string MoTaLoi { get; set; }
    }

    public class RepairRequestResponse
    {
        public int MaYCSC { get; set; }
        public string MaPhong { get; set; }
        public string MoTa { get; set; }
        public DateTime? NgayGui { get; set; }
        public string TrangThai { get; set; }
        public string MaNV { get; set; }
        public List<RepairDetailResponse> ChiTietSuaChua { get; set; }
    }
}
