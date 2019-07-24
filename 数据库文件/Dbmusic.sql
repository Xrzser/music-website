USE [master]
GO
/****** Object:  Database [DBmusic]    Script Date: 2019/5/8 15:58:34 ******/
CREATE DATABASE [DBmusic]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DBmusic', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DBmusic.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DBmusic_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\DBmusic_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DBmusic] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBmusic].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBmusic] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DBmusic] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DBmusic] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DBmusic] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DBmusic] SET ARITHABORT OFF 
GO
ALTER DATABASE [DBmusic] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DBmusic] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DBmusic] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DBmusic] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DBmusic] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DBmusic] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DBmusic] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DBmusic] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DBmusic] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DBmusic] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DBmusic] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DBmusic] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DBmusic] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DBmusic] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DBmusic] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DBmusic] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DBmusic] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DBmusic] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DBmusic] SET  MULTI_USER 
GO
ALTER DATABASE [DBmusic] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DBmusic] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DBmusic] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DBmusic] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [DBmusic] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DBmusic]
GO
/****** Object:  Table [dbo].[tbadministrators]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbadministrators](
	[administrators_id] [int] IDENTITY(1,1) NOT NULL,
	[administrators_name] [varchar](50) NOT NULL,
	[administrators_password] [varchar](50) NOT NULL CONSTRAINT [DF_tbadministrators_administrators_password]  DEFAULT ((111111)),
	[administrators_limit] [varchar](50) NOT NULL CONSTRAINT [DF_tbadministrators_administrators_limit]  DEFAULT ('000'),
 CONSTRAINT [PK_tbadministrators] PRIMARY KEY CLUSTERED 
(
	[administrators_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbfavorite]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbfavorite](
	[user_id] [int] NOT NULL,
	[favorite_songsid_list] [varchar](4000) NULL,
	[favorite_songsheetsid_list] [varchar](400) NULL,
 CONSTRAINT [PK_tbfavorite] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbmusicinfo]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbmusicinfo](
	[music_id] [int] IDENTITY(1,1) NOT NULL,
	[music_name] [varchar](50) NULL,
	[music_rhythm] [int] NULL,
	[music_emotion] [int] NULL,
	[music_type] [int] NULL,
	[music_language] [int] NULL,
	[music_singer] [varchar](50) NULL,
	[music_path] [varchar](100) NULL,
	[upload_user_id] [int] NULL,
	[music_volume] [int] NULL CONSTRAINT [DF_tbmusicinfo_music_volume]  DEFAULT ((0)),
 CONSTRAINT [PK_tbmusicinfo] PRIMARY KEY CLUSTERED 
(
	[music_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbrecommend]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbrecommend](
	[user_id] [int] NOT NULL,
	[update_time] [varchar](50) NULL,
	[recommend_musicstr] [varchar](50) NULL,
 CONSTRAINT [PK_tbrecommend] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbsinger]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbsinger](
	[singer_id] [int] IDENTITY(1,1) NOT NULL,
	[singer_name] [varchar](50) NULL,
	[singer_sex] [int] NULL,
	[singer_image] [varchar](70) NULL,
	[singer_content] [varchar](1000) NULL,
	[singer_volume] [int] NOT NULL CONSTRAINT [DF_tbsinger_singer_volume]  DEFAULT ((0)),
 CONSTRAINT [PK_tbsinger] PRIMARY KEY CLUSTERED 
(
	[singer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbsongsheets]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbsongsheets](
	[songsheet_id] [int] IDENTITY(1,1) NOT NULL,
	[createuser_id] [int] NOT NULL,
	[songsheet_name] [varchar](50) NOT NULL,
	[songsheet_content] [varchar](300) NULL,
	[musicid_list] [varchar](4000) NULL,
	[ispublic] [int] NOT NULL,
	[isvalid] [int] NULL CONSTRAINT [DF_tbsongsheets_isvalid]  DEFAULT ((1)),
	[songsheet_volume] [int] NULL CONSTRAINT [DF_tbsongsheets_songsheet_volume]  DEFAULT ((0)),
 CONSTRAINT [PK_tbsongsheets] PRIMARY KEY CLUSTERED 
(
	[songsheet_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbuser]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbuser](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](10) NOT NULL,
	[user_pwd] [varchar](20) NOT NULL,
	[user_email] [varchar](40) NOT NULL,
	[user_valid] [int] NOT NULL CONSTRAINT [DF_tbuser_user_valid]  DEFAULT ((1)),
 CONSTRAINT [PK_tbuser] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tbuserinfo]    Script Date: 2019/5/8 15:58:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tbuserinfo](
	[user_id] [int] NOT NULL,
	[user_sex] [int] NULL,
	[user_location] [varchar](50) NULL,
	[user_signature] [varchar](200) NULL,
	[user_rhythm] [varchar](100) NULL,
	[user_emotion] [varchar](100) NULL,
	[user_type] [varchar](100) NULL,
	[user_language] [varchar](100) NULL,
	[user_singer] [varchar](300) NULL,
 CONSTRAINT [PK_tbuserinfo] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[tbadministrators] ON 

INSERT [dbo].[tbadministrators] ([administrators_id], [administrators_name], [administrators_password], [administrators_limit]) VALUES (1, N'root', N'111111', N'111')
INSERT [dbo].[tbadministrators] ([administrators_id], [administrators_name], [administrators_password], [administrators_limit]) VALUES (2, N'music001', N'111111', N'111')
INSERT [dbo].[tbadministrators] ([administrators_id], [administrators_name], [administrators_password], [administrators_limit]) VALUES (3, N'music002', N'111111', N'001')
INSERT [dbo].[tbadministrators] ([administrators_id], [administrators_name], [administrators_password], [administrators_limit]) VALUES (6, N'music003', N'111111', N'010')
SET IDENTITY_INSERT [dbo].[tbadministrators] OFF
INSERT [dbo].[tbfavorite] ([user_id], [favorite_songsid_list], [favorite_songsheetsid_list]) VALUES (3, N'99,111,112,111,110,99,108,102,113,108,', N'3,')
SET IDENTITY_INSERT [dbo].[tbmusicinfo] ON 

INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (97, N'消愁', 1, 2, 2, 0, N'毛不易', N'\music\1556352950930.mp3', 3, 15)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (98, N'Wake Me Up', 0, 3, 0, 1, N'Tiffany Alvord', N'\music\1557262310351.mp3', 3, 3)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (99, N'我曾', 1, 2, 0, 0, N'隔壁老樊', N'\music\1555867646898.mp3', 3, 8)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (100, N'平凡的一天', 1, 1, 0, 0, N'毛不易', N'\music\1557801887502.mp3', 3, 1)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (101, N'盛夏', 1, 2, 0, 0, N'毛不易', N'\music\1555940816313.mp3', 3, 1)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (102, N'老街', 1, 2, 0, 0, N'李荣浩', N'\music\1557219502757.mp3', 3, 8)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (103, N'盗将行', 1, 3, 2, 0, N'花粥', N'\music\1556524436119.mp3', 3, 3)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (104, N'倒数', 0, 0, 0, 0, N'邓紫棋', N'\music\1557239556475.mp3', 3, 3)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (105, N'Shape Of You', 0, 3, 1, 1, N'Ed Sheeran', N'\music\1556990728168.mp3', 3, 4)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (106, N'光年之外', 1, 3, 0, 0, N'邓紫棋', N'\music\1557863159576.mp3', 3, 1)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (107, N'爱很简单', 1, 3, 0, 0, N'陶喆 ', N'\music\1557098727043.mp3', 3, 0)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (108, N'Baby I Love You', 0, 3, 0, 1, N'Tiffany Alvord', N'\music\1557910882046.mp3', 3, 12)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (109, N'Blank Space', 0, 3, 0, 1, N'Tiffany Alvord', N'\music\1557010936111.mp3', 3, 1)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (110, N'我好像在哪里见过你', 0, 0, 0, 0, N'薛之谦', N'\music\1556872097092.mp3', 3, 9)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (111, N'丑八怪', 1, 1, 0, 0, N'薛之谦', N'\music\1557548060053.mp3', 3, 8)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (112, N'天分', 1, 1, 0, 0, N'薛之谦', N'\music\1555985715837.mp3', 3, 9)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (113, N'燕归巢', 1, 3, 0, 0, N'许嵩', N'\music\1557175887873.mp3', 3, 5)
INSERT [dbo].[tbmusicinfo] ([music_id], [music_name], [music_rhythm], [music_emotion], [music_type], [music_language], [music_singer], [music_path], [upload_user_id], [music_volume]) VALUES (114, N'我曾', 0, 0, 1, 0, N'隔壁老樊', N'\music\1558926434195.mp3', 3, 0)
SET IDENTITY_INSERT [dbo].[tbmusicinfo] OFF
INSERT [dbo].[tbrecommend] ([user_id], [update_time], [recommend_musicstr]) VALUES (3, N'2019/5/8 15:57:51', N'101,107,102,97,104,103,112,99,113,110,114,106,')
SET IDENTITY_INSERT [dbo].[tbsinger] ON 

INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (18, N'薛之谦', 1, N'\images\singer\1556546263025.jpg', N'薛之谦（Joker Xue），1983年7月17日出生于上海，华语流行乐男歌手、影视演员、音乐制作人，毕业于格里昂酒店管理学院。', 26)
INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (19, N'李荣浩', 1, N'\images\singer\1556954686282.jpg', N'李荣浩，1985年7月11日生于蚌埠，中国流行音乐制作人、歌手、吉他手。', 8)
INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (20, N'邓紫棋', 0, N'\images\singer\1557420978795.jpg', N'邓紫棋成长于一个音乐世家，其母亲为上海音乐学院声乐系毕业生，外婆教唱歌，舅父拉小提琴，外公在乐团吹色士风。在家人的熏陶下，自小便热爱音乐，喜爱唱歌，与音乐结下不解之缘。', 4)
INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (21, N'花粥', 0, N'\images\singer\1557303064984.jpg', N'花粥是一名英雄联盟召唤师，完全贯彻社会主义核心价值观的先进音乐工作者。', 3)
INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (22, N'毛不易', 1, N'\images\singer\1557852379762.jpg', N'毛不易，原名王维家，1994年10月1日出生于黑龙江省齐齐哈尔市泰来县，中国内地流行乐男歌手，毕业于杭州师范大学护理专业。2017年，参加选秀娱乐节目《明日之子》的比赛，获得全国总决赛冠军，从而正式进入演艺圈；9月1日，推出首张个人音乐专辑《巨星不易工作室 No.1》；11月11日，推出个人原创单曲《项羽虞姬》。', 17)
INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (23, N'Ed Sheeran', 1, N'\images\singer\1557900627100.jpg', N'爱德华·克里斯多弗·希兰（Edward Christopher Sheeran）艺名艾德·希兰（Ed Sheeran），1991年2月17日出生于英国英格兰西约克郡，是大西洋唱片（Atlantic Records）旗下的一位歌手同时也是一位创作人。', 4)
INSERT [dbo].[tbsinger] ([singer_id], [singer_name], [singer_sex], [singer_image], [singer_content], [singer_volume]) VALUES (24, N'Tiffany Alvord', 0, N'\images\singer\1557421496118.jpg', N'蒂芬妮·沃德是一位来自美国加州的歌手、作曲者，通过在YouTube网站分享自己的音乐创作或自弹自唱流行歌曲，获得了广泛的知名度。在2008年5月当她15岁的时候，就开始在Youtube上传翻唱和创作的歌曲。使用的乐器主要是吉他、以及钢琴、夏威夷四弦琴等。', 16)
SET IDENTITY_INSERT [dbo].[tbsinger] OFF
SET IDENTITY_INSERT [dbo].[tbsongsheets] ON 

INSERT [dbo].[tbsongsheets] ([songsheet_id], [createuser_id], [songsheet_name], [songsheet_content], [musicid_list], [ispublic], [isvalid], [songsheet_volume]) VALUES (3, 3, N'江湖再见', N'这是一个让长时间的忙碌的你放松的歌单时间13', N'', 1, 0, 11)
INSERT [dbo].[tbsongsheets] ([songsheet_id], [createuser_id], [songsheet_name], [songsheet_content], [musicid_list], [ispublic], [isvalid], [songsheet_volume]) VALUES (19, 3, N'1', N'1', N'', 1, 0, 0)
INSERT [dbo].[tbsongsheets] ([songsheet_id], [createuser_id], [songsheet_name], [songsheet_content], [musicid_list], [ispublic], [isvalid], [songsheet_volume]) VALUES (20, 3, N'好听的英文歌', N'好听的英文歌，入耳.......', N'105,98,', 1, 1, 0)
SET IDENTITY_INSERT [dbo].[tbsongsheets] OFF
SET IDENTITY_INSERT [dbo].[tbuser] ON 

INSERT [dbo].[tbuser] ([user_id], [user_name], [user_pwd], [user_email], [user_valid]) VALUES (3, N'薛睿', N'123456', N'xuerui_1997@126.com', 0)
SET IDENTITY_INSERT [dbo].[tbuser] OFF
INSERT [dbo].[tbuserinfo] ([user_id], [user_sex], [user_location], [user_signature], [user_rhythm], [user_emotion], [user_type], [user_language], [user_singer]) VALUES (3, 1, N'西安，中国', N'不忘初心，方得始终。终成空！', N'1,', N'2,', N'2,', N'0,2,', N'李荣浩，花粥')
USE [master]
GO
ALTER DATABASE [DBmusic] SET  READ_WRITE 
GO
