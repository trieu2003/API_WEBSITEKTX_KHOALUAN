
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
    public class TrangThietBiController : ControllerBase
    {
        private readonly KTXContext _context;

        public TrangThietBiController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<TrangThietBi>>> GetAll()
        {
            return await _context.TrangThietBi.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<TrangThietBi>> Get(int id)
        {
            var item = await _context.TrangThietBi.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<TrangThietBi>> Post(TrangThietBi model)
        {
            _context.TrangThietBi.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, TrangThietBi model)
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
            var model = await _context.TrangThietBi.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.TrangThietBi.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.TrangThietBi.Find(id) != null;
        }

        private object GetKey(TrangThietBi model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
