
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
    public class TangController : ControllerBase
    {
        private readonly KTXContext _context;

        public TangController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Tang>>> GetAll()
        {
            return await _context.Tang.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Tang>> Get(int id)
        {
            var item = await _context.Tang.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<Tang>> Post(Tang model)
        {
            _context.Tang.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, Tang model)
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
            var model = await _context.Tang.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.Tang.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.Tang.Find(id) != null;
        }

        private object GetKey(Tang model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
