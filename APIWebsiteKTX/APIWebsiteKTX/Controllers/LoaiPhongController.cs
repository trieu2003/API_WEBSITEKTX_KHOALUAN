
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
    public class LoaiPhongController : ControllerBase
    {
        private readonly KTXContext _context;

        public LoaiPhongController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<LoaiPhong>>> GetAll()
        {
            return await _context.LoaiPhong.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<LoaiPhong>> Get(int id)
        {
            var item = await _context.LoaiPhong.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<LoaiPhong>> Post(LoaiPhong model)
        {
            _context.LoaiPhong.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, LoaiPhong model)
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
            var model = await _context.LoaiPhong.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.LoaiPhong.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.LoaiPhong.Find(id) != null;
        }

        private object GetKey(LoaiPhong model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
