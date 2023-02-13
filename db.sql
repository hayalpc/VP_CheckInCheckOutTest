USE [master]
GO
/****** Object:  Database [VP_Book]    Script Date: 25.10.2021 21:37:08 ******/
CREATE DATABASE [VP_Book]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'VP_Book', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\VP_Book.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'VP_Book_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\VP_Book_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [VP_Book] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [VP_Book].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [VP_Book] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [VP_Book] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [VP_Book] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [VP_Book] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [VP_Book] SET ARITHABORT OFF 
GO
ALTER DATABASE [VP_Book] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [VP_Book] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [VP_Book] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [VP_Book] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [VP_Book] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [VP_Book] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [VP_Book] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [VP_Book] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [VP_Book] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [VP_Book] SET  ENABLE_BROKER 
GO
ALTER DATABASE [VP_Book] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [VP_Book] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [VP_Book] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [VP_Book] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [VP_Book] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [VP_Book] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [VP_Book] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [VP_Book] SET RECOVERY FULL 
GO
ALTER DATABASE [VP_Book] SET  MULTI_USER 
GO
ALTER DATABASE [VP_Book] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [VP_Book] SET DB_CHAINING OFF 
GO
ALTER DATABASE [VP_Book] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [VP_Book] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [VP_Book] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [VP_Book] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'VP_Book', N'ON'
GO
ALTER DATABASE [VP_Book] SET QUERY_STORE = OFF
GO
USE [VP_Book]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 25.10.2021 21:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime2](7) NOT NULL,
	[ModifyTime] [datetime2](7) NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[ISBN] [nvarchar](max) NOT NULL,
	[PublishYear] [int] NOT NULL,
	[CoverPrice] [decimal](8, 2) NOT NULL,
	[Status] [int] NOT NULL,
	[CheckedOutUserId] [bigint] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookHistory]    Script Date: 25.10.2021 21:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookHistory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime2](7) NOT NULL,
	[ModifyTime] [datetime2](7) NOT NULL,
	[BookId] [bigint] NOT NULL,
	[CheckedOutUserId] [bigint] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_BookHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CheckedOutUser]    Script Date: 25.10.2021 21:37:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CheckedOutUser](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CreateTime] [datetime2](7) NOT NULL,
	[ModifyTime] [datetime2](7) NOT NULL,
	[Name] [nvarchar](32) NOT NULL,
	[MobilePhoneNumber] [nvarchar](max) NOT NULL,
	[NationalId] [bigint] NOT NULL,
	[CheckedOutTime] [datetime2](7) NOT NULL,
	[ReturnTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_CheckedOutUser] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON 
