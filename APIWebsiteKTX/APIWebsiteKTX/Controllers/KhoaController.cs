
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
    public class KhoaController : ControllerBase
    {
        private readonly KTXContext _context;

        public KhoaController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Khoa>>> GetAll()
        {
            return await _context.Khoa.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Khoa>> Get(int id)
        {
            var item = await _context.Khoa.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<Khoa>> Post(Khoa model)
        {
            _context.Khoa.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, Khoa model)
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
            var model = await _context.Khoa.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.Khoa.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.Khoa.Find(id) != null;
        }

        private object GetKey(Khoa model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
