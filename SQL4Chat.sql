USE MASTER
ALTER DATABASE KTX SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE KTX;
USE MASTER
CREATE DATABASE KTX
USE [KTX]
GO
/****** Object:  Table [dbo].[ChiTietPhieuThu]    Script Date: 5/19/2025 7:12:30 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhieuThu](
	[MaChiTiet] [int] IDENTITY(1,1) NOT NULL,
	[MaPhieuThu] [int] NULL,
	[LoaiKhoanThu] [nvarchar](100) NULL,
	[SoTien] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietPhong]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhong](
	[MaChiTietPhong] [int] IDENTITY(1,1) NOT NULL,
	[MaPhong] [nvarchar](50) NULL,
	[MaThietBi] [nvarchar](50) NULL,
	[Giuong] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietSuaChua]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietSuaChua](
	[MaChiTiet] [int] IDENTITY(1,1) NOT NULL,
	[MaYCSC] [int] NULL,
	[MaThietBi] [nvarchar](50) NULL,
	[MoTaLoi] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTiet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatChoTruoc]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatChoTruoc](
	[MaDatCho] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[MaChiTietPhong] [int] NULL,
	[NgayDat] [date] NULL,
	[HanDat] [date] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDatCho] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiemDanh]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiemDanh](
	[MaDiemDanh] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[ThoiGian] [datetime] NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK__DiemDanh__1512439DA869BBBB] PRIMARY KEY CLUSTERED 
(
	[MaDiemDanh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DienNuoc]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DienNuoc](
	[MaDN] [int] IDENTITY(1,1) NOT NULL,
	[MaPhong] [nvarchar](50) NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[SoDienCu] [int] NULL,
	[SoNuocCu] [int] NULL,
	[SoDienMoi] [int] NULL,
	[SoNuocMoi] [int] NULL,
	[MaMucGia] [int] NULL,
	[MaNV] [nvarchar](50) NULL,
 CONSTRAINT [PK__DienNuoc__2725866F7E1693D7] PRIMARY KEY CLUSTERED 
(
	[MaDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Giuong]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Giuong](
	[MaGiuong] [nvarchar](50) NOT NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK_Giuong] PRIMARY KEY CLUSTERED 
(
	[MaGiuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HopDongNoiTru]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDongNoiTru](
	[MaHopDong] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[MaGiuong] [nvarchar](50) NULL,
	[MaPhong] [nvarchar](50) NULL,
	[NgayDangKy] [date] NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
	[DotDangKy] [nvarchar](50) NULL,
	[NhomTruong] [nchar](10) NULL,
	[TrangThai] [nvarchar](50) NULL,
	[TrangThaiDuyet] [nvarchar](50) NULL,
	[PhuongThucThanhToan] [nvarchar](50) NULL,
	[MinhChungThanhToan] [nvarchar](255) NULL,
	[MaNamHoc] [nchar](10) NULL,
	[MaNV] [nvarchar](50) NULL,
 CONSTRAINT [PK__HopDongN__36DD43425E6FB1E7] PRIMARY KEY CLUSTERED 
(
	[MaHopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[MaKhoa] [nvarchar](50) NOT NULL,
	[TenKhoa] [nvarchar](50) NULL,
 CONSTRAINT [PK_Khoa] PRIMARY KEY CLUSTERED 
(
	[MaKhoa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiPhong](
	[MaLoaiPhong] [nvarchar](50) NOT NULL,
	[TenLoai] [nvarchar](100) NULL,
	[SucChua] [int] NULL,
	[MucPhi] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoaiPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MucGiaDienNuoc]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MucGiaDienNuoc](
	[MaMucGia] [int] IDENTITY(1,1) NOT NULL,
	[ThoiGianApDung] [date] NULL,
	[DonGiaDien] [money] NULL,
	[DonGiaNuoc] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaMucGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NamHoc]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NamHoc](
	[MaNamHoc] [nchar](10) NOT NULL,
	[TenNamHoc] [nchar](10) NULL,
 CONSTRAINT [PK_NamHoc] PRIMARY KEY CLUSTERED 
(
	[MaNamHoc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[MaNguoiDung] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](255) NOT NULL,
	[VaiTro] [nvarchar](50) NULL,
	[OTP] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NhanVien]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhanVien](
	[MaNV] [nvarchar](50) NOT NULL,
	[MaNguoiDung] [int] NULL,
	[HoTen] [nvarchar](100) NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[NgaySinh] [date] NULL,
	[AnhDaiDien] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[SDT] [nvarchar](20) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[TrinhDo] [nvarchar](50) NULL,
 CONSTRAINT [PK__NhanVien__2725D70A5CDBDDB8] PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoiQuy]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoiQuy](
	[MaNoiQuy] [int] IDENTITY(1,1) NOT NULL,
	[NoiDung] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNoiQuy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuThu]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuThu](
	[MaPhieuThu] [int] IDENTITY(1,1) NOT NULL,
	[MaHopDong] [int] NULL,
	[NgayLap] [date] NULL,
	[TongTien] [money] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuThu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phong](
	[MaPhong] [nvarchar](50) NOT NULL,
	[TenPhong] [nvarchar](50) NULL,
	[MaLoaiPhong] [nvarchar](50) NULL,
	[MaTang] [nchar](10) NULL,
	[TrangThai] [nvarchar](50) NULL,
 CONSTRAINT [PK__Phong__20BD5E5B90BF245E] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVien](
	[MaSV] [nvarchar](20) NOT NULL,
	[MaNguoiDung] [int] NULL,
	[HoTen] [nvarchar](100) NULL,
	[GioiTinh] [nvarchar](50) NULL,
	[NgaySinh] [nvarchar](50) NULL,
	[Lop] [nvarchar](50) NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[SoCanCuoc] [nvarchar](20) NULL,
	[SDTGiaDinh] [nvarchar](20) NULL,
	[SoHoKhau] [nvarchar](50) NULL,
	[TrangThai] [nvarchar](50) NULL,
	[AnhDaiDien] [nvarchar](50) NULL,
	[MaKhoa] [nvarchar](50) NULL,
 CONSTRAINT [PK__SinhVien__2725081A4026EF04] PRIMARY KEY CLUSTERED 
(
	[MaSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tang]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tang](
	[MaTang] [nchar](10) NOT NULL,
	[TenTang] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tang] PRIMARY KEY CLUSTERED 
(
	[MaTang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrangThietBi]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrangThietBi](
	[MaThietBi] [nvarchar](50) NOT NULL,
	[TenThietBi] [nvarchar](100) NULL,
	[MoTa] [nvarchar](255) NULL,
	[SoLuong] [int] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaThietBi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ViPham]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViPham](
	[MaViPham] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[MaNoiQuy] [int] NULL,
	[NgayViPham] [date] NULL,
	[GhiChu] [nvarchar](255) NULL,
	[HinhThucXuLy] [nvarchar](255) NULL,
	[MucDoXuLy] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
	[FileBienBan] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaViPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YeuCauSuaChua]    Script Date: 5/19/2025 7:12:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[YeuCauSuaChua](
	[MaYCSC] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[MaPhong] [nvarchar](50) NULL,
	[MoTa] [nvarchar](max) NULL,
	[NgayGui] [date] NULL,
	[TrangThai] [nvarchar](50) NULL,
	[MaNV] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaYCSC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Index [UQ__SinhVien__C539D7631733605D]    Script Date: 5/19/2025 7:12:31 AM ******/
