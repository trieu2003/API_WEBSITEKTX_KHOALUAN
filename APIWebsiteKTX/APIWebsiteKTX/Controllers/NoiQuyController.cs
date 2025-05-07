
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
    public class NoiQuyController : ControllerBase
    {
        private readonly KTXContext _context;

        public NoiQuyController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<NoiQuy>>> GetAll()
        {
            return await _context.NoiQuy.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<NoiQuy>> Get(int id)
        {
            var item = await _context.NoiQuy.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<NoiQuy>> Post(NoiQuy model)
        {
            _context.NoiQuy.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, NoiQuy model)
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
            var model = await _context.NoiQuy.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.NoiQuy.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.NoiQuy.Find(id) != null;
        }

        private object GetKey(NoiQuy model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
