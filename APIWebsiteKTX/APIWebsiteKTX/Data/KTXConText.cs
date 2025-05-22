using APIWebsiteKTX.Controllers;
using APIWebsiteKTX.Models;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace APIWebsiteKTX.Data
{
    public class KTXContext : DbContext
    {
        public KTXContext(DbContextOptions<KTXContext> options) : base(options) { }

        public DbSet<ChiTietPhieuThu> ChiTietPhieuThu { get; set; }
        public DbSet<ChiTietPhong> ChiTietPhong { get; set; }
        public DbSet<DatChoTruoc> DatChoTruoc { get; set; }
        public DbSet<DienNuoc> DienNuoc { get; set; }
        public DbSet<HopDongNoiTru> HopDongNoiTru { get; set; }
        public DbSet<Giuong> Giuong { get; set; }
        public DbSet<Khoa> Khoa { get; set; }
        public DbSet<LoaiPhong> LoaiPhong { get; set; }

        public DbSet<MucGiaDienNuoc> MucGiaDienNuoc { get; set; }
        public DbSet<NamHoc> NamHoc { get; set; }
        public DbSet<NguoiDung> NguoiDung { get; set; }
        public DbSet<NhanVien> NhanVien { get; set; }
        public DbSet<NoiQuy> NoiQuy { get; set; }
        public DbSet<PhieuThu> PhieuThu { get; set; }
        public DbSet<Phong> Phong { get; set; }
        public DbSet<SinhVien> SinhVien { get; set; }
        public DbSet<Tang> Tang { get; set; }
        public DbSet<TrangThietBi> TrangThietBi { get; set; }
        public DbSet<ViPham> ViPham { get; set; }
        public DbSet<YeuCauSuaChua> YeuCauSuaChua { get; set; }
        // 1. Thêm DbSet cho DTO trả về từ sp_GetRooms
        public DbSet<PhongController.RoomDto> RoomDtos { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Đánh dấu RoomDto là keyless (không ánh xạ tới bảng thực)
            modelBuilder.Entity<PhongController.RoomDto>().HasNoKey().ToView(null);
            modelBuilder.Entity<HopDongNoiTru>().ToTable("HopDongNoiTru", "dbo");
            modelBuilder.Entity<HopDongNoiTru>().HasKey(h => new { h.MaSV, h.MaGiuong, h.MaPhong });
        }
    }
}
