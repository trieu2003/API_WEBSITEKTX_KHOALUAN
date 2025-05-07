create database KTX
go 
USE [KTX]
GO
/****** Object:  Table [dbo].[ChiTietPhieuThu]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[ChiTietPhong]    Script Date: 4/27/2025 11:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietPhong](
	[MaChiTietPhong] [int] IDENTITY(1,1) NOT NULL,
	[MaPhong] [nvarchar](50) NULL,
	[MaThietBi] [nvarchar](50) NULL,
	[Giuong] [nvarchar](50) NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaChiTietPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChiTietSuaChua]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[DatChoTruoc]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[DienNuoc]    Script Date: 4/27/2025 11:13:01 AM ******/
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
PRIMARY KEY CLUSTERED 
(
	[MaDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Giuong]    Script Date: 4/27/2025 11:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Giuong](
	[MaGiuong] [nvarchar](50) NOT NULL,
	[TenGiuong] [nvarchar](50) NULL,
 CONSTRAINT [PK_Giuong] PRIMARY KEY CLUSTERED 
(
	[MaGiuong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HopDongNoiTru]    Script Date: 4/27/2025 11:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDongNoiTru](
	[MaHopDong] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[MaPhong] [nvarchar](50) NULL,
	[MaMucGia] [int] NULL,
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
/****** Object:  Table [dbo].[Khoa]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[MucGiaDienNuoc]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[NamHoc]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[NhanVien]    Script Date: 4/27/2025 11:13:01 AM ******/
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
	[Email] [nvarchar](100) NULL,
	[SDT] [nvarchar](20) NULL,
	[ChucVu] [nvarchar](50) NULL,
	[TrinhDo] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[NoiQuy]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[PhieuThu]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[Phong]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[SinhVien]    Script Date: 4/27/2025 11:13:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVien](
	[MaSV] [nvarchar](20) NOT NULL,
	[MaNguoiDung] [int] NULL,
	[HoTen] [nvarchar](100) NULL,
	[NgaySinh] [date] NULL,
	[Lop] [nvarchar](50) NULL,
	[SDT] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[SoCanCuoc] [nvarchar](20) NULL,
	[SDTGiaDinh] [nvarchar](20) NULL,
	[SoHoKhau] [nvarchar](50) NULL,
	[TrangThai] [nvarchar](50) NULL,
	[AnhDaiDien] [nvarchar](50) NULL,
	[MaKhoa] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tang]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[TrangThietBi]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[ViPham]    Script Date: 4/27/2025 11:13:01 AM ******/
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
/****** Object:  Table [dbo].[YeuCauSuaChua]    Script Date: 4/27/2025 11:13:01 AM ******/
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
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__NguoiDun__55F68FC09F9CAE7D]    Script Date: 4/27/2025 11:13:01 AM ******/
ALTER TABLE [dbo].[NguoiDung] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__NhanVien__C539D763BD4F179D]    Script Date: 4/27/2025 11:13:01 AM ******/
ALTER TABLE [dbo].[NhanVien] ADD UNIQUE NONCLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__SinhVien__C539D7631733605D]    Script Date: 4/27/2025 11:13:01 AM ******/
ALTER TABLE [dbo].[SinhVien] ADD UNIQUE NONCLUSTERED 
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
ALTER TABLE [dbo].[DatChoTruoc]  WITH CHECK ADD FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[DienNuoc]  WITH CHECK ADD FOREIGN KEY([MaMucGia])
REFERENCES [dbo].[MucGiaDienNuoc] ([MaMucGia])
GO
ALTER TABLE [dbo].[DienNuoc]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[DienNuoc]  WITH CHECK ADD  CONSTRAINT [FK__DienNuoc__MaPhon__3D5E1FD2] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[DienNuoc] CHECK CONSTRAINT [FK__DienNuoc__MaPhon__3D5E1FD2]
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT [FK__HopDongNo__MaPho__3A81B327] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[HopDongNoiTru] CHECK CONSTRAINT [FK__HopDongNo__MaPho__3A81B327]
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
ALTER TABLE [dbo].[NhanVien]  WITH CHECK ADD FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[PhieuThu]  WITH CHECK ADD  CONSTRAINT [FK__PhieuThu__MaHopD__4222D4EF] FOREIGN KEY([MaHopDong])
REFERENCES [dbo].[HopDongNoiTru] ([MaHopDong])
GO
ALTER TABLE [dbo].[PhieuThu] CHECK CONSTRAINT [FK__PhieuThu__MaHopD__4222D4EF]
GO
ALTER TABLE [dbo].[PhieuThu]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
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
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD FOREIGN KEY([MaNguoiDung])
REFERENCES [dbo].[NguoiDung] ([MaNguoiDung])
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [FK_SinhVien_Khoa] FOREIGN KEY([MaKhoa])
REFERENCES [dbo].[Khoa] ([MaKhoa])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [FK_SinhVien_Khoa]
GO
ALTER TABLE [dbo].[ViPham]  WITH CHECK ADD FOREIGN KEY([MaNoiQuy])
REFERENCES [dbo].[NoiQuy] ([MaNoiQuy])
GO
ALTER TABLE [dbo].[ViPham]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[ViPham]  WITH CHECK ADD FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[YeuCauSuaChua]  WITH CHECK ADD  CONSTRAINT [FK__YeuCauSua__MaPho__2B3F6F97] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[YeuCauSuaChua] CHECK CONSTRAINT [FK__YeuCauSua__MaPho__2B3F6F97]
GO
ALTER TABLE [dbo].[YeuCauSuaChua]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[YeuCauSuaChua]  WITH CHECK ADD FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO


