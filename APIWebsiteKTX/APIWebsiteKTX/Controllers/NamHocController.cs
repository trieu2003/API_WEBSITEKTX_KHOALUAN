
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

       
    }
}
