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
        public DbSet<ChiTietSuaChua> ChiTietSuaChua { get; set; }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            // Đánh dấu RoomDto là keyless (không ánh xạ tới bảng thực)
            modelBuilder.Entity<SinhVien>().ToTable("SinhVien")
           .HasKey(s => s.MaSV); // Define primary key for SinhVien

            modelBuilder.Entity<Khoa>().ToTable("Khoa")
                .HasKey(k => k.MaKhoa); // Define primary key for Khoa

            // Define the relationship between SinhVien and Khoa
            modelBuilder.Entity<SinhVien>()
                .HasOne(s => s.Khoa)
                .WithMany() // No navigation property back to SinhVien
                .HasForeignKey(s => s.MaKhoa)
                .OnDelete(DeleteBehavior.Restrict); // Prevent cascading deletes

            // Define the relationship between SinhVien and NguoiDung
            modelBuilder.Entity<SinhVien>()
                .HasOne(s => s.NguoiDung)
                .WithOne()
                .HasForeignKey<SinhVien>(s => s.MaNguoiDung)
                .OnDelete(DeleteBehavior.Restrict); // Prevent cascading deletes

            modelBuilder.Entity<SinhVien>()
                .HasOne(s => s.NguoiDung)
                .WithOne()
                .HasForeignKey<SinhVien>(s => s.MaNguoiDung)
                .IsRequired(false);

            modelBuilder.Entity<NguoiDung>().ToTable("NguoiDung")
            .HasKey(u => u.MaNguoiDung); // Define primary key for NguoiDung
            // Define the relationship between SinhVien and Khoa
            modelBuilder.Entity<SinhVien>()
                .HasOne(s => s.Khoa)
                .WithMany() // Khoa can have many SinhVien, no navigation property back to SinhVien
                .HasForeignKey(s => s.MaKhoa)
                .OnDelete(DeleteBehavior.Restrict); // Prevent cascading deletes
            modelBuilder.Entity<SinhVien>()
           .HasKey(sv => sv.MaSV);

            modelBuilder.Entity<NguoiDung>()
            .HasKey(nd => nd.MaNguoiDung);

            modelBuilder.Entity<NoiQuy>()
            .HasKey(nq => nq.MaNoiQuy);
            // Define the relationship between SinhVien and NguoiDung
            modelBuilder.Entity<SinhVien>()
                .HasOne(s => s.NguoiDung)
                .WithOne()
                .HasForeignKey<SinhVien>(s => s.MaNguoiDung)
                .OnDelete(DeleteBehavior.Restrict);
            modelBuilder.Entity<HopDongNoiTru>().ToTable("HopDongNoiTru", "dbo");
            modelBuilder.Entity<HopDongNoiTru>().HasKey(h => new { h.MaSV, h.MaGiuong, h.MaPhong });
            modelBuilder.Entity<Phong>()
           .HasKey(p => p.MaPhong);
            // Configure HopDongNoiTru
            modelBuilder.Entity<HopDongNoiTru>()
                .HasKey(h => h.MaHopDong);
            modelBuilder.Entity<HopDongNoiTru>()
                .HasOne(h => h.SinhVien)
                .WithMany()
                .HasForeignKey(h => h.MaSV);
            // Configure PhieuThu
            modelBuilder.Entity<PhieuThu>()
                .HasKey(p => p.MaPhieuThu);

            modelBuilder.Entity<PhieuThu>()
                .HasOne(p => p.HopDongNoiTru)
                .WithMany()
                .HasForeignKey(p => p.MaHopDong);

            // Configure ChiTietPhieuThu
            modelBuilder.Entity<ChiTietPhieuThu>()
                .HasKey(c => c.MaChiTiet);

            modelBuilder.Entity<ChiTietPhieuThu>()
                .HasOne(c => c.PhieuThu)
                .WithMany()
                .HasForeignKey(c => c.MaPhieuThu);
            modelBuilder.Entity<LoaiPhong>()

                .HasKey(lp => lp.MaLoaiPhong);

            modelBuilder.Entity<Tang>()
                .HasKey(t => t.MaTang);

            modelBuilder.Entity<ChiTietPhong>()
                .HasKey(ctp => ctp.MaChiTietPhong);

            modelBuilder.Entity<TrangThietBi>()
                .HasKey(tb => tb.MaThietBi);

            modelBuilder.Entity<Giuong>()
                .HasKey(g => g.MaGiuong);
            modelBuilder.Entity<SinhVien>()
            .HasKey(sv => sv.MaSV);
            modelBuilder.Entity<NguoiDung>()
            .HasKey(nd => nd.MaNguoiDung);
            // Quan hệ Phong - LoaiPhong
            modelBuilder.Entity<Phong>()
                .HasOne(p => p.LoaiPhong)
                .WithMany()
                .HasForeignKey(p => p.MaLoaiPhong);

            // Quan hệ Phong - Tang
            modelBuilder.Entity<Phong>()
                .HasOne(p => p.Tang)
                .WithMany()
                .HasForeignKey(p => p.MaTang);

            // Quan hệ Phong - ChiTietPhong
            modelBuilder.Entity<ChiTietPhong>()
                .HasOne(ctp => ctp.Phong)
                .WithMany(p => p.ChiTietPhongs)
                .HasForeignKey(ctp => ctp.MaPhong);

            // Quan hệ ChiTietPhong - TrangThietBi
            modelBuilder.Entity<ChiTietPhong>()
                .HasOne(ctp => ctp.TrangThietBi)
                .WithMany()
                .HasForeignKey(ctp => ctp.MaThietBi)
                .IsRequired(false); // MaThietBi có thể null

            // Quan hệ ChiTietPhong - Giuong
            modelBuilder.Entity<ChiTietPhong>()
                .HasOne(ctp => ctp.Giuong)
                .WithMany()
                .HasForeignKey(ctp => ctp.MaGiuong);
            modelBuilder.Entity<ChiTietPhong>()
                .Property(ctp => ctp.MaGiuong)
                .HasColumnName("Giuong");
            modelBuilder.Entity<YeuCauSuaChua>()
               .HasKey(y => y.MaYCSC);

            modelBuilder.Entity<YeuCauSuaChua>()
                .HasOne(y => y.SinhVien)
                .WithMany()
                .HasForeignKey(y => y.MaSV);

            modelBuilder.Entity<YeuCauSuaChua>()
                 .HasOne(y => y.Phong)
                 .WithMany()
                 .HasForeignKey(y => y.MaPhong);

            modelBuilder.Entity<ChiTietSuaChua>()
                .HasOne(c => c.YeuCauSuaChua)
                .WithMany()
                .HasForeignKey(c => c.MaYCSC);
            modelBuilder.Entity<ChiTietSuaChua>()
               .HasKey(c => c.MaChiTiet);
            modelBuilder.Entity<ChiTietSuaChua>()
                   .HasOne(c => c.YeuCauSuaChua)
                   .WithMany()
                   .HasForeignKey(c => c.MaYCSC);

            modelBuilder.Entity<ChiTietSuaChua>()
                .HasOne(c => c.TrangThietBi)
                .WithMany()
                .HasForeignKey(c => c.MaThietBi);

            modelBuilder.Entity<YeuCauSuaChua>()
                .HasOne(y => y.NhanVien)
                .WithMany()
                .HasForeignKey(y => y.MaNV)
                .IsRequired(false); // MaNV is nullable
        }
    }
}
