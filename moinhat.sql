USE master;
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'KTX')
BEGIN
    ALTER DATABASE KTX SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE KTX;
END;
CREATE DATABASE KTX;
GO

USE KTX;
GO
/****** Object:  Table [dbo].[ChiTietPhieuThu]    Script Date: 6/6/2025 9:08:36 PM ******/
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
/****** Object:  Table [dbo].[ChiTietPhong]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[ChiTietSuaChua]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[CT_ViPham]    Script Date: 6/6/2025 9:08:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CT_ViPham](
	[MaViPham] [int] NOT NULL,
	[MaSV] [nvarchar](20) NOT NULL,
	[HinhThucXuLy] [nvarchar](100) NULL,
	[MucDoXuLy] [nvarchar](50) NULL,
	[GhiChu] [nvarchar](255) NULL,
	[MaNV] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaViPham] ASC,
	[MaSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatChoTruoc]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[DiemDanh]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[DienNuoc]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[Giuong]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[HopDongNoiTru]    Script Date: 6/6/2025 9:08:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HopDongNoiTru](
	[MaHopDong] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
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
	[MaGiuong] [nvarchar](50) NULL,
 CONSTRAINT [PK__HopDongN__36DD43425E6FB1E7] PRIMARY KEY CLUSTERED 
(
	[MaHopDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[LichSuRaVao]    Script Date: 6/6/2025 9:08:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuRaVao](
	[MaLuot] [int] IDENTITY(1,1) NOT NULL,
	[MaSV] [nvarchar](20) NULL,
	[ThoiGian] [datetime] NULL,
	[TrangThai] [nvarchar](10) NULL,
	[HinhAnh] [nvarchar](255) NULL,
	[ViTri] [nvarchar](100) NULL,
	[GhiChu] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLuot] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiPhong]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[MucGiaDienNuoc]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[NamHoc]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[NhanVien]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[NoiQuy]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[PhieuThu]    Script Date: 6/6/2025 9:08:37 PM ******/
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
	[MaPhong] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaPhieuThu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[SinhVien]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[Tang]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[TrangThietBi]    Script Date: 6/6/2025 9:08:37 PM ******/
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
/****** Object:  Table [dbo].[ViPham]    Script Date: 6/6/2025 9:08:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ViPham](
	[MaViPham] [int] IDENTITY(1,1) NOT NULL,
	[MaNoiQuy] [int] NOT NULL,
	[NgayViPham] [date] NOT NULL,
	[MoTa] [nvarchar](255) NULL,
	[FileBienBan] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaViPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[YeuCauSuaChua]    Script Date: 6/6/2025 9:08:37 PM ******/
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

GO
SET IDENTITY_INSERT [dbo].[ChiTietSuaChua] ON 

