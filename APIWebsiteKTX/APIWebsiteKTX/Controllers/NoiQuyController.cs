
using APIWebsiteKTX.Data;
using APIWebsiteKTX.DTO;
using APIWebsiteKTX.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace APIWebsiteKTX.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NoiQuyController : ControllerBase
    {
        private readonly KTXContext _context;

        public NoiQuyController(KTXContext context)
        {
            _context = context;
        }
        [HttpGet]
        public async Task<ActionResult<IEnumerable<NoiQuyDTO>>> GetRules()
        {
            try
            {
                var rules = await _context.NoiQuy
                    .Select(nq => new NoiQuyDTO
                    {
                        MaNoiQuy = nq.MaNoiQuy,
                        NoiDung = nq.NoiDung
                    })
                    .ToListAsync();

                if (!rules.Any())
                {
                    return Ok(new { status = "success", message = "Không có nội quy nào", data = new List<NoiQuyDTO>() });
                }

                return Ok(new { status = "success", data = rules });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { status = "error", message = "Lỗi server", error = ex.Message });
            }
        }
        
    }
}
