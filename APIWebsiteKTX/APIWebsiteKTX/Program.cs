using APIWebsiteKTX.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Đăng ký DbContext với SQL Server
builder.Services.AddDbContext<KTXContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("KTXConnection")));

// Đăng ký dịch vụ controller
builder.Services.AddControllers();

// Đăng ký Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Cấu hình CORS
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigin", policy =>
        policy.WithOrigins("http://localhost:5173")
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials());
});

var app = builder.Build();

// Cấu hình middleware
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.UseCors("AllowSpecificOrigin");
app.UseAuthorization();
app.MapControllers();
app.UseDeveloperExceptionPage();


app.Run();