ALTER TABLE [dbo].[SinhVien] ADD  CONSTRAINT [UQ__SinhVien__C539D7631733605D] UNIQUE NONCLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietPhieuThu]  WITH CHECK ADD FOREIGN KEY([MaPhieuThu])
REFERENCES [dbo].[PhieuThu] ([MaPhieuThu])
GO
ALTER TABLE [dbo].[ChiTietPhong]  WITH CHECK ADD  CONSTRAINT [FK__ChiTietPh__MaPho__267ABA7A] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[ChiTietPhong] CHECK CONSTRAINT [FK__ChiTietPh__MaPho__267ABA7A]
GO
ALTER TABLE [dbo].[ChiTietPhong]  WITH CHECK ADD FOREIGN KEY([MaThietBi])
REFERENCES [dbo].[TrangThietBi] ([MaThietBi])
GO
ALTER TABLE [dbo].[ChiTietPhong]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietPhong_Giuong] FOREIGN KEY([Giuong])
REFERENCES [dbo].[Giuong] ([MaGiuong])
GO
ALTER TABLE [dbo].[ChiTietPhong] CHECK CONSTRAINT [FK_ChiTietPhong_Giuong]
GO
ALTER TABLE [dbo].[ChiTietSuaChua]  WITH CHECK ADD FOREIGN KEY([MaThietBi])
REFERENCES [dbo].[TrangThietBi] ([MaThietBi])
GO
ALTER TABLE [dbo].[ChiTietSuaChua]  WITH CHECK ADD FOREIGN KEY([MaYCSC])
REFERENCES [dbo].[YeuCauSuaChua] ([MaYCSC])
GO
ALTER TABLE [dbo].[DatChoTruoc]  WITH CHECK ADD FOREIGN KEY([MaChiTietPhong])
REFERENCES [dbo].[ChiTietPhong] ([MaChiTietPhong])
GO
ALTER TABLE [dbo].[DatChoTruoc]  WITH CHECK ADD  CONSTRAINT [FK__DatChoTruo__MaSV__32E0915F] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[DatChoTruoc] CHECK CONSTRAINT [FK__DatChoTruo__MaSV__32E0915F]
GO
ALTER TABLE [dbo].[DiemDanh]  WITH CHECK ADD  CONSTRAINT [FK_DiemDanh_SinhVien] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[DiemDanh] CHECK CONSTRAINT [FK_DiemDanh_SinhVien]
GO
ALTER TABLE [dbo].[DienNuoc]  WITH CHECK ADD  CONSTRAINT [FK__DienNuoc__MaMucG__3E52440B] FOREIGN KEY([MaMucGia])
REFERENCES [dbo].[MucGiaDienNuoc] ([MaMucGia])
GO
ALTER TABLE [dbo].[DienNuoc] CHECK CONSTRAINT [FK__DienNuoc__MaMucG__3E52440B]
GO
ALTER TABLE [dbo].[DienNuoc]  WITH CHECK ADD  CONSTRAINT [FK__DienNuoc__MaNV__3F466844] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[DienNuoc] CHECK CONSTRAINT [FK__DienNuoc__MaNV__3F466844]
GO
ALTER TABLE [dbo].[DienNuoc]  WITH CHECK ADD  CONSTRAINT [FK__DienNuoc__MaPhon__3D5E1FD2] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[DienNuoc] CHECK CONSTRAINT [FK__DienNuoc__MaPhon__3D5E1FD2]
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT FK_HopDongNoiTru_Giuong  FOREIGN KEY([MaGiuong])
REFERENCES [dbo].[Giuong] ([MaGiuong])
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT FK_HopDongNoiTru_Phong  FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT [FK__HopDongNoi__MaNV__398D8EEE] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[HopDongNoiTru] CHECK CONSTRAINT [FK__HopDongNoi__MaNV__398D8EEE]
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT [FK__HopDongNoi__MaSV__38996AB5] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[HopDongNoiTru] CHECK CONSTRAINT [FK__HopDongNoi__MaSV__38996AB5]
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT [FK_HopDongNoiTru_NamHoc] FOREIGN KEY([MaNamHoc])
REFERENCES [dbo].[NamHoc] ([MaNamHoc])
GO
ALTER TABLE [dbo].[HopDongNoiTru] CHECK CONSTRAINT [FK_HopDongNoiTru_NamHoc]
GO
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD  CONSTRAINT [FK__NhanVien__MaNguo__145C0A3F] FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[NhanVien] CHECK CONSTRAINT [FK__NhanVien__MaNguo__145C0A3F]
GO
ALTER TABLE [dbo].[PhieuThu]  WITH CHECK ADD  CONSTRAINT [FK__PhieuThu__MaHopD__4222D4EF] FOREIGN KEY([MaHopDong])
REFERENCES [dbo].[HopDongNoiTru] ([MaHopDong])
GO
ALTER TABLE [dbo].[PhieuThu] CHECK CONSTRAINT [FK__PhieuThu__MaHopD__4222D4EF]
GO
ALTER TABLE [dbo].[PhieuThu]  WITH CHECK ADD  CONSTRAINT [FK__PhieuThu__MaNV__4316F928] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[PhieuThu] CHECK CONSTRAINT [FK__PhieuThu__MaNV__4316F928]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK__Phong__MaLoaiPho__1CF15040] FOREIGN KEY([MaLoaiPhong])
REFERENCES [dbo].[LoaiPhong] ([MaLoaiPhong])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK__Phong__MaLoaiPho__1CF15040]
GO
ALTER TABLE [dbo].[Phong]  WITH CHECK ADD  CONSTRAINT [FK_Phong_Tang] FOREIGN KEY([MaTang])
REFERENCES [dbo].[Tang] ([MaTang])
GO
ALTER TABLE [dbo].[Phong] CHECK CONSTRAINT [FK_Phong_Tang]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK__SinhVien__MaNguo__182C9B23] FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK__SinhVien__MaNguo__182C9B23]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK_SinhVien_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK_SinhVien_Khoa]
GO
ALTER TABLE [dbo].[ViPham]  WITH CHECK ADD FOREIGN KEY([MaNoiQuy])
REFERENCES [dbo].[NoiQuy] ([MaNoiQuy])
GO
ALTER TABLE [dbo].[ViPham]  WITH CHECK ADD  CONSTRAINT [FK__ViPham__MaNV__4CA06362] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[ViPham] CHECK CONSTRAINT [FK__ViPham__MaNV__4CA06362]
GO
ALTER TABLE [dbo].[ViPham]  WITH CHECK ADD  CONSTRAINT [FK__ViPham__MaSV__4AB81AF0] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[ViPham] CHECK CONSTRAINT [FK__ViPham__MaSV__4AB81AF0]
GO
ALTER TABLE [dbo].[YeuCauSuaChua]  WITH CHECK ADD  CONSTRAINT [FK__YeuCauSua__MaPho__2B3F6F97] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[YeuCauSuaChua] CHECK CONSTRAINT [FK__YeuCauSua__MaPho__2B3F6F97]
GO
ALTER TABLE [dbo].[YeuCauSuaChua]  WITH CHECK ADD  CONSTRAINT [FK__YeuCauSuaC__MaNV__2C3393D0] FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[YeuCauSuaChua] CHECK CONSTRAINT [FK__YeuCauSuaC__MaNV__2C3393D0]
GO
ALTER TABLE [dbo].[YeuCauSuaChua]  WITH CHECK ADD  CONSTRAINT [FK__YeuCauSuaC__MaSV__2A4B4B5E] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[YeuCauSuaChua] CHECK CONSTRAINT [FK__YeuCauSuaC__MaSV__2A4B4B5E]
GO
