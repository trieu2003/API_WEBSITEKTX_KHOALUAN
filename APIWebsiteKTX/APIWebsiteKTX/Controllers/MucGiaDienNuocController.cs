
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
    public class MucGiaDienNuocController : ControllerBase
    {
        private readonly KTXContext _context;

        public MucGiaDienNuocController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<MucGiaDienNuoc>>> GetAll()
        {
            return await _context.MucGiaDienNuoc.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<MucGiaDienNuoc>> Get(int id)
        {
            var item = await _context.MucGiaDienNuoc.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<MucGiaDienNuoc>> Post(MucGiaDienNuoc model)
        {
            _context.MucGiaDienNuoc.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, MucGiaDienNuoc model)
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
            var model = await _context.MucGiaDienNuoc.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.MucGiaDienNuoc.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.MucGiaDienNuoc.Find(id) != null;
        }

        private object GetKey(MucGiaDienNuoc model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
