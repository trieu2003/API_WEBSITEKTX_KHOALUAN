
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
    public class NhanVienController : ControllerBase
    {
        private readonly KTXContext _context;

        public NhanVienController(KTXContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<NhanVien>>> GetAll()
        {
            return await _context.NhanVien.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<NhanVien>> Get(int id)
        {
            var item = await _context.NhanVien.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<NhanVien>> Post(NhanVien model)
        {
            _context.NhanVien.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, NhanVien model)
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
            var model = await _context.NhanVien.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.NhanVien.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.NhanVien.Find(id) != null;
        }

        private object GetKey(NhanVien model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
