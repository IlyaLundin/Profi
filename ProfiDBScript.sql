USE [master]
GO
/****** Object:  Database [ProfiDB]    Script Date: 09.07.2023 12:04:26 ******/
CREATE DATABASE [ProfiDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProfiDB', FILENAME = N'C:\DBtest\ProfiDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProfiDB_log', FILENAME = N'C:\DBtest\ProfiDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ProfiDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProfiDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProfiDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProfiDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProfiDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProfiDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProfiDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProfiDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProfiDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProfiDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProfiDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProfiDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProfiDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProfiDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProfiDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProfiDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProfiDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProfiDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProfiDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProfiDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProfiDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProfiDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProfiDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProfiDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProfiDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ProfiDB] SET  MULTI_USER 
GO
ALTER DATABASE [ProfiDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProfiDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProfiDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProfiDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProfiDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProfiDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ProfiDB] SET QUERY_STORE = OFF
GO
USE [ProfiDB]
GO
/****** Object:  Table [dbo].[SAE]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAE](
	[Id_SAE] [int] IDENTITY(1,1) NOT NULL,
	[Name_SAE] [nvarchar](100) NOT NULL,
	[Material_Base] [nvarchar](100) NOT NULL,
	[Age] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[Content] [nvarchar](100) NOT NULL,
	[Result] [nvarchar](100) NOT NULL,
	[Price] [int] NOT NULL,
	[Profi_Point] [int] NOT NULL,
	[Photo_Path] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_SAE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[PhotosSAE]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PhotosSAE]
AS
SELECT DISTINCT Name_SAE, Price, Profi_Point, Photo_Path, sp.Id_SAE
FROM SAE s JOIN SAE_Photo sp ON s.Id_SAE=sp.Id_SAE
JOIN Photo p ON p.Id_Photo = sp.Id_Photo
WHERE  Main_Photo = sp.Id_Photo

GO
/****** Object:  Table [dbo].[Role]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id_Role] [int] IDENTITY(1,1) NOT NULL,
	[Name_Role] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Id_User] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](20) NOT NULL,
	[Phone] [nvarchar](10) NOT NULL,
	[FIO] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_User] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role_User]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role_User](
	[Id_Role] [int] NOT NULL,
	[Id_User] [int] NOT NULL,
 CONSTRAINT [PK] PRIMARY KEY CLUSTERED 
(
	[Id_User] ASC,
	[Id_Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[UserRoles]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[UserRoles]
AS
SELECT Name_Role, Login
FROM [User] u JOIN Role_User ru
ON u.Id_User = ru.Id_User
JOIN Role r ON r.Id_Role = ru.Id_Role
GO
/****** Object:  Table [dbo].[Contragent]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contragent](
	[Id_Contragent] [int] IDENTITY(1,1) NOT NULL,
	[Name_Contragent] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](20) NOT NULL,
	[Phone] [nvarchar](10) NOT NULL,
	[Address] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[Logo] [nvarchar](200) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Contragent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SAE_Contragent]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SAE_Contragent](
	[Id_SAE] [int] NOT NULL,
	[Id_Contragent] [int] NOT NULL,
 CONSTRAINT [PK_SC] PRIMARY KEY CLUSTERED 
(
	[Id_SAE] ASC,
	[Id_Contragent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ContragentSAEs]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ContragentSAEs]
AS
SELECT Name_SAE, Name_Contragent, Material_Base, Age, Count, Content, Result, Price, Profi_Point, Logo, Photo_Path
FROM SAE s JOIN SAE_Contragent sc ON s.Id_SAE = sc.Id_SAE
JOIN Contragent c ON sc.Id_Contragent = c.Id_Contragent
GO
/****** Object:  Table [dbo].[LogInJournal]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogInJournal](
	[Id_User] [int] NOT NULL,
	[LogInDateTime] [datetime] NOT NULL,
 CONSTRAINT [PK_LogInJournal] PRIMARY KEY CLUSTERED 
(
	[Id_User] ASC,
	[LogInDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[LogInUsers]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LogInUsers]
AS
SELECT Login, LogInDateTime
FROM LogInJournal l JOIN [User] r ON l.Id_User=r.Id_User
GO
/****** Object:  View [dbo].[SAE_Categories]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[SAE_Categories]
AS
SELECT Name_Category, Name_SAE
FROM Category c JOIN Category_SAE cs ON c.Id_Category=cs.Id_Category
JOIN SAE s ON s.Id_SAE=cs.Id_SAE
GO
/****** Object:  Table [dbo].[Contragent_User]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contragent_User](
	[Id_Role] [int] NOT NULL,
	[Id_User] [int] NOT NULL,
	[Id_Contragent] [int] NOT NULL,
 CONSTRAINT [PK_CU] PRIMARY KEY CLUSTERED 
(
	[Id_Role] ASC,
	[Id_User] ASC,
	[Id_Contragent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[All_Contragents_User]    Script Date: 09.07.2023 12:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[All_Contragents_User]
AS
SELECT Login, Name_Contragent
FROM Contragent_User cu JOIN [User] u ON cu.Id_User=u.Id_User 
JOIN Contragent c ON c.Id_Contragent=cu.Id_Contragent
GO
SET IDENTITY_INSERT [dbo].[Contragent] ON 

INSERT [dbo].[Contragent] ([Id_Contragent], [Name_Contragent], [Email], [Phone], [Address], [Description], [Logo]) VALUES (2, N'Центр спортивного развития Богатырь', N'bogatyr@mail.ru', N'9991121127', N'Байбакова 20/1', N'Центр спортивного развития, ростящий победителей соревнований по боксу с 2015', N'/Resources/Logos/DBbogatyr.jpg')
INSERT [dbo].[Contragent] ([Id_Contragent], [Name_Contragent], [Email], [Phone], [Address], [Description], [Logo]) VALUES (3, N'Дворец культуры Горький', N'bitter1917@gmail.com', N'9991918991', N'Ленина 1', N'Дворец культуры, воспитывающий детей с советских времен ', N'/Resources/Logos/DBGorkyi.jpg')
INSERT [dbo].[Contragent] ([Id_Contragent], [Name_Contragent], [Email], [Phone], [Address], [Description], [Logo]) VALUES (4, N'Центр развития детей младшего школьного возраста Антошка', N'qwerty@yandex.ru', N'9222323233', N'Артема 101', N'Элитный центр развития детей ', N'/Resources/Logos/DBantoshka.jpg')
INSERT [dbo].[Contragent] ([Id_Contragent], [Name_Contragent], [Email], [Phone], [Address], [Description], [Logo]) VALUES (5, N'Фитнес-центр Солнышко', N'solnechko@mail.ru', N'9114572899', N'Пригожинская 200', N'Новый фитнес-центр, работающий с 2019 года, победивший в нескольких соревнованиях', N'/Resources/Logos/DBsolnyshko.jpg')
INSERT [dbo].[Contragent] ([Id_Contragent], [Name_Contragent], [Email], [Phone], [Address], [Description], [Logo]) VALUES (7, N'Школа музыки Вагнер', N'wagner@gmail.com', N'9324041029', N'Музыкальная 15', N'Школа музыки, использующая современные методики обучения', N'/Resources/Logos/DBmusica.jpg')
INSERT [dbo].[Contragent] ([Id_Contragent], [Name_Contragent], [Email], [Phone], [Address], [Description], [Logo]) VALUES (8, N'Центр развития интеллекта Эзоп', N'samos@yandex.ru', N'9176661819', N'Греческая 22', N'Центр развития интеллекта, хранящий греческие традиции воспитания', N'/Resources/Logos/DBEsop.jpg')
SET IDENTITY_INSERT [dbo].[Contragent] OFF
GO
INSERT [dbo].[Contragent_User] ([Id_Role], [Id_User], [Id_Contragent]) VALUES (2, 2, 2)
INSERT [dbo].[Contragent_User] ([Id_Role], [Id_User], [Id_Contragent]) VALUES (2, 1002, 7)
GO
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T04:06:07.903' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T04:15:17.000' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T04:18:57.783' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T04:20:23.387' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T05:12:26.497' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T05:14:33.510' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T05:16:25.877' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T05:24:05.193' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-13T05:33:20.737' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T18:52:55.123' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:22:53.747' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:25:45.370' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:29:31.997' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:30:10.103' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:30:31.920' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:31:55.790' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:36:15.057' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:48:25.153' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:49:18.740' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-15T22:51:59.870' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-19T01:16:10.320' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T17:47:59.907' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T17:54:50.423' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T18:04:26.540' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T18:38:57.493' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:00:27.550' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:04:59.067' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:25:59.827' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:35:59.703' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:42:39.273' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:47:49.487' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:49:16.700' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T21:50:56.843' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:05:16.840' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:08:47.420' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:21:04.210' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:27:51.423' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:47:11.760' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:55:03.047' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T22:56:46.163' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-22T23:02:12.980' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T03:58:54.043' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T05:04:09.317' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T05:09:50.813' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T05:22:53.890' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T05:31:20.190' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T05:32:25.293' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:10:01.963' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:11:38.790' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:18:39.573' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:19:39.033' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:25:44.923' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:26:32.023' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:27:47.630' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:28:38.370' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:39:08.857' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T15:39:33.503' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T19:24:51.967' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T19:29:08.143' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:24:16.497' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:28:10.817' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:30:27.827' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:31:16.627' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:33:51.903' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:34:57.737' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:55:00.597' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:56:40.300' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:58:04.350' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T21:58:49.593' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T22:00:31.427' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T22:45:43.400' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T22:56:17.310' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T22:58:21.960' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-26T23:00:42.173' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:11:25.553' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:23:52.890' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:31:51.700' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:36:10.623' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:36:48.467' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:40:52.443' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:48:10.920' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T01:49:28.583' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T02:02:06.327' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T03:11:22.647' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T03:12:00.673' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T03:15:11.100' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T04:02:22.073' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T04:06:02.960' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T06:28:06.310' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-27T06:29:42.343' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-28T00:53:49.133' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-28T01:20:12.397' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T05:56:58.410' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:07:02.477' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:07:29.187' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:10:25.467' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:17:54.003' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:22:17.577' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:24:35.133' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:28:22.977' AS DateTime))
GO
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:31:38.710' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T06:34:14.093' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-06-30T07:32:10.567' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-07-01T10:57:15.807' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1, CAST(N'2023-07-09T11:55:49.030' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:11:52.340' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:24:12.367' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:27:48.933' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:28:36.380' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:29:10.390' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:29:55.633' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T01:31:30.183' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T03:30:07.757' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T03:34:05.523' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:02:54.040' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:06:23.970' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:07:12.017' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:09:21.433' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:11:07.150' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:11:54.567' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:23:35.220' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T04:33:24.720' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T05:02:22.753' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T05:08:33.667' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-27T06:31:36.493' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-30T00:28:36.533' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-06-30T07:33:34.993' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-07-01T10:57:35.677' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-07-01T10:59:55.793' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-07-01T11:05:07.327' AS DateTime))
INSERT [dbo].[LogInJournal] ([Id_User], [LogInDateTime]) VALUES (1002, CAST(N'2023-07-01T11:08:42.940' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([Id_Role], [Name_Role]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([Id_Role], [Name_Role]) VALUES (2, N'Contragent')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
INSERT [dbo].[Role_User] ([Id_Role], [Id_User]) VALUES (1, 1)
INSERT [dbo].[Role_User] ([Id_Role], [Id_User]) VALUES (2, 2)
INSERT [dbo].[Role_User] ([Id_Role], [Id_User]) VALUES (2, 1002)
GO
SET IDENTITY_INSERT [dbo].[SAE] ON 

INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (1, N'Школа бокса Тайсон', N'Десять груш, сто наборов гантель и перчаток', 18, 100, N'Нет данных', N'Нет данных', 4000, 100, N'/Resources/Images/бокс2.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (2, N'Клуб вязания крючком Юные рукоделы', N'Двадцать наборов для шитья', 9, 50, N'Нет данных', N'Нет данных', 1000, 30, N'/Resources/Images/вязание.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (4, N'Кружок шахмат Юный Магнус Карлсен', N'Двенадцать шахматных досок и 5 дополнительных наборов фигур. Двенадцать парт и две дюжины стульев', 7, 20, N'Нет данных', N'Нет данных', 500, 63, N'/Resources/Images/шах.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (6, N'Секция фитнеса Лотос ', N'Пять надувных шаров, десять боди-баров', 14, 13, N'Нет данных', N'Нет данных', 760, 0, N'/Resources/Images/фитнес.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (8, N'Студия пения Мадонна', N'Три микрофона', 16, 15, N'Нет данных', N'Нет данных', 1250, 12, N'/Resources/Images/пение.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (9, N'Академия бокса Скала', N'Десять груш, сто наборов гантель и перчаток', 20, 25, N'Нет данных', N'Нет данных', 3500, 211, N'/Resources/Images/бокс.jpeg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (10, N'Кружок бисероплетения Звездочка', N'Бисер желтый', 7, 5, N'Нет данных', N'Нет данных', 2300, 0, N'/Resources/Images/бисер.jpeg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (11, N'Школа шахмат Молодой Каспаров', N'Двенадцать шахматных досок и 5 дополнительных наборов фигур. Двенадцать парт и две дюжины стульев', 12, 10, N'Нет данных', N'Нет данных', 1453, 0, N'/Resources/Images/шах.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (12, N'Ансамбль русского народного творчества Сказка', N'Два набора ложек, три свирели, баян', 12, 18, N'Нет данных', N'Нет данных', 3000, 22, N'/Resources/Images/руснар.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (13, N'Кружок игры на скрипке', N'Две альтовых скрипки', 14, 5, N'Нет данных', N'Нет данных', 1453, 0, N'/Resources/Images/скрипка.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (16, N'Секция йоги Индия', N'Две доски с гвозями, пять ковриков', 18, 15, N'Нет данных', N'Нет данных', 900, 10, N'/Resources/Images/йога.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (17, N'Школа балета Щелкунчик', N'Нет данных', 12, 30, N'Нет данных', N'Нет данных', 500, 50, N'/Resources/Images/балет.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (18, N'Клуб юных программистов Цифра', N'Двенадцать ноутбуков, пять учебников', 10, 12, N'Нет данных', N'Нет данных', 4450, 78, N'/Resources/Images/програм.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (19, N'Академия шахмат Рети', N'Двенадцать шахматных досок и 5 дополнительных наборов фигур. Двенадцать парт и две дюжины стульев', 18, 30, N'Нет данных', N'Нет данных', 2200, 156, N'/Resources/Images/шах2.jpg')
INSERT [dbo].[SAE] ([Id_SAE], [Name_SAE], [Material_Base], [Age], [Count], [Content], [Result], [Price], [Profi_Point], [Photo_Path]) VALUES (20, N'Школа детского прикладного творчества', N'Нет данных', 7, 10, N'Нет данных', N'Нет данных', 1000, 0, N'/Resources/Images/вязание.jpg')
SET IDENTITY_INSERT [dbo].[SAE] OFF
GO
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (1, 2)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (2, 4)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (4, 8)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (6, 5)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (8, 7)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (9, 5)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (10, 4)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (11, 3)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (12, 7)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (13, 7)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (16, 5)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (17, 3)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (18, 8)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (19, 8)
INSERT [dbo].[SAE_Contragent] ([Id_SAE], [Id_Contragent]) VALUES (20, 4)
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([Id_User], [Login], [Password], [Email], [Phone], [FIO]) VALUES (1, N'admin', N'admin', N'admin@mail.ru', N'9111121121', N'Понасенков Евгений Николаевич')
INSERT [dbo].[User] ([Id_User], [Login], [Password], [Email], [Phone], [FIO]) VALUES (2, N'bogatyr', N'dobrynya', N'star@gmail.com', N'9292223331', N'Богатырский Добрыня Никитич')
INSERT [dbo].[User] ([Id_User], [Login], [Password], [Email], [Phone], [FIO]) VALUES (1002, N'music', N'wagner1234', N'wagner@mail.ru', N'9881234567', N'Рихард Вагнер')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Contragent_User]  WITH CHECK ADD  CONSTRAINT [FK_C_User] FOREIGN KEY([Id_User], [Id_Role])
REFERENCES [dbo].[Role_User] ([Id_User], [Id_Role])
GO
ALTER TABLE [dbo].[Contragent_User] CHECK CONSTRAINT [FK_C_User]
GO
ALTER TABLE [dbo].[Contragent_User]  WITH CHECK ADD  CONSTRAINT [FK_Contragent_U] FOREIGN KEY([Id_Contragent])
REFERENCES [dbo].[Contragent] ([Id_Contragent])
GO
ALTER TABLE [dbo].[Contragent_User] CHECK CONSTRAINT [FK_Contragent_U]
GO
ALTER TABLE [dbo].[LogInJournal]  WITH CHECK ADD  CONSTRAINT [FK_LogInJournal] FOREIGN KEY([Id_User])
REFERENCES [dbo].[User] ([Id_User])
GO
ALTER TABLE [dbo].[LogInJournal] CHECK CONSTRAINT [FK_LogInJournal]
GO
ALTER TABLE [dbo].[Role_User]  WITH CHECK ADD  CONSTRAINT [FK_Role] FOREIGN KEY([Id_Role])
REFERENCES [dbo].[Role] ([Id_Role])
GO
ALTER TABLE [dbo].[Role_User] CHECK CONSTRAINT [FK_Role]
GO
ALTER TABLE [dbo].[Role_User]  WITH CHECK ADD  CONSTRAINT [FK_User] FOREIGN KEY([Id_User])
REFERENCES [dbo].[User] ([Id_User])
GO
ALTER TABLE [dbo].[Role_User] CHECK CONSTRAINT [FK_User]
GO
ALTER TABLE [dbo].[SAE_Contragent]  WITH CHECK ADD  CONSTRAINT [FK_Contragent] FOREIGN KEY([Id_Contragent])
REFERENCES [dbo].[Contragent] ([Id_Contragent])
GO
ALTER TABLE [dbo].[SAE_Contragent] CHECK CONSTRAINT [FK_Contragent]
GO
ALTER TABLE [dbo].[SAE_Contragent]  WITH CHECK ADD  CONSTRAINT [FK_SAE] FOREIGN KEY([Id_SAE])
REFERENCES [dbo].[SAE] ([Id_SAE])
GO
ALTER TABLE [dbo].[SAE_Contragent] CHECK CONSTRAINT [FK_SAE]
GO
USE [master]
GO
ALTER DATABASE [ProfiDB] SET  READ_WRITE 
GO
