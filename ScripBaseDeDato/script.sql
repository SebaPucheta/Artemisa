USE [master]
GO
/****** Object:  Database [Artemisa]    Script Date: 27/06/2016 15:35:53 ******/
CREATE DATABASE [Artemisa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Artemisa', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Artemisa.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Artemisa_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\Artemisa_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Artemisa] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Artemisa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Artemisa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Artemisa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Artemisa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Artemisa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Artemisa] SET ARITHABORT OFF 
GO
ALTER DATABASE [Artemisa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Artemisa] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Artemisa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Artemisa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Artemisa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Artemisa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Artemisa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Artemisa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Artemisa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Artemisa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Artemisa] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Artemisa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Artemisa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Artemisa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Artemisa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Artemisa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Artemisa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Artemisa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Artemisa] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Artemisa] SET  MULTI_USER 
GO
ALTER DATABASE [Artemisa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Artemisa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Artemisa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Artemisa] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [Artemisa]
GO
/****** Object:  Table [dbo].[Apunte]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Apunte](
	[idApunte] [int] IDENTITY(1,1) NOT NULL,
	[stock] [int] NULL,
	[precioApunte] [float] NOT NULL,
	[cantHoja] [int] NOT NULL,
	[nombreApunte] [varchar](50) NOT NULL,
	[descripcionApunte] [varchar](200) NULL,
	[anoApunte] [int] NOT NULL,
	[codigoBarraApunte] [varchar](50) NULL,
	[idPrecioHoja] [int] NULL,
	[idCategoria] [int] NOT NULL,
	[idTipoApunte] [int] NOT NULL,
	[idEditorial] [int] NOT NULL,
	[idEstado] [int] NULL,
	[idProfesor] [int] NULL,
	[baja] [bit] NOT NULL,
	[idMateria] [int] NOT NULL,
 CONSTRAINT [PK_Apunte_1] PRIMARY KEY CLUSTERED 
(
	[idApunte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Carrera]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Carrera](
	[idCarrera] [int] IDENTITY(1,1) NOT NULL,
	[nombreCarrera] [varchar](50) NOT NULL,
	[baja] [bit] NOT NULL,
	[idFacultad] [int] NOT NULL,
 CONSTRAINT [PK_Carrera] PRIMARY KEY CLUSTERED 
(
	[idCarrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CarreraXMateria]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarreraXMateria](
	[idCarrera] [int] NOT NULL,
	[idMateria] [int] NOT NULL,
 CONSTRAINT [PK_CarreraXMateria] PRIMARY KEY CLUSTERED 
(
	[idCarrera] ASC,
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombreCategoria] [varchar](50) NOT NULL,
	[baja] [bit] NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ciudad]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ciudad](
	[idCiudad] [int] IDENTITY(1,1) NOT NULL,
	[nombreCiudad] [varchar](50) NOT NULL,
	[idProvincia] [int] NOT NULL,
	[baja] [bit] NOT NULL,
 CONSTRAINT [PK_Ciudad] PRIMARY KEY CLUSTERED 
(
	[idCiudad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Editorial]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Editorial](
	[idEditorial] [int] IDENTITY(1,1) NOT NULL,
	[nombreEditorial] [varchar](50) NOT NULL,
	[telefono] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NOT NULL,
	[nombreContacto] [varchar](50) NOT NULL,
	[baja] [bit] NULL,
	[idCiudadEditorial] [int] NOT NULL,
 CONSTRAINT [PK_Editorial] PRIMARY KEY CLUSTERED 
(
	[idEditorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estado](
	[idEstado] [int] IDENTITY(1,1) NOT NULL,
	[nombreEstado] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[idEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facultad]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facultad](
	[idFacultad] [int] IDENTITY(1,1) NOT NULL,
	[nombreFacultad] [varchar](50) NOT NULL,
	[idUniversidad] [int] NOT NULL,
	[baja] [bit] NOT NULL,
	[idCiudad] [int] NOT NULL,
 CONSTRAINT [PK_Facultad] PRIMARY KEY CLUSTERED 
(
	[idFacultad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Libro]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Libro](
	[idLibro] [int] IDENTITY(1,1) NOT NULL,
	[codigoBarraLibro] [varchar](50) NOT NULL,
	[nombreLibro] [varchar](50) NOT NULL,
	[autorLibro] [varchar](50) NOT NULL,
	[descripcionLibro] [varchar](200) NULL,
	[stock] [int] NOT NULL,
	[cantidadHojasLibro] [int] NOT NULL,
	[precioLibro] [float] NOT NULL,
	[idEditorial] [int] NOT NULL,
	[idEstado] [int] NULL,
	[baja] [bit] NOT NULL,
	[idMateria] [int] NOT NULL,
 CONSTRAINT [PK_Libro_1] PRIMARY KEY CLUSTERED 
(
	[idLibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Materia](
	[idMateria] [int] IDENTITY(100,1) NOT NULL,
	[nombreMateria] [varchar](50) NOT NULL,
	[nivelCursado] [int] NOT NULL,
	[descripcionMateria] [varchar](200) NULL,
	[baja] [bit] NOT NULL,
 CONSTRAINT [PK_Materia] PRIMARY KEY CLUSTERED 
(
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MateriaXProfesor]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MateriaXProfesor](
	[idMateria] [int] NOT NULL,
	[idProfesor] [int] NOT NULL,
 CONSTRAINT [PK_MateriaXProfesor] PRIMARY KEY CLUSTERED 
(
	[idMateria] ASC,
	[idProfesor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PrecioXHoja]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioXHoja](
	[idPrecioHoja] [int] IDENTITY(1,1) NOT NULL,
	[precioHoja] [float] NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_PrecioHoja] PRIMARY KEY CLUSTERED 
(
	[idPrecioHoja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profesor](
	[nombreProfesor] [varchar](50) NOT NULL,
	[apellidoProfesor] [varchar](50) NOT NULL,
	[idProfesor] [int] IDENTITY(1,1) NOT NULL,
	[baja] [bit] NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[idProfesor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Provincia](
	[idProvincia] [int] IDENTITY(1,1) NOT NULL,
	[nombreProvincia] [varchar](50) NOT NULL,
	[baja] [bit] NOT NULL,
 CONSTRAINT [PK_Provincia] PRIMARY KEY CLUSTERED 
(
	[idProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoApunte]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoApunte](
	[idTipoApunte] [int] IDENTITY(1,1) NOT NULL,
	[nombreTipoApunte] [varchar](50) NOT NULL,
	[baja] [bit] NULL,
 CONSTRAINT [PK_TipoApunte] PRIMARY KEY CLUSTERED 
(
	[idTipoApunte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Universidad]    Script Date: 27/06/2016 15:35:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Universidad](
	[idUniversidad] [int] IDENTITY(1,1) NOT NULL,
	[nombreUniversidad] [varchar](50) NOT NULL,
	[baja] [bit] NOT NULL,
 CONSTRAINT [PK_Universidad] PRIMARY KEY CLUSTERED 
(
	[idUniversidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Apunte] ON 

INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (4, NULL, 25, 25, N'Diseño', N'PRactico', 2015, N'123456', NULL, 1, 1, 3, NULL, 1, 0, 1)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (5, NULL, 6.25, 25, N'Diseño de Sistemas', N'Practico', 2016, N'234567', 1, 1, 1, 3, NULL, 1, 0, 101)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (6, NULL, 5, 25, N'Diseño de Sistemas', N'Practico', 2015, N'', NULL, 1, 2, 3, NULL, 2, 0, 101)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (7, NULL, 12, 200, N'Analisis de Sistemas', N'ASDASD', 2015, N'', NULL, 1, 2, 3, NULL, 2, 0, 101)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (8, NULL, 50, 200, N'Analisis de Sistemas', N'ASDASD', 2015, N'h234hg34k', 1, 1, 1, 3, NULL, 2, 0, 101)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (9, 0, 5, 51, N'Física 2  Guía de Trabajos Practico ', N'Guía de trabajo practico ', 2014, N'', NULL, 2, 2, 3, NULL, NULL, 0, 102)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (10, 0, 30, 254, N'Algoritmos Y Estructura de Datos', N'Apunte de programación ', 2013, N'', NULL, 3, 2, 3, NULL, 3, 0, 105)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (11, 0, 127, 254, N'Algoritmos Y Estructura de Datos', N'Apunte de programación ', 2013, N'qwesdqw22e', 4, 3, 1, 3, NULL, 3, 0, 105)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (12, 0, 15, 125, N'Ingles 2', N'Apunte de ingles técnico ', 2015, N'', NULL, 1, 2, 3, NULL, 4, 0, 107)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (13, 0, 62.5, 125, N'Ingles 2', N'Apunte de ingles técnico ', 2015, N'dsa32', 4, 1, 1, 3, NULL, 4, 0, 107)
SET IDENTITY_INSERT [dbo].[Apunte] OFF
SET IDENTITY_INSERT [dbo].[Carrera] ON 

INSERT [dbo].[Carrera] ([idCarrera], [nombreCarrera], [baja], [idFacultad]) VALUES (1, N'Ingenieria en Sistemas', 0, 2)
INSERT [dbo].[Carrera] ([idCarrera], [nombreCarrera], [baja], [idFacultad]) VALUES (2, N'Ingeniería Quimica', 0, 2)
INSERT [dbo].[Carrera] ([idCarrera], [nombreCarrera], [baja], [idFacultad]) VALUES (3, N'Ingenieria Civil', 0, 4)
INSERT [dbo].[Carrera] ([idCarrera], [nombreCarrera], [baja], [idFacultad]) VALUES (4, N'Ingenieria Civil', 0, 2)
INSERT [dbo].[Carrera] ([idCarrera], [nombreCarrera], [baja], [idFacultad]) VALUES (5, N'Ingeniería Metalurgica', 0, 2)
SET IDENTITY_INSERT [dbo].[Carrera] OFF
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 101)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 102)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 104)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 105)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 108)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (2, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (2, 108)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (4, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (4, 108)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (5, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (5, 108)
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (1, N'3er Año', 0)
INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (2, N'2do Año', 0)
INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (3, N'1er Año', 0)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[Ciudad] ON 

INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (1, N'Córdoba', 1, 0)
INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (2, N'Villa Maria', 1, 0)
INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (3, N'CABA', 2, 0)
SET IDENTITY_INSERT [dbo].[Ciudad] OFF
SET IDENTITY_INSERT [dbo].[Editorial] ON 

INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (3, N'EDUCO', N'43512321', N'domingobici@gmail.com', N'Maestro M. Lopez 5000', N'Juan Domingo  Bici', 0, 1)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (4, N'Pearson', N'0011232132', N'pearson@pearson.com', N'9 Julio 3432', N'Rogelio', 0, 3)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (5, N'AlfaOmega', N'48117183', N'ventas@alfaomegaeditor.com.ar', N'Paraguay 1307', N'Luis Alberto de la Tapia', 0, 3)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (6, N'Grupo Editorial Patria', N'015553549190', N'info@editorialprada.com.ar', N'Renacimiento 180', N'Javier Enrique Callejas', 0, 3)
SET IDENTITY_INSERT [dbo].[Editorial] OFF
SET IDENTITY_INSERT [dbo].[Facultad] ON 

INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (1, N'Facultad Regional Córdoba', 0, 0, 1)
INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (2, N'Facultad Regional Córdoba', 1, 0, 1)
INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (3, N'Facultad Regional Villa Maria', 2, 0, 2)
INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (4, N'Facultad Regional Villa Maria', 1, 0, 2)
SET IDENTITY_INSERT [dbo].[Facultad] OFF
SET IDENTITY_INSERT [dbo].[Libro] ON 

INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria]) VALUES (1, N'ISBN 978-607-707-920-0', N'Enciclopedia Microsoft Visual Basic ', N'Fco. Javier Ceballos', N'Interfaces gráficas y aplicaciones para internet con Windows Forms y ASP.NET', 0, 1125, 350, 5, 0, 0, 0)
INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria]) VALUES (2, N'0-471-32057-9', N'Física Quinta Edicion Volumen1', N'Robert Resnick', N'Mecánica clasica', 0, 603, 800, 6, NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[Libro] OFF
SET IDENTITY_INSERT [dbo].[Materia] ON 

INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (101, N'Diseño de Sistemas', 3, N'Hardcore', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (102, N'Física 2', 2, N'Física 2 sistemas', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (104, N'Programación de Aplicaciones Visuales ', 3, N'Programación en Visual Basic', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (105, N'Algoritmos y Estructura de Datos', 1, N'Materia de programación en la cual se programa en Phyton', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (107, N'Ingles 2', 3, N'Ingles tecnico', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (108, N'Física 1', 1, N'Mecánica Clasica', 0)
SET IDENTITY_INSERT [dbo].[Materia] OFF
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (101, 1)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (101, 2)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (105, 3)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (107, 4)
SET IDENTITY_INSERT [dbo].[PrecioXHoja] ON 

INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (1, 0.25, CAST(0x0000A62C00000000 AS DateTime))
INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (2, 60, CAST(0x0000A63100000000 AS DateTime))
INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (3, 50, CAST(0x0000A63200000000 AS DateTime))
INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (4, 0.5, CAST(0x0000A63200000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[PrecioXHoja] OFF
SET IDENTITY_INSERT [dbo].[Profesor] ON 

INSERT [dbo].[Profesor] ([nombreProfesor], [apellidoProfesor], [idProfesor], [baja]) VALUES (N'Judith', N'Meles', 1, 0)
INSERT [dbo].[Profesor] ([nombreProfesor], [apellidoProfesor], [idProfesor], [baja]) VALUES (N'Elizabeth', N'Jeinson', 2, 0)
INSERT [dbo].[Profesor] ([nombreProfesor], [apellidoProfesor], [idProfesor], [baja]) VALUES (N'Jorge Pablo', N'Tymoschuk', 3, 0)
INSERT [dbo].[Profesor] ([nombreProfesor], [apellidoProfesor], [idProfesor], [baja]) VALUES (N'Veronica', N'de Loredo', 4, 0)
SET IDENTITY_INSERT [dbo].[Profesor] OFF
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (1, N'Córdoba', 0)
INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (2, N'Buenos Aires', 0)
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[TipoApunte] ON 

INSERT [dbo].[TipoApunte] ([idTipoApunte], [nombreTipoApunte], [baja]) VALUES (1, N'Impreso', 0)
INSERT [dbo].[TipoApunte] ([idTipoApunte], [nombreTipoApunte], [baja]) VALUES (2, N'Digital', 0)
SET IDENTITY_INSERT [dbo].[TipoApunte] OFF
SET IDENTITY_INSERT [dbo].[Universidad] ON 

INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (1, N'Universidad Tecnológica Nacional', 0)
INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (2, N'Universidad Nacional Córdoba', 0)
INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (3, N'Universidad Católica de Córdoba', 0)
INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (4, N'Universidad Provincia Córdoba', 0)
SET IDENTITY_INSERT [dbo].[Universidad] OFF
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Categoria]
GO
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Editorial] FOREIGN KEY([idEditorial])
REFERENCES [dbo].[Editorial] ([idEditorial])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Editorial]
GO
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Estado] FOREIGN KEY([idEstado])
REFERENCES [dbo].[Estado] ([idEstado])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Estado]
GO
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_PrecioHoja] FOREIGN KEY([idPrecioHoja])
REFERENCES [dbo].[PrecioXHoja] ([idPrecioHoja])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_PrecioHoja]
GO
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Profesor] FOREIGN KEY([idProfesor])
REFERENCES [dbo].[Profesor] ([idProfesor])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Profesor]
GO
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_TipoApunte] FOREIGN KEY([idTipoApunte])
REFERENCES [dbo].[TipoApunte] ([idTipoApunte])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_TipoApunte]
GO
ALTER TABLE [dbo].[Carrera]  WITH CHECK ADD  CONSTRAINT [FK_Carrera_Facultad] FOREIGN KEY([idFacultad])
REFERENCES [dbo].[Facultad] ([idFacultad])
GO
ALTER TABLE [dbo].[Carrera] CHECK CONSTRAINT [FK_Carrera_Facultad]
GO
ALTER TABLE [dbo].[CarreraXMateria]  WITH CHECK ADD  CONSTRAINT [FK_CarreraXMateria_Carrera] FOREIGN KEY([idCarrera])
REFERENCES [dbo].[Carrera] ([idCarrera])
GO
ALTER TABLE [dbo].[CarreraXMateria] CHECK CONSTRAINT [FK_CarreraXMateria_Carrera]
GO
ALTER TABLE [dbo].[CarreraXMateria]  WITH CHECK ADD  CONSTRAINT [FK_CarreraXMateria_Materia] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materia] ([idMateria])
GO
ALTER TABLE [dbo].[CarreraXMateria] CHECK CONSTRAINT [FK_CarreraXMateria_Materia]
GO
ALTER TABLE [dbo].[Ciudad]  WITH CHECK ADD  CONSTRAINT [FK_Ciudad_Provincia] FOREIGN KEY([idProvincia])
REFERENCES [dbo].[Provincia] ([idProvincia])
GO
ALTER TABLE [dbo].[Ciudad] CHECK CONSTRAINT [FK_Ciudad_Provincia]
GO
ALTER TABLE [dbo].[Editorial]  WITH CHECK ADD  CONSTRAINT [FK_Editorial_Ciudad] FOREIGN KEY([idCiudadEditorial])
REFERENCES [dbo].[Ciudad] ([idCiudad])
GO
ALTER TABLE [dbo].[Editorial] CHECK CONSTRAINT [FK_Editorial_Ciudad]
GO
ALTER TABLE [dbo].[MateriaXProfesor]  WITH CHECK ADD  CONSTRAINT [FK_MateriaXProfesor_Materia] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materia] ([idMateria])
GO
ALTER TABLE [dbo].[MateriaXProfesor] CHECK CONSTRAINT [FK_MateriaXProfesor_Materia]
GO
ALTER TABLE [dbo].[MateriaXProfesor]  WITH CHECK ADD  CONSTRAINT [FK_MateriaXProfesor_Profesor] FOREIGN KEY([idProfesor])
REFERENCES [dbo].[Profesor] ([idProfesor])
GO
ALTER TABLE [dbo].[MateriaXProfesor] CHECK CONSTRAINT [FK_MateriaXProfesor_Profesor]
GO
USE [master]
GO
ALTER DATABASE [Artemisa] SET  READ_WRITE 
GO
