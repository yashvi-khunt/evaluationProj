USE [master]
GO
/****** Object:  Database [Evaluation]    Script Date: 01-01-2024 13:21:38 ******/
CREATE DATABASE [Evaluation]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Evaluation', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Evaluation.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Evaluation_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Evaluation_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Evaluation] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Evaluation].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Evaluation] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Evaluation] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Evaluation] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Evaluation] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Evaluation] SET ARITHABORT OFF 
GO
ALTER DATABASE [Evaluation] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Evaluation] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Evaluation] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Evaluation] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Evaluation] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Evaluation] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Evaluation] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Evaluation] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Evaluation] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Evaluation] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Evaluation] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Evaluation] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Evaluation] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Evaluation] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Evaluation] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Evaluation] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Evaluation] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Evaluation] SET RECOVERY FULL 
GO
ALTER DATABASE [Evaluation] SET  MULTI_USER 
GO
ALTER DATABASE [Evaluation] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Evaluation] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Evaluation] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Evaluation] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Evaluation] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Evaluation] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Evaluation', N'ON'
GO
ALTER DATABASE [Evaluation] SET QUERY_STORE = ON
GO
ALTER DATABASE [Evaluation] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Evaluation]
GO
/****** Object:  Table [dbo].[ManufacturerProductMappings]    Script Date: 01-01-2024 13:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturerProductMappings](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.ManufacturerProductMappings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 01-01-2024 13:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Manufacturers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 01-01-2024 13:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseHistories]    Script Date: 01-01-2024 13:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseHistories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceId] [int] NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[RateId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Date] [datetime] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.PurchaseHistories] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rates]    Script Date: 01-01-2024 13:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [real] NOT NULL,
	[Date] [datetime] NOT NULL,
	[ProductId] [int] NOT NULL,
	[isDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.Rates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01-01-2024 13:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[UserName] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ManufacturerProductMappings] ON 

INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (1, 1, 1, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (2, 2, 6, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (3, 1, 3, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (4, 2, 7, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (5, 3, 4, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (6, 3, 2, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (7, 13, 2, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (8, 1, 10, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (9, 1, 6, 1)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (10, 13, 6, 1)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (11, 1, 9, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (12, 13, 5, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (13, 13, 9, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (14, 2, 10, 1)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (15, 3, 3, 0)
INSERT [dbo].[ManufacturerProductMappings] ([Id], [ManufacturerID], [ProductID], [isDeleted]) VALUES (16, 5, 3, 1)
SET IDENTITY_INSERT [dbo].[ManufacturerProductMappings] OFF
GO
SET IDENTITY_INSERT [dbo].[Manufacturers] ON 

INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (1, N'Apple', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (2, N'Samsung', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (3, N'Sony', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (5, N'Dell', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (13, N'Party 21', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (14, N'Party 22', 1)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (15, N'hfdu', 1)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (16, N'@', 1)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (17, N'Apple123', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (18, N'Party33', 0)
INSERT [dbo].[Manufacturers] ([Id], [Name], [isDeleted]) VALUES (19, N'Party 12', 1)
SET IDENTITY_INSERT [dbo].[Manufacturers] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (1, N'iPhone14 Plus1', 1)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (2, N'iPad Air', 0)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (3, N'MacBook Air', 0)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (4, N'AirPods Pro', 0)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (5, N'iWatch SE', 0)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (6, N'Galaxy Tab S9 FE', 0)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (7, N'Galaxy S22', 1)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (8, N'Galaxy Book Pro', 1)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (9, N'Galaxy Watch2', 1)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (10, N'iMac', 0)
INSERT [dbo].[Products] ([Id], [Name], [isDeleted]) VALUES (11, N'Product 12', 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseHistories] ON 

INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (2, 101, 1, 1, 1, 2, CAST(N'2023-12-25T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (3, 101, 1, 2, 3, 1, CAST(N'2023-12-25T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (4, 102, 1, 1, 1, 3, CAST(N'2023-12-09T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (5, 102, 1, 3, 4, 1, CAST(N'2023-12-09T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (6, 103, 1, 3, 4, 1, CAST(N'2023-12-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (7, 103, 1, 1, 1, 2, CAST(N'2023-12-03T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (8, 104, 2, 6, 8, 2, CAST(N'2023-12-01T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (9, 105, 3, 2, 3, 1, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (10, 106, 3, 4, 9, 1, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (11, 107, 13, 9, 10, 10, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (12, 107, 13, 9, 3, 5, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (13, 107, 13, 5, 10, 20, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[PurchaseHistories] ([Id], [InvoiceId], [ManufacturerId], [ProductId], [RateId], [Quantity], [Date], [isDeleted]) VALUES (14, 108, 3, 2, 3, 1, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[PurchaseHistories] OFF
GO
SET IDENTITY_INSERT [dbo].[Rates] ON 

INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (1, 85000, CAST(N'2023-12-25T18:36:30.567' AS DateTime), 1, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (2, 63999, CAST(N'2023-11-23T18:11:12.330' AS DateTime), 1, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (3, 42500, CAST(N'2023-11-23T00:00:00.000' AS DateTime), 2, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (4, 105000, CAST(N'2023-11-23T21:25:41.630' AS DateTime), 3, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (5, 159999, CAST(N'2023-11-23T22:47:21.407' AS DateTime), 1, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (6, 45656, CAST(N'2023-12-01T00:00:00.000' AS DateTime), 1, 1)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (7, 45656, CAST(N'2023-12-30T00:00:00.000' AS DateTime), 7, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (8, 50000, CAST(N'2023-12-26T00:00:00.000' AS DateTime), 6, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (9, 35000, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 4, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (10, 2000, CAST(N'2023-12-28T00:00:00.000' AS DateTime), 9, 0)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (11, 15999, CAST(N'2023-12-31T00:00:00.000' AS DateTime), 5, 1)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (12, 15999, CAST(N'2023-12-31T00:00:00.000' AS DateTime), 2, 1)
INSERT [dbo].[Rates] ([Id], [Amount], [Date], [ProductId], [isDeleted]) VALUES (13, 4599, CAST(N'2024-01-01T00:00:00.000' AS DateTime), 5, 0)
SET IDENTITY_INSERT [dbo].[Rates] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [PasswordHash], [UserName]) VALUES (1, N'Admin@123', N'admin')
INSERT [dbo].[Users] ([Id], [PasswordHash], [UserName]) VALUES (2, N'yashci', N'yashvi')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Manufacturers]    Script Date: 01-01-2024 13:21:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Manufacturers] ON [dbo].[Manufacturers]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Products]    Script Date: 01-01-2024 13:21:39 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Products] ON [dbo].[Products]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_ProductId]    Script Date: 01-01-2024 13:21:39 ******/
CREATE NONCLUSTERED INDEX [IX_ProductId] ON [dbo].[Rates]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ManufacturerProductMappings] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Manufacturers] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[PurchaseHistories] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[Rates] ADD  DEFAULT ((0)) FOR [isDeleted]
GO
ALTER TABLE [dbo].[ManufacturerProductMappings]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ManufacturerProductMappings_dbo.Manufacturers_ManufacturerId] FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturers] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ManufacturerProductMappings] CHECK CONSTRAINT [FK_dbo.ManufacturerProductMappings_dbo.Manufacturers_ManufacturerId]
GO
ALTER TABLE [dbo].[ManufacturerProductMappings]  WITH CHECK ADD  CONSTRAINT [FK_dbo.ManufacturerProductMappings_dbo.Products_ProductId] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ManufacturerProductMappings] CHECK CONSTRAINT [FK_dbo.ManufacturerProductMappings_dbo.Products_ProductId]
GO
ALTER TABLE [dbo].[PurchaseHistories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Manufacturers_ManufacturerId] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturers] ([Id])
GO
ALTER TABLE [dbo].[PurchaseHistories] CHECK CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Manufacturers_ManufacturerId]
GO
ALTER TABLE [dbo].[PurchaseHistories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
GO
ALTER TABLE [dbo].[PurchaseHistories] CHECK CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Products_ProductId]
GO
ALTER TABLE [dbo].[PurchaseHistories]  WITH CHECK ADD  CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Rates_RateId] FOREIGN KEY([RateId])
REFERENCES [dbo].[Rates] ([Id])
GO
ALTER TABLE [dbo].[PurchaseHistories] CHECK CONSTRAINT [FK_dbo.PurchaseHistories_dbo.Rates_RateId]
GO
ALTER TABLE [dbo].[Rates]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Rates_dbo.Products_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Rates] CHECK CONSTRAINT [FK_dbo.Rates_dbo.Products_ProductId]
GO
USE [master]
GO
ALTER DATABASE [Evaluation] SET  READ_WRITE 
GO
