
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
    public class PhieuThuController : ControllerBase
    {
        private readonly KTXContext _context;

        public PhieuThuController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<PhieuThu>>> GetAll()
        {
            return await _context.PhieuThu.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<PhieuThu>> Get(int id)
        {
            var item = await _context.PhieuThu.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<PhieuThu>> Post(PhieuThu model)
        {
            _context.PhieuThu.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, PhieuThu model)
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
            var model = await _context.PhieuThu.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.PhieuThu.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.PhieuThu.Find(id) != null;
        }

        private object GetKey(PhieuThu model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