INSERT [dbo].[ChiTietSuaChua] ([MaChiTiet], [MaYCSC], [MaThietBi], [MoTaLoi]) VALUES (1, 1, N'TB001', N'Đèn trần không sáng, cần thay bóng mới.')
INSERT [dbo].[ChiTietSuaChua] ([MaChiTiet], [MaYCSC], [MaThietBi], [MoTaLoi]) VALUES (3, 1, N'TB002', N'Quạt trần chạy chậm, nghi ngờ hỏng động cơ.')
INSERT [dbo].[ChiTietSuaChua] ([MaChiTiet], [MaYCSC], [MaThietBi], [MoTaLoi]) VALUES (4, 1, N'TB004', N'Cửa sổ bị kẹt, bản lề cần tra dầu hoặc thay mới.')
SET IDENTITY_INSERT [dbo].[ChiTietSuaChua] OFF
GO
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (1, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasd', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (2, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'Vào lúc 12h tối', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (2, N'2001216121', N'Nhắc nhở', N'Nhẹ', N'Vào lúc 12h tối', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (3, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasd', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (3, N'2001216121', N'Nhắc nhở', N'Nhẹ', N'ádasd', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (4, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasdas', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (5, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasd', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (6, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasd', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (6, N'2001216121', N'Nhắc nhở', N'Nhẹ', N'ádasd', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (7, N'2001216015', N'Cảnh cáo', N'Nhẹ', N'sdasd', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (7, N'2001216060', N'Cảnh cáo', N'Nhẹ', N'sdasd', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (8, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'sdsad', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (9, N'2001216004', N'Nhắc nhở', N'Trung Bình', N'sadas', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (9, N'2001216060', N'Nhắc nhở', N'Trung Bình', N'sadas', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (10, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'áds', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (11, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasd', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (12, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'sadasdsa', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (13, N'2001216002', N'Nhắc nhở', N'Nhẹ', N'sadas', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (15, N'2001216002', N'Nhắc nhở', N'Nhẹ', N'adss', NULL)
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (16, N'2001216002', N'Nhắc nhở', N'Nhẹ', N'quá ồn', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (17, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'Cùng với 2 người lạ vào trường', N'NV001')
INSERT [dbo].[CT_ViPham] ([MaViPham], [MaSV], [HinhThucXuLy], [MucDoXuLy], [GhiChu], [MaNV]) VALUES (18, N'2001216060', N'Nhắc nhở', N'Nhẹ', N'ádasd', N'NV001')
GO
SET IDENTITY_INSERT [dbo].[DiemDanh] ON 

GO
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15146, N'2001216121', CAST(N'2025-06-01T13:44:14.130' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15147, N'2001216121', CAST(N'2025-06-01T13:44:14.177' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15148, N'2001216121', CAST(N'2025-06-01T13:44:14.217' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15149, N'2001216121', CAST(N'2025-06-01T13:44:14.250' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15150, N'2001216121', CAST(N'2025-06-01T13:44:14.360' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15151, N'2001216121', CAST(N'2025-06-01T13:44:14.470' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15152, N'2001216121', CAST(N'2025-06-01T13:44:14.533' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15153, N'2001216060', CAST(N'2025-06-01T13:44:14.843' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15154, N'2001216060', CAST(N'2025-06-01T13:44:14.957' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15155, N'2001216060', CAST(N'2025-06-01T13:44:15.083' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15156, N'2001216060', CAST(N'2025-06-01T13:44:15.197' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15157, N'2001216060', CAST(N'2025-06-01T13:44:15.390' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15158, N'2001216121', CAST(N'2025-06-01T13:44:15.687' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15159, N'2001216121', CAST(N'2025-06-01T13:44:15.737' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15160, N'2001216121', CAST(N'2025-06-01T13:44:15.863' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15161, N'2001216121', CAST(N'2025-06-01T13:44:16.107' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15162, N'2001216121', CAST(N'2025-06-01T13:44:16.170' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15163, N'2001216121', CAST(N'2025-06-01T13:44:16.220' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15164, N'2001216060', CAST(N'2025-06-01T13:44:16.590' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15165, N'2001216060', CAST(N'2025-06-01T13:44:17.243' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15166, N'2001216060', CAST(N'2025-06-01T13:44:17.307' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15167, N'2001216060', CAST(N'2025-06-01T13:44:17.370' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15168, N'2001216060', CAST(N'2025-06-01T13:44:17.437' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15169, N'2001216060', CAST(N'2025-06-01T13:44:17.483' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15170, N'2001216060', CAST(N'2025-06-01T13:44:17.547' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15171, N'2001216121', CAST(N'2025-06-01T13:44:17.673' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15172, N'2001216121', CAST(N'2025-06-01T13:44:17.780' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15173, N'2001216121', CAST(N'2025-06-01T13:44:17.843' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15174, N'2001216060', CAST(N'2025-06-01T13:44:17.847' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15175, N'2001216060', CAST(N'2025-06-01T13:44:17.910' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15176, N'2001216121', CAST(N'2025-06-01T13:44:18.020' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15177, N'2001216060', CAST(N'2025-06-01T13:44:18.083' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15178, N'2001216121', CAST(N'2025-06-01T13:44:18.150' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15179, N'2001216121', CAST(N'2025-06-01T13:44:18.390' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15180, N'2001216121', CAST(N'2025-06-01T13:44:18.440' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15181, N'2001216121', CAST(N'2025-06-01T13:44:18.500' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15182, N'2001216121', CAST(N'2025-06-01T13:44:18.570' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15183, N'2001216121', CAST(N'2025-06-01T13:44:18.640' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15184, N'2001216121', CAST(N'2025-06-01T13:44:18.683' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15185, N'2001216121', CAST(N'2025-06-01T13:44:18.747' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15186, N'2001216060', CAST(N'2025-06-01T13:44:18.873' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15187, N'2001216121', CAST(N'2025-06-01T13:44:18.877' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15188, N'2001216121', CAST(N'2025-06-01T13:44:18.933' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15189, N'2001216121', CAST(N'2025-06-01T13:44:18.980' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15190, N'2001216121', CAST(N'2025-06-01T13:44:19.043' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15191, N'2001216121', CAST(N'2025-06-01T13:44:19.107' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15192, N'2001216121', CAST(N'2025-06-01T13:44:19.173' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15193, N'2001216121', CAST(N'2025-06-01T13:44:19.223' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15194, N'2001216121', CAST(N'2025-06-01T13:44:19.287' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15195, N'2001216121', CAST(N'2025-06-01T13:44:19.350' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15196, N'2001216121', CAST(N'2025-06-01T13:44:19.420' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15197, N'2001216060', CAST(N'2025-06-01T13:44:20.307' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15198, N'2001216121', CAST(N'2025-06-01T13:44:20.437' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15199, N'2001216060', CAST(N'2025-06-01T13:44:20.493' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15200, N'2001216060', CAST(N'2025-06-01T13:44:20.557' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15201, N'2001216060', CAST(N'2025-06-01T13:44:20.627' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15202, N'2001216060', CAST(N'2025-06-01T13:44:20.687' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15203, N'2001216060', CAST(N'2025-06-01T13:44:20.730' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15204, N'2001216060', CAST(N'2025-06-01T13:44:21.037' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15205, N'2001216060', CAST(N'2025-06-01T13:44:21.270' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15206, N'2001216060', CAST(N'2025-06-01T13:44:21.447' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15207, N'2001216060', CAST(N'2025-06-01T13:44:21.517' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15208, N'2001216060', CAST(N'2025-06-01T13:44:21.577' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15209, N'2001216060', CAST(N'2025-06-01T13:44:21.643' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15210, N'2001216060', CAST(N'2025-06-01T13:44:21.687' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15211, N'2001216060', CAST(N'2025-06-01T13:44:21.750' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15212, N'2001216060', CAST(N'2025-06-01T13:44:21.817' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15213, N'2001216060', CAST(N'2025-06-01T13:44:21.880' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15214, N'2001216060', CAST(N'2025-06-01T13:44:21.927' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15215, N'2001216060', CAST(N'2025-06-01T13:44:21.993' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15216, N'2001216060', CAST(N'2025-06-01T13:44:22.057' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15217, N'2001216060', CAST(N'2025-06-01T13:44:22.130' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15218, N'2001216060', CAST(N'2025-06-01T13:44:22.197' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15219, N'2001216060', CAST(N'2025-06-01T13:44:22.243' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15220, N'2001216060', CAST(N'2025-06-01T13:44:22.293' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15221, N'2001216060', CAST(N'2025-06-01T13:44:22.363' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15222, N'2001216060', CAST(N'2025-06-01T13:44:22.423' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15223, N'2001216060', CAST(N'2025-06-01T13:44:22.477' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15224, N'2001216060', CAST(N'2025-06-01T13:44:22.537' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15225, N'2001216060', CAST(N'2025-06-01T13:44:22.600' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15226, N'2001216060', CAST(N'2025-06-01T13:44:22.660' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15227, N'2001216060', CAST(N'2025-06-01T13:44:22.713' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15228, N'2001216060', CAST(N'2025-06-01T13:44:22.777' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15229, N'2001216060', CAST(N'2025-06-01T13:44:22.843' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15230, N'2001216060', CAST(N'2025-06-01T13:44:22.907' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15231, N'2001216060', CAST(N'2025-06-01T13:44:22.953' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15232, N'2001216060', CAST(N'2025-06-01T13:44:23.020' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15233, N'2001216060', CAST(N'2025-06-01T13:44:23.080' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15234, N'2001216060', CAST(N'2025-06-01T13:44:23.147' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15235, N'2001216060', CAST(N'2025-06-01T13:44:23.193' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15236, N'2001216060', CAST(N'2025-06-01T13:44:23.260' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15237, N'2001216060', CAST(N'2025-06-01T13:44:23.317' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15238, N'2001216060', CAST(N'2025-06-01T13:44:23.383' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15239, N'2001216060', CAST(N'2025-06-01T13:44:23.437' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15240, N'2001216060', CAST(N'2025-06-01T13:44:23.500' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15241, N'2001216060', CAST(N'2025-06-01T13:44:23.563' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15242, N'2001216060', CAST(N'2025-06-01T13:44:23.627' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15243, N'2001216060', CAST(N'2025-06-01T13:44:23.693' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15244, N'2001216060', CAST(N'2025-06-01T13:44:23.743' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15245, N'2001216060', CAST(N'2025-06-01T13:44:23.800' AS DateTime), N'Có mặt')
GO
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15246, N'2001216060', CAST(N'2025-06-01T13:44:23.863' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15247, N'2001216060', CAST(N'2025-06-01T13:44:23.927' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15248, N'2001216060', CAST(N'2025-06-01T13:44:23.980' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15249, N'2001216060', CAST(N'2025-06-01T13:44:24.043' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15250, N'2001216060', CAST(N'2025-06-01T13:44:24.107' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15251, N'2001216060', CAST(N'2025-06-01T13:44:24.167' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15252, N'2001216060', CAST(N'2025-06-01T13:44:24.220' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15253, N'2001216060', CAST(N'2025-06-01T13:44:24.347' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15254, N'2001216060', CAST(N'2025-06-01T13:44:24.407' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15255, N'2001216060', CAST(N'2025-06-01T13:44:24.457' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15256, N'2001216060', CAST(N'2025-06-01T13:44:24.523' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15257, N'2001216060', CAST(N'2025-06-01T13:44:24.583' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15258, N'2001216121', CAST(N'2025-06-01T13:44:24.587' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15259, N'2001216060', CAST(N'2025-06-01T13:44:24.643' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15260, N'2001216060', CAST(N'2025-06-01T13:44:25.123' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15261, N'2001216060', CAST(N'2025-06-01T13:44:25.170' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15262, N'2001216060', CAST(N'2025-06-01T13:44:25.473' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15263, N'2001216121', CAST(N'2025-06-01T13:44:25.603' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15264, N'2001216060', CAST(N'2025-06-01T13:44:25.670' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15265, N'2001216060', CAST(N'2025-06-01T13:44:25.713' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15266, N'2001216060', CAST(N'2025-06-01T13:44:25.777' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15267, N'2001216060', CAST(N'2025-06-01T13:44:25.847' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15268, N'2001216060', CAST(N'2025-06-01T13:44:25.907' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15269, N'2001216060', CAST(N'2025-06-01T13:44:25.960' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15270, N'2001216060', CAST(N'2025-06-01T13:44:26.023' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15271, N'2001216060', CAST(N'2025-06-01T13:44:26.083' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15272, N'2001216060', CAST(N'2025-06-01T13:44:26.123' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15273, N'2001216060', CAST(N'2025-06-01T13:44:26.160' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15274, N'2001216060', CAST(N'2025-06-01T13:44:26.217' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15275, N'2001216060', CAST(N'2025-06-01T13:44:26.610' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15276, N'2001216121', CAST(N'2025-06-01T13:44:26.910' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15277, N'2001216060', CAST(N'2025-06-01T13:44:26.917' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15278, N'2001216060', CAST(N'2025-06-01T13:44:27.177' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15279, N'2001216121', CAST(N'2025-06-01T13:44:27.947' AS DateTime), N'Có mặt')
INSERT [dbo].[DiemDanh] ([MaDiemDanh], [MaSV], [ThoiGian], [TrangThai]) VALUES (15280, N'2001216121', CAST(N'2025-06-01T13:44:28.003' AS DateTime), N'Có mặt')
SET IDENTITY_INSERT [dbo].[DiemDanh] OFF
GO
SET IDENTITY_INSERT [dbo].[DienNuoc] ON 

INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (2, N'KTX-01-01', CAST(N'2025-04-01' AS Date), CAST(N'2025-04-30' AS Date), 100, 10, 150, 12, 2, N'NV001')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (3, N'KTX-01-01', CAST(N'2025-04-01' AS Date), CAST(N'2025-04-30' AS Date), 200, 15, 260, 18, 2, N'NV002')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (4, N'KTX-01-01', CAST(N'2025-04-01' AS Date), CAST(N'2025-04-30' AS Date), 150, 150, 275, 200, 5, N'NV001')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (5, N'KTX-01-01', CAST(N'2025-05-01' AS Date), CAST(N'2025-05-31' AS Date), 275, 200, 300, 300, 5, N'NV001')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (6, N'KTX-01-01', CAST(N'2025-06-01' AS Date), CAST(N'2025-06-30' AS Date), 300, 300, 450, 450, 1, N'NV001')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (7, N'KTX-01-01', CAST(N'2025-07-01' AS Date), CAST(N'2025-07-31' AS Date), 450, 450, 500, 500, 1, N'NV001')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (8, N'KTX-01-01', CAST(N'2025-08-01' AS Date), CAST(N'2025-08-31' AS Date), 500, 500, 550, 550, 1, NULL)
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (9, N'KTX-01-01', CAST(N'2025-09-01' AS Date), CAST(N'2025-09-30' AS Date), 550, 550, 600, 600, 1, N'NV003')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (10, N'KTX-01-01', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-31' AS Date), 600, 600, 700, 700, 1, N'NV003')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (11, N'KTX-01-02', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-31' AS Date), 557, 433, 643, 542, 1, N'NV003')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (12, N'KTX-01-03', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-31' AS Date), 321, 222, 544, 542, 1, N'NV003')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (13, N'KTX-01-04', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-31' AS Date), 222, 333, 342, 412, 1, N'NV003')
INSERT [dbo].[DienNuoc] ([MaDN], [MaPhong], [NgayBatDau], [NgayKetThuc], [SoDienCu], [SoNuocCu], [SoDienMoi], [SoNuocMoi], [MaMucGia], [MaNV]) VALUES (14, N'KTX-01-05', CAST(N'2025-10-01' AS Date), CAST(N'2025-10-31' AS Date), 433, 434, 542, 521, 1, N'NV003')
SET IDENTITY_INSERT [dbo].[DienNuoc] OFF
GO
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-01-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-02-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-03-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-04-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-05-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-06-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-07-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-08-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-09-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-01-10-10', N'Đã sử dụng')
GO
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-01-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-02-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-03-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-04-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-05-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-06-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-07-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-08-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-09-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-02-10-10', N'Đã sử dụng')
GO
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-01-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-02-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-03-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-04-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-05-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-06-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-07-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-08-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-09-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-03-10-10', N'Đã sử dụng')
GO
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-01-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-02-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-03-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-04-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-05-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-06-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-07-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-08-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-09-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-04-10-10', N'Đã sử dụng')
GO
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-01-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-02-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-03-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-04-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-05-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-06-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-07-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-08-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-09-10', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-01', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-02', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-03', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-04', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-05', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-06', N'Trống')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-07', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-08', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-09', N'Đã sử dụng')
INSERT [dbo].[Giuong] ([MaGiuong], [TrangThai]) VALUES (N'KTX-05-10-10', N'Đã sử dụng')
GO
SET IDENTITY_INSERT [dbo].[HopDongNoiTru] ON 

INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (1, N'2001216001', N'KTX-01-01-01', N'KTX-01-01', CAST(N'2023-07-01' AS Date), CAST(N'2023-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'1         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2023001', N'NH2023    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (2, N'2001216002', N'KTX-01-01-02', N'KTX-01-01', CAST(N'2023-07-02' AS Date), CAST(N'2023-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2023002', N'NH2023    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (3, N'2001216003', N'KTX-01-02-01', N'KTX-01-02', CAST(N'2023-07-03' AS Date), CAST(N'2023-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'1         ', N'Hủy', N'Từ chối', N'Chuyển khoản', NULL, N'NH2023    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (4, N'2001216004', N'KTX-01-01-03', N'KTX-01-01', CAST(N'2024-06-15' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024001', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (5, N'2001216005', N'KTX-01-02-02', N'KTX-01-02', CAST(N'2024-06-20' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Chuyển khoản', NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (6, N'2001216006', N'KTX-02-01-01', N'KTX-02-01', CAST(N'2024-07-01' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'1         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024002', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (7, N'2001216007', N'KTX-02-01-02', N'KTX-02-01', CAST(N'2024-07-05' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (8, N'2001216008', N'KTX-01-01-04', N'KTX-01-01', CAST(N'2025-05-01' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Chuyển khoản', NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (9, N'2001216009', N'KTX-01-02-03', N'KTX-01-02', CAST(N'2025-05-10' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025001', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (10, N'2001216010', N'KTX-02-01-03', N'KTX-02-01', CAST(N'2025-05-15' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', NULL, NULL, N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (11, N'2001216011', N'KTX-01-01-01', N'KTX-01-01', CAST(N'2024-06-01' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024001', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (12, N'2001216012', N'KTX-01-01-02', N'KTX-01-01', CAST(N'2024-06-02' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024002', N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (13, N'2001216013', N'KTX-01-01-03', N'KTX-01-01', CAST(N'2024-06-03' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Chuyển khoản', NULL, N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (14, N'2001216014', N'KTX-01-01-04', N'KTX-01-01', CAST(N'2024-06-04' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024003', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (15, N'2001216015', N'KTX-01-01-05', N'KTX-01-01', CAST(N'2024-06-05' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (16, N'2001216016', N'KTX-01-01-06', N'KTX-01-01', CAST(N'2024-06-06' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024004', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (17, N'2001216017', N'KTX-01-01-07', N'KTX-01-01', CAST(N'2024-06-07' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024005', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (18, N'2001216018', N'KTX-01-01-08', N'KTX-01-01', CAST(N'2024-06-08' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (19, N'2001216019', N'KTX-01-01-09', N'KTX-01-01', CAST(N'2024-06-09' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024006', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (20, N'2001216020', N'KTX-01-01-10', N'KTX-01-01', CAST(N'2024-06-10' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024007', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (21, N'2001216021', N'KTX-01-02-01', N'KTX-01-02', CAST(N'2024-06-11' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (22, N'2001216022', N'KTX-01-02-02', N'KTX-01-02', CAST(N'2024-06-12' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024008', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (23, N'2001216023', N'KTX-01-02-03', N'KTX-01-02', CAST(N'2024-06-13' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024009', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (24, N'2001216024', N'KTX-01-02-04', N'KTX-01-02', CAST(N'2024-06-14' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Thẻ ngân hàng', NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (25, N'2001216025', N'KTX-01-02-05', N'KTX-01-02', CAST(N'2024-06-15' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024010', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (26, N'2001216026', N'KTX-01-02-06', N'KTX-01-02', CAST(N'2024-06-16' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024011', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (27, N'2001216027', N'KTX-01-02-07', N'KTX-01-02', CAST(N'2024-06-17' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (28, N'2001216028', N'KTX-01-02-08', N'KTX-01-02', CAST(N'2024-06-18' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024012', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (29, N'2001216029', N'KTX-01-02-09', N'KTX-01-02', CAST(N'2024-06-19' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024013', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (30, N'2001216030', N'KTX-01-02-10', N'KTX-01-02', CAST(N'2024-06-20' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ duyệt', N'Chờ duyệt', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (31, N'2001216031', N'KTX-01-03-01', N'KTX-01-03', CAST(N'2024-06-21' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'1         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024014', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (32, N'2001216032', N'KTX-01-03-02', N'KTX-01-03', CAST(N'2024-06-22' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024015', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (33, N'2001216033', N'KTX-01-03-03', N'KTX-01-03', CAST(N'2024-06-23' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (34, N'2001216034', N'KTX-01-03-04', N'KTX-01-03', CAST(N'2024-06-24' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024016', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (35, N'2001216035', N'KTX-01-03-05', N'KTX-01-03', CAST(N'2024-06-25' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024017', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (36, N'2001216036', N'KTX-01-03-06', N'KTX-01-03', CAST(N'2024-06-26' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Tiền mặt', NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (37, N'2001216037', N'KTX-01-03-07', N'KTX-01-03', CAST(N'2024-06-27' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024018', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (38, N'2001216038', N'KTX-01-03-08', N'KTX-01-03', CAST(N'2024-06-28' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024019', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (39, N'2001216039', N'KTX-01-03-09', N'KTX-01-03', CAST(N'2024-06-29' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (40, N'2001216040', N'KTX-01-03-10', N'KTX-01-03', CAST(N'2024-06-30' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024020', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (41, N'2001216041', N'KTX-01-04-01', N'KTX-01-04', CAST(N'2024-07-01' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'1         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024021', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (42, N'2001216042', N'KTX-01-04-02', N'KTX-01-04', CAST(N'2024-07-02' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (43, N'2001216043', N'KTX-01-04-03', N'KTX-01-04', CAST(N'2024-07-03' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2024022', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (44, N'2001216044', N'KTX-01-04-04', N'KTX-01-04', CAST(N'2024-07-04' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024023', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (45, N'2001216045', N'KTX-01-04-05', N'KTX-01-04', CAST(N'2024-07-05' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (46, N'2001216046', N'KTX-01-04-06', N'KTX-01-04', CAST(N'2024-07-06' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2024024', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (47, N'2001216047', N'KTX-01-04-07', N'KTX-01-04', CAST(N'2024-07-07' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024025', N'NH2024    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (48, N'2001216048', N'KTX-01-04-08', N'KTX-01-04', CAST(N'2024-07-08' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Tiền mặt', NULL, N'NH2024    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (49, N'2001216049', N'KTX-01-04-09', N'KTX-01-04', CAST(N'2024-07-09' AS Date), CAST(N'2024-09-01' AS Date), CAST(N'2025-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2024026', N'NH2024    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (50, N'2001216050', N'KTX-01-04-10', N'KTX-01-04', CAST(N'2025-04-01' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025001', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (51, N'2001216060', N'KTX-01-05-01', N'KTX-01-05', CAST(N'2025-04-02' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'1         ', N'Chờ nhận phòng', N'Chờ duyệt', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (52, N'2001216121', N'KTX-01-05-02', N'KTX-01-05', CAST(N'2025-04-03' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025002', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (53, N'2001216201', N'KTX-01-05-03', N'KTX-01-05', CAST(N'2025-04-04' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2025003', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (54, N'2001216202', N'KTX-01-05-04', N'KTX-01-05', CAST(N'2025-04-05' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (55, N'2001216203', N'KTX-01-05-05', N'KTX-01-05', CAST(N'2025-04-06' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025004', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (56, N'2001216204', N'KTX-01-05-06', N'KTX-01-05', CAST(N'2025-04-07' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025005', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (57, N'2001216205', N'KTX-01-05-07', N'KTX-01-05', CAST(N'2025-04-08' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Tiền mặt', NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (58, N'2001216206', N'KTX-01-05-08', N'KTX-01-05', CAST(N'2025-04-09' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025006', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (59, N'2001216207', N'KTX-01-05-09', N'KTX-01-05', CAST(N'2025-04-10' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025007', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (60, N'2001216208', N'KTX-01-05-10', N'KTX-01-05', CAST(N'2025-04-11' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (61, N'2001216209', N'KTX-01-06-01', N'KTX-01-06', CAST(N'2025-04-12' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'1         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025008', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (62, N'2001216210', N'KTX-01-06-02', N'KTX-01-06', CAST(N'2025-04-13' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2025009', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (63, N'2001216211', N'KTX-01-06-03', N'KTX-01-06', CAST(N'2025-04-14' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (64, N'2001216212', N'KTX-01-06-04', N'KTX-01-06', CAST(N'2025-04-15' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025010', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (65, N'2001216213', N'KTX-01-06-05', N'KTX-01-06', CAST(N'2025-04-16' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025011', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (66, N'2001216214', N'KTX-01-06-06', N'KTX-01-06', CAST(N'2025-04-17' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (67, N'2001216215', N'KTX-01-06-07', N'KTX-01-06', CAST(N'2025-04-18' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025012', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (68, N'2001216216', N'KTX-01-06-08', N'KTX-01-06', CAST(N'2025-04-19' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2025013', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (69, N'2001216217', N'KTX-01-06-09', N'KTX-01-06', CAST(N'2025-04-20' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Chờ duyệt', N'Chờ duyệt', N'Chuyển khoản', NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (70, N'2001216218', N'KTX-01-06-10', N'KTX-01-06', CAST(N'2025-04-21' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025014', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (71, N'2001216219', N'KTX-01-07-01', N'KTX-01-07', CAST(N'2025-04-22' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'1         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025015', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (72, N'2001216220', N'KTX-01-07-02', N'KTX-01-07', CAST(N'2025-04-23' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (73, N'2001216222', N'KTX-01-07-04', N'KTX-01-07', CAST(N'2025-04-25' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025017', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (74, N'2001216223', N'KTX-01-07-05', N'KTX-01-07', CAST(N'2025-04-26' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Chờ nhận phòng', N'Chờ duyệt', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (75, N'2001216224', N'KTX-01-07-06', N'KTX-01-07', CAST(N'2025-04-27' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Thẻ ngân hàng', N'TXN2025018', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (76, N'2001216225', N'KTX-01-07-07', N'KTX-01-07', CAST(N'2025-04-28' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025019', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (77, N'2001216226', N'KTX-01-07-08', N'KTX-01-07', CAST(N'2025-04-29' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Hủy', N'Từ chối', NULL, NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (78, N'2001216227', N'KTX-01-07-09', N'KTX-01-07', CAST(N'2025-04-30' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2025020', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (79, N'2001216228', N'KTX-01-07-10', N'KTX-01-07', CAST(N'2025-05-01' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025021', N'NH2025    ', N'NV001')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (80, N'2001216229', N'KTX-01-08-01', N'KTX-01-08', CAST(N'2025-05-02' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 2', N'1         ', N'Chờ nhận phòng', N'Chờ duyệt', N'Thẻ ngân hàng', NULL, N'NH2025    ', N'NV002')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (81, N'2001216230', N'KTX-01-08-02', N'KTX-01-08', CAST(N'2025-05-03' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Chuyển khoản', N'TXN2025022', N'NH2025    ', N'NV003')
INSERT [dbo].[HopDongNoiTru] ([MaHopDong], [MaSV], [MaGiuong], [MaPhong], [NgayDangKy], [NgayBatDau], [NgayKetThuc], [DotDangKy], [NhomTruong], [TrangThai], [TrangThaiDuyet], [PhuongThucThanhToan], [MinhChungThanhToan], [MaNamHoc], [MaNV]) VALUES (82, N'2001216414', N'KTX-01-08-03', N'KTX-01-08', CAST(N'2025-05-04' AS Date), CAST(N'2025-09-01' AS Date), CAST(N'2026-06-30' AS Date), N'Đợt 1', N'0         ', N'Đang Sử Dụng', N'Đã duyệt', N'Tiền mặt', N'TXN2025023', N'NH2025    ', N'NV001')SET IDENTITY_INSERT [dbo].[HopDongNoiTru] OFF
GO
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'CNTT', N'Công nghệ thông tin')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'KT', N'Kế toán')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'NN', N'Ngoại ngữ')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'QTKD', N'Quản trị kinh doanh')
INSERT [dbo].[Khoa] ([MaKhoa], [TenKhoa]) VALUES (N'YH', N'Y học')
GO
SET IDENTITY_INSERT [dbo].[LichSuRaVao] ON 

INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (1, N'2001216060', CAST(N'2025-05-23T08:28:55.377' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_082855.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (2, N'2001216060', CAST(N'2025-05-23T08:29:21.277' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_082921.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (3, N'2001216060', CAST(N'2025-05-23T08:29:40.833' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_082940.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (4, N'2001216060', CAST(N'2025-05-23T08:30:37.480' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_083037.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (5, N'2001216060', CAST(N'2025-05-23T08:32:13.530' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_083213.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (6, N'2001216060', CAST(N'2025-05-23T08:33:54.833' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_083354.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (7, N'2001216060', CAST(N'2025-05-23T08:44:23.993' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_084423.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (8, N'2001216060', CAST(N'2025-05-23T08:44:36.327' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_084436.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (9, N'2001216060', CAST(N'2025-05-23T08:44:57.230' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250523_084457.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (10, N'2001216060', CAST(N'2025-05-25T10:29:30.223' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250525_102930.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (11, N'2001216060', CAST(N'2025-05-31T21:41:09.697' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250531_214109.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (12, N'2001216060', CAST(N'2025-06-06T17:23:45.090' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250606_172345.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (13, N'2001216060', CAST(N'2025-06-06T17:24:11.690' AS DateTime), N'Vào', N'D:\KTX_RaVao\AnhQuet\2001216060_20250606_172411.jpg', N'Cổng chính', NULL)
INSERT [dbo].[LichSuRaVao] ([MaLuot], [MaSV], [ThoiGian], [TrangThai], [HinhAnh], [ViTri], [GhiChu]) VALUES (14, N'2001216060', CAST(N'2025-06-06T17:24:58.187' AS DateTime), N'Ra', N'D:\KTX_RaVao\AnhQuet\2001216060_20250606_172458.jpg', N'Cổng chính', NULL)
SET IDENTITY_INSERT [dbo].[LichSuRaVao] OFF
GO
INSERT [dbo].[LoaiPhong] ([MaLoaiPhong], [TenLoai], [SucChua], [MucPhi]) VALUES (N'LP001', N'Phòng thường', 4, 500000.0000)
INSERT [dbo].[LoaiPhong] ([MaLoaiPhong], [TenLoai], [SucChua], [MucPhi]) VALUES (N'LP002', N'Phòng VIP', 2, 1500000.0000)
GO
SET IDENTITY_INSERT [dbo].[MucGiaDienNuoc] ON 

INSERT [dbo].[MucGiaDienNuoc] ([MaMucGia], [ThoiGianApDung], [DonGiaDien], [DonGiaNuoc]) VALUES (1, CAST(N'2021-01-01' AS Date), 3500.0000, 5000.0000)
INSERT [dbo].[MucGiaDienNuoc] ([MaMucGia], [ThoiGianApDung], [DonGiaDien], [DonGiaNuoc]) VALUES (2, CAST(N'2022-01-01' AS Date), 4000.0000, 5500.0000)
INSERT [dbo].[MucGiaDienNuoc] ([MaMucGia], [ThoiGianApDung], [DonGiaDien], [DonGiaNuoc]) VALUES (3, CAST(N'2023-01-01' AS Date), 4500.0000, 6000.0000)
INSERT [dbo].[MucGiaDienNuoc] ([MaMucGia], [ThoiGianApDung], [DonGiaDien], [DonGiaNuoc]) VALUES (4, CAST(N'2025-01-01' AS Date), 4000.0000, 20000.0000)
INSERT [dbo].[MucGiaDienNuoc] ([MaMucGia], [ThoiGianApDung], [DonGiaDien], [DonGiaNuoc]) VALUES (5, CAST(N'2025-06-01' AS Date), 4500.0000, 22000.0000)
SET IDENTITY_INSERT [dbo].[MucGiaDienNuoc] OFF
GO
INSERT [dbo].[NamHoc] ([MaNamHoc], [TenNamHoc]) VALUES (N'NH2021    ', N'2021-2022 ')
INSERT [dbo].[NamHoc] ([MaNamHoc], [TenNamHoc]) VALUES (N'NH2022    ', N'2022-2023 ')
INSERT [dbo].[NamHoc] ([MaNamHoc], [TenNamHoc]) VALUES (N'NH2023    ', N'2023-2024 ')
INSERT [dbo].[NamHoc] ([MaNamHoc], [TenNamHoc]) VALUES (N'NH2024    ', N'2024-2025 ')
INSERT [dbo].[NamHoc] ([MaNamHoc], [TenNamHoc]) VALUES (N'NH2025    ', N'2025-2026 ')
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (1, N'admin', N'$2a$12$wApSIegJlhXzCFrGfq1rnu9nec4cb2Ro4rieXnobwM3ckTwVcIKgK', N'Admin', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (2, N'trannam', N'$2a$12$wApSIegJlhXzCFrGfq1rnu9nec4cb2Ro4rieXnobwM3ckTwVcIKgK', N'NhanVienKyThuat', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (3, N'kythuat', N'$2a$12$wApSIegJlhXzCFrGfq1rnu9nec4cb2Ro4rieXnobwM3ckTwVcIKgK', N'NhanVienKyThuat', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (4, N'sinhvien02', N'123', N'NhanVien', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (5, N'thanhngan', N'123', N'NhanVien', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (6, N'nguyennam', N'$2a$11$6kGj6k0buwRFqG7QPDzLgOpMvNjBae8VteqtJ76AniQRnpD2IGK9i', N'NhanVien', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (7, N'2001216001', N'2001216001', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (8, N'2001216002', N'2001216002', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (9, N'2001216003', N'2001216003', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (10, N'2001216004', N'2001216004', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (11, N'2001216005', N'2001216005', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (12, N'2001216006', N'2001216006', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (13, N'2001216007', N'2001216007', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (14, N'2001216008', N'2001216008', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (15, N'2001216009', N'2001216009', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (16, N'2001216010', N'2001216010', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (17, N'2001216011', N'2001216011', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (18, N'2001216012', N'2001216012', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (19, N'2001216013', N'2001216013', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (20, N'2001216014', N'2001216014', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (21, N'2001216015', N'2001216015', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (22, N'2001216016', N'2001216016', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (23, N'2001216017', N'2001216017', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (24, N'2001216018', N'2001216018', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (25, N'2001216019', N'2001216019', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (26, N'2001216020', N'2001216020', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (27, N'2001216021', N'2001216021', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (28, N'2001216022', N'2001216022', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (29, N'2001216023', N'2001216023', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (30, N'2001216024', N'2001216024', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (31, N'2001216025', N'2001216025', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (32, N'2001216026', N'2001216026', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (33, N'2001216027', N'2001216027', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (34, N'2001216028', N'2001216028', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (35, N'2001216029', N'2001216029', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (36, N'2001216030', N'2001216030', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (37, N'2001216031', N'2001216031', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (38, N'2001216032', N'2001216032', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (39, N'2001216033', N'2001216033', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (40, N'2001216034', N'2001216034', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (41, N'2001216035', N'2001216035', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (42, N'2001216036', N'2001216036', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (43, N'2001216037', N'2001216037', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (44, N'2001216038', N'2001216038', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (45, N'2001216039', N'2001216039', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (46, N'2001216040', N'2001216040', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (47, N'2001216041', N'2001216041', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (48, N'2001216042', N'2001216042', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (49, N'2001216043', N'2001216043', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (50, N'2001216044', N'2001216044', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (51, N'2001216045', N'2001216045', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (52, N'2001216046', N'2001216046', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (53, N'2001216047', N'2001216047', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (54, N'2001216048', N'2001216048', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (55, N'2001216049', N'2001216049', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (56, N'2001216050', N'2001216050', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (57, N'2001216060', N'2001216060', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (58, N'2001216121', N'2001216121', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (59, N'2001216201', N'2001216201', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (60, N'2001216202', N'2001216202', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (61, N'2001216203', N'2001216203', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (62, N'2001216204', N'2001216204', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (63, N'2001216205', N'2001216205', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (64, N'2001216206', N'2001216206', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (65, N'2001216207', N'2001216207', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (66, N'2001216208', N'2001216208', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (67, N'2001216209', N'2001216209', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (68, N'2001216210', N'2001216210', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (69, N'2001216211', N'2001216211', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (70, N'2001216212', N'2001216212', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (71, N'2001216213', N'2001216213', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (72, N'2001216214', N'2001216214', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (73, N'2001216215', N'2001216215', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (74, N'2001216216', N'2001216216', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (75, N'2001216217', N'2001216217', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (76, N'2001216218', N'2001216218', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (77, N'2001216219', N'2001216219', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (78, N'2001216220', N'2001216220', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (79, N'2001216221', N'2001216221', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (80, N'2001216222', N'2001216222', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (81, N'2001216223', N'2001216223', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (82, N'2001216224', N'2001216224', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (83, N'2001216225', N'2001216225', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (84, N'2001216226', N'2001216226', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (85, N'2001216227', N'2001216227', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (86, N'2001216228', N'2001216228', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (87, N'2001216229', N'2001216229', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (88, N'2001216230', N'2001216230', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (89, N'2001216414', N'2001216414', N'Sinh viên', NULL)
INSERT [dbo].[NguoiDung] ([MaNguoiDung], [TenDangNhap], [MatKhau], [VaiTro], [OTP]) VALUES (90, N'2001215850', N'2001215850', N'Sinh viên', NULL)
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
GO
INSERT [dbo].[NhanVien] ([MaNV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [AnhDaiDien], [Email], [SDT], [ChucVu], [TrinhDo]) VALUES (N'NV001', 6, N'Nguyễn Nam', N'Nam', CAST(N'1985-03-15' AS Date), N'avatar2.jpg', N'buihungphuong0218@gmail.com', N'0901234567', N'Nhân viên', N'Cử nhân CNTT')
INSERT [dbo].[NhanVien] ([MaNV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [AnhDaiDien], [Email], [SDT], [ChucVu], [TrinhDo]) VALUES (N'NV002', 2, N'Phạm Thị C', N'Nữ', CAST(N'1990-07-20' AS Date), N'avatar1.jpg', N'phamc@example.com', N'0907654321', N'Thu ngân', N'Cử nhân Kế toán')
INSERT [dbo].[NhanVien] ([MaNV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [AnhDaiDien], [Email], [SDT], [ChucVu], [TrinhDo]) VALUES (N'NV003', 3, N'Nguyễn Minh D', N'Nam', CAST(N'1992-11-10' AS Date), N'avatar3.jpg', N'nguyend@example.com', N'0912345678', N'Nhân viên kỹ thuật', N'Thạc sĩ CNTT')
INSERT [dbo].[NhanVien] ([MaNV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [AnhDaiDien], [Email], [SDT], [ChucVu], [TrinhDo]) VALUES (N'NV004', 4, N'Trần Tuyết Như', N'Nữ', CAST(N'1993-11-02' AS Date), N'avatar4.jpg', N'tuyetnhuw@gmail.com', N'0927371711', N'Nhân viên kỹ thuật', N'Thạc sĩ CNTT')
INSERT [dbo].[NhanVien] ([MaNV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [AnhDaiDien], [Email], [SDT], [ChucVu], [TrinhDo]) VALUES (N'NV004', 5, N'Nguyễn Thanh Ngân', N'Nữ', CAST(N'2006-12-24' AS Date), N'avatar4.jpg', N'thanhngan2412@gmail.com', N'0927371711', N'Nhân viên kỹ thuật', N'Cử nhân NNA')

GO
SET IDENTITY_INSERT [dbo].[NoiQuy] ON 

INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (1, N'Vi phạm giờ giới nghiêm')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (2, N'Sử dụng thiết bị điện trái phép')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (3, N'Gây ồn ào trong ký túc xá')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (4, N'Không giữ vệ sinh khu vực chung')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (5, N'Hút thuốc trong khu ký túc xá')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (6, N'Đưa người lạ vào ký túc xá mà không đăng ký')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (7, N'Sử dụng rượu bia trong phòng ở')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (8, N'Tự ý di chuyển đồ đạc của ký túc xá')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (9, N'Gây hư hỏng tài sản ký túc xá')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (10, N'Không tuân thủ quy định phân loại rác')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (11, N'Sử dụng bếp nấu ăn trong phòng ở')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (12, N'Để xe không đúng nơi quy định')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (13, N'Không tham gia dọn dẹp định kỳ')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (14, N'Sử dụng loa phát âm thanh lớn ngoài giờ cho phép')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (15, N'Tự ý thay đổi ổ khóa phòng')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (16, N'Không báo cáo sự cố hỏng hóc trong phòng')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (17, N'Đánh bạc hoặc tổ chức đánh bạc')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (18, N'Sử dụng chất cấm trong ký túc xá')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (19, N'Treo, dán áp phích không được phép')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (20, N'Không tắt điện, nước khi rời phòng')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (21, N'Xâm phạm tài sản cá nhân của người khác')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (22, N'Tổ chức tụ tập đông người không được phép')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (23, N'Không chấp hành kiểm tra phòng định kỳ')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (24, N'Sử dụng mạng internet cho mục đích bất hợp pháp')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (25, N'Không đóng phí ký túc xá đúng hạn')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (26, N'Cản trở công việc của nhân viên quản lý')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (27, N'Sử dụng thiết bị điện công suất cao')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (28, N'Không tham gia các buổi họp nội quy')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (29, N'Gây mất đoàn kết giữa các sinh viên')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (30, N'Không đăng ký tạm trú theo quy định')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (31, N'Sử dụng vật nuôi trong ký túc xá')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (32, N'Không tuân thủ quy định phòng cháy chữa cháy')
INSERT [dbo].[NoiQuy] ([MaNoiQuy], [NoiDung]) VALUES (33, N'Tự ý sửa chữa, cải tạo phòng ở')
SET IDENTITY_INSERT [dbo].[NoiQuy] OFF

GO
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-01', N'Phòng 01-01', N'LP001', N'T1        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-02', N'Phòng 01-02', N'LP001', N'T1        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-03', N'Phòng 01-03', N'LP001', N'T1        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-04', N'Phòng 01-04', N'LP001', N'T1        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-05', N'Phòng 01-05', N'LP001', N'T1        ', N'2')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-06', N'Phòng 01-06', N'LP001', N'T1        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-07', N'Phòng 01-07', N'LP001', N'T1        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-08', N'Phòng 01-08', N'LP001', N'T1        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-09', N'Phòng 01-09', N'LP001', N'T1        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-01-10', N'Phòng 01-10', N'LP001', N'T1        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-01', N'Phòng 02-01', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-02', N'Phòng 02-02', N'LP001', N'T2        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-03', N'Phòng 02-03', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-04', N'Phòng 02-04', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-05', N'Phòng 02-05', N'LP001', N'T2        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-06', N'Phòng 02-06', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-07', N'Phòng 02-07', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-08', N'Phòng 02-08', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-09', N'Phòng 02-09', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-02-10', N'Phòng 02-10', N'LP001', N'T2        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-01', N'Phòng 03-01', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-02', N'Phòng 03-02', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-03', N'Phòng 03-03', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-04', N'Phòng 03-04', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-05', N'Phòng 03-05', N'LP001', N'T3        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-06', N'Phòng 03-06', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-07', N'Phòng 03-07', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-08', N'Phòng 03-08', N'LP001', N'T3        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-09', N'Phòng 03-09', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-03-10', N'Phòng 03-10', N'LP001', N'T3        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-01', N'Phòng 04-01', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-02', N'Phòng 04-02', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-03', N'Phòng 04-03', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-04', N'Phòng 04-04', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-05', N'Phòng 04-05', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-06', N'Phòng 04-06', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-07', N'Phòng 04-07', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-08', N'Phòng 04-08', N'LP002', N'T4        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-09', N'Phòng 04-09', N'LP002', N'T4        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-04-10', N'Phòng 04-10', N'LP002', N'T4        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-01', N'Phòng 05-01', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-02', N'Phòng 05-02', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-03', N'Phòng 05-03', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-04', N'Phòng 05-04', N'LP002', N'T5        ', N'0')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-05', N'Phòng 05-05', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-06', N'Phòng 05-06', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-07', N'Phòng 05-07', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-08', N'Phòng 05-08', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-09', N'Phòng 05-09', N'LP002', N'T5        ', N'1')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong], [MaLoaiPhong], [MaTang], [TrangThai]) VALUES (N'KTX-05-10', N'Phòng 05-10', N'LP002', N'T5        ', N'1')
GO
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001215850', 90, N'Huỳnh Vĩ Khang', N'Nam', N'2002-05-28', N'12DHTH17', N'0767487840', N'huynhvikhang6a13@gmail.com', N'123426789041', N'0930123458', N'85Q30/TPHCM', N'Đang Học', N'vikhang2805.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216001', 7, N'Nguyễn Văn An', N'Nam', N'2002-01-01', N'KT01', N'0901216001', N'2001216001@example.com', N'123456789001', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216002', 8, N'Trần Thị Bình', N'Nữ', N'2002-01-01', N'NN01', N'0901216002', N'2001216002@example.com', N'123456789002', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216003', 9, N'Lê Văn Cường', N'Nam', N'2002-01-01', N'QTKD01', N'0901216003', N'2001216003@example.com', N'123456789003', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216004', 10, N'Phạm Thị Dung', N'Nữ', N'2002-01-01', N'YH01', N'0901216004', N'2001216004@example.com', N'123456789004', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216005', 11, N'Hoàng Văn Em', N'Nam', N'2002-01-01', N'CNTT01', N'0901216005', N'2001216005@example.com', N'123456789005', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216006', 12, N'Nguyễn Thị Fleur', N'Nữ', N'2002-01-01', N'KT01', N'0901216006', N'2001216006@example.com', N'123456789006', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216007', 13, N'Trần Văn Giang', N'Nam', N'2002-01-01', N'NN01', N'0901216007', N'2001216007@example.com', N'123456789007', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216008', 14, N'Lê Thị Hà', N'Nữ', N'2002-01-01', N'QTKD01', N'0901216008', N'2001216008@example.com', N'123456789008', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216009', 15, N'Phạm Văn Hùng', N'Nam', N'2002-01-01', N'YH01', N'0901216009', N'2001216009@example.com', N'123456789009', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216010', 16, N'Hoàng Thị In', N'Nữ', N'2002-01-01', N'CNTT01', N'0901216010', N'2001216010@example.com', N'123456789010', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216011', 17, N'Nguyễn Văn Khang', N'Nam', N'2002-01-01', N'KT01', N'0901216011', N'2001216011@example.com', N'123456789011', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216012', 18, N'Trần Thị Lan', N'Nữ', N'2002-01-01', N'NN01', N'0901216012', N'2001216012@example.com', N'123456789012', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216013', 19, N'Lê Văn Minh', N'Nam', N'2002-01-01', N'QTKD01', N'0901216013', N'2001216013@example.com', N'123456789013', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216014', 20, N'Phạm Thị Ngọc', N'Nữ', N'2002-01-01', N'YH01', N'0901216014', N'2001216014@example.com', N'123456789014', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216015', 21, N'Hoàng Văn Phong', N'Nam', N'2002-01-01', N'CNTT01', N'0901216015', N'2001216015@example.com', N'123456789015', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216016', 22, N'Nguyễn Thị Quỳnh', N'Nữ', N'2002-01-01', N'KT01', N'0901216016', N'2001216016@example.com', N'123456789016', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216017', 23, N'Trần Văn Răng', N'Nam', N'2002-01-01', N'NN01', N'0901216017', N'2001216017@example.com', N'123456789017', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216018', 24, N'Lê Thị Sương', N'Nữ', N'2002-01-01', N'QTKD01', N'0901216018', N'2001216018@example.com', N'123456789018', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216019', 25, N'Phạm Văn Tâm', N'Nam', N'2002-01-01', N'YH01', N'0901216019', N'2001216019@example.com', N'123456789019', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216020', 26, N'Hoàng Thị Uyên', N'Nữ', N'2002-01-01', N'CNTT01', N'0901216020', N'2001216020@example.com', N'123456789020', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216021', 27, N'Nguyễn Văn Vương', N'Nam', N'2002-01-01', N'KT01', N'0901216021', N'2001216021@example.com', N'123456789021', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216022', 28, N'Trần Văn Tý', N'Nam', N'2003-05-21', N'CNTT2021A', N'0901216037', N'2001212882@example.com', N'213213112222', NULL, NULL, NULL, NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216023', 29, N'Lê Văn Ý', N'Nam', N'2002-01-01', N'QTKD01', N'0901216023', N'2001216023@example.com', N'123456789023', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216024', 30, N'Phạm Thị Zara', N'Nữ', N'2002-01-01', N'YH01', N'0901216024', N'2001216024@example.com', N'123456789024', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216025', 31, N'Hoàng Văn Bình', N'Nam', N'2002-01-01', N'CNTT01', N'0901216025', N'2001216025@example.com', N'123456789025', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216026', 32, N'Nguyễn Thị Cẩm', N'Nữ', N'2002-01-01', N'KT01', N'0901216026', N'2001216026@example.com', N'123456789026', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216027', 33, N'Trần Văn Duy', N'Nam', N'2002-01-01', N'NN01', N'0901216027', N'2001216027@example.com', N'123456789027', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216028', 34, N'Lê Thị E', N'Nữ', N'2002-01-01', N'QTKD01', N'0901216028', N'2001216028@example.com', N'123456789028', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216029', 35, N'Phạm Văn Phát', N'Nam', N'2002-01-01', N'YH01', N'0901216029', N'2001216029@example.com', N'123456789029', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216030', 36, N'Hoàng Thị Giang', N'Nữ', N'2002-01-01', N'CNTT01', N'0901216030', N'2001216030@example.com', N'123456789030', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216031', 37, N'Nguyễn Văn Hiếu', N'Nam', N'2002-01-01', N'KT01', N'0901216031', N'2001216031@example.com', N'123456789031', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216032', 38, N'Trần Thị Ích', N'Nữ', N'2002-01-01', N'NN01', N'0901216032', N'2001216032@example.com', N'123456789032', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216033', 39, N'Lê Văn Khôi', N'Nam', N'2002-01-01', N'QTKD01', N'0901216033', N'2001216033@example.com', N'123456789033', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216034', 40, N'Phạm Thị Liên', N'Nữ', N'2002-01-01', N'YH01', N'0901216034', N'2001216034@example.com', N'123456789034', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216035', 41, N'Hoàng Văn Mạnh', N'Nam', N'2002-01-01', N'CNTT01', N'0901216035', N'2001216035@example.com', N'123456789035', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216036', 42, N'Nguyễn Thị Nga', N'Nữ', N'2002-01-01', N'KT01', N'0901216036', N'2001216036@example.com', N'123456789036', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216037', 43, N'Trần Văn Oanh', N'Nam', N'2002-01-01', N'NN01', N'0901216037', N'2001216037@example.com', N'123456789037', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216038', 44, N'Lê Thị Phúc', N'Nữ', N'2002-01-01', N'QTKD01', N'0901216038', N'2001216038@example.com', N'123456789038', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216039', 45, N'Phạm Văn Quân', N'Nam', N'2002-01-01', N'YH01', N'0901216039', N'2001216039@example.com', N'123456789039', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216040', 46, N'Hoàng Thị Rạng', N'Nữ', N'2002-01-01', N'CNTT01', N'0901216040', N'2001216040@example.com', N'123456789040', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216041', 47, N'Nguyễn Văn Sáng', N'Nam', N'2002-01-01', N'KT01', N'0901216041', N'2001216041@example.com', N'123456789041', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216042', 48, N'Trần Thị Thảo', N'Nữ', N'2002-01-01', N'NN01', N'0901216042', N'2001216042@example.com', N'123456789042', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216043', 49, N'Lê Văn Út', N'Nam', N'2002-01-01', N'QTKD01', N'0901216043', N'2001216043@example.com', N'123456789043', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216044', 50, N'Phạm Thị Vân', N'Nữ', N'2002-01-01', N'YH01', N'0901216044', N'2001216044@example.com', N'123456789044', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216045', 51, N'Hoàng Văn Xuyên', N'Nam', N'2002-01-01', N'CNTT01', N'0901216045', N'2001216045@example.com', N'123456789045', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216046', 52, N'Nguyễn Thị Yến', N'Nữ', N'2002-01-01', N'KT01', N'0901216046', N'2001216046@example.com', N'123456789046', NULL, NULL, N'Đang học', NULL, N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216047', 53, N'Trần Văn Zăng', N'Nam', N'2002-01-01', N'NN01', N'0901216047', N'2001216047@example.com', N'123456789047', NULL, NULL, N'Đang học', NULL, N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216048', 54, N'Lê Thị Ánh', N'Nữ', N'2002-01-01', N'QTKD01', N'0901216048', N'2001216048@example.com', N'123456789048', NULL, NULL, N'Đang học', NULL, N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216049', 55, N'Phạm Văn Bảo', N'Nam', N'2002-01-01', N'YH01', N'0901216049', N'2001216049@example.com', N'123456789049', NULL, NULL, N'Đang học', NULL, N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216050', 56, N'Hoàng Thị Châu', N'Nữ', N'2002-01-01', N'CNTT01', N'0901216050', N'2001216050@example.com', N'123456789050', NULL, NULL, N'Đang học', NULL, N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216060', 57, N'Bùi Hùng Phương', N'Nam', N'2003-04-24', N'CNTT2021A', N'0389867424', N'buihungphuong0219@gmail.com', N'123343243432', N'0934834238', N'17NHT/TPHCM', N'Đạng Học', N'avatar1.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216121', 58, N'Trần Hữu Tài', N'Nam', N'2003-04-14', N'CNTT2021A', N'0389867424', N'huutai@gmail.com', N'123343243432', N'0934834238', N'17NHT/TPHCM', N'Đạng Học', N'2001216060_1.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216201', 59, N'Nguyễn Thị Mai', N'Nữ', N'2003-05-10', N'CNTT2021B', N'0391234567', N'maingt@example.com', N'123456789012', N'0931234567', N'12Q1/TPHCM', N'Đang Học', N'avatar2.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216202', 60, N'Lê Văn Hùng', N'Nam', N'2002-11-15', N'KT2021A', N'0389876543', N'hunglv@example.com', N'123456789013', N'0932345678', N'15Q2/TPHCM', N'Đang Học', N'avatar3.jpg', N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216203', 61, N'Phạm Thị Lan', N'Nữ', N'2003-03-22', N'NN2021A', N'0378765432', N'lanpt@example.com', N'123456789014', N'0933456789', N'18Q3/TPHCM', N'Đang Học', N'avatar4.jpg', N'NN')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216204', 62, N'Trần Văn Nam', N'Nam', N'2002-07-18', N'QTKD2021A', N'0367654321', N'namtv@example.com', N'123456789015', N'0934567890', N'20Q4/TPHCM', N'Đang Học', N'avatar5.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216205', 63, N'Hoàng Thị Hồng', N'Nữ', N'2003-09-30', N'YH2021A', N'0356543210', N'honght@example.com', N'123456789016', N'0935678901', N'22Q5/TPHCM', N'Đang Học', N'avatar6.jpg', N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216206', 64, N'Vũ Văn Tùng', N'Nam', N'2002-12-05', N'CNSH2021A', N'0345432109', N'tungvv@example.com', N'123456789017', N'0936789012', N'25Q6/TPHCM', N'Đang Học', N'avatar7.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216207', 65, N'Nguyễn Thị Thảo', N'Nữ', N'2003-01-12', N'CNTP2021A', N'0334321098', N'thaont@example.com', N'123456789018', N'0937890123', N'27Q7/TPHCM', N'Đang Học', N'avatar8.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216208', 66, N'Đỗ Văn Quang', N'Nam', N'2002-08-25', N'DT2021A', N'0323210987', N'quangdv@example.com', N'123456789019', N'0938901234', N'30Q8/TPHCM', N'Đang Học', N'avatar9.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216209', 67, N'Bùi Thị Linh', N'Nữ', N'2003-06-14', N'CK2021A', N'0312109876', N'linhbt@example.com', N'123456789020', N'0939012345', N'32Q9/TPHCM', N'Đang Học', N'avatar10.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216210', 68, N'Lê Văn Phúc', N'Nam', N'2002-10-20', N'XD2021A', N'0390987654', N'phuclv@example.com', N'123456789021', N'0930123456', N'35Q10/TPHCM', N'Đang Học', N'avatar11.jpg', N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216211', 69, N'Phạm Thị Hương', N'Nữ', N'2003-02-28', N'MT2021A', N'0388765432', N'huongpt@example.com', N'123456789022', N'0931234568', N'37Q11/TPHCM', N'Đang Học', N'avatar12.jpg', N'YH')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216212', 70, N'Trần Văn Đức', N'Nam', N'2002-04-17', N'TCNH2021A', N'0377654321', N'ductv@example.com', N'123456789023', N'0932345679', N'40Q12/TPHCM', N'Đang Học', N'avatar13.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216213', 71, N'Hoàng Thị Ngọc', N'Nữ', N'2003-07-09', N'MKT2021A', N'0366543210', N'ngocht@example.com', N'123456789024', N'0933456780', N'42Q13/TPHCM', N'Đang Học', N'avatar14.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216214', 72, N'Vũ Văn Anh', N'Nam', N'2002-09-23', N'CNHH2021A', N'0355432109', N'anhvv@example.com', N'123456789025', N'0934567891', N'45Q14/TPHCM', N'Đang Học', N'avatar15.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216215', 73, N'Nguyễn Thị Thu', N'Nữ', N'2003-11-01', N'VT2021A', N'0344321098', N'thunt@example.com', N'123456789026', N'0935678902', N'47Q15/TPHCM', N'Đang Học', N'avatar16.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216216', 74, N'Đỗ Văn Bình', N'Nam', N'2002-05-14', N'KTDT2021A', N'0333210987', N'binhdv@example.com', N'123456789027', N'0936789013', N'50Q16/TPHCM', N'Đang Học', N'avatar17.jpg', N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216217', 75, N'Bùi Thị Yến', N'Nữ', N'2003-08-19', N'KTXD2021A', N'0322109876', N'yenbt@example.com', N'123456789028', N'0937890124', N'52Q17/TPHCM', N'Đang Học', N'avatar18.jpg', N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216218', 76, N'Lê Văn Thái', N'Nam', N'2002-03-27', N'CNM2021A', N'0390987653', N'thailv@example.com', N'123456789029', N'0938901235', N'55Q18/TPHCM', N'Đang Học', N'avatar19.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216219', 77, N'Phạm Thị Duyên', N'Nữ', N'2003-10-11', N'TM2021A', N'0389876542', N'duyenpt@example.com', N'123456789030', N'0939012346', N'57Q19/TPHCM', N'Đang Học', N'avatar20.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216220', 78, N'Trần Văn Khánh', N'Nam', N'2002-06-30', N'LUAT2021A', N'0378765431', N'khanhtv@example.com', N'123456789031', N'0930123457', N'60Q20/TPHCM', N'Đang Học', N'avatar21.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216221', 79, N'Hoàng Thị Ánh', N'Nữ', N'2003-12-08', N'KTQT2021A', N'0367654320', N'anhht@example.com', N'123456789032', N'0931234569', N'62Q21/TPHCM', N'Đang Học', N'avatar22.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216222', 80, N'Vũ Văn Hậu', N'Nam', N'2002-02-15', N'CNNT2021A', N'0356543219', N'hauvv@example.com', N'123456789033', N'0932345670', N'65Q22/TPHCM', N'Đang Học', N'avatar23.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216223', 81, N'Nguyễn Thị Minh', N'Nữ', N'2003-04-29', N'QTDL2021A', N'0345432108', N'minhnt@example.com', N'123456789034', N'0933456781', N'67Q23/TPHCM', N'Đang Học', N'avatar24.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216224', 82, N'Đỗ Văn Tuấn', N'Nam', N'2002-11-03', N'CNVT2021A', N'0334321097', N'tuandv@example.com', N'123456789035', N'0934567892', N'70Q24/TPHCM', N'Đang Học', N'avatar25.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216225', 83, N'Bùi Thị Hoa', N'Nữ', N'2003-01-21', N'TH2021A', N'0323210986', N'hoabt@example.com', N'123456789036', N'0935678903', N'72Q25/TPHCM', N'Đang Học', N'avatar26.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216226', 84, N'Lê Văn Huy', N'Nam', N'2002-08-12', N'KTMT2021A', N'0390987652', N'huylv@example.com', N'123456789037', N'0936789014', N'75Q26/TPHCM', N'Đang Học', N'avatar27.jpg', N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216227', 85, N'Phạm Thị Thủy', N'Nữ', N'2003-09-26', N'TMĐT2021A', N'0389876541', N'thuypt@example.com', N'123456789038', N'0937890125', N'77Q27/TPHCM', N'Đang Học', N'avatar28.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216228', 86, N'Trần Văn Long', N'Nam', N'2002-05-08', N'KTCK2021A', N'0378765430', N'longtv@example.com', N'123456789039', N'0938901236', N'80Q28/TPHCM', N'Đang Học', N'avatar29.jpg', N'KT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216229', 87, N'Hoàng Thị Hạnh', N'Nữ', N'2003-03-16', N'CNĐT2021A', N'0367654329', N'hanhht@example.com', N'123456789040', N'0939012347', N'82Q29/TPHCM', N'Đang Học', N'avatar30.jpg', N'CNTT')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216230', 88, N'Vũ Văn Sơn', N'Nam', N'2002-10-27', N'QTTM2021A', N'0356543218', N'sonvv@example.com', N'123456789041', N'0930123458', N'85Q30/TPHCM', N'Đang Học', N'avatar31.jpg', N'QTKD')
INSERT [dbo].[SinhVien] ([MaSV], [MaNguoiDung], [HoTen], [GioiTinh], [NgaySinh], [Lop], [SDT], [Email], [SoCanCuoc], [SDTGiaDinh], [SoHoKhau], [TrangThai], [AnhDaiDien], [MaKhoa]) VALUES (N'2001216414', 89, N'Đào Quí Mùi', N'Nam', N'2003-06-15', N'12DHTH13', N'0356543218', N'muidao156@example.com', N'123426789041', N'0930123458', N'85Q30/TPHCM', N'Đang Học', N'muidao156.jpg', N'CNTT')
GO
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T1        ', N'Tầng 1')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T2        ', N'Tầng 2')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T3        ', N'Tầng 3')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T4        ', N'Tầng 4')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T5        ', N'Tầng 5')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T6        ', N'Tầng 6')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T7        ', N'Tầng 7')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T8        ', N'Tầng 8')
INSERT [dbo].[Tang] ([MaTang], [TenTang]) VALUES (N'T9        ', N'Tầng 9')
GO
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB001', N'Quạt trần', N'Quạt trần 3 cánh, công suất 50W', 50, N'Hoạt động')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB002', N'Đèn huỳnh quang', N'Đèn ống 1.2m, 36W', 100, N'Hoạt động')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB003', N'Bàn học', N'Bàn gỗ 1.2m x 0.6m', 60, N'Hoạt động')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB004', N'Ghế tựa', N'Ghế nhựa có tựa lưng', 120, N'Hoạt động')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB005', N'Tủ quần áo', N'Tủ sắt 2 cánh, 1.8m x 1m', 40, N'Hoạt động')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB006', N'Ổ cắm điện', N'Ổ cắm 4 lỗ, 220V', 80, N'Hoạt động')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB007', N'Quạt treo tường', N'Quạt treo tường 40cm, 45W', 30, N'Hỏng')
INSERT [dbo].[TrangThietBi] ([MaThietBi], [TenThietBi], [MoTa], [SoLuong], [TrangThai]) VALUES (N'TB008', N'Giường tầng', N'Giường sắt 2 tầng, 2m x 0.8m', 200, N'Hoạt động')
GO
SET IDENTITY_INSERT [dbo].[ViPham] ON 

INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (1, 2, CAST(N'2025-05-28' AS Date), N'ádasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (2, 3, CAST(N'2025-05-28' AS Date), N'Vào lúc 12h tối', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (3, 4, CAST(N'2025-05-28' AS Date), N'ádasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (4, 4, CAST(N'2025-05-28' AS Date), N'ádasdas', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (5, 2, CAST(N'2025-05-30' AS Date), N'ádasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (6, 2, CAST(N'2025-05-31' AS Date), N'ádasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (7, 3, CAST(N'2025-06-02' AS Date), N'sdasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (8, 4, CAST(N'2025-06-02' AS Date), N'sdsad', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (9, 2, CAST(N'2025-06-02' AS Date), N'sadas', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (10, 1, CAST(N'2025-06-02' AS Date), N'áds', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (11, 5, CAST(N'2025-06-02' AS Date), N'ádasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (12, 2, CAST(N'2025-06-02' AS Date), N'sadasdsa', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (13, 4, CAST(N'2025-06-02' AS Date), N'sadas', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (14, 4, CAST(N'2025-06-02' AS Date), N'sdasd', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (15, 3, CAST(N'2025-06-02' AS Date), N'adss', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (16, 4, CAST(N'2025-06-02' AS Date), N'quá ồn', NULL)
INSERT [dbo].[ViPham] ([MaViPham], [MaNoiQuy], [NgayViPham], [MoTa], [FileBienBan]) VALUES (17, 5, CAST(N'2025-06-02' AS Date), N'Cùng với 2 người lạ vào trường', NULL)
SET IDENTITY_INSERT [dbo].[ViPham] OFF
GO
SET IDENTITY_INSERT [dbo].[YeuCauSuaChua] ON 

INSERT [dbo].[YeuCauSuaChua] ([MaYCSC], [MaSV], [MaPhong], [MoTa], [NgayGui], [TrangThai], [MaNV]) VALUES (1, N'2001216060', N'KTX-01-01', N'Hiện tại cần xử lý và thực hiện', CAST(N'2025-05-21' AS Date), N'Đang Xử Lý', N'NV001')
SET IDENTITY_INSERT [dbo].[YeuCauSuaChua] OFF
GO
SET ANSI_PADDING ON
GO
SET IDENTITY_INSERT [dbo].[ChiTietPhong] ON 

INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (1, N'KTX-01-01', N'TB001', N'KTX-01-01-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (2, N'KTX-01-01', N'TB002', N'KTX-01-01-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (3, N'KTX-01-01', N'TB002', N'KTX-01-01-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (4, N'KTX-01-01', N'TB003', N'KTX-01-01-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (5, N'KTX-01-01', N'TB003', N'KTX-01-01-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (6, N'KTX-01-01', N'TB004', N'KTX-01-01-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (7, N'KTX-01-01', N'TB004', N'KTX-01-01-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (8, N'KTX-01-01', N'TB004', N'KTX-01-01-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (9, N'KTX-01-01', N'TB004', N'KTX-01-01-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (10, N'KTX-01-01', N'TB005', N'KTX-01-01-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (11, N'KTX-01-01', N'TB006', N'KTX-01-01-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (12, N'KTX-01-01', N'TB008', N'KTX-01-01-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (13, N'KTX-01-01', N'TB008', N'KTX-01-01-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (14, N'KTX-01-01', N'TB008', N'KTX-01-01-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (15, N'KTX-01-01', N'TB008', N'KTX-01-01-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (16, N'KTX-01-01', N'TB008', N'KTX-01-01-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (17, N'KTX-01-01', N'TB008', N'KTX-01-01-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (18, N'KTX-01-01', N'TB008', N'KTX-01-01-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (19, N'KTX-01-01', N'TB008', N'KTX-01-01-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (20, N'KTX-01-01', N'TB008', N'KTX-01-01-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (21, N'KTX-01-01', N'TB008', N'KTX-01-01-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (22, N'KTX-01-02', N'TB001', N'KTX-01-02-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (23, N'KTX-01-02', N'TB002', N'KTX-01-02-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (24, N'KTX-01-02', N'TB002', N'KTX-01-02-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (25, N'KTX-01-02', N'TB003', N'KTX-01-02-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (26, N'KTX-01-02', N'TB003', N'KTX-01-02-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (27, N'KTX-01-02', N'TB004', N'KTX-01-02-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (28, N'KTX-01-02', N'TB004', N'KTX-01-02-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (29, N'KTX-01-02', N'TB004', N'KTX-01-02-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (30, N'KTX-01-02', N'TB004', N'KTX-01-02-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (31, N'KTX-01-02', N'TB005', N'KTX-01-02-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (32, N'KTX-01-02', N'TB006', N'KTX-01-02-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (33, N'KTX-01-02', N'TB008', N'KTX-01-02-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (34, N'KTX-01-02', N'TB008', N'KTX-01-02-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (35, N'KTX-01-02', N'TB008', N'KTX-01-02-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (36, N'KTX-01-02', N'TB008', N'KTX-01-02-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (37, N'KTX-01-02', N'TB008', N'KTX-01-02-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (38, N'KTX-01-02', N'TB008', N'KTX-01-02-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (39, N'KTX-01-02', N'TB008', N'KTX-01-02-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (40, N'KTX-01-02', N'TB008', N'KTX-01-02-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (41, N'KTX-01-02', N'TB008', N'KTX-01-02-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (42, N'KTX-01-02', N'TB008', N'KTX-01-02-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (43, N'KTX-01-03', N'TB001', N'KTX-01-03-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (44, N'KTX-01-03', N'TB002', N'KTX-01-03-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (45, N'KTX-01-03', N'TB002', N'KTX-01-03-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (46, N'KTX-01-03', N'TB003', N'KTX-01-03-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (47, N'KTX-01-03', N'TB003', N'KTX-01-03-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (48, N'KTX-01-03', N'TB004', N'KTX-01-03-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (49, N'KTX-01-03', N'TB004', N'KTX-01-03-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (50, N'KTX-01-03', N'TB004', N'KTX-01-03-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (51, N'KTX-01-03', N'TB004', N'KTX-01-03-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (52, N'KTX-01-03', N'TB005', N'KTX-01-03-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (53, N'KTX-01-03', N'TB006', N'KTX-01-03-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (54, N'KTX-01-03', N'TB008', N'KTX-01-03-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (55, N'KTX-01-03', N'TB008', N'KTX-01-03-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (56, N'KTX-01-03', N'TB008', N'KTX-01-03-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (57, N'KTX-01-03', N'TB008', N'KTX-01-03-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (58, N'KTX-01-03', N'TB008', N'KTX-01-03-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (59, N'KTX-01-03', N'TB008', N'KTX-01-03-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (60, N'KTX-01-03', N'TB008', N'KTX-01-03-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (61, N'KTX-01-03', N'TB008', N'KTX-01-03-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (62, N'KTX-01-03', N'TB008', N'KTX-01-03-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (63, N'KTX-01-03', N'TB008', N'KTX-01-03-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (64, N'KTX-01-04', N'TB001', N'KTX-01-04-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (65, N'KTX-01-04', N'TB002', N'KTX-01-04-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (66, N'KTX-01-04', N'TB002', N'KTX-01-04-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (67, N'KTX-01-04', N'TB003', N'KTX-01-04-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (68, N'KTX-01-04', N'TB003', N'KTX-01-04-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (69, N'KTX-01-04', N'TB004', N'KTX-01-04-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (70, N'KTX-01-04', N'TB004', N'KTX-01-04-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (71, N'KTX-01-04', N'TB004', N'KTX-01-04-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (72, N'KTX-01-04', N'TB004', N'KTX-01-04-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (73, N'KTX-01-04', N'TB005', N'KTX-01-04-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (74, N'KTX-01-04', N'TB006', N'KTX-01-04-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (75, N'KTX-01-04', N'TB008', N'KTX-01-04-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (76, N'KTX-01-04', N'TB008', N'KTX-01-04-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (77, N'KTX-01-04', N'TB008', N'KTX-01-04-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (78, N'KTX-01-04', N'TB008', N'KTX-01-04-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (79, N'KTX-01-04', N'TB008', N'KTX-01-04-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (80, N'KTX-01-04', N'TB008', N'KTX-01-04-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (81, N'KTX-01-04', N'TB008', N'KTX-01-04-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (82, N'KTX-01-04', N'TB008', N'KTX-01-04-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (83, N'KTX-01-04', N'TB008', N'KTX-01-04-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (84, N'KTX-01-04', N'TB008', N'KTX-01-04-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (85, N'KTX-01-05', N'TB001', N'KTX-01-05-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (86, N'KTX-01-05', N'TB002', N'KTX-01-05-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (87, N'KTX-01-05', N'TB002', N'KTX-01-05-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (88, N'KTX-01-05', N'TB003', N'KTX-01-05-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (89, N'KTX-01-05', N'TB003', N'KTX-01-05-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (90, N'KTX-01-05', N'TB004', N'KTX-01-05-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (91, N'KTX-01-05', N'TB004', N'KTX-01-05-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (92, N'KTX-01-05', N'TB004', N'KTX-01-05-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (93, N'KTX-01-05', N'TB004', N'KTX-01-05-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (94, N'KTX-01-05', N'TB005', N'KTX-01-05-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (95, N'KTX-01-05', N'TB006', N'KTX-01-05-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (96, N'KTX-01-05', N'TB008', N'KTX-01-05-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (97, N'KTX-01-05', N'TB008', N'KTX-01-05-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (98, N'KTX-01-05', N'TB008', N'KTX-01-05-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (99, N'KTX-01-05', N'TB008', N'KTX-01-05-04')
GO
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (100, N'KTX-01-05', N'TB008', N'KTX-01-05-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (101, N'KTX-01-05', N'TB008', N'KTX-01-05-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (102, N'KTX-01-05', N'TB008', N'KTX-01-05-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (103, N'KTX-01-05', N'TB008', N'KTX-01-05-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (104, N'KTX-01-05', N'TB008', N'KTX-01-05-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (105, N'KTX-01-05', N'TB008', N'KTX-01-05-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (106, N'KTX-01-06', N'TB001', N'KTX-01-06-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (107, N'KTX-01-06', N'TB002', N'KTX-01-06-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (108, N'KTX-01-06', N'TB002', N'KTX-01-06-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (109, N'KTX-01-06', N'TB003', N'KTX-01-06-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (110, N'KTX-01-06', N'TB003', N'KTX-01-06-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (111, N'KTX-01-06', N'TB004', N'KTX-01-06-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (112, N'KTX-01-06', N'TB004', N'KTX-01-06-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (113, N'KTX-01-06', N'TB004', N'KTX-01-06-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (114, N'KTX-01-06', N'TB004', N'KTX-01-06-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (115, N'KTX-01-06', N'TB005', N'KTX-01-06-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (116, N'KTX-01-06', N'TB006', N'KTX-01-06-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (117, N'KTX-01-06', N'TB008', N'KTX-01-06-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (118, N'KTX-01-06', N'TB008', N'KTX-01-06-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (119, N'KTX-01-06', N'TB008', N'KTX-01-06-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (120, N'KTX-01-06', N'TB008', N'KTX-01-06-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (121, N'KTX-01-06', N'TB008', N'KTX-01-06-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (122, N'KTX-01-06', N'TB008', N'KTX-01-06-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (123, N'KTX-01-06', N'TB008', N'KTX-01-06-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (124, N'KTX-01-06', N'TB008', N'KTX-01-06-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (125, N'KTX-01-06', N'TB008', N'KTX-01-06-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (126, N'KTX-01-06', N'TB008', N'KTX-01-06-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (127, N'KTX-01-07', N'TB001', N'KTX-01-07-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (128, N'KTX-01-07', N'TB002', N'KTX-01-07-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (129, N'KTX-01-07', N'TB002', N'KTX-01-07-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (130, N'KTX-01-07', N'TB003', N'KTX-01-07-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (131, N'KTX-01-07', N'TB003', N'KTX-01-07-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (132, N'KTX-01-07', N'TB004', N'KTX-01-07-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (133, N'KTX-01-07', N'TB004', N'KTX-01-07-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (134, N'KTX-01-07', N'TB004', N'KTX-01-07-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (135, N'KTX-01-07', N'TB004', N'KTX-01-07-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (136, N'KTX-01-07', N'TB005', N'KTX-01-07-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (137, N'KTX-01-07', N'TB006', N'KTX-01-07-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (138, N'KTX-01-07', N'TB008', N'KTX-01-07-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (139, N'KTX-01-07', N'TB008', N'KTX-01-07-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (140, N'KTX-01-07', N'TB008', N'KTX-01-07-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (141, N'KTX-01-07', N'TB008', N'KTX-01-07-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (142, N'KTX-01-07', N'TB008', N'KTX-01-07-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (143, N'KTX-01-07', N'TB008', N'KTX-01-07-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (144, N'KTX-01-07', N'TB008', N'KTX-01-07-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (145, N'KTX-01-07', N'TB008', N'KTX-01-07-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (146, N'KTX-01-07', N'TB008', N'KTX-01-07-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (147, N'KTX-01-07', N'TB008', N'KTX-01-07-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (148, N'KTX-01-08', N'TB001', N'KTX-01-08-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (149, N'KTX-01-08', N'TB002', N'KTX-01-08-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (150, N'KTX-01-08', N'TB002', N'KTX-01-08-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (151, N'KTX-01-08', N'TB003', N'KTX-01-08-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (152, N'KTX-01-08', N'TB003', N'KTX-01-08-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (153, N'KTX-01-08', N'TB004', N'KTX-01-08-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (154, N'KTX-01-08', N'TB004', N'KTX-01-08-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (155, N'KTX-01-08', N'TB004', N'KTX-01-08-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (156, N'KTX-01-08', N'TB004', N'KTX-01-08-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (157, N'KTX-01-08', N'TB005', N'KTX-01-08-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (158, N'KTX-01-08', N'TB006', N'KTX-01-08-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (159, N'KTX-01-08', N'TB008', N'KTX-01-08-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (160, N'KTX-01-08', N'TB008', N'KTX-01-08-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (161, N'KTX-01-08', N'TB008', N'KTX-01-08-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (162, N'KTX-01-08', N'TB008', N'KTX-01-08-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (163, N'KTX-01-08', N'TB008', N'KTX-01-08-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (164, N'KTX-01-08', N'TB008', N'KTX-01-08-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (165, N'KTX-01-08', N'TB008', N'KTX-01-08-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (166, N'KTX-01-08', N'TB008', N'KTX-01-08-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (167, N'KTX-01-08', N'TB008', N'KTX-01-08-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (168, N'KTX-01-08', N'TB008', N'KTX-01-08-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (169, N'KTX-01-09', N'TB001', N'KTX-01-09-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (170, N'KTX-01-09', N'TB002', N'KTX-01-09-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (171, N'KTX-01-09', N'TB002', N'KTX-01-09-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (172, N'KTX-01-09', N'TB003', N'KTX-01-09-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (173, N'KTX-01-09', N'TB003', N'KTX-01-09-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (174, N'KTX-01-09', N'TB004', N'KTX-01-09-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (175, N'KTX-01-09', N'TB004', N'KTX-01-09-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (176, N'KTX-01-09', N'TB004', N'KTX-01-09-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (177, N'KTX-01-09', N'TB004', N'KTX-01-09-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (178, N'KTX-01-09', N'TB005', N'KTX-01-09-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (179, N'KTX-01-09', N'TB006', N'KTX-01-09-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (180, N'KTX-01-09', N'TB008', N'KTX-01-09-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (181, N'KTX-01-09', N'TB008', N'KTX-01-09-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (182, N'KTX-01-09', N'TB008', N'KTX-01-09-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (183, N'KTX-01-09', N'TB008', N'KTX-01-09-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (184, N'KTX-01-09', N'TB008', N'KTX-01-09-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (185, N'KTX-01-09', N'TB008', N'KTX-01-09-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (186, N'KTX-01-09', N'TB008', N'KTX-01-09-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (187, N'KTX-01-09', N'TB008', N'KTX-01-09-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (188, N'KTX-01-09', N'TB008', N'KTX-01-09-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (189, N'KTX-01-09', N'TB008', N'KTX-01-09-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (190, N'KTX-01-10', N'TB001', N'KTX-01-10-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (191, N'KTX-01-10', N'TB002', N'KTX-01-10-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (192, N'KTX-01-10', N'TB002', N'KTX-01-10-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (193, N'KTX-01-10', N'TB003', N'KTX-01-10-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (194, N'KTX-01-10', N'TB003', N'KTX-01-10-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (195, N'KTX-01-10', N'TB004', N'KTX-01-10-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (196, N'KTX-01-10', N'TB004', N'KTX-01-10-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (197, N'KTX-01-10', N'TB004', N'KTX-01-10-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (198, N'KTX-01-10', N'TB004', N'KTX-01-10-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (199, N'KTX-01-10', N'TB005', N'KTX-01-10-10')
GO
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (200, N'KTX-01-10', N'TB006', N'KTX-01-10-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (201, N'KTX-01-10', N'TB008', N'KTX-01-10-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (202, N'KTX-01-10', N'TB008', N'KTX-01-10-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (203, N'KTX-01-10', N'TB008', N'KTX-01-10-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (204, N'KTX-01-10', N'TB008', N'KTX-01-10-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (205, N'KTX-01-10', N'TB008', N'KTX-01-10-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (206, N'KTX-01-10', N'TB008', N'KTX-01-10-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (207, N'KTX-01-10', N'TB008', N'KTX-01-10-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (208, N'KTX-01-10', N'TB008', N'KTX-01-10-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (209, N'KTX-01-10', N'TB008', N'KTX-01-10-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (210, N'KTX-01-10', N'TB008', N'KTX-01-10-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (211, N'KTX-02-01', N'TB001', N'KTX-02-01-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (212, N'KTX-02-01', N'TB002', N'KTX-02-01-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (213, N'KTX-02-01', N'TB002', N'KTX-02-01-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (214, N'KTX-02-01', N'TB003', N'KTX-02-01-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (215, N'KTX-02-01', N'TB003', N'KTX-02-01-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (216, N'KTX-02-01', N'TB004', N'KTX-02-01-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (217, N'KTX-02-01', N'TB004', N'KTX-02-01-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (218, N'KTX-02-01', N'TB004', N'KTX-02-01-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (219, N'KTX-02-01', N'TB004', N'KTX-02-01-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (220, N'KTX-02-01', N'TB005', N'KTX-02-01-10')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (221, N'KTX-02-01', N'TB006', N'KTX-02-01-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (222, N'KTX-02-01', N'TB008', N'KTX-02-01-01')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (223, N'KTX-02-01', N'TB008', N'KTX-02-01-02')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (224, N'KTX-02-01', N'TB008', N'KTX-02-01-03')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (225, N'KTX-02-01', N'TB008', N'KTX-02-01-04')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (226, N'KTX-02-01', N'TB008', N'KTX-02-01-05')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (227, N'KTX-02-01', N'TB008', N'KTX-02-01-06')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (228, N'KTX-02-01', N'TB008', N'KTX-02-01-07')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (229, N'KTX-02-01', N'TB008', N'KTX-02-01-08')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (230, N'KTX-02-01', N'TB008', N'KTX-02-01-09')
INSERT [dbo].[ChiTietPhong] ([MaChiTietPhong], [MaPhong], [MaThietBi], [Giuong]) VALUES (231, N'KTX-02-01', N'TB008', N'KTX-02-01-10')
SET IDENTITY_INSERT [dbo].[ChiTietPhong] OFF
/****** Object:  Index [UQ__NguoiDun__55F68FC09F9CAE7D]    Script Date: 6/6/2025 9:08:37 PM ******/
ALTER TABLE [dbo].[NguoiDung] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__NhanVien__C539D763BD4F179D]    Script Date: 6/6/2025 9:08:37 PM ******/
ALTER TABLE [dbo].[NhanVien] ADD  CONSTRAINT [UQ__NhanVien__C539D763BD4F179D] UNIQUE NONCLUSTERED 
(
	[MaNguoiDung] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ__SinhVien__C539D7631733605D]    Script Date: 6/6/2025 9:08:37 PM ******/
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
ALTER TABLE [dbo].[CT_ViPham]  WITH CHECK ADD FOREIGN KEY([MaNV])
REFERENCES [dbo].[NhanVien] ([MaNV])
GO
ALTER TABLE [dbo].[CT_ViPham]  WITH CHECK ADD FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[CT_ViPham]  WITH CHECK ADD FOREIGN KEY([MaViPham])
REFERENCES [dbo].[ViPham] ([MaViPham])
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
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT [FK_HopDongNoiTru_Giuong] FOREIGN KEY([MaGiuong])
REFERENCES [dbo].[Giuong] ([MaGiuong])
GO
ALTER TABLE [dbo].[HopDongNoiTru] CHECK CONSTRAINT [FK_HopDongNoiTru_Giuong]
GO
ALTER TABLE [dbo].[HopDongNoiTru]  WITH CHECK ADD  CONSTRAINT [FK_HopDongNoiTru_NamHoc] FOREIGN KEY([MaNamHoc])
REFERENCES [dbo].[NamHoc] ([MaNamHoc])
GO
ALTER TABLE [dbo].[HopDongNoiTru] CHECK CONSTRAINT [FK_HopDongNoiTru_NamHoc]
GO
ALTER TABLE [dbo].[LichSuRaVao]  WITH CHECK ADD  CONSTRAINT [FK_LichSuRaVao_SinhVien] FOREIGN KEY([MaSV])
REFERENCES [dbo].[SinhVien] ([MaSV])
GO
ALTER TABLE [dbo].[LichSuRaVao] CHECK CONSTRAINT [FK_LichSuRaVao_SinhVien]
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
-- Chèn dữ liệu vào bảng PhieuThu
INSERT [dbo].[PhieuThu] ([MaHopDong], [NgayLap], [TongTien], [TrangThai], [MaNV], [MaPhong]) VALUES 
(1, CAST(N'2024-09-01' AS Date), 1200000, N'Chưa thanh toán', N'NV001', N'KTX-01-01'),
(1, CAST(N'2024-10-01' AS Date), 1200000, N'Chưa thanh toán', N'NV001', N'KTX-01-01'),
(1, CAST(N'2024-11-01' AS Date), 1200000, N'Chưa thanh toán', N'NV001', N'KTX-01-01'),
(6, CAST(N'2024-09-01' AS Date), 1200000, N'Đã thanh toán', N'NV001', N'KTX-02-01'),
(6, CAST(N'2024-10-01' AS Date), 1200000, N'Đã thanh toán', N'NV001', N'KTX-02-01'),
(9, CAST(N'2024-09-01' AS Date), 1200000, N'Đã thanh toán', N'NV001', N'KTX-01-02'),
(9, CAST(N'2024-10-01' AS Date), 1200000, N'Đã thanh toán', N'NV001', N'KTX-01-02'),
(31, CAST(N'2024-09-01' AS Date), 1200000, N'Đã thanh toán', N'NV003', N'KTX-01-03'),
(31, CAST(N'2024-10-01' AS Date), 1200000, N'Đã thanh toán', N'NV003', N'KTX-01-03'),
(41, CAST(N'2024-09-01' AS Date), 1200000, N'Đã thanh toán', N'NV001', N'KTX-01-04'),
(41, CAST(N'2024-10-01' AS Date), 1200000, N'Đã thanh toán', N'NV001', N'KTX-01-04'),
(52, CAST(N'2025-09-01' AS Date), 1200000, N'Đã thanh toán', N'NV003', N'KTX-01-05'),
(52, CAST(N'2025-10-01' AS Date), 1200000, N'Đã thanh toán', N'NV003', N'KTX-01-05'),
(61, CAST(N'2025-09-01' AS Date), 1200000, N'Đã thanh toán', N'NV003', N'KTX-01-06'),
(61, CAST(N'2025-10-01' AS Date), 1200000, N'Đã thanh toán', N'NV003', N'KTX-01-06');

-- Chèn dữ liệu vào bảng ChiTietPhieuThu
INSERT [dbo].[ChiTietPhieuThu] ([MaPhieuThu], [LoaiKhoanThu], [SoTien]) VALUES 
(1, N'Hợp Đồng Nội Trú', 1000000),
(1, N'Tiền điện nước', 200000),
(2, N'Hợp Đồng Nội Trú', 1000000),
(2, N'Tiền điện nước', 200000),
(3, N'Hợp Đồng Nội Trú', 1000000),
(3, N'Tiền điện nước', 200000),
(4, N'Hợp Đồng Nội Trú', 1000000),
(4, N'Tiền điện nước', 200000),
(5, N'Hợp Đồng Nội Trú', 1000000),
(5, N'Tiền điện nước', 200000),
(6, N'Hợp Đồng Nội Trú', 1000000),
(6, N'Tiền điện nước', 200000),
(7, N'Hợp Đồng Nội Trú', 1000000),
(7, N'Tiền điện nước', 200000),
(8, N'Hợp Đồng Nội Trú', 1000000),
(8, N'Tiền điện nước', 200000),
(9, N'Hợp Đồng Nội Trú', 1000000),
(9, N'Tiền điện nước', 200000),
(10, N'Hợp Đồng Nội Trú', 1000000),
(10, N'Tiền điện nước', 200000),
(11, N'Hợp Đồng Nội Trú', 1000000),
(11, N'Tiền điện nước', 200000),
(12, N'Hợp Đồng Nội Trú', 1000000),
(12, N'Tiền điện nước', 200000),
(13, N'Hợp Đồng Nội Trú', 1000000),
(13, N'Tiền điện nước', 200000),
(14, N'Hợp Đồng Nội Trú', 1000000),
(14, N'Tiền điện nước', 200000);