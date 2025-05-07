
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
    public class NguoiDungController : ControllerBase
    {
        private readonly KTXContext _context;

        public NguoiDungController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<NguoiDung>>> GetAll()
        {
            return await _context.NguoiDung.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<NguoiDung>> Get(int id)
        {
            var item = await _context.NguoiDung.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<NguoiDung>> Post(NguoiDung model)
        {
            _context.NguoiDung.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, NguoiDung model)
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
            var model = await _context.NguoiDung.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.NguoiDung.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.NguoiDung.Find(id) != null;
        }

        private object GetKey(NguoiDung model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
