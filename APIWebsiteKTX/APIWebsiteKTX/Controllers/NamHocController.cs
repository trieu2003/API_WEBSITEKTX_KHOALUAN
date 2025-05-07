
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
    public class NamHocController : ControllerBase
    {
        private readonly KTXContext _context;

        public NamHocController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<NamHoc>>> GetAll()
        {
            return await _context.NamHoc.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<NamHoc>> Get(int id)
        {
            var item = await _context.NamHoc.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<NamHoc>> Post(NamHoc model)
        {
            _context.NamHoc.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, NamHoc model)
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
            var model = await _context.NamHoc.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.NamHoc.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.NamHoc.Find(id) != null;
        }

        private object GetKey(NamHoc model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
