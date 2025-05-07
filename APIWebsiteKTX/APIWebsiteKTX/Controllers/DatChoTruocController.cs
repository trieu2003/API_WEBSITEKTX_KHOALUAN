
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
    public class DatChoTruocController : ControllerBase
    {
        private readonly KTXContext _context;

        public DatChoTruocController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<DatChoTruoc>>> GetAll()
        {
            return await _context.DatChoTruoc.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<DatChoTruoc>> Get(int id)
        {
            var item = await _context.DatChoTruoc.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<DatChoTruoc>> Post(DatChoTruoc model)
        {
            _context.DatChoTruoc.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, DatChoTruoc model)
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
            var model = await _context.DatChoTruoc.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.DatChoTruoc.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.DatChoTruoc.Find(id) != null;
        }

        private object GetKey(DatChoTruoc model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
