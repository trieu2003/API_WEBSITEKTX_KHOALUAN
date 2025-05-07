
using APIWebsiteKTX.Data;
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
    public class ChiTietPhieuThuController : ControllerBase
    {
        private readonly KTXContext _context;

        public ChiTietPhieuThuController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ChiTietPhieuThu>>> GetAll()
        {
            return await _context.ChiTietPhieuThu.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ChiTietPhieuThu>> Get(int id)
        {
            var item = await _context.ChiTietPhieuThu.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<ChiTietPhieuThu>> Post(ChiTietPhieuThu model)
        {
            _context.ChiTietPhieuThu.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, ChiTietPhieuThu model)
        {
            if (!ModelExists(id))
            {
                return NotFound();
            }
            _context.Entry(model).State = EntityState.Modified;
            await _context.SaveChangesAsync();
            return NoContent();
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            var model = await _context.ChiTietPhieuThu.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.ChiTietPhieuThu.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.ChiTietPhieuThu.Find(id) != null;
        }

        private object GetKey(ChiTietPhieuThu model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
