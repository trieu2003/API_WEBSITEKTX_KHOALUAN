
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
    public class ViPhamController : ControllerBase
    {
        private readonly KTXContext _context;

        public ViPhamController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<ViPham>>> GetAll()
        {
            return await _context.ViPham.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ViPham>> Get(int id)
        {
            var item = await _context.ViPham.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<ViPham>> Post(ViPham model)
        {
            _context.ViPham.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, ViPham model)
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
            var model = await _context.ViPham.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.ViPham.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.ViPham.Find(id) != null;
        }

        private object GetKey(ViPham model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
