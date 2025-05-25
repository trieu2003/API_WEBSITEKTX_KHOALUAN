
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
}