USE [KTX];
GO
-- 13. NguoiDung r  1
INSERT INTO [dbo].[NguoiDung] (TenDangNhap, MatKhau, VaiTro, OTP) VALUES
(N'sv001', N'nvpass001', N'Sinh viên', NULL),
(N'sv002', N'nvpass001', N'Sinh viên', NULL),
(N'nv002', N'nvpass001', N'Nhân viên', NULL),
(N'admin', N'pass@123', N'Admin', NULL),
(N'nv001', N'nvpass001', N'Nhân viên', NULL);
GO

-- 8. Khoa r 2
INSERT INTO [dbo].[Khoa] (MaKhoa, TenKhoa) VALUES
(N'CNTT', N'Công nghệ thông tin'),
(N'QTKD', N'Quản trị kinh doanh');
GO

-- 6. Giuong r --3 
INSERT INTO [dbo].[Giuong] (MaGiuong, TenGiuong) VALUES
(N'G1', N'Giường tầng 1'),
(N'G2', N'Giường tầng 2');
GO

-- 11. NamHoc r 4
INSERT INTO [dbo].[NamHoc] (MaNamHoc, TenNamHoc) VALUES
(N'2024-2025', N'2024-2025'),
(N'2025-2026', N'2025-2026');
GO

-- 12. NoiQuy r 5
INSERT INTO [dbo].[NoiQuy] (NoiDung) VALUES
(N'Không được mang chất cấm vào KTX'),
(N'Giữ trật tự sau 22h');
GO


-- 14. NhanVien r 6
INSERT INTO [dbo].[NhanVien] (MaNV, MaNguoiDung, HoTen, GioiTinh, NgaySinh, Email, SDT, ChucVu, TrinhDo) VALUES
(N'nv001', 5, N'Nguyễn Văn A', N'Nam', '1990-01-01', N'vana@ktx.edu.vn', N'0909123456', N'Quản lý', N'Cao đẳng'),
(N'nv002', 3, N'Lê Thị B', N'Nữ', '1992-02-02', N'thib@ktx.edu.vn', N'0987123456', N'Nhân viên', N'Đại học'); -- chưa
GO


