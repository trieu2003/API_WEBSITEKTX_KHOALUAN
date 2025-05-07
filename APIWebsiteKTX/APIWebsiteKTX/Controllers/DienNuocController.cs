
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
    public class DienNuocController : ControllerBase
    {
        private readonly KTXContext _context;

        public DienNuocController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<DienNuoc>>> GetAll()
        {
            return await _context.DienNuoc.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<DienNuoc>> Get(int id)
        {
            var item = await _context.DienNuoc.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<DienNuoc>> Post(DienNuoc model)
        {
            _context.DienNuoc.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, DienNuoc model)
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
            var model = await _context.DienNuoc.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.DienNuoc.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.DienNuoc.Find(id) != null;
        }

        private object GetKey(DienNuoc model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
