
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
    public class ChiTietPhongController : ControllerBase
    {
        private readonly KTXContext _context;

        public ChiTietPhongController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ChiTietPhong>>> GetAll()
        {
            return await _context.ChiTietPhong.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ChiTietPhong>> Get(int id)
        {
            var item = await _context.ChiTietPhong.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<ChiTietPhong>> Post(ChiTietPhong model)
        {
            _context.ChiTietPhong.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, ChiTietPhong model)
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
            var model = await _context.ChiTietPhong.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.ChiTietPhong.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.ChiTietPhong.Find(id) != null;
        }

        private object GetKey(ChiTietPhong model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