-- 9. LoaiPhong r 7
INSERT INTO [dbo].[LoaiPhong] (MaLoaiPhong, TenLoai, SucChua, MucPhi) VALUES
(N'LP1', N'Phòng thường', 4, 500000),
(N'LP2', N'Phòng VIP', 2, 1500000);
GO

-- 18. Tang r  8
INSERT INTO [dbo].[Tang] (MaTang, TenTang) VALUES
(N'T01', N'Tầng 1'),
(N'T02', N'Tầng 2');
GO

-- 16. Phong r 9
INSERT INTO [dbo].[Phong] (MaPhong, TenPhong, MaLoaiPhong, MaTang, TrangThai) VALUES
(N'P101', N'Phòng 101', N'LP1', N'T01', N'Hoạt động'),
(N'P102', N'Phòng 102', N'LP2', N'T01', N'Hoạt động');
GO

-- 19. TrangThietBi r 10
INSERT INTO [dbo].[TrangThietBi] (MaThietBi, TenThietBi, MoTa, SoLuong, TrangThai) VALUES
(N'TB001', N'Quạt điện', N'Quạt trần', 2, N'Hoạt động'),
(N'TB002', N'Đèn ngủ', N'Đèn LED', 4, N'Hoạt động');
GO
-- 2. ChiTietPhong r 11
INSERT INTO [dbo].[ChiTietPhong] (MaPhong, MaThietBi, Giuong, TrangThai) VALUES
(N'P101', N'TB001', N'G1', N'Đang sử dụng'),
(N'P102', N'TB002', N'G2', N'Đang trống');
GO

-- 17. SinhVien r 12
INSERT INTO [dbo].[SinhVien] (MaSV, MaNguoiDung, HoTen, NgaySinh, Lop, SDT, Email, SoCanCuoc, SDTGiaDinh, SoHoKhau, TrangThai, AnhDaiDien, MaKhoa) VALUES
(N'sv001', 1, N'Phạm Văn C', '2003-03-03', N'DHTH19A', N'0912345678', N'cvp@univ.edu.vn', N'0123456789', N'0987654321', N'Sổ hộ khẩu 01', N'Đang ở', NULL, N'CNTT'),
(N'sv002', 2, N'Trương Thị D', '2004-04-04', N'DHTH19B', N'0909876543', N'dttruong@univ.edu.vn', N'0234567891', N'0976543210', N'Sổ hộ khẩu 02', N'Đang ở', NULL, N'QTKD');
GO

-- 20. ViPham r 13
INSERT INTO [dbo].[ViPham] (MaSV, MaNoiQuy, NgayViPham, GhiChu, HinhThucXuLy, MucDoXuLy, MaNV, FileBienBan) VALUES
(N'sv001', 1, '2025-05-05', N'Mở nhạc to', N'Nhắc nhở', N'Nhẹ', N'NV001', N'vp001.pdf'),
(N'sv002', 2, '2025-05-06', N'Nói chuyện ồn', N'Phạt tiền', N'Trung bình', N'NV002', N'vp002.pdf');
GO

-- 21. YeuCauSuaChua r 14
INSERT INTO [dbo].[YeuCauSuaChua] (MaSV, MaPhong, MoTa, NgayGui, TrangThai, MaNV) VALUES
(N'sv001', N'P101', N'Quạt không quay', '2025-05-01', N'Chờ xử lý', N'NV001'),
(N'sv002', N'P102', N'Đèn không sáng', '2025-05-02', N'Đã hoàn thành', N'NV002');
GO

