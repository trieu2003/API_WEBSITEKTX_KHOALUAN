﻿using System.ComponentModel.DataAnnotations;

namespace APIWebsiteKTX.DTO
{
    public class PhieuThuRequestDTO
    {
        public string MaSV { get; set; }
    }
    public class ChiTietPhieuThuDTO
    {
        public string LoaiKhoanThu { get; set; }
        public decimal? SoTien { get; set; }
    }

    public class PhieuThuResponseDTO
    {
        public string MaSV { get; set; }
        public string HoTen { get; set; }
        public int MaPhieuThu { get; set; }
        public DateTime NgayLap { get; set; }
        public decimal TongTien { get; set; }
        public string TrangThai { get; set; }
        public string MaNV { get; set; }
        public List<ChiTietPhieuThuDTO> ChiTietPhieuThu { get; set; }
    }
    public class LocPhieuThuRequestDTO
    {
        public string MaSV { get; set; }
        public string? TrangThai { get; set; }
        public DateTime? NgayLapTu { get; set; }
        public DateTime? NgayLapDen { get; set; }
        public List<string>? LoaiKhoanThu { get; set; }  // hỗ trợ nhiều loại
        public string? TenSinhVien { get; set; }
        public int Page { get; set; } = 1;               // phân trang
        public int PageSize { get; set; } = 10;
    }
}