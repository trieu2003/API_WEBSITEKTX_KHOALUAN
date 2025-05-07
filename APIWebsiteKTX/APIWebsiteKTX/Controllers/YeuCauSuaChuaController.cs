
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
    public class YeuCauSuaChuaController : ControllerBase
    {
        private readonly KTXContext _context;

        public YeuCauSuaChuaController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<YeuCauSuaChua>>> GetAll()
        {
            return await _context.YeuCauSuaChua.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<YeuCauSuaChua>> Get(int id)
        {
            var item = await _context.YeuCauSuaChua.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<YeuCauSuaChua>> Post(YeuCauSuaChua model)
        {
            _context.YeuCauSuaChua.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, YeuCauSuaChua model)
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
            var model = await _context.YeuCauSuaChua.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.YeuCauSuaChua.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.YeuCauSuaChua.Find(id) != null;
        }

        private object GetKey(YeuCauSuaChua model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
