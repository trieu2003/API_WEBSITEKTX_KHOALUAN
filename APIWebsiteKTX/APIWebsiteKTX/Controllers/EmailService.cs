using MailKit.Net.Smtp;
using MimeKit;
using System.Threading.Tasks;

namespace APIWebsiteKTX.Controllers
{
    public class EmailService
    {
        private readonly IConfiguration _configuration;

        public EmailService(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public async Task SendOtpEmail(string toEmail, string otp)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("KTX System", _configuration["Smtp:FromEmail"]));
            message.To.Add(new MailboxAddress("", toEmail));
            message.Subject = "Mã OTP Đặt Lại Mật Khẩu";

            message.Body = new TextPart("plain")
            {
                Text = $"Mã OTP của bạn là: {otp}\nMã này có hiệu lực trong 5 phút."
            };

            using var client = new SmtpClient();
            try
            {
                await client.ConnectAsync(_configuration["Smtp:Host"], int.Parse(_configuration["Smtp:Port"]), MailKit.Security.SecureSocketOptions.StartTls);
                await client.AuthenticateAsync(_configuration["Smtp:Username"], _configuration["Smtp:Password"]);
                await client.SendAsync(message);
            }
            finally
            {
                await client.DisconnectAsync(true);
            }
        }
    }
}