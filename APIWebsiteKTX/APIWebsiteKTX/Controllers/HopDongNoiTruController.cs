
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
    public class HopDongNoiTruController : ControllerBase
    {
        private readonly KTXContext _context;

        public HopDongNoiTruController(KTXContext context)
        {
            _context = context;
        }
        [HttpPost("DangKyHopDong")]
        public async Task<IActionResult> DangKyHopDong([FromBody] HopDongNoiTru model)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);
            model.NgayDangKy = DateTime.Now;
            model.NgayBatDau = DateTime.Now;
            try
            {
                _context.HopDongNoiTru.Add(model);
                await _context.SaveChangesAsync();
                return Ok(new { message = "Đăng ký hợp đồng thành công" });
            }
            catch (Exception ex)
            {
                return StatusCode(500, new
                {
                    message = "Đã xảy ra lỗi",
                    error = ex.InnerException?.Message ?? ex.Message
                });
            }
        }
        [HttpGet]
        public async Task<ActionResult<IEnumerable<HopDongNoiTru>>> GetAll()
        {
            return await _context.HopDongNoiTru.ToListAsync();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<HopDongNoiTru>> Get(int id)
        {
            var item = await _context.HopDongNoiTru.FindAsync(id);
            if (item == null)
            {
                return NotFound();
            }
            return item;
        }

        [HttpPost]
        public async Task<ActionResult<HopDongNoiTru>> Post(HopDongNoiTru model)
        {
            _context.HopDongNoiTru.Add(model);
            await _context.SaveChangesAsync();
            return CreatedAtAction(nameof(Get), new { id = GetKey(model) }, model);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> Put(int id, HopDongNoiTru model)
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
            var model = await _context.HopDongNoiTru.FindAsync(id);
            if (model == null)
            {
                return NotFound();
            }
            _context.HopDongNoiTru.Remove(model);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool ModelExists(int id)
        {
            return _context.HopDongNoiTru.Find(id) != null;
        }

        private object GetKey(HopDongNoiTru model)
        {
            return model.GetType().GetProperty("Id")?.GetValue(model);
        }
    }
}
