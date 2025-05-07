using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.Models
{
    public class NoiQuy
    {
        [Key]
        public int MaNoiQuy { get; set; }
        public string NoiDung { get; set; }
    }
}
