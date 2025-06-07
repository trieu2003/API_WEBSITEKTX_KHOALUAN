using Microsoft.AspNetCore.Mvc;
using Net.payOS;
using Net.payOS.Types;
using System.Collections.Generic;

namespace APIWebsiteKTX.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PayOSController : ControllerBase
    {
        [HttpPost("thanh-toan")]
        public async Task<IActionResult> TaoDonThanhToan([FromBody] HoaDonModel model)
        {
            var payos = new PayOS(
                "32542182-51db-48cf-8d7a-6d8a18d599b5",  // clientId
                "dc3def5d-79e6-4b24-9c21-5ab24f9481c2",  // apiKey
                "162ea9960c0fb31f3f6267f89d5c2788da5cfc623ad1311e1baa800f386ef229" // checksumKey
            );

            var orderCode = new Random().Next(100000, 999999);

            var items = new List<ItemData>
            {
                new ItemData("Thanh toán phí KTX", 1, model.TongTien)
            };

            var paymentData = new PaymentData(
                orderCode: orderCode,
                amount: model.TongTien,
                description: $"Thanh toán KTX cho {model.HoTen}",
                items: items,
                cancelUrl: "http://localhost:3000/huy",
                returnUrl: "http://localhost:3000/ket-qua"
            );

            var result = await payos.createPaymentLink(paymentData);

            return Ok(new { url = result.checkoutUrl });
        }
    }

    public class HoaDonModel
    {
        public string HoTen { get; set; }
        public int TongTien { get; set; }
    }
}
