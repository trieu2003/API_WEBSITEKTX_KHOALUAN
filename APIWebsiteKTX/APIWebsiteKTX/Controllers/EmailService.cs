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

            // Đường dẫn logo HUIT - cập nhật đúng URL thực tế trên server bạn
            string logoUrl = "https://sinhvien.huit.edu.vn/Content/AConfig/images/sv_header_login.png";

            string htmlBody = $@"
        <div style='font-family:Arial,sans-serif; background-color:#0066b3; color:white; max-width:1000px; margin:auto; padding:20px; border-radius:8px;'>
            <div style='text-align:center; margin-bottom:20px;'>
                <img src='{logoUrl}' alt='Logo HUIT' style='max-height:80px;' />
            </div>
            <h2 style='margin-bottom:10px;'>Ký Túc Xá HUIT - Mã OTP Xác Thực</h2>
            <p style='color:white;'>Chào bạn,</p>
            <p style='color:white;'>Chúng tôi đã nhận được yêu cầu đặt lại mật khẩu từ tài khoản của bạn.</p>
            <p><strong>Mã OTP của bạn là:</strong></p>
            <div style='font-size:24px; font-weight:bold; background:#ffffff; color:#0066b3; padding:10px; text-align:center; border-radius:5px; margin: 10px 0;'>
                {otp}
            </div>
            <p style='color:white;'>Mã OTP này sẽ hết hạn sau <strong>5 phút</strong>. Vui lòng không chia sẻ mã này với bất kỳ ai.</p>
            <p style='color:white;'>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>
            <br/>
            <p style='font-size:14px; color:white;'>Trân trọng,<br/>Ban quản lý Ký Túc Xá HUIT</p>
        </div>";

            message.Body = new TextPart("html") { Text = htmlBody };

            using var client = new SmtpClient();
            try
            {
                await client.ConnectAsync(
                    _configuration["Smtp:Host"],
                    int.Parse(_configuration["Smtp:Port"]),
                    MailKit.Security.SecureSocketOptions.StartTls);

                await client.AuthenticateAsync(
                    _configuration["Smtp:Username"],
                    _configuration["Smtp:Password"]);

                await client.SendAsync(message);
            }
            finally
            {
                await client.DisconnectAsync(true);
            }
        }
    }
}