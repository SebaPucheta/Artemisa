USE [master]
GO
/****** Object:  Database [ProyectoArtemisa]    Script Date: 30/09/2016 19:13:39 ******/
CREATE DATABASE [ProyectoArtemisa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProyectoArtemisa', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ProyectoArtemisa.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ProyectoArtemisa_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ProyectoArtemisa_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ProyectoArtemisa] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProyectoArtemisa].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProyectoArtemisa] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ProyectoArtemisa] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProyectoArtemisa] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProyectoArtemisa] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProyectoArtemisa] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProyectoArtemisa] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProyectoArtemisa] SET  MULTI_USER 
GO
ALTER DATABASE [ProyectoArtemisa] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProyectoArtemisa] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProyectoArtemisa] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProyectoArtemisa] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ProyectoArtemisa]
GO
/****** Object:  Table [dbo].[Apunte]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Carrera]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[CarreraXMateria]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Ciudad]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cliente](
	[idCliente] [int] IDENTITY(1,1) NOT NULL,
	[nombreCliente] [varchar](50) NOT NULL,
	[apellidoCliente] [varchar](50) NOT NULL,
	[nroDni] [int] NOT NULL,
	[idTipoDNI] [int] NOT NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteXCarrera]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClienteXCarrera](
	[idCliente] [int] NOT NULL,
	[idCarrera] [int] NOT NULL,
 CONSTRAINT [PK_ClienteXCarrera] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC,
	[idCarrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleFactura](
	[idDetalleFactura] [int] IDENTITY(1,1) NOT NULL,
	[idItem] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[subtotal] [float] NOT NULL,
	[idFactura] [int] NOT NULL,
	[idTipoItem] [int] NOT NULL,
 CONSTRAINT [PK_DetalleFactura] PRIMARY KEY CLUSTERED 
(
	[idDetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Editorial]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Editorial](
	[idEditorial] [int] IDENTITY(1,1) NOT NULL,
	[nombreEditorial] [varchar](50) NOT NULL,
	[baja] [bit] NOT NULL,
 CONSTRAINT [PK_Editorial_1] PRIMARY KEY CLUSTERED 
(
	[idEditorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EditorialXProveedor]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EditorialXProveedor](
	[idEditorial] [int] NOT NULL,
	[idProveedor] [int] NOT NULL,
 CONSTRAINT [PK_EditorialXProveedor] PRIMARY KEY CLUSTERED 
(
	[idEditorial] ASC,
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Estado]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[EstadoOrdenImpresion]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EstadoOrdenImpresion](
	[idEstadoOrdenImpresion] [int] IDENTITY(1,1) NOT NULL,
	[nombreEstadoOrdenImpresion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_EstadoOrdenImpresion] PRIMARY KEY CLUSTERED 
(
	[idEstadoOrdenImpresion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Factura](
	[idFactura] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [date] NOT NULL,
	[total] [float] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Facultad]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Item]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Item](
	[idItem] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[idItem] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Libro]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Materia]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[MateriaXProfesor]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[OrdenImpresion]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenImpresion](
	[idOrdenImpresion] [int] IDENTITY(1,1) NOT NULL,
	[idApunte] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[idEstadoOrdenImpresion] [int] NOT NULL,
	[fecha] [date] NOT NULL,
 CONSTRAINT [PK_OrdenImpresion] PRIMARY KEY CLUSTERED 
(
	[idOrdenImpresion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PrecioXHoja]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Profesor]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Proveedor]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Proveedor](
	[idProveedor] [int] IDENTITY(1,1) NOT NULL,
	[nombreProveedor] [varchar](50) NOT NULL,
	[telefono] [varchar](50) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NOT NULL,
	[nombreContacto] [varchar](50) NOT NULL,
	[baja] [bit] NULL,
	[idCiudadEditorial] [int] NOT NULL,
 CONSTRAINT [PK_Editorial] PRIMARY KEY CLUSTERED 
(
	[idProveedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Provincia]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Rol]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rol](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[nombreRol] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoApunte]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[TipoDNI]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoDNI](
	[idTipoDNI] [int] IDENTITY(1,1) NOT NULL,
	[nombreTipoDNI] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoDNI] PRIMARY KEY CLUSTERED 
(
	[idTipoDNI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Universidad]    Script Date: 30/09/2016 19:13:39 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 30/09/2016 19:13:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Usuario](
	[idUsuario] [int] IDENTITY(1,1) NOT NULL,
	[nombreUsuario] [varchar](50) NOT NULL,
	[contrasena] [varchar](50) NOT NULL,
	[idCliente] [int] NOT NULL,
	[idRol] [int] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[idUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Apunte] ON 

INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (9, -1, 5, 51, N'Física 2  Guía de Trabajos Practico ', N'Guía de trabajo practico ', 2014, N'', NULL, 2, 2, 3, NULL, 3, 0, 102)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (10, -1, 60, 254, N'Algoritmos Y Estructura de Datos', N'Apunte de programación ', 2013, N'', NULL, 3, 2, 3, NULL, 3, 1, 105)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (11, 8, 128, 254, N'Algoritmos Y Estructura de Datos', N'Apunte de programación ', 2013, N'qwesdqw22v', 4, 3, 1, 3, NULL, 3, 0, 105)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (12, -1, 20, 125, N'Ingles 2', N'Apunte de ingles técnico ', 2015, N'', NULL, 1, 2, 3, NULL, 4, 1, 107)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (13, -1, 62.5, 125, N'Ingles 2', N'Apunte de ingles técnico ', 2015, N'dsa32', 4, 1, 1, 3, NULL, 4, 0, 107)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria]) VALUES (14, -1, 28.5, 57, N'Habilitación Profesional', N'Apunte teórico para habiitacion profesional', 2016, N'123asd', 4, 1, 1, 3, NULL, 5, 0, 112)
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
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 109)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 110)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 111)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 112)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (2, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (2, 108)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (4, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (4, 108)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (4, 111)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (5, 107)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (5, 108)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (5, 111)
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (1, N'3er Año', 0)
INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (2, N'2do Año', 0)
INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (3, N'1er Año', 0)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[Ciudad] ON 

INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (1, N'Córdoba', 1, 0)
INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (2, N'Villa Maria', 1, 0)
INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (3, N'CABA', 2, 0)
INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (4, N'Rosario', 3, 0)
INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (5, N'Villa Allende', 1, 0)
SET IDENTITY_INSERT [dbo].[Ciudad] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI]) VALUES (2, N'Juan', N'Moyano', 38500329, 1)
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI]) VALUES (3, N'Sebastian', N'Pucheta', 12456789, 1)
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI]) VALUES (4, N'Ruben', N'Urteaga', 40256542, 1)
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI]) VALUES (5, N'Amato', N'Loco', 45678945, 1)
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[DetalleFactura] ON 

INSERT [dbo].[DetalleFactura] ([idDetalleFactura], [idItem], [cantidad], [subtotal], [idFactura], [idTipoItem]) VALUES (4, 11, 1, 128, 16, 2)
INSERT [dbo].[DetalleFactura] ([idDetalleFactura], [idItem], [cantidad], [subtotal], [idFactura], [idTipoItem]) VALUES (5, 3, 1, 900, 16, 1)
SET IDENTITY_INSERT [dbo].[DetalleFactura] OFF
SET IDENTITY_INSERT [dbo].[Editorial] ON 

INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (1, N'AlfaOmega', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (2, N'EDUCO', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (3, N'Panini', 1)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (4, N'De Bolsillo', 1)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (5, N'De Bolsillo', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (6, N'Panini', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (7, N'Panini Comics', 1)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (8, N'McGrawHill', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (9, N'Grupo Editorial Patria 2', 1)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (10, N'Zafiro', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (11, N'Ivrea', 1)
SET IDENTITY_INSERT [dbo].[Editorial] OFF
INSERT [dbo].[EditorialXProveedor] ([idEditorial], [idProveedor]) VALUES (1, 12)
INSERT [dbo].[EditorialXProveedor] ([idEditorial], [idProveedor]) VALUES (2, 12)
SET IDENTITY_INSERT [dbo].[EstadoOrdenImpresion] ON 

INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (1, N'Pendiente')
INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (2, N'Impreso')
INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (3, N'En Local')
INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (4, N'Cancelada')
SET IDENTITY_INSERT [dbo].[EstadoOrdenImpresion] OFF
SET IDENTITY_INSERT [dbo].[Factura] ON 

INSERT [dbo].[Factura] ([idFactura], [fecha], [total]) VALUES (1, CAST(0xB83B0B00 AS Date), 199.5)
INSERT [dbo].[Factura] ([idFactura], [fecha], [total]) VALUES (2, CAST(0xC63B0B00 AS Date), 253)
INSERT [dbo].[Factura] ([idFactura], [fecha], [total]) VALUES (11, CAST(0xEC3B0B00 AS Date), 0)
INSERT [dbo].[Factura] ([idFactura], [fecha], [total]) VALUES (16, CAST(0xEC3B0B00 AS Date), 1028)
SET IDENTITY_INSERT [dbo].[Factura] OFF
SET IDENTITY_INSERT [dbo].[Facultad] ON 

INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (1, N'Facultad Regional Córdoba', 0, 0, 1)
INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (2, N'Facultad Regional Córdoba', 1, 0, 1)
INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (3, N'Facultad Regional Villa Maria', 2, 0, 2)
INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (4, N'Facultad Regional Rosario', 1, 0, 4)
SET IDENTITY_INSERT [dbo].[Facultad] OFF
INSERT [dbo].[Item] ([idItem], [descripcion]) VALUES (1, N'Libro')
INSERT [dbo].[Item] ([idItem], [descripcion]) VALUES (2, N'Apunte')
SET IDENTITY_INSERT [dbo].[Libro] ON 

INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria]) VALUES (3, N'0-471-32057-9', N'Física Quinta Edicion', N'Robert Resnick', N'Volumen 1', -1, 657, 900, 6, NULL, 0, 108)
INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria]) VALUES (4, N'0-13-814767-4', N'Señales y Sistemas Segunda Edicion', N'Alan V. Oppenheim', N'Señales continuas y discretas ', -1, 946, 950, 7, NULL, 0, 109)
SET IDENTITY_INSERT [dbo].[Libro] OFF
SET IDENTITY_INSERT [dbo].[Materia] ON 

INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (101, N'Diseño de Sistemas', 3, N'Hardcore', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (102, N'Física 2', 2, N'Física 2 sistemas', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (104, N'Programación de Aplicaciones Visuales ', 3, N'Programación en Visual Basic', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (105, N'Algoritmos y Estructura de Datos', 1, N'Materia de programación en la cual se programa en Phyton', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (107, N'Ingles 2', 3, N'Ingles tecnico', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (108, N'Física 1', 1, N'Mecánica Clasica', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (109, N'Comunicaciónes y Redes de Información', 3, N'Materia de Analista Universitario de Sistemas, que remplaza a las materias, comunicaciones y a la materia redes, de la carrera de ingeniería. ', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (110, N'Matemática superior ', 3, N'Métodos numéricos y señales.', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (111, N'Análisis Matemático 1', 1, N'Materia de matematica', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (112, N'Habilitación Profesional', 4, N'Materia oara analista universitario de sistemas', 0)
SET IDENTITY_INSERT [dbo].[Materia] OFF
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (101, 1)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (101, 2)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (105, 3)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (107, 4)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (112, 5)
SET IDENTITY_INSERT [dbo].[OrdenImpresion] ON 

INSERT [dbo].[OrdenImpresion] ([idOrdenImpresion], [idApunte], [cantidad], [idEstadoOrdenImpresion], [fecha]) VALUES (1, 11, 9, 3, CAST(0xC63B0B00 AS Date))
SET IDENTITY_INSERT [dbo].[OrdenImpresion] OFF
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
INSERT [dbo].[Profesor] ([nombreProfesor], [apellidoProfesor], [idProfesor], [baja]) VALUES (N'Irene', N'Mac William', 5, 0)
SET IDENTITY_INSERT [dbo].[Profesor] OFF
SET IDENTITY_INSERT [dbo].[Proveedor] ON 

INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (3, N'EDUCO', N'43512322', N'domingobici@gmail.com', N'Maestro M. Lopez 5000', N'Juan Domingo  Bici', 0, 1)
INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (4, N'Pearson', N'0011232132', N'pearson@pearson.com', N'9 Julio 3432', N'Marco Aurelio Alfonso', 0, 3)
INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (5, N'AlfaOmega', N'48117183', N'ventas@alfaomegaeditor.com.ar', N'Paraguay 1307', N'Luis Alberto de la Tapia', 0, 3)
INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (6, N'Grupo Editorial Patria', N'015553549190', N'info@editorialprada.com.ar', N'Renacimiento 180', N'Javier Enrique ', 0, 3)
INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (7, N'Prentice Hall', N'0013243212', N'info@prenticehall.com', N'calle 4 25', N'Pablo Eduardo Roig Vázquez', 0, 3)
INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (10, N'Los locos Adams', N'01555354919', N'info@editorialprada.com', N'Libertador 2500', N'Irene', 0, 1)
INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (12, N'Los locos Adams', N'01555354919', N'info@editorialprada.com', N'Libertador 2500', N'Irene', 0, 1)
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (1, N'Córdoba', 0)
INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (2, N'Buenos Aires', 0)
INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (3, N'Santa Fe ', 0)
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (1, N'administrador')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (2, N'alumno')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (3, N'invitado')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (4, N'empleado')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (1, N'administrador')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (2, N'alumno')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (3, N'invitado')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (4, N'empleado')
SET IDENTITY_INSERT [dbo].[Rol] OFF
SET IDENTITY_INSERT [dbo].[TipoApunte] ON 

INSERT [dbo].[TipoApunte] ([idTipoApunte], [nombreTipoApunte], [baja]) VALUES (1, N'Impreso', 0)
INSERT [dbo].[TipoApunte] ([idTipoApunte], [nombreTipoApunte], [baja]) VALUES (2, N'Digital', 0)
SET IDENTITY_INSERT [dbo].[TipoApunte] OFF
SET IDENTITY_INSERT [dbo].[TipoDNI] ON 

INSERT [dbo].[TipoDNI] ([idTipoDNI], [nombreTipoDNI]) VALUES (1, N'DNI')
INSERT [dbo].[TipoDNI] ([idTipoDNI], [nombreTipoDNI]) VALUES (2, N'Pasaporte')
SET IDENTITY_INSERT [dbo].[TipoDNI] OFF
SET IDENTITY_INSERT [dbo].[Universidad] ON 

INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (1, N'Universidad Tecnológica Nacional', 0)
INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (2, N'Universidad Nacional Córdoba', 0)
INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (3, N'Universidad Católica de Córdoba', 0)
INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (4, N'Universidad Provincia Córdoba', 0)
SET IDENTITY_INSERT [dbo].[Universidad] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (1, N'marvinien', N'123456789', 2, 1)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (2, N'pucheta', N'123456', 3, 1)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (3, N'elruben', N'123456', 4, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (5, N'amato', N'123456', 5, 3)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Categoria] FOREIGN KEY([idCategoria])
REFERENCES [dbo].[Categoria] ([idCategoria])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Categoria]
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
ALTER TABLE [dbo].[Carrera]  WITH CHECK ADD  CONSTRAINT [FK_Carrera_Facultad1] FOREIGN KEY([idFacultad])
REFERENCES [dbo].[Facultad] ([idFacultad])
GO
ALTER TABLE [dbo].[Carrera] CHECK CONSTRAINT [FK_Carrera_Facultad1]
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
ALTER TABLE [dbo].[Cliente]  WITH CHECK ADD  CONSTRAINT [FK_Cliente_TipoDNI] FOREIGN KEY([idTipoDNI])
REFERENCES [dbo].[TipoDNI] ([idTipoDNI])
GO
ALTER TABLE [dbo].[Cliente] CHECK CONSTRAINT [FK_Cliente_TipoDNI]
GO
ALTER TABLE [dbo].[ClienteXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_ClienteXCarrera_Carrera] FOREIGN KEY([idCarrera])
REFERENCES [dbo].[Carrera] ([idCarrera])
GO
ALTER TABLE [dbo].[ClienteXCarrera] CHECK CONSTRAINT [FK_ClienteXCarrera_Carrera]
GO
ALTER TABLE [dbo].[ClienteXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_ClienteXCarrera_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[ClienteXCarrera] CHECK CONSTRAINT [FK_ClienteXCarrera_Cliente]
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_DetalleFactura] FOREIGN KEY([idDetalleFactura])
REFERENCES [dbo].[DetalleFactura] ([idDetalleFactura])
GO
ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_DetalleFactura]
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_Factura] FOREIGN KEY([idFactura])
REFERENCES [dbo].[Factura] ([idFactura])
GO
ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_Factura]
GO
ALTER TABLE [dbo].[DetalleFactura]  WITH CHECK ADD  CONSTRAINT [FK_DetalleFactura_Item] FOREIGN KEY([idTipoItem])
REFERENCES [dbo].[Item] ([idItem])
GO
ALTER TABLE [dbo].[DetalleFactura] CHECK CONSTRAINT [FK_DetalleFactura_Item]
GO
ALTER TABLE [dbo].[EditorialXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_EditorialXProveedor_Editorial] FOREIGN KEY([idEditorial])
REFERENCES [dbo].[Editorial] ([idEditorial])
GO
ALTER TABLE [dbo].[EditorialXProveedor] CHECK CONSTRAINT [FK_EditorialXProveedor_Editorial]
GO
ALTER TABLE [dbo].[EditorialXProveedor]  WITH CHECK ADD  CONSTRAINT [FK_EditorialXProveedor_Proveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedor] ([idProveedor])
GO
ALTER TABLE [dbo].[EditorialXProveedor] CHECK CONSTRAINT [FK_EditorialXProveedor_Proveedor]
GO
ALTER TABLE [dbo].[Libro]  WITH CHECK ADD  CONSTRAINT [FK_Libro_Editorial] FOREIGN KEY([idEditorial])
REFERENCES [dbo].[Editorial] ([idEditorial])
GO
ALTER TABLE [dbo].[Libro] CHECK CONSTRAINT [FK_Libro_Editorial]
GO
ALTER TABLE [dbo].[Libro]  WITH CHECK ADD  CONSTRAINT [FK_Libro_Estado] FOREIGN KEY([idEstado])
REFERENCES [dbo].[Estado] ([idEstado])
GO
ALTER TABLE [dbo].[Libro] CHECK CONSTRAINT [FK_Libro_Estado]
GO
ALTER TABLE [dbo].[Libro]  WITH CHECK ADD  CONSTRAINT [FK_Libro_Materia] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materia] ([idMateria])
GO
ALTER TABLE [dbo].[Libro] CHECK CONSTRAINT [FK_Libro_Materia]
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
ALTER TABLE [dbo].[OrdenImpresion]  WITH CHECK ADD  CONSTRAINT [FK_OrdenImpresion_Apunte] FOREIGN KEY([idApunte])
REFERENCES [dbo].[Apunte] ([idApunte])
GO
ALTER TABLE [dbo].[OrdenImpresion] CHECK CONSTRAINT [FK_OrdenImpresion_Apunte]
GO
ALTER TABLE [dbo].[OrdenImpresion]  WITH CHECK ADD  CONSTRAINT [FK_OrdenImpresion_Estado] FOREIGN KEY([idEstadoOrdenImpresion])
REFERENCES [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion])
GO
ALTER TABLE [dbo].[OrdenImpresion] CHECK CONSTRAINT [FK_OrdenImpresion_Estado]
GO
ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Editorial_Ciudad] FOREIGN KEY([idCiudadEditorial])
REFERENCES [dbo].[Ciudad] ([idCiudad])
GO
ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [FK_Editorial_Ciudad]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Cliente] FOREIGN KEY([idCliente])
REFERENCES [dbo].[Cliente] ([idCliente])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Cliente]
GO
USE [master]
GO
ALTER DATABASE [ProyectoArtemisa] SET  READ_WRITE 
GO