GO
INSERT [dbo].[Book] ([Id], [CreateTime], [ModifyTime], [Title], [ISBN], [PublishYear], [CoverPrice], [Status], [CheckedOutUserId]) VALUES (1, CAST(N'2021-10-23T19:53:13.0066443' AS DateTime2), CAST(N'2021-10-25T21:27:13.4884274' AS DateTime2), N'Ne İçin Varsan Onun için Yaşa', N'9786254414046', 2010, CAST(14.00 AS Decimal(8, 2)), 2, 6)
GO
INSERT [dbo].[Book] ([Id], [CreateTime], [ModifyTime], [Title], [ISBN], [PublishYear], [CoverPrice], [Status], [CheckedOutUserId]) VALUES (2, CAST(N'2021-10-23T20:54:54.0768431' AS DateTime2), CAST(N'2021-10-25T21:29:24.6456592' AS DateTime2), N'Hayvan Çiftliği', N'87897987', 1945, CAST(6.65 AS Decimal(8, 2)), 1, NULL)
GO
INSERT [dbo].[Book] ([Id], [CreateTime], [ModifyTime], [Title], [ISBN], [PublishYear], [CoverPrice], [Status], [CheckedOutUserId]) VALUES (3, CAST(N'2021-10-25T21:33:00.9410676' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Şeker Portakalı', N'9789750738609', 2010, CAST(16.85 AS Decimal(8, 2)), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
SET IDENTITY_INSERT [dbo].[BookHistory] ON 
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (1, CAST(N'2021-10-23T20:45:12.8118123' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 1, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (2, CAST(N'2021-10-23T21:03:10.1815076' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 1, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (3, CAST(N'2021-10-23T21:04:13.5156473' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 2, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (4, CAST(N'2021-10-23T21:13:07.0332736' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 3, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (5, CAST(N'2021-10-23T21:14:26.8231262' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 3, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (6, CAST(N'2021-10-25T20:38:02.2042808' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 2, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (7, CAST(N'2021-10-25T20:40:10.9379890' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 4, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (8, CAST(N'2021-10-25T20:47:34.4644111' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 4, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (9, CAST(N'2021-10-25T20:51:44.0903158' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 5, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (10, CAST(N'2021-10-25T20:56:36.1045731' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 5, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (11, CAST(N'2021-10-25T21:27:13.4735574' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 1, 6, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (12, CAST(N'2021-10-25T21:27:30.2020597' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 7, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (13, CAST(N'2021-10-25T21:27:57.2431410' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 7, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (14, CAST(N'2021-10-25T21:28:05.9333388' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 8, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (15, CAST(N'2021-10-25T21:29:06.2430461' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 8, 3)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (16, CAST(N'2021-10-25T21:29:12.4042441' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 9, 2)
GO
INSERT [dbo].[BookHistory] ([Id], [CreateTime], [ModifyTime], [BookId], [CheckedOutUserId], [Status]) VALUES (17, CAST(N'2021-10-25T21:29:24.6454443' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), 2, 9, 3)
GO
SET IDENTITY_INSERT [dbo].[BookHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[CheckedOutUser] ON 
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (1, CAST(N'2021-10-23T20:45:10.7440332' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Erdinç Karaman', N'543 337 9967', 11111111111, CAST(N'2021-10-23T20:45:10.7793479' AS DateTime2), CAST(N'2021-11-07T20:45:10.7857480' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (2, CAST(N'2021-10-23T21:04:13.5059440' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Test', N'111 111 1111', 11111111111, CAST(N'2021-10-23T21:04:13.5063605' AS DateTime2), CAST(N'2021-11-07T21:04:13.5064077' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (3, CAST(N'2021-10-23T21:13:06.9146744' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Book Tester', N'533 333 3333', 99999999999, CAST(N'2021-10-23T21:13:06.9151449' AS DateTime2), CAST(N'2021-11-07T21:13:06.9151775' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (4, CAST(N'2021-10-25T20:40:10.9297444' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Erdinç Karaman', N'533 333 3333', 99999999999, CAST(N'2021-10-25T20:40:10.9299736' AS DateTime2), CAST(N'2021-11-09T20:40:10.9300088' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (5, CAST(N'2021-10-25T20:51:44.0891315' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Test Service', N'533 333 3333', 11111111111, CAST(N'2021-10-25T20:51:44.0891393' AS DateTime2), CAST(N'2021-11-09T20:51:44.0891395' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (6, CAST(N'2021-10-25T21:27:13.4346463' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Erdinç Karaman', N'543 337 9967', 11111111111, CAST(N'2021-10-25T21:27:13.4349089' AS DateTime2), CAST(N'2021-11-09T21:27:13.4349457' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (7, CAST(N'2021-10-25T21:27:30.1994368' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Test Service', N'533 333 3333', 11111111111, CAST(N'2021-10-25T21:27:30.1994448' AS DateTime2), CAST(N'2021-11-09T21:27:30.1994461' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (8, CAST(N'2021-10-25T21:28:05.9318393' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Subscription', N'111 111 1111', 11111111111, CAST(N'2021-10-25T21:28:05.9318471' AS DateTime2), CAST(N'2021-11-09T21:28:05.9318483' AS DateTime2))
GO
INSERT [dbo].[CheckedOutUser] ([Id], [CreateTime], [ModifyTime], [Name], [MobilePhoneNumber], [NationalId], [CheckedOutTime], [ReturnTime]) VALUES (9, CAST(N'2021-10-25T21:29:12.4030676' AS DateTime2), CAST(N'0001-01-01T00:00:00.0000000' AS DateTime2), N'Erdinç Karaman', N'543 337 9967', 11111111111, CAST(N'2021-10-25T21:29:12.4030746' AS DateTime2), CAST(N'2021-11-09T21:29:12.4030748' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[CheckedOutUser] OFF
GO
/****** Object:  Index [IX_Book_CheckedOutUserId]    Script Date: 25.10.2021 21:37:08 ******/
CREATE NONCLUSTERED INDEX [IX_Book_CheckedOutUserId] ON [dbo].[Book]
(
	[CheckedOutUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BookHistory_BookId]    Script Date: 25.10.2021 21:37:08 ******/
CREATE NONCLUSTERED INDEX [IX_BookHistory_BookId] ON [dbo].[BookHistory]
(
	[BookId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_BookHistory_CheckedOutUserId]    Script Date: 25.10.2021 21:37:08 ******/
CREATE NONCLUSTERED INDEX [IX_BookHistory_CheckedOutUserId] ON [dbo].[BookHistory]
(
	[CheckedOutUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_CheckedOutUserId]  DEFAULT ((0)) FOR [CheckedOutUserId]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_CheckedOutUser_CheckedOutUserId] FOREIGN KEY([CheckedOutUserId])
REFERENCES [dbo].[CheckedOutUser] ([Id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_CheckedOutUser_CheckedOutUserId]
GO
ALTER TABLE [dbo].[BookHistory]  WITH CHECK ADD  CONSTRAINT [FK_BookHistory_Book_BookId] FOREIGN KEY([BookId])
REFERENCES [dbo].[Book] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BookHistory] CHECK CONSTRAINT [FK_BookHistory_Book_BookId]
GO
ALTER TABLE [dbo].[BookHistory]  WITH CHECK ADD  CONSTRAINT [FK_BookHistory_CheckedOutUser_CheckedOutUserId] FOREIGN KEY([CheckedOutUserId])
REFERENCES [dbo].[CheckedOutUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BookHistory] CHECK CONSTRAINT [FK_BookHistory_CheckedOutUser_CheckedOutUserId]
GO
USE [master]
GO
ALTER DATABASE [VP_Book] SET  READ_WRITE 
GO
