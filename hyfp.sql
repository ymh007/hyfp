USE [master]
GO
/****** Object:  Database [HYFP_CUS]    Script Date: 2018-10-16 10:10:47 ******/
CREATE DATABASE [HYFP_CUS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'bailuyuan', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\HYFP_CUS.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'bailuyuan_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\HYFP_CUS_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HYFP_CUS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HYFP_CUS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HYFP_CUS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HYFP_CUS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HYFP_CUS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HYFP_CUS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HYFP_CUS] SET ARITHABORT OFF 
GO
ALTER DATABASE [HYFP_CUS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HYFP_CUS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [HYFP_CUS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HYFP_CUS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HYFP_CUS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HYFP_CUS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HYFP_CUS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HYFP_CUS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HYFP_CUS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HYFP_CUS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HYFP_CUS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HYFP_CUS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HYFP_CUS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HYFP_CUS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HYFP_CUS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HYFP_CUS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HYFP_CUS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HYFP_CUS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HYFP_CUS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HYFP_CUS] SET  MULTI_USER 
GO
ALTER DATABASE [HYFP_CUS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HYFP_CUS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HYFP_CUS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HYFP_CUS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'HYFP_CUS', N'ON'
GO
USE [HYFP_CUS]
GO
/****** Object:  DatabaseRole [svndtcms]    Script Date: 2018-10-16 10:10:48 ******/
CREATE ROLE [svndtcms]
GO
/****** Object:  UserDefinedFunction [dbo].[f_split]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[f_split](@c varchar(2000),@split varchar(2)) 
returns @t table(col varchar(20)) 
as 
begin 

while(charindex(@split,@c)<>0) 
begin 
insert @t(col) values (substring(@c,1,charindex(@split,@c)-1)) 
set @c = stuff(@c,1,charindex(@split,@c),'') 
end 
insert @t(col) values (@c) 
return 
end 

GO
/****** Object:  Table [dbo].[account]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[xiehui_id] [int] NULL,
	[date] [date] NULL,
	[b_subject] [int] NULL,
	[s_subject] [int] NULL,
	[zhaiyao] [nvarchar](200) NULL,
	[jie] [numeric](18, 0) NULL,
	[dai] [numeric](18, 0) NULL,
 CONSTRAINT [PK_ACCOUNT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[account_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_account_albums] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[account_manager]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_manager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[sort_id] [int] NULL,
 CONSTRAINT [PK_account_manager] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[level] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[id_card] [nvarchar](50) NULL,
	[member_no] [nvarchar](50) NULL,
	[can_amount] [numeric](18, 0) NULL,
	[amount] [numeric](18, 0) NULL,
	[member_amount] [numeric](18, 0) NULL,
	[purpose] [nvarchar](50) NULL,
	[lb_person] [nvarchar](50) NULL,
	[lb_person_names] [nvarchar](50) NULL,
	[add_time] [datetime] NULL,
	[member_id] [int] NOT NULL,
	[status] [tinyint] NULL,
	[reason] [nvarchar](200) NULL,
	[yh_amount] [numeric](18, 0) NULL,
	[wh_amount] [numeric](18, 0) NULL,
	[zy_amount] [numeric](18, 0) NULL,
	[cq_amount] [numeric](18, 0) NULL,
	[hk_status] [tinyint] NOT NULL,
	[month] [int] NULL,
	[audit_time] [datetime] NULL,
	[chanye] [nvarchar](50) NULL,
	[remark] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[daikuan_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_daikuan_ALBUMS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_audit]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_audit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[member_no] [nvarchar](50) NULL,
	[amount] [numeric](18, 0) NULL,
	[purpose] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[village] [nvarchar](50) NULL,
	[status] [int] NULL,
	[reason] [nvarchar](50) NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_DAIKUAN_AUDIT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_chanye]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_chanye](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[amount] [numeric](18, 0) NULL,
	[add_time] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_manager]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_manager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[start_date] [datetime] NULL,
	[amount] [numeric](18, 0) NULL,
	[wh_amount] [numeric](18, 0) NULL,
	[zy_amount] [numeric](18, 0) NULL,
	[cq_amount] [numeric](18, 0) NULL,
	[status] [nvarchar](50) NULL,
	[add_time] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_repay]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_repay](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[daikuan_id] [int] NULL,
	[amount] [numeric](18, 0) NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_daikuan_repay] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_repay_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_repay_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[daikuan_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_daikuan_repay_albums] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[daikuan_set]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[daikuan_set](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[xiehui_id] [int] NULL,
	[rate] [numeric](18, 0) NULL,
	[over_rate] [numeric](18, 0) NULL,
	[amount] [numeric](18, 0) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[channel_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[call_index] [nvarchar](50) NULL,
	[title] [nvarchar](100) NULL,
	[link_url] [nvarchar](255) NULL,
	[img_url] [nvarchar](255) NULL,
	[seo_title] [nvarchar](255) NULL,
	[seo_keywords] [nvarchar](255) NULL,
	[seo_description] [nvarchar](255) NULL,
	[tags] [nvarchar](500) NULL,
	[zhaiyao] [nvarchar](255) NULL,
	[content] [ntext] NULL,
	[sort_id] [int] NULL,
	[click] [int] NULL,
	[status] [tinyint] NULL,
	[is_msg] [tinyint] NULL,
	[is_top] [tinyint] NULL,
	[is_red] [tinyint] NOT NULL,
	[is_hot] [tinyint] NULL,
	[is_slide] [tinyint] NULL,
	[is_sys] [tinyint] NULL,
	[user_name] [nvarchar](100) NULL,
	[add_time] [datetime] NULL,
	[update_time] [datetime] NULL,
	[sign_user_name] [nvarchar](max) NULL,
	[sign_time] [nvarchar](500) NULL,
 CONSTRAINT [PK_DT_ARTICLE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_DT_ARTICLE_ALBUMS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article_attach]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article_attach](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NULL,
	[file_name] [nvarchar](255) NULL,
	[file_path] [nvarchar](255) NULL,
	[file_size] [int] NULL,
	[file_ext] [nvarchar](20) NULL,
	[down_num] [int] NULL,
	[point] [int] NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_DT_ARTICLE_ATTACH] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article_attribute_field]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article_attribute_field](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](100) NULL,
	[title] [nvarchar](100) NULL,
	[control_type] [nvarchar](50) NULL,
	[data_type] [nvarchar](50) NULL,
	[data_length] [int] NULL,
	[data_place] [tinyint] NULL,
	[item_option] [ntext] NULL,
	[default_value] [ntext] NULL,
	[is_required] [tinyint] NULL,
	[is_password] [tinyint] NULL,
	[is_html] [tinyint] NULL,
	[editor_type] [tinyint] NULL,
	[valid_tip_msg] [nvarchar](255) NULL,
	[valid_error_msg] [nvarchar](255) NULL,
	[valid_pattern] [nvarchar](500) NULL,
	[sort_id] [int] NULL,
	[is_sys] [tinyint] NULL,
 CONSTRAINT [PK_DT_ARTICLE_ATTRIBUTE_FIELD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article_attribute_value]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article_attribute_value](
	[article_id] [int] NOT NULL,
	[sub_title] [nvarchar](255) NULL,
	[source] [nvarchar](100) NULL,
	[author] [nvarchar](50) NULL,
	[goods_no] [nvarchar](100) NULL,
	[stock_quantity] [int] NULL,
	[market_price] [decimal](9, 2) NULL,
	[sell_price] [decimal](9, 2) NULL,
	[point] [int] NULL,
	[tel] [nvarchar](20) NULL,
	[address] [nvarchar](500) NULL,
	[copyright] [nvarchar](100) NULL,
	[fax] [nvarchar](50) NULL,
	[unit] [nvarchar](50) NULL,
 CONSTRAINT [PK_DT_ARTICLE_ATTRIBUTE_VALUE] PRIMARY KEY CLUSTERED 
(
	[article_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article_category]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article_category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[channel_id] [int] NOT NULL,
	[page_type] [int] NULL,
	[title] [nvarchar](100) NULL,
	[call_index] [nvarchar](50) NULL,
	[parent_id] [int] NULL,
	[class_list] [nvarchar](500) NULL,
	[class_layer] [int] NULL,
	[sort_id] [int] NULL,
	[link_url] [nvarchar](255) NULL,
	[img_url] [nvarchar](255) NULL,
	[content] [ntext] NULL,
	[seo_title] [nvarchar](255) NULL,
	[seo_keywords] [nvarchar](255) NULL,
	[seo_description] [nvarchar](255) NULL,
 CONSTRAINT [PK_DT_ARTICLE_CATEGORY] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_article_comment]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_article_comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[channel_id] [int] NULL,
	[article_id] [int] NULL,
	[parent_id] [int] NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[user_ip] [nvarchar](255) NULL,
	[content] [ntext] NULL,
	[is_lock] [tinyint] NULL,
	[add_time] [datetime] NULL,
	[is_reply] [tinyint] NULL,
	[reply_content] [ntext] NULL,
	[reply_time] [datetime] NULL,
 CONSTRAINT [PK_DT_ARTICLE_COMMENT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_channel]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dt_channel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[site_id] [int] NULL,
	[name] [varchar](50) NULL,
	[title] [varchar](100) NULL,
	[is_albums] [tinyint] NULL,
	[is_attach] [tinyint] NULL,
	[is_spec] [tinyint] NULL,
	[sort_id] [int] NULL,
 CONSTRAINT [PK_DT_CHANNEL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dt_channel_field]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_channel_field](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[channel_id] [int] NULL,
	[field_id] [int] NULL,
 CONSTRAINT [PK_DT_CHANNEL_FIELD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_channel_site]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_channel_site](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[build_path] [nvarchar](100) NULL,
	[templet_path] [nvarchar](100) NULL,
	[domain] [nvarchar](255) NULL,
	[name] [nvarchar](255) NULL,
	[logo] [nvarchar](255) NULL,
	[company] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[tel] [nvarchar](30) NULL,
	[fax] [nvarchar](30) NULL,
	[email] [nvarchar](50) NULL,
	[crod] [nvarchar](100) NULL,
	[copyright] [text] NULL,
	[seo_title] [nvarchar](255) NULL,
	[seo_keyword] [nvarchar](255) NULL,
	[seo_description] [nvarchar](500) NULL,
	[is_default] [tinyint] NULL,
	[sort_id] [int] NULL,
 CONSTRAINT [PK_DT_CHANNEL_SITE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_express]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_express](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[express_code] [nvarchar](100) NULL,
	[express_fee] [decimal](9, 2) NULL,
	[website] [nvarchar](255) NULL,
	[remark] [ntext] NULL,
	[sort_id] [int] NULL,
	[is_lock] [tinyint] NULL,
 CONSTRAINT [PK_DT_EXPRESS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_feedback]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_feedback](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[site_path] [nvarchar](100) NULL,
	[title] [nvarchar](100) NULL,
	[content] [ntext] NULL,
	[user_name] [nvarchar](50) NULL,
	[user_tel] [nvarchar](30) NULL,
	[user_qq] [nvarchar](30) NULL,
	[user_email] [nvarchar](100) NULL,
	[add_time] [datetime] NOT NULL,
	[reply_content] [ntext] NULL,
	[reply_time] [datetime] NULL,
	[is_lock] [tinyint] NOT NULL,
 CONSTRAINT [PK__dt_feedback__6359AB88] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_link]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_link](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[site_path] [nvarchar](100) NULL,
	[title] [nvarchar](255) NULL,
	[user_name] [nvarchar](50) NULL,
	[user_tel] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[site_url] [nvarchar](255) NULL,
	[img_url] [nvarchar](255) NULL,
	[is_image] [int] NOT NULL,
	[sort_id] [int] NOT NULL,
	[is_red] [tinyint] NOT NULL,
	[is_lock] [tinyint] NOT NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK__dt_link__5DA0D232] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_mail_template]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_mail_template](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[call_index] [nvarchar](50) NULL,
	[maill_title] [nvarchar](100) NULL,
	[content] [ntext] NULL,
	[is_sys] [tinyint] NULL,
 CONSTRAINT [PK_DT_MAIL_TEMPLATE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_manager]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_manager](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[role_type] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[password] [nvarchar](100) NULL,
	[salt] [nvarchar](20) NULL,
	[real_name] [nvarchar](50) NULL,
	[telephone] [nvarchar](30) NULL,
	[email] [nvarchar](30) NULL,
	[is_lock] [int] NULL,
	[add_time] [datetime] NULL,
	[categorys] [nvarchar](200) NULL,
 CONSTRAINT [PK_DT_MANAGER] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_manager_log]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_manager_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[action_type] [nvarchar](100) NULL,
	[remark] [nvarchar](255) NULL,
	[user_ip] [nvarchar](30) NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_DT_MANAGER_LOG] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_manager_role]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_manager_role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_name] [nvarchar](100) NULL,
	[role_type] [tinyint] NULL,
	[is_sys] [tinyint] NULL,
 CONSTRAINT [PK_DT_MANAGER_ROLE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_manager_role_value]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_manager_role_value](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NULL,
	[nav_name] [nvarchar](100) NULL,
	[action_type] [nvarchar](50) NULL,
 CONSTRAINT [PK_DT_MANAGER_ROLE_VALUE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_navigation]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_navigation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[channel_id] [int] NULL,
	[nav_type] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[title] [nvarchar](100) NULL,
	[sub_title] [nvarchar](100) NULL,
	[icon_url] [nvarchar](255) NULL,
	[link_url] [nvarchar](255) NULL,
	[sort_id] [int] NULL,
	[is_lock] [tinyint] NULL,
	[remark] [nvarchar](500) NULL,
	[action_type] [nvarchar](500) NULL,
	[is_sys] [tinyint] NULL,
 CONSTRAINT [PK_DT_NAVIGATION] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_order_goods]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_order_goods](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NULL,
	[order_id] [int] NULL,
	[goods_no] [nvarchar](50) NULL,
	[goods_title] [nvarchar](100) NULL,
	[img_url] [nvarchar](255) NULL,
	[spec_text] [text] NULL,
	[goods_price] [decimal](9, 2) NULL,
	[real_price] [decimal](9, 2) NULL,
	[quantity] [int] NULL,
	[point] [int] NULL,
 CONSTRAINT [PK_DT_ORDER_GOODS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_orders]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dt_orders](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[order_no] [nvarchar](100) NULL,
	[trade_no] [nvarchar](100) NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[payment_id] [int] NULL,
	[payment_fee] [decimal](9, 2) NULL,
	[payment_status] [tinyint] NULL,
	[payment_time] [datetime] NULL,
	[express_id] [int] NULL,
	[express_no] [nvarchar](100) NULL,
	[express_fee] [decimal](9, 2) NULL,
	[express_status] [tinyint] NULL,
	[express_time] [datetime] NULL,
	[accept_name] [nvarchar](50) NULL,
	[post_code] [nvarchar](20) NULL,
	[telphone] [nvarchar](30) NULL,
	[mobile] [nvarchar](20) NULL,
	[email] [nvarchar](30) NULL,
	[area] [nvarchar](100) NULL,
	[address] [nvarchar](500) NULL,
	[message] [nvarchar](500) NULL,
	[remark] [nvarchar](500) NULL,
	[is_invoice] [tinyint] NULL,
	[invoice_title] [varchar](100) NULL,
	[invoice_taxes] [decimal](9, 2) NULL,
	[payable_amount] [decimal](9, 2) NULL,
	[real_amount] [decimal](9, 2) NULL,
	[order_amount] [decimal](9, 2) NULL,
	[point] [int] NULL,
	[status] [tinyint] NULL,
	[add_time] [datetime] NULL,
	[confirm_time] [datetime] NULL,
	[complete_time] [datetime] NULL,
 CONSTRAINT [PK_DT_ORDERS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dt_payment]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_payment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[img_url] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[type] [tinyint] NULL,
	[poundage_type] [tinyint] NULL,
	[poundage_amount] [decimal](9, 2) NULL,
	[sort_id] [int] NULL,
	[is_lock] [tinyint] NULL,
	[api_path] [nvarchar](100) NULL,
 CONSTRAINT [PK_DT_PAYMENT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_sms_template]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_sms_template](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[call_index] [nvarchar](50) NULL,
	[content] [ntext] NULL,
	[is_sys] [tinyint] NULL,
 CONSTRAINT [PK_DT_SMS_TEMPLATE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_student]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[school] [nvarchar](50) NULL,
	[score] [nvarchar](50) NULL,
	[re_score] [nvarchar](50) NULL,
	[add_time] [datetime] NULL,
	[teacher_id] [int] NULL,
	[status] [nvarchar](50) NULL,
 CONSTRAINT [PK_STUDENT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_teacher]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_teacher](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[quota] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[add_time] [datetime] NULL,
	[students] [nvarchar](100) NULL,
	[resquota] [nvarchar](50) NULL,
	[direction] [nvarchar](50) NULL,
	[major] [nvarchar](50) NULL,
 CONSTRAINT [PK_TEACHER] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_amount_log]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_amount_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[payment_id] [int] NULL,
	[value] [decimal](9, 2) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_DT_USER_AMOUNT_LOG] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_attach_log]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_attach_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[attach_id] [int] NULL,
	[file_name] [nvarchar](255) NULL,
	[add_time] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_code]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_code](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[type] [nvarchar](20) NULL,
	[str_code] [nvarchar](255) NULL,
	[count] [int] NULL,
	[status] [tinyint] NULL,
	[user_ip] [nvarchar](20) NULL,
	[eff_time] [datetime] NOT NULL,
	[add_time] [datetime] NOT NULL,
 CONSTRAINT [PK_DT_USER_CODE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_group_price]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_group_price](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[article_id] [int] NULL,
	[group_id] [int] NULL,
	[price] [decimal](9, 2) NULL,
 CONSTRAINT [PK_DT_USER_GROUP_PRICE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_groups]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_groups](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[grade] [int] NULL,
	[upgrade_exp] [int] NULL,
	[amount] [decimal](9, 2) NULL,
	[point] [int] NULL,
	[discount] [int] NULL,
	[is_default] [tinyint] NULL,
	[is_upgrade] [tinyint] NULL,
	[is_lock] [tinyint] NULL,
 CONSTRAINT [PK_DT_USER_GROUPS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_login_log]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_login_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[remark] [nvarchar](255) NULL,
	[login_time] [datetime] NULL,
	[login_ip] [nvarchar](50) NULL,
 CONSTRAINT [PK_DT_USER_LOGIN_LOG] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_message]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_message](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type] [tinyint] NULL,
	[post_user_name] [nvarchar](100) NULL,
	[accept_user_name] [nvarchar](100) NULL,
	[is_read] [tinyint] NULL,
	[title] [nvarchar](100) NULL,
	[content] [ntext] NULL,
	[post_time] [datetime] NOT NULL,
	[read_time] [datetime] NULL,
 CONSTRAINT [PK_DT_USER_MESSAGE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_oauth]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_oauth](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[oauth_name] [nvarchar](50) NOT NULL,
	[oauth_access_token] [nvarchar](500) NULL,
	[oauth_openid] [nvarchar](255) NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_DT_USER_OAUTH] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_oauth_app]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_oauth_app](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](100) NULL,
	[img_url] [nvarchar](255) NULL,
	[app_id] [nvarchar](100) NULL,
	[app_key] [nvarchar](500) NULL,
	[remark] [nvarchar](500) NULL,
	[sort_id] [int] NULL,
	[is_lock] [tinyint] NULL,
	[api_path] [nvarchar](255) NULL,
 CONSTRAINT [PK_DT_USER_OAUTH_APP] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_point_log]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_point_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[value] [int] NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
 CONSTRAINT [PK_DT_USER_POINT_LOG] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_user_recharge]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_user_recharge](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[user_name] [nvarchar](100) NULL,
	[recharge_no] [nvarchar](100) NULL,
	[payment_id] [int] NULL,
	[amount] [decimal](9, 2) NULL,
	[status] [tinyint] NULL,
	[add_time] [datetime] NULL,
	[complete_time] [datetime] NULL,
 CONSTRAINT [PK_DT_USER_RECHARGE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dt_users]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dt_users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[group_id] [int] NULL,
	[user_name] [nvarchar](100) NOT NULL,
	[salt] [nvarchar](20) NULL,
	[password] [nvarchar](100) NOT NULL,
	[mobile] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[avatar] [nvarchar](255) NULL,
	[nick_name] [nvarchar](100) NULL,
	[sex] [nvarchar](20) NULL,
	[birthday] [datetime] NULL,
	[telphone] [nvarchar](50) NULL,
	[area] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[qq] [nvarchar](20) NULL,
	[msn] [nvarchar](100) NULL,
	[amount] [decimal](9, 2) NULL,
	[point] [int] NULL,
	[exp] [int] NULL,
	[status] [tinyint] NULL,
	[reg_time] [datetime] NULL,
	[reg_ip] [nvarchar](20) NULL,
 CONSTRAINT [PK_DT_USERS] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no] [nvarchar](50) NULL,
	[town] [nvarchar](50) NULL,
	[village] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
	[birthday] [nvarchar](50) NULL,
	[education] [nvarchar](50) NULL,
	[id_card] [nvarchar](50) NULL,
	[amount] [numeric](18, 0) NULL,
	[type] [nvarchar](50) NULL,
	[level] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[can_amount] [numeric](18, 0) NULL,
	[date] [datetime] NULL,
	[remark] [nvarchar](200) NULL,
	[yh_amount] [numeric](18, 0) NULL,
	[peigu] [numeric](18, 0) NULL,
	[add_time] [datetime] NULL,
	[is_delete] [int] NOT NULL,
	[img_url] [nvarchar](50) NULL,
	[fangkong] [nvarchar](50) NULL,
	[shenqingbiao] [nvarchar](50) NULL,
	[pingzheng] [nvarchar](50) NULL,
	[shenfenzheng] [nvarchar](50) NULL,
 CONSTRAINT [PK_MEMBER] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_member_albums] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_cw_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_cw_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_member_cw_albums] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_exit]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_exit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no] [nvarchar](50) NULL,
	[town] [nvarchar](50) NULL,
	[village] [nvarchar](50) NULL,
	[address] [nvarchar](50) NULL,
	[name] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
	[birthday] [nvarchar](50) NULL,
	[education] [nvarchar](50) NULL,
	[id_card] [nvarchar](50) NULL,
	[amount] [numeric](18, 0) NULL,
	[add_time] [datetime] NULL,
	[status] [tinyint] NULL,
	[exit_time] [datetime] NULL,
	[member_id] [int] NULL,
	[shenqingbiao] [nvarchar](50) NULL,
 CONSTRAINT [PK_EXIT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_exit_albums]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_exit_albums](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[exit_id] [int] NULL,
	[thumb_path] [nvarchar](255) NULL,
	[original_path] [nvarchar](255) NULL,
	[remark] [nvarchar](500) NULL,
	[add_time] [datetime] NULL,
	[link_url] [nvarchar](500) NULL,
 CONSTRAINT [PK_member_exit_albums] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_exit_family]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_exit_family](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
	[relationship] [nvarchar](50) NULL,
	[birthday] [nvarchar](50) NULL,
	[education] [nvarchar](50) NULL,
 CONSTRAINT [PK_member_exit_family] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_family]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_family](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[member_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[gender] [nvarchar](50) NULL,
	[relationship] [nvarchar](50) NULL,
	[birthday] [nvarchar](50) NULL,
	[education] [nvarchar](50) NULL,
 CONSTRAINT [PK_member_family] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[member_level]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_level](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[amount] [numeric](18, 0) NULL,
	[add_time] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[subject]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[sort_id] [int] NULL,
 CONSTRAINT [PK_SUBJECT] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[subject_detail]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subject_detail](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[b_subject] [int] NULL,
	[s_subject] [int] NULL,
	[amount] [numeric](18, 0) NULL,
 CONSTRAINT [PK_SUBJECT_DETAIL] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[village]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[village](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[sort_id] [int] NULL,
 CONSTRAINT [PK_manager_level] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[xiehui]    Script Date: 2018-10-16 10:10:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xiehui](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[name] [nvarchar](50) NULL,
	[village] [nvarchar](50) NULL,
	[town] [nvarchar](50) NULL,
	[person] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[address] [nvarchar](200) NULL,
	[no] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[add_time] [datetime] NULL,
	[salt] [nvarchar](20) NULL,
	[is_lock] [int] NULL,
	[role_id] [int] NULL,
	[role_type] [int] NULL,
	[sort_id] [int] NULL,
 CONSTRAINT [PK_XIEHUI] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[account] ON 

INSERT [dbo].[account] ([id], [xiehui_id], [date], [b_subject], [s_subject], [zhaiyao], [jie], [dai]) VALUES (7, 16, CAST(0xC33E0B00 AS Date), 1, 2, N'', CAST(1000 AS Numeric(18, 0)), CAST(2000 AS Numeric(18, 0)))
INSERT [dbo].[account] ([id], [xiehui_id], [date], [b_subject], [s_subject], [zhaiyao], [jie], [dai]) VALUES (8, 16, CAST(0xC33E0B00 AS Date), 4, 5, N'', CAST(22 AS Numeric(18, 0)), CAST(22 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[account] OFF
SET IDENTITY_INSERT [dbo].[account_albums] ON 

INSERT [dbo].[account_albums] ([id], [account_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (4, 7, N'/upload/201809/25/201809251419319516.png', N'/upload/201809/25/201809251419319516.png', N'', NULL, N'')
INSERT [dbo].[account_albums] ([id], [account_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (5, 8, N'/upload/201809/25/201809251419345141.png', N'/upload/201809/25/201809251419345141.png', N'', NULL, N'')
SET IDENTITY_INSERT [dbo].[account_albums] OFF
SET IDENTITY_INSERT [dbo].[account_manager] ON 

INSERT [dbo].[account_manager] ([id], [parent_id], [name], [type], [sort_id]) VALUES (1, 0, N'城关镇', N'', 99)
INSERT [dbo].[account_manager] ([id], [parent_id], [name], [type], [sort_id]) VALUES (2, 1, N'新星村', NULL, 1)
INSERT [dbo].[account_manager] ([id], [parent_id], [name], [type], [sort_id]) VALUES (3, 1, N'平安村', NULL, 2)
INSERT [dbo].[account_manager] ([id], [parent_id], [name], [type], [sort_id]) VALUES (4, 1, N'赵家河村', NULL, 3)
SET IDENTITY_INSERT [dbo].[account_manager] OFF
SET IDENTITY_INSERT [dbo].[daikuan] ON 

INSERT [dbo].[daikuan] ([id], [name], [level], [gender], [tel], [id_card], [member_no], [can_amount], [amount], [member_amount], [purpose], [lb_person], [lb_person_names], [add_time], [member_id], [status], [reason], [yh_amount], [wh_amount], [zy_amount], [cq_amount], [hk_status], [month], [audit_time], [chanye], [remark]) VALUES (30, N'陈斌', N'2', N'', N'', N'612422198204116630', N'JXC-009', CAST(10000 AS Numeric(18, 0)), CAST(10000 AS Numeric(18, 0)), CAST(1000 AS Numeric(18, 0)), N'种养殖', N'54,51', N'陈海滨,陈世忠', CAST(0x0000A96900E6B680 AS DateTime), 59, 1, NULL, CAST(0 AS Numeric(18, 0)), CAST(12000 AS Numeric(18, 0)), CAST(2000 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), 0, 12, CAST(0x0000A96A0165BE08 AS DateTime), N'1', NULL)
INSERT [dbo].[daikuan] ([id], [name], [level], [gender], [tel], [id_card], [member_no], [can_amount], [amount], [member_amount], [purpose], [lb_person], [lb_person_names], [add_time], [member_id], [status], [reason], [yh_amount], [wh_amount], [zy_amount], [cq_amount], [hk_status], [month], [audit_time], [chanye], [remark]) VALUES (31, N'陈斌', N'3', NULL, N'', N'612422198204116630', N'JXC-009', CAST(10000 AS Numeric(18, 0)), CAST(10000 AS Numeric(18, 0)), CAST(1000 AS Numeric(18, 0)), N'', N'54,51', N'陈海滨,陈世忠', CAST(0x0000A96B009BA466 AS DateTime), 59, 0, NULL, CAST(0 AS Numeric(18, 0)), CAST(12000 AS Numeric(18, 0)), CAST(2000 AS Numeric(18, 0)), CAST(0 AS Numeric(18, 0)), 0, 12, NULL, N'1', NULL)
SET IDENTITY_INSERT [dbo].[daikuan] OFF
SET IDENTITY_INSERT [dbo].[daikuan_albums] ON 

INSERT [dbo].[daikuan_albums] ([id], [daikuan_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (14, 8, N'/upload/201809/12/201809121601009990.png', N'/upload/201809/12/201809121601009990.png', N'', CAST(0x0000A9590107F795 AS DateTime), N'')
INSERT [dbo].[daikuan_albums] ([id], [daikuan_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (15, 8, N'/upload/201809/12/201809121601010440.png', N'/upload/201809/12/201809121601010440.png', N'', CAST(0x0000A9590107F796 AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[daikuan_albums] OFF
SET IDENTITY_INSERT [dbo].[daikuan_chanye] ON 

INSERT [dbo].[daikuan_chanye] ([id], [name], [amount], [add_time]) VALUES (1, N'养羊', CAST(10000 AS Numeric(18, 0)), CAST(0x0000A96A01182468 AS DateTime))
SET IDENTITY_INSERT [dbo].[daikuan_chanye] OFF
SET IDENTITY_INSERT [dbo].[daikuan_repay] ON 

INSERT [dbo].[daikuan_repay] ([id], [daikuan_id], [amount], [add_time]) VALUES (55, 26, CAST(1000 AS Numeric(18, 0)), CAST(0x0000A95B00FC0CA0 AS DateTime))
INSERT [dbo].[daikuan_repay] ([id], [daikuan_id], [amount], [add_time]) VALUES (56, 26, CAST(200 AS Numeric(18, 0)), CAST(0x0000A95B00FC103B AS DateTime))
INSERT [dbo].[daikuan_repay] ([id], [daikuan_id], [amount], [add_time]) VALUES (57, 27, CAST(1000 AS Numeric(18, 0)), CAST(0x0000A95B00FC2807 AS DateTime))
INSERT [dbo].[daikuan_repay] ([id], [daikuan_id], [amount], [add_time]) VALUES (58, 27, CAST(1400 AS Numeric(18, 0)), CAST(0x0000A95B00FC2C5B AS DateTime))
SET IDENTITY_INSERT [dbo].[daikuan_repay] OFF
SET IDENTITY_INSERT [dbo].[daikuan_set] ON 

INSERT [dbo].[daikuan_set] ([id], [xiehui_id], [rate], [over_rate], [amount]) VALUES (1, 16, CAST(20 AS Numeric(18, 0)), CAST(20 AS Numeric(18, 0)), CAST(20000 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[daikuan_set] OFF
SET IDENTITY_INSERT [dbo].[dt_article_attribute_field] ON 

INSERT [dbo].[dt_article_attribute_field] ([id], [name], [title], [control_type], [data_type], [data_length], [data_place], [item_option], [default_value], [is_required], [is_password], [is_html], [editor_type], [valid_tip_msg], [valid_error_msg], [valid_pattern], [sort_id], [is_sys]) VALUES (1, N'tel', N'电话', N'single-text', N'nvarchar(50)', 50, 0, N'', N'', 0, 0, 0, 0, N'', N'', N'', 3, 0)
INSERT [dbo].[dt_article_attribute_field] ([id], [name], [title], [control_type], [data_type], [data_length], [data_place], [item_option], [default_value], [is_required], [is_password], [is_html], [editor_type], [valid_tip_msg], [valid_error_msg], [valid_pattern], [sort_id], [is_sys]) VALUES (4, N'address', N'地址', N'multi-text', N'nvarchar(500)', 500, 0, N'', N'', 0, 0, 0, 0, N'', N'', N'', 4, 0)
INSERT [dbo].[dt_article_attribute_field] ([id], [name], [title], [control_type], [data_type], [data_length], [data_place], [item_option], [default_value], [is_required], [is_password], [is_html], [editor_type], [valid_tip_msg], [valid_error_msg], [valid_pattern], [sort_id], [is_sys]) VALUES (5, N'copyright', N'版权所有', N'single-text', N'nvarchar(100)', 100, 0, N'', N'', 0, 0, 0, 0, N'', N'', N'', 1, 0)
INSERT [dbo].[dt_article_attribute_field] ([id], [name], [title], [control_type], [data_type], [data_length], [data_place], [item_option], [default_value], [is_required], [is_password], [is_html], [editor_type], [valid_tip_msg], [valid_error_msg], [valid_pattern], [sort_id], [is_sys]) VALUES (19, N'fax', N'邮编', N'single-text', N'nvarchar(50)', 50, 0, N'', N'', 0, 0, 0, 0, N'', N'', N'', 5, 0)
INSERT [dbo].[dt_article_attribute_field] ([id], [name], [title], [control_type], [data_type], [data_length], [data_place], [item_option], [default_value], [is_required], [is_password], [is_html], [editor_type], [valid_tip_msg], [valid_error_msg], [valid_pattern], [sort_id], [is_sys]) VALUES (20, N'unit', N'学会秘书长单位', N'single-text', N'nvarchar(50)', 50, 0, N'', N'', 0, 0, 0, 0, N'', N'', N'', 2, 0)
SET IDENTITY_INSERT [dbo].[dt_article_attribute_field] OFF
SET IDENTITY_INSERT [dbo].[dt_channel_site] ON 

INSERT [dbo].[dt_channel_site] ([id], [title], [build_path], [templet_path], [domain], [name], [logo], [company], [address], [tel], [fax], [email], [crod], [copyright], [seo_title], [seo_keyword], [seo_description], [is_default], [sort_id]) VALUES (4, N'默认站点', N'main', N'main', N'', N'西瑞集团', N'', N'西安易达有限公司', N'高新区', N'', N'-', N'', N'', N'', N'', N'', N'', 1, 99)
INSERT [dbo].[dt_channel_site] ([id], [title], [build_path], [templet_path], [domain], [name], [logo], [company], [address], [tel], [fax], [email], [crod], [copyright], [seo_title], [seo_keyword], [seo_description], [is_default], [sort_id]) VALUES (5, N'手机网站', N'mobile', N'main', N'm.dtcms.net', N'西瑞集团', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'让更多的人分享互联网开发技术', 0, 100)
SET IDENTITY_INSERT [dbo].[dt_channel_site] OFF
SET IDENTITY_INSERT [dbo].[dt_express] ON 

INSERT [dbo].[dt_express] ([id], [title], [express_code], [express_fee], [website], [remark], [sort_id], [is_lock]) VALUES (1, N'顺丰快递', N'shunfeng', CAST(24.00 AS Decimal(9, 2)), N'http://www.sf-express.com', N'国内最好的物流公司', 99, 0)
SET IDENTITY_INSERT [dbo].[dt_express] OFF
SET IDENTITY_INSERT [dbo].[dt_link] ON 

INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (1, N'main', N'动软中国', N'', N'', N'', N'http://www.maticsoft.com', N'http://www.maticsoft.com/images/logo/logo12.gif', 1, 99, 1, 0, CAST(0x0000A48D0015CDA4 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (2, N'main', N'读科技', N'', N'', N'', N'http://www.dukeji.com', N'http://www.dukeji.com/Content/themes/base/CMS/images/logo.jpg', 1, 99, 1, 0, CAST(0x0000A48D001C735A AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (3, N'main', N'中国站长网', N'', N'', N'', N'http://www.chinaz.com', N'http://www.chinaz.com/images/chinaz.gif', 1, 99, 1, 0, CAST(0x0000A48D001CAACE AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (4, N'main', N'我要源码站', N'', N'', N'', N'http://www.51aspx.com', N'http://img.51aspx.com/p/images/logo_88x31.gif', 1, 99, 1, 0, CAST(0x0000A48D001E65E1 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (5, N'main', N'懒人图库', N'', N'', N'', N'http://www.lanrentuku.com', N'http://img.lanrentuku.com/img/images/logo88x31.gif', 1, 99, 1, 0, CAST(0x0000A48D00217018 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (6, N'main', N'深圳体验设计专业委员会', N'', N'', N'', N'http://www.uxdc.org', N'http://www.uxdc.org/logo/uxdc_logo.gif', 1, 99, 1, 0, CAST(0x0000A48D00228774 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (7, N'main', N'腾讯CDC', N'', N'', N'', N'http://cdc.tencent.com', N'http://cdc.tencent.com/wp-content/uploads/cdc_logo.gif', 1, 99, 1, 0, CAST(0x0000A48D0022BB96 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (8, N'main', N'视觉同盟', N'', N'', N'', N'http://www.visionunion.com', N'http://www.visionunion.com/help/images/vu_logo.gif', 1, 99, 1, 0, CAST(0x0000A48D0022FCB5 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (9, N'main', N'百度搜索用户体验中心', N'', N'', N'', N'http://ued.baidu.com', N'http://cdc.tencent.com/wp-content/uploads/2015/02/ued.baidu_.com_.jpg', 1, 99, 1, 0, CAST(0x0000A48D00240099 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (10, N'main', N'蓝色理想', N'', N'', N'', N'http://www.blueidea.com', N'http://www.blueidea.com/logo.gif', 1, 99, 1, 0, CAST(0x0000A48D0024A247 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (11, N'main', N'盒子UI设计', N'', N'', N'', N'http://www.boxui.com', N'', 0, 99, 1, 0, CAST(0x0000A48D00255466 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (12, N'main', N'图标下载', N'', N'', N'', N'http://www.easyicon.net/', N'', 0, 99, 1, 0, CAST(0x0000A48D00258403 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (13, N'main', N'素材天下', N'', N'', N'', N'http://www.sucaitianxia.com', N'', 0, 99, 1, 0, CAST(0x0000A48D0025BF3C AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (14, N'main', N'设计联盟', N'', N'', N'', N'http://www.cndu.cn', N'', 0, 99, 1, 0, CAST(0x0000A48D0025E484 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (15, N'main', N'插画中国', N'', N'', N'', N'http://www.chahua.org', N'', 0, 99, 1, 0, CAST(0x0000A48D00261835 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (16, N'main', N'设计路上', N'', N'', N'', N'http://www.sj63.com', N'', 0, 99, 1, 0, CAST(0x0000A48D00264A5C AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (17, N'main', N'UI制造者', N'', N'', N'', N'http://www.uimaker.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002676B5 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (18, N'main', N'视觉中国', N'', N'', N'', N'http://www.shijue.me', N'', 0, 99, 1, 0, CAST(0x0000A48D0026CF1E AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (19, N'main', N'美图看看', N'', N'', N'', N'http://kankan.meitu.com', N'', 0, 99, 1, 0, CAST(0x0000A48D0026F9D9 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (20, N'main', N'包装设计网', N'', N'', N'', N'http://www.chndesign.com', N'', 0, 99, 1, 0, CAST(0x0000A48D00272ECD AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (21, N'main', N'火星网', N'', N'', N'', N'http://www.hxsd.com.cn', N'', 0, 99, 1, 0, CAST(0x0000A48D0027B09E AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (22, N'main', N'桌面城市', N'', N'', N'', N'http://www.deskcity.com', N'', 0, 99, 1, 0, CAST(0x0000A48D0027D690 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (23, N'main', N'天堂图片', N'', N'', N'', N'http://www.ivsky.com', N'', 0, 99, 1, 0, CAST(0x0000A48D00280930 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (24, N'main', N'游艺网', N'', N'', N'', N'http://www.game798.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002830A3 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (25, N'main', N'JQuery', N'', N'', N'', N'http://www.jquery.com', N'', 0, 99, 1, 0, CAST(0x0000A48D00287C1C AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (26, N'main', N'dowebok', N'', N'', N'', N'http://www.dowebok.com', N'', 0, 99, 1, 0, CAST(0x0000A48D0028EB91 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (27, N'main', N'前端开发仓库', N'', N'', N'', N'http://code.ciaoca.com', N'', 0, 99, 1, 0, CAST(0x0000A48D00292080 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (28, N'main', N'Discuz社区', N'', N'', N'', N'http://www.discuz.net', N'', 0, 99, 1, 0, CAST(0x0000A48D00299958 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (29, N'main', N'IT之家', N'', N'', N'', N'http://www.ithome.com', N'', 0, 99, 1, 0, CAST(0x0000A48D0029C44A AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (30, N'main', N'中国IT实验室', N'', N'', N'', N'http://www.chinaitlab.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002A1589 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (31, N'main', N'驱动之家', N'', N'', N'', N'http://www.mydrivers.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002A47B0 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (32, N'main', N'雷锋网', N'', N'', N'', N'http://www.leiphone.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002A71AA AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (33, N'main', N'ckplayer视频播放器', N'', N'', N'', N'http://www.ckplayer.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002A983C AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (34, N'main', N'快递查询', N'', N'', N'', N'http://www.kuaidi100.com', N'', 0, 99, 1, 0, CAST(0x0000A48D002AE9E5 AS DateTime))
INSERT [dbo].[dt_link] ([id], [site_path], [title], [user_name], [user_tel], [email], [site_url], [img_url], [is_image], [sort_id], [is_red], [is_lock], [add_time]) VALUES (35, N'main', N'动力启航', N'', N'', N'', N'http://www.dtsoft.net', N'', 0, 99, 1, 0, CAST(0x0000A48D002B09B3 AS DateTime))
SET IDENTITY_INSERT [dbo].[dt_link] OFF
SET IDENTITY_INSERT [dbo].[dt_mail_template] ON 

INSERT [dbo].[dt_mail_template] ([id], [title], [call_index], [maill_title], [content], [is_sys]) VALUES (2, N'注册激活账户邮件', N'regverify', N'激活注册账户(请勿回复此邮件)', N'<p>
	<strong>尊敬的{username}，您好：</strong> 
</p>
<p>
	&nbsp;&nbsp;&nbsp; 欢迎您成为{webname}会员用户，请点击如下的网址进行激活您的会员账户：
</p>
<p>
	&nbsp;&nbsp;&nbsp; <a href="{linkurl}" target="_blank">{linkurl}</a> 
</p>
<hr />
<p>
	此链接有效期为{valid}天，请在{valid}天内点击链接进行注册；如果您从未注册过本站会员，请忽略本邮件；此邮件为系统自动发出，请勿回复。<br />
任何疑问，请拨打客服热线咨询：{webtel}。谢谢您的支持！
</p>
<div style="text-align:right;">
	{webname} {weburl}
</div>', 1)
INSERT [dbo].[dt_mail_template] ([id], [title], [call_index], [maill_title], [content], [is_sys]) VALUES (3, N'用户取回密码', N'getpassword', N'找回密码提示(请勿回复此邮件)', N'<strong>{username}，您好：</strong><br />
<p>
	您在<span style="color:#FF0000;">{webname}</span>点击了“忘记密码”找回申请，故系统自动为您发送了这封邮件。您可以点击以下链接修改您的密码：<br />
<a href="{linkurl}" target="_blank">{linkurl}</a> 
</p>
<hr />
<p>
	此链接有效期为{valid}天，请在{valid}天内点击链接进行修改。如果您不需要修改密码，或者您从未点击过“忘记密码”按钮，请忽略本邮件。<br />
任何疑问，请拨打客服热线咨询：{webtel}。谢谢您的支持！
</p>
<div style="text-align:right;">
	{webname} {weburl}
</div>', 1)
INSERT [dbo].[dt_mail_template] ([id], [title], [call_index], [maill_title], [content], [is_sys]) VALUES (4, N'欢迎新用户邮件', N'welcomemsg', N'欢迎新用户(请勿回复此邮件)', N'<p>
	<strong>尊敬的{username}，您好：</strong> 
</p>
<p>
	&nbsp;&nbsp;&nbsp; 您已成功注册并正式成为{webname}会员用户，请您注意保管好个人账户信息，防止丢失或泄漏。
</p>
<hr />
<p>
	此邮件为系统自动发出，请勿回复本邮件，任何疑问，请拨打客服热线咨询：{webtel}。谢谢您的支持！
</p>
<div style="text-align:right;">
	{webname} {weburl}
</div>', 1)
INSERT [dbo].[dt_mail_template] ([id], [title], [call_index], [maill_title], [content], [is_sys]) VALUES (5, N'订单确认通知', N'order_confirm', N'订单确认通知', N'<p>
	<strong>尊敬的{username}，您好：</strong> 
</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 您在{webname}的一笔订单已确认，订单号为：{orderno}，共计{amount}元，我们会尽快安排发货，请您耐心等待，祝您购物愉快！
</p>
<hr />
<p>
	此邮件为系统自动发出，请勿回复本邮件，任何疑问，请拨打客服热线咨询：{webtel}。谢谢您的支持！
</p>
<div style="text-align:right;">
	{webname} {weburl}
</div>', 1)
INSERT [dbo].[dt_mail_template] ([id], [title], [call_index], [maill_title], [content], [is_sys]) VALUES (6, N'订单发货通知', N'order_express', N'订单发货通知', N'<p>
	<strong>尊敬的{username}，您好：</strong> 
</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 您在{webname}的一笔订单已经发货，订单号为：{orderno}，共计{amount}元，请您注意查收，祝您购物愉快！
</p>
<hr />
<p>
	此邮件为系统自动发出，请勿回复本邮件，任何疑问，请拨打客服热线咨询：{webtel}。谢谢您的支持！
</p>
<div style="text-align:right;">
	{webname} {weburl}
</div>', 1)
INSERT [dbo].[dt_mail_template] ([id], [title], [call_index], [maill_title], [content], [is_sys]) VALUES (7, N'订单完成通知', N'order_complete', N'订单完成通知', N'<p>
	<strong>尊敬的{username}，您好：</strong> 
</p>
<p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 您在{webname}的一笔订单交易完成，订单号为：{orderno}，共计{amount}元，期待您下次光临，祝您购物愉快！
</p>
<hr />
<p>
	此邮件为系统自动发出，请勿回复本邮件，任何疑问，请拨打客服热线咨询：{webtel}。谢谢您的支持！
</p>
<div style="text-align:right;">
	{webname} {weburl}
</div>', 1)
SET IDENTITY_INSERT [dbo].[dt_mail_template] OFF
SET IDENTITY_INSERT [dbo].[dt_manager] ON 

INSERT [dbo].[dt_manager] ([id], [role_id], [role_type], [user_name], [password], [salt], [real_name], [telephone], [email], [is_lock], [add_time], [categorys]) VALUES (6, 1, 1, N'admin', N'87FA6AD6CBFDF3108E4DD6F47F5D04A4', N'24V0XZ', N'超级管理员', N'13800138000', N'info@dtcms.net', 0, CAST(0x0000A45A00E1AC53 AS DateTime), NULL)
INSERT [dbo].[dt_manager] ([id], [role_id], [role_type], [user_name], [password], [salt], [real_name], [telephone], [email], [is_lock], [add_time], [categorys]) VALUES (78, 2, 2, N'test', N'6211B10D2D0D260B', N'DX8BF0', N'', N'', N'', 0, CAST(0x0000A8C00126C49C AS DateTime), N'')
INSERT [dbo].[dt_manager] ([id], [role_id], [role_type], [user_name], [password], [salt], [real_name], [telephone], [email], [is_lock], [add_time], [categorys]) VALUES (107, 1, 1, N'qwe', N'3409245DD6466740', N'JH4R80', N'', N'', N'', 0, CAST(0x0000A953010A0958 AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[dt_manager] OFF
SET IDENTITY_INSERT [dbo].[dt_manager_role] ON 

INSERT [dbo].[dt_manager_role] ([id], [role_name], [role_type], [is_sys]) VALUES (1, N'超级管理组', 1, 1)
INSERT [dbo].[dt_manager_role] ([id], [role_name], [role_type], [is_sys]) VALUES (3, N'村级', 2, 0)
INSERT [dbo].[dt_manager_role] ([id], [role_name], [role_type], [is_sys]) VALUES (4, N'镇级', 2, 0)
INSERT [dbo].[dt_manager_role] ([id], [role_name], [role_type], [is_sys]) VALUES (5, N'县级', 2, 0)
INSERT [dbo].[dt_manager_role] ([id], [role_name], [role_type], [is_sys]) VALUES (6, N'管理员', 2, 0)
SET IDENTITY_INSERT [dbo].[dt_manager_role] OFF
SET IDENTITY_INSERT [dbo].[dt_manager_role_value] ON 

INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (709, 3, N'sys_controller', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (710, 3, N'tuihui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (711, 3, N'member', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (712, 3, N'member', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (713, 3, N'member', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (714, 3, N'member', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (715, 3, N'member', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (716, 3, N'exit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (717, 3, N'exit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (718, 3, N'exit_audit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (719, 3, N'exit_audit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (720, 3, N'daikuan', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (721, 3, N'daikuan_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (722, 3, N'daikuan_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (723, 3, N'daikuan_list', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (724, 3, N'daikuan_list', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (725, 3, N'daikuan_list', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (726, 3, N'daikuan_chanye', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (727, 3, N'daikuan_chanye', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (728, 3, N'daikuan_chanye', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (729, 3, N'daikuan_chanye', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (730, 3, N'daikuan_chanye', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (731, 3, N'account', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (732, 3, N'subject', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (733, 3, N'subject', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (734, 3, N'subject_detail', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (735, 3, N'subject_detail', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (736, 3, N'account_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (737, 3, N'account_manager', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (738, 3, N'account_manager', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (739, 3, N'account_manager', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (740, 3, N'account_manager', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (741, 3, N'statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (742, 3, N'member_statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (743, 3, N'member_statis', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (744, 3, N'total', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (745, 3, N'total', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (746, 3, N'statis_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (747, 3, N'statis_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (748, 3, N'hz_statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (749, 3, N'hz_statis', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1026, 5, N'sys_controller', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1027, 5, N'sys_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1028, 5, N'village', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1029, 5, N'village', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1030, 5, N'village', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1031, 5, N'village', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1032, 5, N'village', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1033, 5, N'xiehui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1034, 5, N'xiehui', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1035, 5, N'xiehui', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1036, 5, N'xiehui', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1037, 5, N'xiehui', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1038, 5, N'xiehui', N'Audit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1039, 5, N'tuihui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1040, 5, N'member', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1041, 5, N'member', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1042, 5, N'member', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1043, 5, N'member', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1044, 5, N'member', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1045, 5, N'daikuan', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1046, 5, N'daikuan_audit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1047, 5, N'daikuan_audit', N'Audit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1048, 5, N'daikuan_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1049, 5, N'daikuan_manager', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1133, 4, N'sys_controller', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1134, 4, N'village', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1135, 4, N'village', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1136, 4, N'village', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1137, 4, N'village', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1138, 4, N'village', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1139, 4, N'xiehui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1140, 4, N'xiehui', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1141, 4, N'xiehui', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1142, 4, N'xiehui', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1143, 4, N'xiehui', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1144, 4, N'xiehui', N'Audit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1145, 4, N'tuihui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1146, 4, N'member', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1147, 4, N'member', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1148, 4, N'member', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1149, 4, N'member', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1150, 4, N'member', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1151, 4, N'exit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1152, 4, N'exit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1153, 4, N'exit_audit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1154, 4, N'exit_audit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1155, 4, N'exit_audits', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1156, 4, N'exit_audits', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1157, 4, N'daikuan', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1158, 4, N'daikuan_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1159, 4, N'daikuan_list', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1160, 4, N'daikuan_list', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1161, 4, N'daikuan_list', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1162, 4, N'daikuan_audit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1163, 4, N'daikuan_audit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1164, 4, N'daikuan_audit', N'Audit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1165, 4, N'daikuan_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1166, 4, N'daikuan_manager', N'View')
GO
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1167, 4, N'daikuan_chanye', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1168, 4, N'daikuan_chanye', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1169, 4, N'huankuan', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1170, 4, N'huankuan', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1171, 4, N'account', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1172, 4, N'daikuan_set', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1173, 4, N'daikuan_set', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1174, 4, N'daikuan_set', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1175, 4, N'daikuan_set', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1176, 4, N'daikuan_set', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1177, 4, N'subject', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1178, 4, N'subject', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1179, 4, N'subject', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1180, 4, N'subject', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1181, 4, N'subject', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1182, 4, N'subject_detail', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1183, 4, N'subject_detail', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1184, 4, N'account_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1185, 4, N'account_manager', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1186, 4, N'account_manager', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1187, 4, N'account_manager', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1188, 4, N'account_manager', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1189, 4, N'statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1190, 4, N'member_statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1191, 4, N'member_statis', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1192, 4, N'total', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1193, 4, N'total', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1194, 4, N'statis_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1195, 4, N'statis_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1196, 4, N'hz_statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1197, 4, N'hz_statis', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1490, 6, N'sys_controller', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1491, 6, N'sys_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1492, 6, N'village', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1493, 6, N'village', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1494, 6, N'village', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1495, 6, N'village', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1496, 6, N'village', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1497, 6, N'xiehui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1498, 6, N'xiehui', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1499, 6, N'xiehui', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1500, 6, N'xiehui', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1501, 6, N'xiehui', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1502, 6, N'xiehui', N'Audit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1503, 6, N'manager_role', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1504, 6, N'manager_role', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1505, 6, N'manager_role', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1506, 6, N'manager_role', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1507, 6, N'manager_role', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1508, 6, N'tuihui', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1509, 6, N'member', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1510, 6, N'member', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1511, 6, N'member_edit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1512, 6, N'member_edit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1513, 6, N'member_edit', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1514, 6, N'member_edit', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1515, 6, N'member_edit', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1516, 6, N'member_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1517, 6, N'member_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1518, 6, N'member_list', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1519, 6, N'member_list', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1520, 6, N'member_list', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1521, 6, N'member_tz', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1522, 6, N'member_tz', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1523, 6, N'member_level', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1524, 6, N'member_level', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1525, 6, N'member_level', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1526, 6, N'member_level', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1527, 6, N'member_level', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1528, 6, N'exit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1529, 6, N'exit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1530, 6, N'exit_audit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1531, 6, N'exit_audit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1532, 6, N'exit_audits', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1533, 6, N'exit_audits', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1534, 6, N'member_exit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1535, 6, N'member_exit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1536, 6, N'eixt_check', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1537, 6, N'eixt_check', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1538, 6, N'daikuan', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1539, 6, N'daikuan_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1540, 6, N'daikuan_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1541, 6, N'daikuan_list', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1542, 6, N'daikuan_list', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1543, 6, N'daikuan_list', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1544, 6, N'daikuan_zige', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1545, 6, N'daikuan_zige', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1546, 6, N'daikuan_zige', N'Audit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1547, 6, N'daikuan_chanye', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1548, 6, N'daikuan_chanye', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1549, 6, N'daikuan_chanye', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1550, 6, N'daikuan_chanye', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1551, 6, N'daikuan_chanye', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1552, 6, N'daikuan_audit', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1553, 6, N'daikuan_audit', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1554, 6, N'jiandu', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1555, 6, N'jiandu', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1556, 6, N'huankuan', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1557, 6, N'huankuan', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1558, 6, N'account', N'Show')
GO
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1559, 6, N'account_manager', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1560, 6, N'account_manager', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1561, 6, N'account_manager', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1562, 6, N'account_manager', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1563, 6, N'account_manager', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1564, 6, N'daikuan_set', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1565, 6, N'daikuan_set', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1566, 6, N'daikuan_set', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1567, 6, N'daikuan_set', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1568, 6, N'daikuan_set', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1569, 6, N'subject', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1570, 6, N'subject', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1571, 6, N'subject', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1572, 6, N'subject', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1573, 6, N'subject', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1574, 6, N'subject_detail', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1575, 6, N'subject_detail', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1576, 6, N'account_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1577, 6, N'account_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1578, 6, N'account_list', N'Add')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1579, 6, N'account_list', N'Edit')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1580, 6, N'account_list', N'Delete')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1581, 6, N'statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1582, 6, N'member_statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1583, 6, N'member_statis', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1584, 6, N'total', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1585, 6, N'total', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1586, 6, N'statis_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1587, 6, N'statis_list', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1588, 6, N'hz_statis', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1589, 6, N'hz_statis', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1590, 6, N'warn', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1591, 6, N'warn', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1592, 6, N'danger', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1593, 6, N'danger', N'View')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1594, 6, N'warn_list', N'Show')
INSERT [dbo].[dt_manager_role_value] ([id], [role_id], [nav_name], [action_type]) VALUES (1595, 6, N'warn_list', N'View')
SET IDENTITY_INSERT [dbo].[dt_manager_role_value] OFF
SET IDENTITY_INSERT [dbo].[dt_navigation] ON 

INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (4, 0, 0, N'System', N'sys_controller', N'控制面板', N'控制面板', N'/admin/skin/default/nav/sys.png', N'', 103, 0, N'系统默认导航，不可更改导航ID', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (7, 4, 0, N'System', N'sys_manager', N'协会系统', N'', N'', N'', 101, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (9, 7, 0, N'System', N'village', N'村镇管理', N'', N'', N'manager/village_list.aspx', 1, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (10, 7, 0, N'System', N'manager_log', N'管理日志', N'', N'', N'manager/manager_log.aspx', 3, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (11, 4, 0, N'System', N'sys_settings', N'系统管理', N'', N'', N'', 99, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (12, 11, 0, N'System', N'sys_config', N'系统设置', N'', N'', N'settings/sys_config.aspx', 99, 0, N'', N'Show,View,Edit', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (13, 11, 0, N'System', N'sys_plugin_config', N'插件设置', N'', N'', N'settings/plugin_list.aspx', 100, 0, N'', N'Show,View,Build,Instal,Unload', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (14, 11, 0, N'System', N'sys_url_rewrite', N'URL配置', N'', N'', N'settings/url_rewrite_list.aspx', 102, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (19, 4, 0, N'System', N'sys_design', N'界面管理', N'', N'', N'', 100, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (20, 19, 0, N'System', N'sys_site_templet', N'站点模板管理', N'', N'', N'settings/templet_list.aspx', 99, 0, N'', N'Show,View,Add,Edit,Delete,Build', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (21, 19, 0, N'System', N'sys_builder_html', N'生成静态管理', N'', N'', N'settings/builder_html.aspx', 100, 0, N'', N'Show,View,Build', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (22, 19, 0, N'System', N'sys_navigation', N'后台导航管理', N'', N'', N'settings/nav_list.aspx', 102, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (165, 7, 0, N'System', N'xiehui', N'账号管理', N'', N'', N'manager/xiehui_list.aspx', 2, 0, N'', N'Show,View,Add,Edit,Delete,Audit', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (166, 172, 0, N'System', N'member', N'入会管理', N'', N'', N'', 1, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (167, 4, 0, N'System', N'daikuan', N'借贷监测', N'', N'', N'', 103, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (168, 167, 0, N'System', N'daikuan_list', N'借款申请', N'', N'', N'daikuan/daikuan_list.aspx', 1, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (169, 167, 0, N'System', N'daikuan_zige', N'资格审查', N'', N'', N'daikuan/daikuan_audit_list.aspx', 2, 0, N'', N'Show,View,Audit', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (171, 167, 0, N'System', N'daikuan_chanye', N'动因审核', N'', N'', N'daikuan/daikuan_chanye_list.aspx', 3, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (172, 4, 0, N'System', N'tuihui', N'会员动态', N'', N'', N'', 102, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (173, 172, 0, N'System', N'exit', N'退会管理', N'', N'', N'exit/member_exit_list.aspx', 4, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (174, 4, 0, N'System', N'account', N'财务管理', N'', N'', N'', 104, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (175, 174, 0, N'System', N'subject', N'科目管理', N'', N'', N'subject/subject_list.aspx', 99, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (176, 174, 0, N'System', N'account_list', N'账目明细', N'', N'', N'account/account_list.aspx', 101, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (179, 174, 0, N'System', N'subject_detail', N'科目明细', N'', N'', N'statis/subject_detail_list.aspx', 100, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (180, 181, 0, N'System', N'statis_list', N'科目统计', N'', N'', N'statis/subject_statis.aspx', 101, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (181, 4, 0, N'System', N'statis', N'统计分析', N'', N'', N'', 105, 0, N'', N'Show', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (182, 181, 0, N'System', N'hz_statis', N'汇总统计', N'', N'', N'statis/hz_statis.aspx', 102, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (183, 166, 0, N'System', N'member_level', N'授信级别', N'', N'', N'member/member_level_list.aspx', 4, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (184, 167, 0, N'System', N'daikuan_audit', N'借款审批', N'', N'', N'daikuan/daikuan_audit_list.aspx', 4, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (185, 181, 0, N'System', N'member_statis', N'会员统计', N'', N'', N'statis/member_statis.aspx', 99, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (186, 181, 0, N'System', N'total', N'汇总数据', N'', N'', N'statis/total_list.aspx', 100, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (187, 4, 0, N'System', N'warn', N'监测预警', N'', N'', N'', 106, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (188, 187, 0, N'System', N'warn_list', N'风险预警', N'', N'', N'statis/warn_list.aspx', 100, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (189, 187, 0, N'System', N'danger', N'风险监测', N'', N'', N'statis/danger_list.aspx', 99, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (190, 187, 0, N'System', N'danger_manager', N'风险管控', N'', N'', N'', 102, 0, N'', N'', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (191, 167, 0, N'System', N'jiandu', N'监督使用', N'', N'', N'daikuan/jiandu_list.aspx', 5, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (192, 167, 0, N'System', N'huankuan', N'还款管理', N'', N'', N'daikuan/daikuan_manager_list.aspx', 6, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (193, 173, 0, N'System', N'exit_audit', N'退会申请', N'', N'', N'member/exit/exit_edit.aspx', 1, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (194, 173, 0, N'System', N'exit_audits', N'退会审核', N'', N'', N'member/exit/exit_audit_list.aspx', 2, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (195, 173, 0, N'System', N'eixt_check', N'研究核准', N'', N'', N'', 4, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (196, 7, 0, N'System', N'manager_role', N'权限设置', N'', N'', N'manager/role_list.aspx', 99, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (197, 174, 0, N'System', N'daikuan_set', N'占用费比例', N'', N'', N'daikuan/daikuan_set_list.aspx', 99, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (198, 174, 0, N'System', N'account_manager', N'账目台账', N'', N'', N'account/account_manager_list.aspx', 99, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (199, 166, 0, N'System', N'member_tz', N'会员台账', N'', N'', N'member/member_tz.aspx', 3, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (200, 173, 0, N'System', N'member_exit', N'退会会员', N'', N'', N'member/exit/member_exit_list.aspx', 3, 0, N'', N'Show,View', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (201, 166, 0, N'System', N'member_edit', N'入会申请', N'', N'', N'member/member_edit.aspx', 1, 0, N'', N'Show,View,Add,Edit,Delete', 0)
INSERT [dbo].[dt_navigation] ([id], [parent_id], [channel_id], [nav_type], [name], [title], [sub_title], [icon_url], [link_url], [sort_id], [is_lock], [remark], [action_type], [is_sys]) VALUES (202, 166, 0, N'System', N'member_list', N'入会审核', N'', N'', N'member/member_list.aspx', 2, 0, N'', N'Show,View,Add,Edit,Delete', 0)
SET IDENTITY_INSERT [dbo].[dt_navigation] OFF
SET IDENTITY_INSERT [dbo].[dt_payment] ON 

INSERT [dbo].[dt_payment] ([id], [title], [img_url], [remark], [type], [poundage_type], [poundage_amount], [sort_id], [is_lock], [api_path]) VALUES (1, N'货到付款', N'', N'收到商品后进行支付，支持现金和刷卡服务。', 2, 2, CAST(0.00 AS Decimal(9, 2)), 99, 0, N'')
INSERT [dbo].[dt_payment] ([id], [title], [img_url], [remark], [type], [poundage_type], [poundage_amount], [sort_id], [is_lock], [api_path]) VALUES (2, N'账户余额', N'', N'账户余额是客户在您网站上的账户虚拟资金', 1, 2, CAST(0.00 AS Decimal(9, 2)), 100, 0, N'balance')
INSERT [dbo].[dt_payment] ([id], [title], [img_url], [remark], [type], [poundage_type], [poundage_amount], [sort_id], [is_lock], [api_path]) VALUES (3, N'支付宝', N'', N'付款后立即到账，无预付/年费，单笔费率阶梯最低0.7%，无流量限制。<a href="https://www.alipay.com/himalayas/practicality_customer.htm?customer_external_id=C433530444855584111X&market_type=from_agent_contract&pro_codes=61F99645EC0DC4380ADE569DD132AD7A" target="_blank">立即申请</a>', 1, 2, CAST(0.00 AS Decimal(9, 2)), 101, 0, N'alipaypc')
INSERT [dbo].[dt_payment] ([id], [title], [img_url], [remark], [type], [poundage_type], [poundage_amount], [sort_id], [is_lock], [api_path]) VALUES (4, N'财付通', N'', N'费率最低至<span style="color:#FF0000;font-weight: bold;">0.61%</span>，并赠送价值千元企业QQ。<a href="http://union.tenpay.com/mch/mch_register.shtml?sp_suggestuser=1202822001" target="_blank">中小商家签约入口</a>', 1, 2, CAST(0.00 AS Decimal(9, 2)), 102, 0, N'tenpaypc')
SET IDENTITY_INSERT [dbo].[dt_payment] OFF
SET IDENTITY_INSERT [dbo].[dt_sms_template] ON 

INSERT [dbo].[dt_sms_template] ([id], [title], [call_index], [content], [is_sys]) VALUES (1, N'会员验证码短信', N'usercode', N'您的验证码为：{code}，{valid}分钟内有效。', 1)
INSERT [dbo].[dt_sms_template] ([id], [title], [call_index], [content], [is_sys]) VALUES (2, N'欢迎新用户短信', N'welcomemsg', N'欢迎成为{webname}会员，你的用户名为：{username}，注意保管好您的账户信息。', 1)
INSERT [dbo].[dt_sms_template] ([id], [title], [call_index], [content], [is_sys]) VALUES (3, N'订单确认通知', N'order_confirm', N'尊敬的{username}，您在{webname}的订单已确认，订单号为：{orderno}，共计{amount}元，我们会尽快安排发货。', 1)
INSERT [dbo].[dt_sms_template] ([id], [title], [call_index], [content], [is_sys]) VALUES (4, N'订单发货通知', N'order_express', N'尊敬的{username}，您在{webname}的订单已发货，订单号为：{orderno}，请注意查收。', 1)
INSERT [dbo].[dt_sms_template] ([id], [title], [call_index], [content], [is_sys]) VALUES (5, N'订单完成通知', N'order_complete', N'尊敬的{username}，您在{webname}的一笔订单交易完成，订单号为：{orderno}，期待下次光临，祝您购物愉快。', 1)
SET IDENTITY_INSERT [dbo].[dt_sms_template] OFF
SET IDENTITY_INSERT [dbo].[dt_user_groups] ON 

INSERT [dbo].[dt_user_groups] ([id], [title], [grade], [upgrade_exp], [amount], [point], [discount], [is_default], [is_upgrade], [is_lock]) VALUES (1, N'注册会员', 1, 0, CAST(0.00 AS Decimal(9, 2)), 0, 100, 1, 0, 0)
INSERT [dbo].[dt_user_groups] ([id], [title], [grade], [upgrade_exp], [amount], [point], [discount], [is_default], [is_upgrade], [is_lock]) VALUES (2, N'高级会员', 2, 1000, CAST(0.00 AS Decimal(9, 2)), 0, 99, 0, 1, 0)
INSERT [dbo].[dt_user_groups] ([id], [title], [grade], [upgrade_exp], [amount], [point], [discount], [is_default], [is_upgrade], [is_lock]) VALUES (3, N'中级会员', 3, 2000, CAST(1.00 AS Decimal(9, 2)), 10, 98, 0, 1, 0)
INSERT [dbo].[dt_user_groups] ([id], [title], [grade], [upgrade_exp], [amount], [point], [discount], [is_default], [is_upgrade], [is_lock]) VALUES (4, N'钻石会员', 4, 3000, CAST(2.00 AS Decimal(9, 2)), 20, 95, 0, 1, 0)
SET IDENTITY_INSERT [dbo].[dt_user_groups] OFF
SET IDENTITY_INSERT [dbo].[dt_user_oauth_app] ON 

INSERT [dbo].[dt_user_oauth_app] ([id], [title], [img_url], [app_id], [app_key], [remark], [sort_id], [is_lock], [api_path]) VALUES (1, N'用QQ帐号登录', N'/images/oauth/qq.png', N'API Key', N'Secret Key', N'QQ互联开放平台', 99, 0, N'qq')
INSERT [dbo].[dt_user_oauth_app] ([id], [title], [img_url], [app_id], [app_key], [remark], [sort_id], [is_lock], [api_path]) VALUES (2, N'用新浪微博登录', N'/images/oauth/weibo.png', N'API Key', N'Secret Key', N'新浪微博开放平台', 100, 0, N'sina')
INSERT [dbo].[dt_user_oauth_app] ([id], [title], [img_url], [app_id], [app_key], [remark], [sort_id], [is_lock], [api_path]) VALUES (3, N'用淘宝账号登录', N'/images/oauth/taobao.png', N'API Key', N'Secret Key', N'淘宝开放平台', 101, 0, N'taobao')
INSERT [dbo].[dt_user_oauth_app] ([id], [title], [img_url], [app_id], [app_key], [remark], [sort_id], [is_lock], [api_path]) VALUES (4, N'用开心网帐号登录', N'/images/oauth/kaixin.png', N'API Key', N'Secret Key', N'开心网开放平台', 102, 0, N'kaixin')
INSERT [dbo].[dt_user_oauth_app] ([id], [title], [img_url], [app_id], [app_key], [remark], [sort_id], [is_lock], [api_path]) VALUES (5, N'用人人网帐号登录', N'/images/oauth/renren.png', N'API Key', N'Secret Key', N'人人网开放平台', 103, 0, N'renren')
INSERT [dbo].[dt_user_oauth_app] ([id], [title], [img_url], [app_id], [app_key], [remark], [sort_id], [is_lock], [api_path]) VALUES (6, N'用飞信账号登录', N'/images/oauth/feixin.png', N'API Key', N'Secret Key', N'中国移动飞信开放平台', 104, 0, N'feixin')
SET IDENTITY_INSERT [dbo].[dt_user_oauth_app] OFF
SET IDENTITY_INSERT [dbo].[dt_users] ON 

INSERT [dbo].[dt_users] ([id], [group_id], [user_name], [salt], [password], [mobile], [email], [avatar], [nick_name], [sex], [birthday], [telphone], [area], [address], [qq], [msn], [amount], [point], [exp], [status], [reg_time], [reg_ip]) VALUES (1, 1, N'test', N'4B2H04', N'ED60EDEC7283B95C', N'13800138000', N'test@dtcms.net', N'', N'测试', N'保密', NULL, N'', N'', N'', N'', N'', CAST(230.00 AS Decimal(9, 2)), 10, 20, 0, CAST(0x0000A46B01451CE8 AS DateTime), N'127.0.0.1')
SET IDENTITY_INSERT [dbo].[dt_users] OFF
SET IDENTITY_INSERT [dbo].[member] ON 

INSERT [dbo].[member] ([id], [no], [town], [village], [address], [name], [gender], [birthday], [education], [id_card], [amount], [type], [level], [tel], [can_amount], [date], [remark], [yh_amount], [peigu], [add_time], [is_delete], [img_url], [fangkong], [shenqingbiao], [pingzheng], [shenfenzheng]) VALUES (70, N'HJDF-001', N'12', N'33', N'十组', N'吴大周', N'男', N'', N'小学', N'612422197206204415', CAST(500 AS Numeric(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A97A011E26D3 AS DateTime), 0, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[member] ([id], [no], [town], [village], [address], [name], [gender], [birthday], [education], [id_card], [amount], [type], [level], [tel], [can_amount], [date], [remark], [yh_amount], [peigu], [add_time], [is_delete], [img_url], [fangkong], [shenqingbiao], [pingzheng], [shenfenzheng]) VALUES (71, N'HJDF-002', N'12', N'33', N'九组', N'龙艳（李应根）', N'女', N'', N'小学', N'612422197811124443', CAST(0 AS Numeric(18, 0)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A97A011F181E AS DateTime), 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[member] OFF
SET IDENTITY_INSERT [dbo].[member_albums] ON 

INSERT [dbo].[member_albums] ([id], [member_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (5, 68, N'/upload/201810/08/201810081633175556.png', N'/upload/201810/08/201810081633175556.png', N'', CAST(0x0000A9730110EAAF AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[member_albums] OFF
SET IDENTITY_INSERT [dbo].[member_cw_albums] ON 

INSERT [dbo].[member_cw_albums] ([id], [member_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (3, 68, N'/upload/201810/08/201810081633204791.png', N'/upload/201810/08/201810081633204791.png', N'', CAST(0x0000A9730110EAB1 AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[member_cw_albums] OFF
SET IDENTITY_INSERT [dbo].[member_exit] ON 

INSERT [dbo].[member_exit] ([id], [no], [town], [village], [address], [name], [gender], [birthday], [education], [id_card], [amount], [add_time], [status], [exit_time], [member_id], [shenqingbiao]) VALUES (23, N'HJDF-002', N'12', N'28', N'十二组', N'龙艳（李应根）', N'男', N'', N'小学', N'612422197811124443', CAST(0 AS Numeric(18, 0)), CAST(0x0000A97A011F5F7D AS DateTime), 1, CAST(0x0000A97A011F8ED8 AS DateTime), 71, N'')
SET IDENTITY_INSERT [dbo].[member_exit] OFF
SET IDENTITY_INSERT [dbo].[member_exit_albums] ON 

INSERT [dbo].[member_exit_albums] ([id], [exit_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (7, 7, N'/upload/201809/14/201809141518284405.png', N'/upload/201809/14/201809141518284405.png', N'', CAST(0x0000A95B00FC467F AS DateTime), N'')
INSERT [dbo].[member_exit_albums] ([id], [exit_id], [thumb_path], [original_path], [remark], [add_time], [link_url]) VALUES (8, 7, N'/upload/201809/14/201809141518284755.png', N'/upload/201809/14/201809141518284755.png', N'', CAST(0x0000A95B00FC4680 AS DateTime), N'')
SET IDENTITY_INSERT [dbo].[member_exit_albums] OFF
SET IDENTITY_INSERT [dbo].[member_level] ON 

INSERT [dbo].[member_level] ([id], [name], [amount], [add_time]) VALUES (1, N'绿卡会员', CAST(5000 AS Numeric(18, 0)), CAST(0x0000A96A010E14A0 AS DateTime))
INSERT [dbo].[member_level] ([id], [name], [amount], [add_time]) VALUES (2, N'蓝卡会员', CAST(10000 AS Numeric(18, 0)), CAST(0x0000A96A010E2058 AS DateTime))
INSERT [dbo].[member_level] ([id], [name], [amount], [add_time]) VALUES (3, N'金卡会员', CAST(20000 AS Numeric(18, 0)), CAST(0x0000A96A010E2760 AS DateTime))
SET IDENTITY_INSERT [dbo].[member_level] OFF
SET IDENTITY_INSERT [dbo].[subject] ON 

INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (1, 0, N'资产类', N'1', 1)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (2, 1, N'现金', N'2', 2)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (3, 1, N'银行存款', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (4, 0, N'负债', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (5, 4, N'会员入会互助金', N'2', 1)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (6, 4, N'政府拨入互助资金', N'2', 2)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (7, 1, N'借出互助金', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (8, 1, N'待处理逾期互助资金', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (9, 1, N'应收款项', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (10, 1, N'固定资产', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (11, 4, N'政府其它拨款', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (12, 0, N'净资产', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (13, 12, N'净资产', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (14, 0, N'收入', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (15, 14, N'互助金占用费收入', N'2', 2)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (16, 14, N'政府补助收入', N'2', 1)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (17, 14, N'其他收入', N'2', 5)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (18, 0, N'业务活动费用', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (19, 18, N'业务活动支出', N'2', 99)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (20, 14, N'业务管理费收入', N'2', 3)
INSERT [dbo].[subject] ([id], [parent_id], [name], [type], [sort_id]) VALUES (21, 14, N'公益金', N'2', 4)
SET IDENTITY_INSERT [dbo].[subject] OFF
SET IDENTITY_INSERT [dbo].[subject_detail] ON 

INSERT [dbo].[subject_detail] ([id], [b_subject], [s_subject], [amount]) VALUES (1, 1, 2, CAST(10000 AS Numeric(18, 0)))
SET IDENTITY_INSERT [dbo].[subject_detail] OFF
SET IDENTITY_INSERT [dbo].[village] ON 

INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (11, 0, N'城关镇', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (12, 0, N'涧池镇', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (13, 0, N'平梁镇', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (14, 0, N'蒲溪镇', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (15, 0, N'双乳镇', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (16, 0, N'漩涡镇', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (17, 0, N'汉阳镇', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (18, 0, N'双河口镇', 8)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (19, 0, N'观音河镇', 9)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (20, 0, N'铁佛寺镇', 10)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (21, 11, N'新星村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (22, 11, N'平安村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (23, 11, N'赵家河村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (24, 11, N'月河村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (25, 11, N'麒麟村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (26, 11, N'中坝村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (27, 11, N'三元村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (28, 12, N'仁河村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (29, 12, N'栋梁村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (30, 12, N'王家河村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (31, 12, N'麻柳村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (32, 12, N'马鞍桥村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (33, 12, N'东风村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (34, 12, N'紫云村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (35, 12, N'五坪村', 8)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (36, 12, N'五星村', 9)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (37, 13, N'石门寺村 ', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (38, 13, N'蔡家河村 ', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (39, 13, N'二郎村 ', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (40, 13, N'清河村 ', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (41, 13, N'太行村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (42, 13, N'登天村 ', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (43, 13, N'新四村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (44, 13, N'义河村 ', 8)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (45, 13, N'酒店村', 9)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (46, 13, N'长坝村', 10)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (47, 14, N'芹菜沟村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (48, 14, N'天星村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (49, 14, N'胜利村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (50, 14, N'小街村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (51, 15, N'江河村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (52, 15, N'双乳村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (53, 15, N'三同村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (54, 16, N'茨沟村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (55, 16, N'田凤村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (56, 16, N'东河村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (57, 16, N'群英村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (58, 16, N'田堰村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (59, 16, N'中银村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (60, 16, N'金星村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (61, 16, N'龙泉村', 8)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (62, 16, N'双河村', 9)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (63, 16, N'鳌头村', 10)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (64, 16, N'朝阳村', 11)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (65, 16, N'大涨河村', 12)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (66, 16, N'联合村', 13)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (67, 16, N'上七村', 14)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (68, 16, N'塔岭村', 15)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (69, 16, N'渭河村', 16)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (70, 16, N'梓中村', 17)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (71, 17, N'双坪村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (72, 17, N'大坝村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (73, 17, N'笔架村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (74, 17, N'交通村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (75, 17, N'鲤鱼村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (76, 17, N'天池村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (77, 17, N'松林村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (78, 17, N'长新村', 8)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (79, 17, N'白庙村', 9)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (80, 17, N'金红村', 10)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (81, 17, N'磨坝村', 11)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (82, 17, N'长红村', 12)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (83, 18, N'斑竹园村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (84, 18, N'三柳村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (85, 18, N'黄土岗村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (86, 18, N'龙垭村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (87, 18, N'石家沟村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (88, 18, N'幸和村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (89, 18, N'梨树河村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (90, 18, N'凤柳村', 8)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (91, 18, N'黄龙村', 9)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (92, 18, N'火棺子树村', 10)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (93, 18, N'兴春村', 11)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (94, 19, N'合心村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (95, 19, N'水田村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (96, 19, N'进步村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (97, 19, N'药王村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (98, 19, N'观音河村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (99, 19, N'中坪村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (100, 19, N'义兴村', 7)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (101, 20, N'四合村', 1)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (102, 20, N'双喜村', 2)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (103, 20, N'合一村', 3)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (104, 20, N'铜钱村', 4)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (105, 20, N'高峰村', 5)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (106, 20, N'李庄村', 6)
INSERT [dbo].[village] ([id], [parent_id], [name], [sort_id]) VALUES (107, 20, N'集中村', 7)
SET IDENTITY_INSERT [dbo].[village] OFF
SET IDENTITY_INSERT [dbo].[xiehui] ON 

INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (6, 0, N'管理员', N'', N'', N'', N'', N'', N'admin', N'9DDACC9FF2C270A2A8DAEBF89308363A', CAST(0x0000A96100F7FF80 AS DateTime), N'VPB8RN', 0, 1, 2, 100)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (7, 0, N'县级管理员', N'0', N'0', N'', N'', N'', N'guanli', N'8048F5ECD7EB22EF6CC26A3A6F01D55A', CAST(0x0000A97A01011AA0 AS DateTime), N'8R8T48', 0, 6, 2, 99)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (8, 0, N'城关镇', NULL, N'11', NULL, NULL, NULL, N'城关镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (9, 0, N'涧池镇', NULL, N'12', NULL, NULL, NULL, N'涧池镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (10, 0, N'平梁镇', NULL, N'13', NULL, NULL, NULL, N'平梁镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (11, 0, N'蒲溪镇', NULL, N'14', NULL, NULL, NULL, N'蒲溪镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (12, 0, N'双乳镇', NULL, N'15', NULL, NULL, NULL, N'双乳镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (13, 0, N'漩涡镇', NULL, N'16', NULL, NULL, NULL, N'漩涡镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (14, 0, N'汉阳镇', NULL, N'17', NULL, NULL, NULL, N'汉阳镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (15, 0, N'双河口镇', NULL, N'18', NULL, NULL, NULL, N'双河口镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (16, 0, N'观音河镇', NULL, N'19', NULL, NULL, NULL, N'观音河镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (17, 0, N'铁佛寺镇', NULL, N'20', NULL, NULL, NULL, N'铁佛寺镇', N'9DDACC9FF2C270A2A8DAEBF89308363A', NULL, N'VPB8RN', 0, NULL, 2, 10)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (18, 8, N'城关镇新星村协会', N'21', N'11', N'', N'', N'', N'城关镇新星村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (19, 8, N'城关镇平安村协会', N'22', N'11', NULL, NULL, NULL, N'城关镇平安村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (20, 8, N'城关镇赵家河村协会', N'23', N'11', NULL, NULL, NULL, N'城关镇赵家河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (21, 8, N'城关镇月河村协会', N'24', N'11', NULL, NULL, NULL, N'城关镇月河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (22, 8, N'城关镇麒麟村协会', N'25', N'11', NULL, NULL, NULL, N'城关镇麒麟村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (23, 8, N'城关镇中坝村协会', N'26', N'11', NULL, NULL, NULL, N'城关镇中坝村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (24, 8, N'城关镇三元村协会', N'27', N'11', NULL, NULL, NULL, N'城关镇三元村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (25, 9, N'涧池镇仁河村协会', N'28', N'12', NULL, NULL, NULL, N'涧池镇仁河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (26, 9, N'涧池镇栋梁村协会', N'29', N'12', NULL, NULL, NULL, N'涧池镇栋梁村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (27, 9, N'涧池镇王家河村协会', N'30', N'12', NULL, NULL, NULL, N'涧池镇王家河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (28, 9, N'涧池镇麻柳村协会', N'31', N'12', NULL, NULL, NULL, N'涧池镇麻柳村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (29, 9, N'涧池镇马鞍桥村协会', N'32', N'12', NULL, NULL, NULL, N'涧池镇马鞍桥村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (30, 9, N'涧池镇东风村协会', N'33', N'12', NULL, NULL, NULL, N'涧池镇东风村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (31, 9, N'涧池镇紫云村协会', N'34', N'12', NULL, NULL, NULL, N'涧池镇紫云村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (32, 9, N'涧池镇五坪村协会', N'35', N'12', NULL, NULL, NULL, N'涧池镇五坪村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (33, 9, N'涧池镇五星村协会', N'36', N'12', NULL, NULL, NULL, N'涧池镇五星村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (34, 10, N'平梁镇石门寺村 协会', N'37', N'13', NULL, NULL, NULL, N'平梁镇石门寺村 ', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (35, 10, N'平梁镇蔡家河村 协会', N'38', N'13', NULL, NULL, NULL, N'平梁镇蔡家河村 ', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (36, 10, N'平梁镇二郎村 协会', N'39', N'13', NULL, NULL, NULL, N'平梁镇二郎村 ', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (37, 10, N'平梁镇清河村 协会', N'40', N'13', NULL, NULL, NULL, N'平梁镇清河村 ', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (38, 10, N'平梁镇太行村协会', N'41', N'13', NULL, NULL, NULL, N'平梁镇太行村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (39, 10, N'平梁镇登天村 协会', N'42', N'13', NULL, NULL, NULL, N'平梁镇登天村 ', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (40, 10, N'平梁镇新四村协会', N'43', N'13', NULL, NULL, NULL, N'平梁镇新四村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (41, 10, N'平梁镇义河村 协会', N'44', N'13', NULL, NULL, NULL, N'平梁镇义河村 ', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (42, 10, N'平梁镇酒店村协会', N'45', N'13', NULL, NULL, NULL, N'平梁镇酒店村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (43, 10, N'平梁镇长坝村协会', N'46', N'13', NULL, NULL, NULL, N'平梁镇长坝村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 10)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (44, 11, N'蒲溪镇芹菜沟村协会', N'47', N'14', NULL, NULL, NULL, N'蒲溪镇芹菜沟村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (45, 11, N'蒲溪镇天星村协会', N'48', N'14', NULL, NULL, NULL, N'蒲溪镇天星村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (46, 11, N'蒲溪镇胜利村协会', N'49', N'14', NULL, NULL, NULL, N'蒲溪镇胜利村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (47, 11, N'蒲溪镇小街村协会', N'50', N'14', NULL, NULL, NULL, N'蒲溪镇小街村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (48, 12, N'双乳镇江河村协会', N'51', N'15', NULL, NULL, NULL, N'双乳镇江河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (49, 12, N'双乳镇双乳村协会', N'52', N'15', NULL, NULL, NULL, N'双乳镇双乳村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (50, 12, N'双乳镇三同村协会', N'53', N'15', NULL, NULL, NULL, N'双乳镇三同村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (51, 13, N'漩涡镇茨沟村协会', N'54', N'16', NULL, NULL, NULL, N'漩涡镇茨沟村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (52, 13, N'漩涡镇田凤村协会', N'55', N'16', NULL, NULL, NULL, N'漩涡镇田凤村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (53, 13, N'漩涡镇东河村协会', N'56', N'16', NULL, NULL, NULL, N'漩涡镇东河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (54, 13, N'漩涡镇群英村协会', N'57', N'16', NULL, NULL, NULL, N'漩涡镇群英村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (55, 13, N'漩涡镇田堰村协会', N'58', N'16', NULL, NULL, NULL, N'漩涡镇田堰村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (56, 13, N'漩涡镇中银村协会', N'59', N'16', NULL, NULL, NULL, N'漩涡镇中银村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (57, 13, N'漩涡镇金星村协会', N'60', N'16', NULL, NULL, NULL, N'漩涡镇金星村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (58, 13, N'漩涡镇龙泉村协会', N'61', N'16', NULL, NULL, NULL, N'漩涡镇龙泉村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (59, 13, N'漩涡镇双河村协会', N'62', N'16', NULL, NULL, NULL, N'漩涡镇双河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (60, 13, N'漩涡镇鳌头村协会', N'63', N'16', NULL, NULL, NULL, N'漩涡镇鳌头村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 10)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (61, 13, N'漩涡镇朝阳村协会', N'64', N'16', NULL, NULL, NULL, N'漩涡镇朝阳村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (62, 13, N'漩涡镇大涨河村协会', N'65', N'16', NULL, NULL, NULL, N'漩涡镇大涨河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (63, 13, N'漩涡镇联合村协会', N'66', N'16', NULL, NULL, NULL, N'漩涡镇联合村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 10)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (64, 13, N'漩涡镇上七村协会', N'67', N'16', NULL, NULL, NULL, N'漩涡镇上七村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 11)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (65, 13, N'漩涡镇塔岭村协会', N'68', N'16', NULL, NULL, NULL, N'漩涡镇塔岭村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 12)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (66, 13, N'漩涡镇渭河村协会', N'69', N'16', NULL, NULL, NULL, N'漩涡镇渭河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 13)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (67, 13, N'漩涡镇梓中村协会', N'70', N'16', NULL, NULL, NULL, N'漩涡镇梓中村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 14)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (68, 14, N'汉阳镇双坪村协会', N'71', N'17', NULL, NULL, NULL, N'汉阳镇双坪村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (69, 14, N'汉阳镇大坝村协会', N'72', N'17', NULL, NULL, NULL, N'汉阳镇大坝村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (70, 14, N'汉阳镇笔架村协会', N'73', N'17', NULL, NULL, NULL, N'汉阳镇笔架村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (71, 14, N'汉阳镇交通村协会', N'74', N'17', NULL, NULL, NULL, N'汉阳镇交通村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (72, 14, N'汉阳镇鲤鱼村协会', N'75', N'17', NULL, NULL, NULL, N'汉阳镇鲤鱼村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (73, 14, N'汉阳镇天池村协会', N'76', N'17', NULL, NULL, NULL, N'汉阳镇天池村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (74, 14, N'汉阳镇松林村协会', N'77', N'17', NULL, NULL, NULL, N'汉阳镇松林村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (75, 14, N'汉阳镇长新村协会', N'78', N'17', NULL, NULL, NULL, N'汉阳镇长新村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (76, 14, N'汉阳镇白庙村协会', N'79', N'17', NULL, NULL, NULL, N'汉阳镇白庙村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (77, 14, N'汉阳镇金红村协会', N'80', N'17', NULL, NULL, NULL, N'汉阳镇金红村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 10)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (78, 14, N'汉阳镇磨坝村协会', N'81', N'17', NULL, NULL, NULL, N'汉阳镇磨坝村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (79, 14, N'汉阳镇长红村协会', N'82', N'17', NULL, NULL, NULL, N'汉阳镇长红村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (80, 15, N'双河口镇斑竹园村协会', N'83', N'18', NULL, NULL, NULL, N'双河口镇斑竹园村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (81, 15, N'双河口镇三柳村协会', N'84', N'18', NULL, NULL, NULL, N'双河口镇三柳村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (82, 15, N'双河口镇黄土岗村协会', N'85', N'18', NULL, NULL, NULL, N'双河口镇黄土岗村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (83, 15, N'双河口镇龙垭村协会', N'86', N'18', NULL, NULL, NULL, N'双河口镇龙垭村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (84, 15, N'双河口镇石家沟村协会', N'87', N'18', NULL, NULL, NULL, N'双河口镇石家沟村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (85, 15, N'双河口镇幸和村协会', N'88', N'18', NULL, NULL, NULL, N'双河口镇幸和村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (86, 15, N'双河口镇梨树河村协会', N'89', N'18', NULL, NULL, NULL, N'双河口镇梨树河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (87, 15, N'双河口镇凤柳村协会', N'90', N'18', NULL, NULL, NULL, N'双河口镇凤柳村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (88, 15, N'双河口镇黄龙村协会', N'91', N'18', NULL, NULL, NULL, N'双河口镇黄龙村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 9)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (89, 15, N'双河口镇火棺子树村协会', N'92', N'18', NULL, NULL, NULL, N'双河口镇火棺子树村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 10)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (90, 15, N'双河口镇兴春村协会', N'93', N'18', NULL, NULL, NULL, N'双河口镇兴春村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 8)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (91, 16, N'观音河镇合心村协会', N'94', N'19', NULL, NULL, NULL, N'观音河镇合心村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (92, 16, N'观音河镇水田村协会', N'95', N'19', NULL, NULL, NULL, N'观音河镇水田村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (93, 16, N'观音河镇进步村协会', N'96', N'19', NULL, NULL, NULL, N'观音河镇进步村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (94, 16, N'观音河镇药王村协会', N'97', N'19', NULL, NULL, NULL, N'观音河镇药王村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (95, 16, N'观音河镇观音河村协会', N'98', N'19', NULL, NULL, NULL, N'观音河镇观音河村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (96, 16, N'观音河镇中坪村协会', N'99', N'19', NULL, NULL, NULL, N'观音河镇中坪村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (97, 16, N'观音河镇义兴村协会', N'100', N'19', NULL, NULL, NULL, N'观音河镇义兴村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (98, 17, N'铁佛寺镇四合村协会', N'101', N'20', NULL, NULL, NULL, N'铁佛寺镇四合村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 1)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (99, 17, N'铁佛寺镇双喜村协会', N'102', N'20', NULL, NULL, NULL, N'铁佛寺镇双喜村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 2)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (100, 17, N'铁佛寺镇合一村协会', N'103', N'20', NULL, NULL, NULL, N'铁佛寺镇合一村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 3)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (101, 17, N'铁佛寺镇铜钱村协会', N'104', N'20', NULL, NULL, NULL, N'铁佛寺镇铜钱村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 4)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (102, 17, N'铁佛寺镇高峰村协会', N'105', N'20', NULL, NULL, NULL, N'铁佛寺镇高峰村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 5)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (103, 17, N'铁佛寺镇李庄村协会', N'106', N'20', NULL, NULL, NULL, N'铁佛寺镇李庄村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 6)
INSERT [dbo].[xiehui] ([id], [parent_id], [name], [village], [town], [person], [tel], [address], [no], [password], [add_time], [salt], [is_lock], [role_id], [role_type], [sort_id]) VALUES (104, 17, N'铁佛寺镇集中村协会', N'107', N'20', NULL, NULL, NULL, N'铁佛寺镇集中村', N'46FA80CA76AEDBBF89F11EC5C023D945', NULL, N'VPB8RN', 0, 3, 2, 7)
GO
SET IDENTITY_INSERT [dbo].[xiehui] OFF
/****** Object:  Index [PK_DAIKUAN]    Script Date: 2018-10-16 10:10:48 ******/
ALTER TABLE [dbo].[daikuan] ADD  CONSTRAINT [PK_DAIKUAN] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DAIKUAN_CHANYE]    Script Date: 2018-10-16 10:10:48 ******/
ALTER TABLE [dbo].[daikuan_chanye] ADD  CONSTRAINT [PK_DAIKUAN_CHANYE] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DAIKUAN_MANAGER]    Script Date: 2018-10-16 10:10:48 ******/
ALTER TABLE [dbo].[daikuan_manager] ADD  CONSTRAINT [PK_DAIKUAN_MANAGER] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_DAIKUAN_SET]    Script Date: 2018-10-16 10:10:48 ******/
ALTER TABLE [dbo].[daikuan_set] ADD  CONSTRAINT [PK_DAIKUAN_SET] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PK_MEMBER_LEVEL]    Script Date: 2018-10-16 10:10:48 ******/
ALTER TABLE [dbo].[member_level] ADD  CONSTRAINT [PK_MEMBER_LEVEL] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[account_manager] ADD  CONSTRAINT [DF_account_manager_sort_id]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[daikuan] ADD  CONSTRAINT [DF_daikuan_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[daikuan] ADD  CONSTRAINT [DF_daikuan_status]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[daikuan_albums] ADD  CONSTRAINT [DF__dt_daikuan__artic__5887175A]  DEFAULT ((0)) FOR [daikuan_id]
GO
ALTER TABLE [dbo].[daikuan_albums] ADD  CONSTRAINT [DF__dt_daikuan__thumb__597B3B93]  DEFAULT ('') FOR [thumb_path]
GO
ALTER TABLE [dbo].[daikuan_albums] ADD  CONSTRAINT [DF__dt_daikuan__origi__5A6F5FCC]  DEFAULT ('') FOR [original_path]
GO
ALTER TABLE [dbo].[daikuan_albums] ADD  CONSTRAINT [DF__dt_daikuan__remar__5B638405]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[daikuan_albums] ADD  CONSTRAINT [DF__dt_daikuan__add_t__5C57A83E]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[daikuan_audit] ADD  CONSTRAINT [DF_daikuan_audit_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[daikuan_chanye] ADD  CONSTRAINT [DF_daikuan_chanye_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[daikuan_manager] ADD  CONSTRAINT [DF_daikuan_manager_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__chann__44801EAD]  DEFAULT ((0)) FOR [channel_id]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__categ__457442E6]  DEFAULT ((0)) FOR [category_id]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__call___4668671F]  DEFAULT ('') FOR [call_index]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__link___475C8B58]  DEFAULT ('') FOR [link_url]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__img_u__4850AF91]  DEFAULT ('') FOR [img_url]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__seo_t__4944D3CA]  DEFAULT ('') FOR [seo_title]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__seo_k__4A38F803]  DEFAULT ('') FOR [seo_keywords]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__seo_d__4B2D1C3C]  DEFAULT ('') FOR [seo_description]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__zhaiy__4C214075]  DEFAULT ('') FOR [zhaiyao]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__sort___4D1564AE]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__click__4E0988E7]  DEFAULT ((0)) FOR [click]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__statu__4EFDAD20]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__is_ms__4FF1D159]  DEFAULT ((0)) FOR [is_msg]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__is_to__50E5F592]  DEFAULT ((0)) FOR [is_top]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__is_re__51DA19CB]  DEFAULT ((0)) FOR [is_red]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__is_ho__52CE3E04]  DEFAULT ((0)) FOR [is_hot]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__is_sl__53C2623D]  DEFAULT ((0)) FOR [is_slide]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__is_sy__54B68676]  DEFAULT ((0)) FOR [is_sys]
GO
ALTER TABLE [dbo].[dt_article] ADD  CONSTRAINT [DF__dt_articl__add_t__55AAAAAF]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_article_albums] ADD  CONSTRAINT [DF__dt_articl__artic__5887175A]  DEFAULT ((0)) FOR [article_id]
GO
ALTER TABLE [dbo].[dt_article_albums] ADD  CONSTRAINT [DF__dt_articl__thumb__597B3B93]  DEFAULT ('') FOR [thumb_path]
GO
ALTER TABLE [dbo].[dt_article_albums] ADD  CONSTRAINT [DF__dt_articl__origi__5A6F5FCC]  DEFAULT ('') FOR [original_path]
GO
ALTER TABLE [dbo].[dt_article_albums] ADD  CONSTRAINT [DF__dt_articl__remar__5B638405]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_article_albums] ADD  CONSTRAINT [DF__dt_articl__add_t__5C57A83E]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__artic__5F3414E9]  DEFAULT ((0)) FOR [article_id]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__file___60283922]  DEFAULT ('') FOR [file_name]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__file___611C5D5B]  DEFAULT ('') FOR [file_path]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__file___62108194]  DEFAULT ((0)) FOR [file_size]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__file___6304A5CD]  DEFAULT ('') FOR [file_ext]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__down___63F8CA06]  DEFAULT ((0)) FOR [down_num]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__point__64ECEE3F]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[dt_article_attach] ADD  CONSTRAINT [DF__dt_articl__add_t__65E11278]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__title__68BD7F23]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__data___69B1A35C]  DEFAULT ((0)) FOR [data_length]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__data___6AA5C795]  DEFAULT ((0)) FOR [data_place]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__item___6B99EBCE]  DEFAULT ('') FOR [item_option]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__defau__6C8E1007]  DEFAULT ('') FOR [default_value]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__is_re__6D823440]  DEFAULT ((0)) FOR [is_required]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__is_pa__6E765879]  DEFAULT ((0)) FOR [is_password]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__is_ht__6F6A7CB2]  DEFAULT ((0)) FOR [is_html]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__edito__705EA0EB]  DEFAULT ((0)) FOR [editor_type]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__valid__7152C524]  DEFAULT ('') FOR [valid_tip_msg]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__valid__7246E95D]  DEFAULT ('') FOR [valid_error_msg]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__valid__733B0D96]  DEFAULT ('') FOR [valid_pattern]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__sort___742F31CF]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_article_attribute_field] ADD  CONSTRAINT [DF__dt_articl__is_sy__75235608]  DEFAULT ((0)) FOR [is_sys]
GO
ALTER TABLE [dbo].[dt_article_attribute_value] ADD  CONSTRAINT [DF_dt_article_attribute_value_stock_quantity]  DEFAULT ((0)) FOR [stock_quantity]
GO
ALTER TABLE [dbo].[dt_article_attribute_value] ADD  CONSTRAINT [DF_dt_article_attribute_value_market_price]  DEFAULT ((0)) FOR [market_price]
GO
ALTER TABLE [dbo].[dt_article_attribute_value] ADD  CONSTRAINT [DF_dt_article_attribute_value_sell_price]  DEFAULT ((0)) FOR [sell_price]
GO
ALTER TABLE [dbo].[dt_article_attribute_value] ADD  CONSTRAINT [DF_dt_article_attribute_value_point]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF_dt_article_category_page_type_1]  DEFAULT ((2)) FOR [page_type]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__call___7FA0E47B]  DEFAULT ('') FOR [call_index]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__paren__009508B4]  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF_dt_article_category_class_layer]  DEFAULT ((0)) FOR [class_layer]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__sort___01892CED]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__link___027D5126]  DEFAULT ('') FOR [link_url]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__img_u__0371755F]  DEFAULT ('') FOR [img_url]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__seo_t__04659998]  DEFAULT ('') FOR [seo_title]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__seo_k__0559BDD1]  DEFAULT ('') FOR [seo_keywords]
GO
ALTER TABLE [dbo].[dt_article_category] ADD  CONSTRAINT [DF__dt_articl__seo_d__064DE20A]  DEFAULT ('') FOR [seo_description]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__chann__092A4EB5]  DEFAULT ((0)) FOR [channel_id]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__artic__0A1E72EE]  DEFAULT ((0)) FOR [article_id]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__paren__0B129727]  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__user___0C06BB60]  DEFAULT ((0)) FOR [user_id]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__user___0CFADF99]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__is_lo__0DEF03D2]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__add_t__0EE3280B]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_article_comment] ADD  CONSTRAINT [DF__dt_articl__is_re__0FD74C44]  DEFAULT ((0)) FOR [is_reply]
GO
ALTER TABLE [dbo].[dt_channel] ADD  CONSTRAINT [DF__dt_channel__name__2101D846]  DEFAULT ('') FOR [name]
GO
ALTER TABLE [dbo].[dt_channel] ADD  CONSTRAINT [DF__dt_channe__title__21F5FC7F]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dt_channel] ADD  CONSTRAINT [DF__dt_channe__is_al__22EA20B8]  DEFAULT ((0)) FOR [is_albums]
GO
ALTER TABLE [dbo].[dt_channel] ADD  CONSTRAINT [DF__dt_channe__is_at__23DE44F1]  DEFAULT ((0)) FOR [is_attach]
GO
ALTER TABLE [dbo].[dt_channel] ADD  CONSTRAINT [DF__dt_channe__is_sp__24D2692A]  DEFAULT ((0)) FOR [is_spec]
GO
ALTER TABLE [dbo].[dt_channel] ADD  CONSTRAINT [DF__dt_channe__sort___25C68D63]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_channel_site] ADD  CONSTRAINT [DF__dt_channe__build__2B7F66B9]  DEFAULT ('') FOR [build_path]
GO
ALTER TABLE [dbo].[dt_channel_site] ADD  CONSTRAINT [DF__dt_channe__templ__2C738AF2]  DEFAULT ('') FOR [templet_path]
GO
ALTER TABLE [dbo].[dt_channel_site] ADD  CONSTRAINT [DF__dt_channe__domai__2D67AF2B]  DEFAULT ('') FOR [domain]
GO
ALTER TABLE [dbo].[dt_channel_site] ADD  CONSTRAINT [DF__dt_channe__is_de__2F4FF79D]  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[dt_channel_site] ADD  CONSTRAINT [DF__dt_channe__sort___30441BD6]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_express] ADD  CONSTRAINT [DF__dt_expres__expre__33208881]  DEFAULT ('') FOR [express_code]
GO
ALTER TABLE [dbo].[dt_express] ADD  CONSTRAINT [DF__dt_expres__expre__3414ACBA]  DEFAULT ((0)) FOR [express_fee]
GO
ALTER TABLE [dbo].[dt_express] ADD  CONSTRAINT [DF__dt_expres__websi__3508D0F3]  DEFAULT ('') FOR [website]
GO
ALTER TABLE [dbo].[dt_express] ADD  CONSTRAINT [DF__dt_expres__remar__35FCF52C]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_express] ADD  CONSTRAINT [DF__dt_expres__sort___36F11965]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_express] ADD  CONSTRAINT [DF__dt_expres__is_lo__37E53D9E]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_feedback] ADD  CONSTRAINT [DF__dt_feedba__add_t__644DCFC1]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_feedback] ADD  CONSTRAINT [DF__dt_feedba__reply__6541F3FA]  DEFAULT ('') FOR [reply_content]
GO
ALTER TABLE [dbo].[dt_feedback] ADD  CONSTRAINT [DF__dt_feedba__is_lo__66361833]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_link] ADD  CONSTRAINT [DF__dt_link__is_imag__5E94F66B]  DEFAULT ((0)) FOR [is_image]
GO
ALTER TABLE [dbo].[dt_link] ADD  CONSTRAINT [DF__dt_link__sort_id__5F891AA4]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_link] ADD  CONSTRAINT [DF__dt_link__is_red__607D3EDD]  DEFAULT ((0)) FOR [is_red]
GO
ALTER TABLE [dbo].[dt_link] ADD  CONSTRAINT [DF__dt_link__add_tim__61716316]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_mail_template] ADD  CONSTRAINT [DF__dt_mail_t__is_sy__3AC1AA49]  DEFAULT ((0)) FOR [is_sys]
GO
ALTER TABLE [dbo].[dt_manager] ADD  CONSTRAINT [DF__dt_manage__role___3D9E16F4]  DEFAULT ((2)) FOR [role_type]
GO
ALTER TABLE [dbo].[dt_manager] ADD  CONSTRAINT [DF__dt_manage__real___3E923B2D]  DEFAULT ('') FOR [real_name]
GO
ALTER TABLE [dbo].[dt_manager] ADD  CONSTRAINT [DF__dt_manage__telep__3F865F66]  DEFAULT ('') FOR [telephone]
GO
ALTER TABLE [dbo].[dt_manager] ADD  CONSTRAINT [DF__dt_manage__email__407A839F]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[dt_manager] ADD  CONSTRAINT [DF__dt_manage__is_lo__416EA7D8]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_manager] ADD  CONSTRAINT [DF__dt_manage__add_t__4262CC11]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_manager_log] ADD  CONSTRAINT [DF__dt_manage__add_t__453F38BC]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_manager_role] ADD  CONSTRAINT [DF__dt_manage__is_sy__481BA567]  DEFAULT ((0)) FOR [is_sys]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__paren__4CE05A84]  DEFAULT ((0)) FOR [parent_id]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__chann__4DD47EBD]  DEFAULT ((0)) FOR [channel_id]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__nav_t__4EC8A2F6]  DEFAULT ('') FOR [nav_type]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_navigat__name__4FBCC72F]  DEFAULT ('') FOR [name]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__title__50B0EB68]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__sub_t__51A50FA1]  DEFAULT ('') FOR [sub_title]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__link___529933DA]  DEFAULT ('') FOR [link_url]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__sort___538D5813]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__is_lo__54817C4C]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__remar__5575A085]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__actio__5669C4BE]  DEFAULT ('') FOR [action_type]
GO
ALTER TABLE [dbo].[dt_navigation] ADD  CONSTRAINT [DF__dt_naviga__is_sy__575DE8F7]  DEFAULT ((0)) FOR [is_sys]
GO
ALTER TABLE [dbo].[dt_order_goods] ADD  CONSTRAINT [DF__dt_order___goods__5A3A55A2]  DEFAULT ((0)) FOR [goods_price]
GO
ALTER TABLE [dbo].[dt_order_goods] ADD  CONSTRAINT [DF__dt_order___real___5B2E79DB]  DEFAULT ((0)) FOR [real_price]
GO
ALTER TABLE [dbo].[dt_order_goods] ADD  CONSTRAINT [DF__dt_order___quant__5C229E14]  DEFAULT ((0)) FOR [quantity]
GO
ALTER TABLE [dbo].[dt_order_goods] ADD  CONSTRAINT [DF__dt_order___point__5D16C24D]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__order__5FF32EF8]  DEFAULT ('') FOR [order_no]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__trade__60E75331]  DEFAULT ('') FOR [trade_no]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__user___61DB776A]  DEFAULT ((0)) FOR [user_id]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__user___62CF9BA3]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__payme__63C3BFDC]  DEFAULT ((0)) FOR [payment_id]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__payme__64B7E415]  DEFAULT ((0)) FOR [payment_fee]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__payme__65AC084E]  DEFAULT ((0)) FOR [payment_status]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__expre__66A02C87]  DEFAULT ((0)) FOR [express_id]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__expre__679450C0]  DEFAULT ('') FOR [express_no]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__expre__688874F9]  DEFAULT ((0)) FOR [express_fee]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__expre__697C9932]  DEFAULT ((0)) FOR [express_status]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__accep__6A70BD6B]  DEFAULT ('') FOR [accept_name]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__post___6B64E1A4]  DEFAULT ('') FOR [post_code]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__telph__6C5905DD]  DEFAULT ('') FOR [telphone]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__mobil__6D4D2A16]  DEFAULT ('') FOR [mobile]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF_dt_orders_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__area__6E414E4F]  DEFAULT ('') FOR [area]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__addre__6F357288]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__messa__702996C1]  DEFAULT ('') FOR [message]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__remar__711DBAFA]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__is_in__7211DF33]  DEFAULT ((0)) FOR [is_invoice]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__invoi__7306036C]  DEFAULT ((0)) FOR [invoice_taxes]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__payab__73FA27A5]  DEFAULT ((0)) FOR [payable_amount]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__real___74EE4BDE]  DEFAULT ((0)) FOR [real_amount]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__order__75E27017]  DEFAULT ((0)) FOR [order_amount]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__point__76D69450]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__statu__77CAB889]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[dt_orders] ADD  CONSTRAINT [DF__dt_orders__add_t__78BEDCC2]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_payment] ADD  CONSTRAINT [DF__dt_paymen__img_u__7B9B496D]  DEFAULT ('') FOR [img_url]
GO
ALTER TABLE [dbo].[dt_payment] ADD  CONSTRAINT [DF__dt_payment__type__7C8F6DA6]  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[dt_payment] ADD  CONSTRAINT [DF__dt_paymen__pound__7D8391DF]  DEFAULT ((1)) FOR [poundage_type]
GO
ALTER TABLE [dbo].[dt_payment] ADD  CONSTRAINT [DF__dt_paymen__pound__7E77B618]  DEFAULT ((0)) FOR [poundage_amount]
GO
ALTER TABLE [dbo].[dt_payment] ADD  CONSTRAINT [DF__dt_paymen__sort___7F6BDA51]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_payment] ADD  CONSTRAINT [DF__dt_paymen__is_lo__015422C3]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_sms_template] ADD  CONSTRAINT [DF__dt_sms_te__title__04308F6E]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dt_sms_template] ADD  CONSTRAINT [DF__dt_sms_te__call___0524B3A7]  DEFAULT ('') FOR [call_index]
GO
ALTER TABLE [dbo].[dt_sms_template] ADD  CONSTRAINT [DF__dt_sms_te__conte__0618D7E0]  DEFAULT ('') FOR [content]
GO
ALTER TABLE [dbo].[dt_sms_template] ADD  CONSTRAINT [DF__dt_sms_te__is_sy__070CFC19]  DEFAULT ((0)) FOR [is_sys]
GO
ALTER TABLE [dbo].[dt_user_amount_log] ADD  CONSTRAINT [DF__dt_user_a__payme__118A8A8C]  DEFAULT ((0)) FOR [payment_id]
GO
ALTER TABLE [dbo].[dt_user_amount_log] ADD  CONSTRAINT [DF__dt_user_a__value__127EAEC5]  DEFAULT ((0)) FOR [value]
GO
ALTER TABLE [dbo].[dt_user_amount_log] ADD  CONSTRAINT [DF__dt_user_a__remar__1372D2FE]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_user_amount_log] ADD  CONSTRAINT [DF__dt_user_a__add_t__1466F737]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_user_attach_log] ADD  CONSTRAINT [DF__dt_user_a__add_t__164F3FA9]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_user_code] ADD  CONSTRAINT [DF__dt_user_c__count__192BAC54]  DEFAULT ((0)) FOR [count]
GO
ALTER TABLE [dbo].[dt_user_code] ADD  CONSTRAINT [DF__dt_user_c__statu__1A1FD08D]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[dt_user_code] ADD  CONSTRAINT [DF__dt_user_c__add_t__1B13F4C6]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_user_group_price] ADD  CONSTRAINT [DF__dt_user_g__artic__1DF06171]  DEFAULT ((0)) FOR [article_id]
GO
ALTER TABLE [dbo].[dt_user_group_price] ADD  CONSTRAINT [DF__dt_user_g__group__1FD8A9E3]  DEFAULT ((0)) FOR [group_id]
GO
ALTER TABLE [dbo].[dt_user_group_price] ADD  CONSTRAINT [DF__dt_user_g__price__20CCCE1C]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__title__23A93AC7]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__grade__249D5F00]  DEFAULT ((0)) FOR [grade]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__upgra__25918339]  DEFAULT ((0)) FOR [upgrade_exp]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__amoun__2685A772]  DEFAULT ((0)) FOR [amount]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__point__2779CBAB]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__is_de__286DEFE4]  DEFAULT ((0)) FOR [is_default]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__is_up__2962141D]  DEFAULT ((1)) FOR [is_upgrade]
GO
ALTER TABLE [dbo].[dt_user_groups] ADD  CONSTRAINT [DF__dt_user_g__is_lo__2A563856]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_user_login_log] ADD  CONSTRAINT [DF__dt_user_l__user___2D32A501]  DEFAULT ('') FOR [user_name]
GO
ALTER TABLE [dbo].[dt_user_login_log] ADD  CONSTRAINT [DF__dt_user_l__remar__2E26C93A]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_user_login_log] ADD  CONSTRAINT [DF__dt_user_l__login__2F1AED73]  DEFAULT (getdate()) FOR [login_time]
GO
ALTER TABLE [dbo].[dt_user_login_log] ADD  CONSTRAINT [DF__dt_user_l__login__300F11AC]  DEFAULT ('') FOR [login_ip]
GO
ALTER TABLE [dbo].[dt_user_message] ADD  CONSTRAINT [DF__dt_user_me__type__32EB7E57]  DEFAULT ((1)) FOR [type]
GO
ALTER TABLE [dbo].[dt_user_message] ADD  CONSTRAINT [DF__dt_user_m__is_re__33DFA290]  DEFAULT ((0)) FOR [is_read]
GO
ALTER TABLE [dbo].[dt_user_message] ADD  CONSTRAINT [DF__dt_user_m__post___34D3C6C9]  DEFAULT (getdate()) FOR [post_time]
GO
ALTER TABLE [dbo].[dt_user_oauth] ADD  CONSTRAINT [DF__dt_user_o__oauth__37B03374]  DEFAULT ('0') FOR [oauth_name]
GO
ALTER TABLE [dbo].[dt_user_oauth] ADD  CONSTRAINT [DF__dt_user_o__add_t__38A457AD]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_user_oauth_app] ADD  CONSTRAINT [DF__dt_user_o__title__3B80C458]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dt_user_oauth_app] ADD  CONSTRAINT [DF__dt_user_o__img_u__3C74E891]  DEFAULT ('') FOR [img_url]
GO
ALTER TABLE [dbo].[dt_user_oauth_app] ADD  CONSTRAINT [DF__dt_user_o__remar__3D690CCA]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[dt_user_oauth_app] ADD  CONSTRAINT [DF__dt_user_o__sort___3E5D3103]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_user_oauth_app] ADD  CONSTRAINT [DF__dt_user_o__is_lo__40457975]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[dt_user_oauth_app] ADD  CONSTRAINT [DF__dt_user_o__api_p__41399DAE]  DEFAULT ('') FOR [api_path]
GO
ALTER TABLE [dbo].[dt_user_point_log] ADD  CONSTRAINT [DF__dt_user_p__add_t__44160A59]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_user_recharge] ADD  CONSTRAINT [DF__dt_user_r__amoun__4BB72C21]  DEFAULT ((0)) FOR [amount]
GO
ALTER TABLE [dbo].[dt_user_recharge] ADD  CONSTRAINT [DF__dt_user_r__statu__4CAB505A]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[dt_user_recharge] ADD  CONSTRAINT [DF__dt_user_r__add_t__4D9F7493]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__mobile__6E0C4425]  DEFAULT ('') FOR [mobile]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__email__6F00685E]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__avatar__6FF48C97]  DEFAULT ('') FOR [avatar]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__nick_n__70E8B0D0]  DEFAULT ('') FOR [nick_name]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__sex__71DCD509]  DEFAULT ('') FOR [sex]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__telpho__72D0F942]  DEFAULT ('') FOR [telphone]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__area__73C51D7B]  DEFAULT ('') FOR [area]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__addres__74B941B4]  DEFAULT ('') FOR [address]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__qq__75AD65ED]  DEFAULT ('') FOR [qq]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__msn__76A18A26]  DEFAULT ('') FOR [msn]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__amount__7795AE5F]  DEFAULT ((0)) FOR [amount]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__point__7889D298]  DEFAULT ((0)) FOR [point]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__exp__797DF6D1]  DEFAULT ((0)) FOR [exp]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__status__7A721B0A]  DEFAULT ((0)) FOR [status]
GO
ALTER TABLE [dbo].[dt_users] ADD  CONSTRAINT [DF__dt_users__reg_ti__7B663F43]  DEFAULT (getdate()) FOR [reg_time]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [DF_member_is_delte]  DEFAULT ((0)) FOR [is_delete]
GO
ALTER TABLE [dbo].[member_albums] ADD  CONSTRAINT [DF_member_albums_daikuan_id]  DEFAULT ((0)) FOR [member_id]
GO
ALTER TABLE [dbo].[member_albums] ADD  CONSTRAINT [DF_member_albums_thumb_path]  DEFAULT ('') FOR [thumb_path]
GO
ALTER TABLE [dbo].[member_albums] ADD  CONSTRAINT [DF_member_albums_original_path]  DEFAULT ('') FOR [original_path]
GO
ALTER TABLE [dbo].[member_albums] ADD  CONSTRAINT [DF_member_albums_remark]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[member_albums] ADD  CONSTRAINT [DF_member_albums_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[member_cw_albums] ADD  CONSTRAINT [DF_member_cw_albums_member_id]  DEFAULT ((0)) FOR [member_id]
GO
ALTER TABLE [dbo].[member_cw_albums] ADD  CONSTRAINT [DF_member_cw_albums_thumb_path]  DEFAULT ('') FOR [thumb_path]
GO
ALTER TABLE [dbo].[member_cw_albums] ADD  CONSTRAINT [DF_member_cw_albums_original_path]  DEFAULT ('') FOR [original_path]
GO
ALTER TABLE [dbo].[member_cw_albums] ADD  CONSTRAINT [DF_member_cw_albums_remark]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[member_cw_albums] ADD  CONSTRAINT [DF_member_cw_albums_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[member_exit] ADD  CONSTRAINT [DF_exit_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[member_exit_albums] ADD  CONSTRAINT [DF_member_exit_albums_daikuan_id]  DEFAULT ((0)) FOR [exit_id]
GO
ALTER TABLE [dbo].[member_exit_albums] ADD  CONSTRAINT [DF_member_exit_albums_thumb_path]  DEFAULT ('') FOR [thumb_path]
GO
ALTER TABLE [dbo].[member_exit_albums] ADD  CONSTRAINT [DF_member_exit_albums_original_path]  DEFAULT ('') FOR [original_path]
GO
ALTER TABLE [dbo].[member_exit_albums] ADD  CONSTRAINT [DF_member_exit_albums_remark]  DEFAULT ('') FOR [remark]
GO
ALTER TABLE [dbo].[member_exit_albums] ADD  CONSTRAINT [DF_member_exit_albums_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[member_level] ADD  CONSTRAINT [DF_member_level_add_time]  DEFAULT (getdate()) FOR [add_time]
GO
ALTER TABLE [dbo].[subject] ADD  CONSTRAINT [DF_subject_sort_id]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[village] ADD  CONSTRAINT [DF_manager_level_sort_id]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[xiehui] ADD  CONSTRAINT [DF_xiehui_is_lock]  DEFAULT ((0)) FOR [is_lock]
GO
ALTER TABLE [dbo].[xiehui] ADD  CONSTRAINT [DF_xiehui_role_type]  DEFAULT ((2)) FOR [role_type]
GO
ALTER TABLE [dbo].[xiehui] ADD  CONSTRAINT [DF_xiehui_sort_id]  DEFAULT ((99)) FOR [sort_id]
GO
ALTER TABLE [dbo].[dt_article_attribute_value]  WITH CHECK ADD  CONSTRAINT [FK_DT_ARTIC_REFERENCE_DT_ARTIC] FOREIGN KEY([article_id])
REFERENCES [dbo].[dt_article] ([id])
GO
ALTER TABLE [dbo].[dt_article_attribute_value] CHECK CONSTRAINT [FK_DT_ARTIC_REFERENCE_DT_ARTIC]
GO
ALTER TABLE [dbo].[dt_channel]  WITH CHECK ADD  CONSTRAINT [FK_DT_CHANN_REFERENCE_DT_CHANN] FOREIGN KEY([site_id])
REFERENCES [dbo].[dt_channel_site] ([id])
GO
ALTER TABLE [dbo].[dt_channel] CHECK CONSTRAINT [FK_DT_CHANN_REFERENCE_DT_CHANN]
GO
ALTER TABLE [dbo].[dt_channel_field]  WITH CHECK ADD  CONSTRAINT [FK_DT_CHANN_REFERENCE_DT_ARTIC] FOREIGN KEY([field_id])
REFERENCES [dbo].[dt_article_attribute_field] ([id])
GO
ALTER TABLE [dbo].[dt_channel_field] CHECK CONSTRAINT [FK_DT_CHANN_REFERENCE_DT_ARTIC]
GO
ALTER TABLE [dbo].[dt_channel_field]  WITH CHECK ADD  CONSTRAINT [FK_DT_CHANN_REFERENCE_DT_CHANN_FIELD] FOREIGN KEY([channel_id])
REFERENCES [dbo].[dt_channel] ([id])
GO
ALTER TABLE [dbo].[dt_channel_field] CHECK CONSTRAINT [FK_DT_CHANN_REFERENCE_DT_CHANN_FIELD]
GO
ALTER TABLE [dbo].[dt_manager_role_value]  WITH CHECK ADD  CONSTRAINT [FK_DT_MANAG_REFERENCE_DT_MANAG_ROLE_VALUE] FOREIGN KEY([role_id])
REFERENCES [dbo].[dt_manager_role] ([id])
GO
ALTER TABLE [dbo].[dt_manager_role_value] CHECK CONSTRAINT [FK_DT_MANAG_REFERENCE_DT_MANAG_ROLE_VALUE]
GO
ALTER TABLE [dbo].[dt_order_goods]  WITH CHECK ADD  CONSTRAINT [FK_DT_ORDER_REFERENCE_DT_ORDER] FOREIGN KEY([order_id])
REFERENCES [dbo].[dt_orders] ([id])
GO
ALTER TABLE [dbo].[dt_order_goods] CHECK CONSTRAINT [FK_DT_ORDER_REFERENCE_DT_ORDER]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N'xiehui_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N'date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目大类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N'b_subject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'科目小类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N's_subject'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'摘要' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N'zhaiyao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'借' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N'jie'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account', @level2type=N'COLUMN',@level2name=N'dai'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums', @level2type=N'COLUMN',@level2name=N'account_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父科目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_manager', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_manager', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'account_manager', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'id_card'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员证号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'member_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'可贷款金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'可贷款金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'member_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款用途' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'purpose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'互助联保人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'lb_person'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态0正常1未审核2锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'已还金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'yh_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'未还金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'wh_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'互助金占用费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'zy_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'超期占用费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'cq_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan', @level2type=N'COLUMN',@level2name=N'audit_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums', @level2type=N'COLUMN',@level2name=N'daikuan_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片相册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'member_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款用途' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'purpose'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属村镇' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'village'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'驳回理由' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'reason'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_audit', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款初始时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'start_date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'已还款金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'未还款金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'wh_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'互助金占用费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'zy_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'超期占用费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'cq_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_manager', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay', @level2type=N'COLUMN',@level2name=N'daikuan_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'已还金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums', @level2type=N'COLUMN',@level2name=N'daikuan_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片相册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_repay_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款利率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_set', @level2type=N'COLUMN',@level2name=N'rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'超期利率' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_set', @level2type=N'COLUMN',@level2name=N'over_rate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'贷款限额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'daikuan_set', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类别ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'category_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'调用别名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'call_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外部链接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'link_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'img_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'seo_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO关健字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'seo_keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'seo_description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'TAG标签逗号分隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'tags'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'内容摘要' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'zhaiyao'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'详细内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'浏览次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'click'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态0正常1未审核2锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否允许评论' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'is_msg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否置顶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'is_top'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否推荐' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'is_red'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否热门' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'is_hot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否幻灯片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'is_slide'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否管理员发布0不是1是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'is_sys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'创建时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'修改时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article', @level2type=N'COLUMN',@level2name=N'update_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums', @level2type=N'COLUMN',@level2name=N'article_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片相册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'article_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件路径' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'file_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小(字节)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'file_size'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件扩展名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'file_ext'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下载次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'down_num'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'积分(正赠送负消费)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attach'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'列名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'控件类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'control_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'data_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段长度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'data_length'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'小数点位数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'data_place'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'选项列表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'item_option'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'default_value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否必填0非必填1必填' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'is_required'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否密码框' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'is_password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否允许HTML' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'is_html'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'编辑器类型0标准型1简洁型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'editor_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'验证提示信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'valid_tip_msg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'验证失败提示信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'valid_error_msg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'验证正则表达式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'valid_pattern'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统默认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field', @level2type=N'COLUMN',@level2name=N'is_sys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展属性表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_field'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父表ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_value', @level2type=N'COLUMN',@level2name=N'article_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'扩展属性表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_attribute_value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类别标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'调用别名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'call_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父类别ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类别ID列表(逗号分隔开)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'class_list'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类别深度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'class_layer'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'URL跳转地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'link_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'img_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'seo_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO关健字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'seo_keywords'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_category', @level2type=N'COLUMN',@level2name=N'seo_description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主表ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'article_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父评论ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'user_ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'评论内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发表时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否已答复' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'is_reply'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'答复内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'reply_content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回复时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_article_comment', @level2type=N'COLUMN',@level2name=N'reply_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'站点ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'site_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否开启相册功能' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'is_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否开启附件功能' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'is_attach'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否开启规格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'is_spec'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统频道表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_field', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_field', @level2type=N'COLUMN',@level2name=N'channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'字段ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_field', @level2type=N'COLUMN',@level2name=N'field_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道属性表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_field'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成目录名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'build_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模板目录名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'templet_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'绑定域名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'domain'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网站名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'网站LOGO' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'logo'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公司名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'company'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'通讯地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'传真号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备案号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'crod'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'版权信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'copyright'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'seo_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO关健字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'seo_keyword'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'SEO描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'seo_description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否默认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'is_default'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'频道分类' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_channel_site'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快递名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物流编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'express_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'配送费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'express_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快递网址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'website'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否不显示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物流快递' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_express'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'调用别名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template', @level2type=N'COLUMN',@level2name=N'call_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template', @level2type=N'COLUMN',@level2name=N'maill_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统默认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template', @level2type=N'COLUMN',@level2name=N'is_sys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮件模板' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_mail_template'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'role_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员类型1超管2系管' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'role_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'6位随机字符串,加密用到' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'salt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'real_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'telephone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员信息表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'action_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'user_ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'操作时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role', @level2type=N'COLUMN',@level2name=N'role_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role', @level2type=N'COLUMN',@level2name=N'role_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否系统默认0否1是' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role', @level2type=N'COLUMN',@level2name=N'is_sys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理角色表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role_value', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role_value', @level2type=N'COLUMN',@level2name=N'role_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导航名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role_value', @level2type=N'COLUMN',@level2name=N'nav_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限类型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role_value', @level2type=N'COLUMN',@level2name=N'action_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理角色权限表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_manager_role_value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属父导航ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属频道ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'channel_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导航类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'nav_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'导航ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'副标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'sub_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图标地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'icon_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'链接地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'link_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否隐藏0显示1隐藏' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'权限资源' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'action_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统默认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation', @level2type=N'COLUMN',@level2name=N'is_sys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统导航菜单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_navigation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'article_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'order_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品货号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'goods_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'goods_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'img_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'规格描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'spec_text'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'商品价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'goods_price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实际价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'real_price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订购数量' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'quantity'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'积分,正数赠送|负数消费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单商品表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_order_goods'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'order_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'交易号担保支付用到' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'trade_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'payment_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付手续费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'payment_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付状态1未支付2已支付' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'payment_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'payment_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快递ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'express_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'快递单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'express_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物流费用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'express_fee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发货状态1未发货2已发货' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'express_status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发货时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'express_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货人姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'accept_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'邮政编码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'post_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'联系电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'telphone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属省市区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收货地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单留言' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否索要发票' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'is_invoice'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发票抬头' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'invoice_title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'税金' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'invoice_taxes'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'应付商品总金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'payable_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'实付商品总金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'real_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单总金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'order_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'积分,正数赠送|负数消费' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单状态1生成订单,2确认订单,3完成订单,4取消订单,5作废订单' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下单时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'确认时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'confirm_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders', @level2type=N'COLUMN',@level2name=N'complete_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'订单表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_orders'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'img_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付类型1线上2线下' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手续费类型1百分比2固定金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'poundage_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手续费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'poundage_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否启用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'API目录名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment', @level2type=N'COLUMN',@level2name=N'api_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_payment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_sms_template', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_sms_template', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'调用别名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_sms_template', @level2type=N'COLUMN',@level2name=N'call_index'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'短信内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_sms_template', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系统默认' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_sms_template', @level2type=N'COLUMN',@level2name=N'is_sys'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机短信模板' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_sms_template'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'payment_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增减值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员金额日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_amount_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log', @level2type=N'COLUMN',@level2name=N'attach_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log', @level2type=N'COLUMN',@level2name=N'file_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'下载时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户下载记录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_attach_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成码类别 password取回密码,register邀请注册' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成的字符串' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'str_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用次数' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'count'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态0未使用1已使用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'user_ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'eff_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户随机码表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_code'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_group_price', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_group_price', @level2type=N'COLUMN',@level2name=N'article_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员组ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_group_price', @level2type=N'COLUMN',@level2name=N'group_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_group_price', @level2type=N'COLUMN',@level2name=N'price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员组价格' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_group_price'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'组别名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员等级值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'grade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'升级经验值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'upgrade_exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认预存款' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默认积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'购物折扣' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'discount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否注册用户组' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'is_default'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否自动升级' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'is_upgrade'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否禁用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员组别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_groups'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log', @level2type=N'COLUMN',@level2name=N'login_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登录IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log', @level2type=N'COLUMN',@level2name=N'login_ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员登录日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_login_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'短信息类型0系统消息1收件箱2发件箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发件人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'post_user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收件人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'accept_user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否查看0未阅1已阅' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'is_read'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'短信息标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'短信息内容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'发送时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'post_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'阅读时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message', @level2type=N'COLUMN',@level2name=N'read_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员短消息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_message'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'开放平台名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'oauth_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'access_token' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'oauth_access_token'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'授权key' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'oauth_openid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'授权时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OAuth授权用户信息' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'标题' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'title'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'显示图片' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'img_url'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AppId' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'app_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AppKey' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'app_key'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否启用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'接口目录' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app', @level2type=N'COLUMN',@level2name=N'api_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OAuth应用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_oauth_app'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'增减积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log', @level2type=N'COLUMN',@level2name=N'value'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注说明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员积分日志表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_point_log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'充值单号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'recharge_no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'payment_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'状态0未完成1已完成' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'完成时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge', @level2type=N'COLUMN',@level2name=N'complete_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户充值表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_user_recharge'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户组ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'group_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'user_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'6位随机字符串,加密用到' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'salt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手机号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'mobile'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户头像' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'avatar'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户昵称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'nick_name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'sex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'telphone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属地区逗号分隔' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'详情地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'QQ号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'qq'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'MSN号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'msn'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账户余额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账户积分' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'point'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'升级经验值' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'exp'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'账户状态,0正常,1待验证,2待审核,3锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'reg_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'注册IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users', @level2type=N'COLUMN',@level2name=N'reg_ip'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'dt_users'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属村镇' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'village'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'id_card'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缴纳会费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'可贷款金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'can_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缴纳会费时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'备注' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'优惠金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'yh_amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums', @level2type=N'COLUMN',@level2name=N'member_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums', @level2type=N'COLUMN',@level2name=N'member_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_cw_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'会员编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'所属村镇' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'village'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'身份证号码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'id_card'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缴纳会费金额' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'amount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'自增ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文章ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums', @level2type=N'COLUMN',@level2name=N'exit_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'缩略图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums', @level2type=N'COLUMN',@level2name=N'thumb_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'原图地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums', @level2type=N'COLUMN',@level2name=N'original_path'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'图片描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums', @level2type=N'COLUMN',@level2name=N'remark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上传时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'附件表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'member_exit_albums'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父科目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subject', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subject', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'类别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subject', @level2type=N'COLUMN',@level2name=N'type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'subject', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父科目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'village', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'village', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'village', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父科目' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'parent_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会名称' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会所属村' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'village'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'镇' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'town'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会负责人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'person'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'负责人电话' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'tel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会账号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'no'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'协会密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'添加时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'add_time'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'6位随机字符串,加密用到' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'salt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否锁定' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'is_lock'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'role_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'管理员类型1超管2系管' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'role_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序数字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'xiehui', @level2type=N'COLUMN',@level2name=N'sort_id'
GO
USE [master]
GO
ALTER DATABASE [HYFP_CUS] SET  READ_WRITE 
GO