-- 3. ChiTietSuaChua r 15
INSERT INTO [dbo].[ChiTietSuaChua] (MaYCSC, MaThietBi, MoTaLoi) VALUES
(1, N'TB001', N'Quạt tắc ngẽn bơm dầu'),
(2, N'TB002', N'Bóng đèn hỏng');
GO
-- 4. DatChoTruoc r 16
INSERT INTO [dbo].[DatChoTruoc] (MaSV, MaChiTietPhong, NgayDat, HanDat, TrangThai) VALUES
(N'sv001', 3, '2025-05-01', '2025-05-10', N'Đã đặt'),
(N'sv002', 4, '2025-05-02', '2025-05-12', N'Chờ duyệt');
GO
-- 7. HopDongNoiTru r 17
INSERT INTO [dbo].[HopDongNoiTru] (MaSV, MaPhong, MaMucGia, NgayDangKy, NgayBatDau, NgayKetThuc, DotDangKy, NhomTruong, TrangThai, TrangThaiDuyet, PhuongThucThanhToan, MinhChungThanhToan, MaNamHoc, MaNV) VALUES
(N'sv001', N'P101', 1, '2025-04-01', '2025-05-01', '2025-10-31', N'Đợt 1', N'SV001', N'Còn hiệu lực', N'Đã duyệt', N'Chuyển khoản', N'voucher001.jpg', N'2024-2025', N'NV001'),
(N'sv002', N'P102', 1, '2025-04-05', '2025-05-05', '2025-10-31', N'Đợt 1', N'SV002', N'Còn hiệu lực', N'Chưa duyệt', N'Tiền mặt', NULL, N'2024-2025', N'NV002');
GO
-- 10. MucGiaDienNuoc r 18
INSERT INTO [dbo].[MucGiaDienNuoc] (ThoiGianApDung, DonGiaDien, DonGiaNuoc) VALUES
('2025-01-01', 3500, 15000),
('2025-04-01', 3600, 15500);
GO

-- 15. PhieuThu r 18
INSERT INTO [dbo].[PhieuThu] (MaHopDong, NgayLap, TongTien, TrangThai, MaNV) VALUES
(2, '2025-05-01', 1750000, N'Đã thu', N'nv001'),
(3, '2025-05-02', 1500000, N'Chưa thu', N'nv001');
GO

-- 1. ChiTietPhieuThu r 19
INSERT INTO [dbo].[ChiTietPhieuThu] (MaPhieuThu, LoaiKhoanThu, SoTien) VALUES
(3, N'Tiền phòng tháng 5', 1500000),
(4, N'Tiền điện nước tháng 5', 250000);
GO






-- 5. DienNuoc r 20
INSERT INTO [dbo].[DienNuoc] (MaPhong, NgayBatDau, NgayKetThuc, SoDienCu, SoNuocCu, SoDienMoi, SoNuocMoi, MaMucGia, MaNV) VALUES
(N'P101', '2025-04-01', '2025-04-30', 120, 30, 150, 40, 1, N'NV001'),
(N'P102', '2025-04-01', '2025-04-30', 80, 20, 100, 25, 1, N'NV002');
GO




















USE [KTX];
GO

SELECT * FROM [dbo].[ChiTietPhieuThu];
GO

SELECT * FROM [dbo].[ChiTietPhong];
GO

SELECT * FROM [dbo].[ChiTietSuaChua];
GO

SELECT * FROM [dbo].[DatChoTruoc];
GO

SELECT * FROM [dbo].[DienNuoc];
GO

SELECT * FROM [dbo].[Giuong];
GO

SELECT * FROM [dbo].[HopDongNoiTru];
GO

SELECT * FROM [dbo].[Khoa];
GO

SELECT * FROM [dbo].[LoaiPhong];
GO

SELECT * FROM [dbo].[MucGiaDienNuoc];
GO

SELECT * FROM [dbo].[NamHoc];
GO

SELECT * FROM [dbo].[NoiQuy];
GO

SELECT * FROM [dbo].[NguoiDung];
GO

SELECT * FROM [dbo].[NhanVien];
GO

SELECT * FROM [dbo].[PhieuThu];
GO

SELECT * FROM [dbo].[Phong];
GO

SELECT * FROM [dbo].[SinhVien];
GO

SELECT * FROM [dbo].[Tang];
GO

SELECT * FROM [dbo].[TrangThietBi];
GO

SELECT * FROM [dbo].[ViPham];
GO

SELECT * FROM [dbo].[YeuCauSuaChua];
GO
