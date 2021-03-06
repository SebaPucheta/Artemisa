USE [master]
GO
/****** Object:  Database [ProyectoArtemisa]    Script Date: 01/12/2016 20:30:24 ******/
CREATE DATABASE [ProyectoArtemisa]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HP10', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\HP10.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HP10_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\HP10_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  StoredProcedure [dbo].[sp_facturaXIdFactura]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_facturaXIdFactura]
(@idFactura int)
as
SELECT F.idFactura, F.fecha, F.total, DF.idDetalleFactura, DF.cantidad, DF.subtotal ,
       (
            CASE WHEN DF.idTipoItem=2 THEN  (SELECT A.nombreApunte FROM Apunte A WHERE A.idApunte = DF.idItem)
                 ELSE (SELECT L.nombreLibro FROM Libro L WHERE L.idLibro = DF.idItem)
                 END
        ) as nombreItem,
        ISNULL (E.nombreEmpleado + ' ' + e.apellidoEmpleado, ' ') AS nombreEmpleado


FROM Factura F INNER JOIN DetalleFactura DF
    ON F.idFactura = DF.idFactura
    LEFT JOIN  Usuario U
    ON U.idUsuario = F.idUsuarioEmpleado
    LEFT JOIN Empleado e
    ON e.idEmpleados = U.idCliente
    where F.idFactura = @idFactura






GO
/****** Object:  StoredProcedure [dbo].[sp_ingresoLibros]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_ingresoLibros]
(@FECHADESDE date,
@FECHAHASTA date,
@NOMBREPROVEEDOR varchar,
@NOMBREUSUARIO varchar,
@APELLIDOUSUARIO varchar)
as
SELECT I.fecha, P.nombreProveedor, ISNULL(e.nombreEmpleado,'') + ' ' + ISNULL(e.apellidoEmpleado, '') AS nombreUsuario, i.total
FROM IngresoLibro I LEFT JOIN Usuario U
                ON I.idUsuario = U.idUsuario
                LEFT JOIN Empleado e
                ON e.idEmpleados = U.idCliente
                INNER JOIN Proveedor P
                ON P.idProveedor = I.idProveedor
WHERE (I.fecha between @fechaDesde and @fechaHasta) AND P.nombreProveedor LIKE (CASE WHEN @NOMBREPROVEEDOR='*' THEN   '%%' ELSE  '%'+@NOMBREPROVEEDOR+'%' END ) AND e.apellidoEmpleado LIKE (CASE WHEN @APELLIDOUSUARIO='*' THEN   '%%' ELSE  '%'+@APELLIDOUSUARIO+'%' END ) AND e.nombreEmpleado LIKE (CASE WHEN @NOMBREUSUARIO='*' THEN   '%%' ELSE '%'+@NOMBREUSUARIO+'%' END )






GO
/****** Object:  StoredProcedure [dbo].[sp_venta]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_venta]
@idFactura int
as
SELECT idFactura, fecha, total 
FROM dbo.Factura
where idFactura = @idFactura






GO
/****** Object:  StoredProcedure [dbo].[sp_ventaXapunte]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_ventaXapunte]
(@fechaDesde datetime,
@fechaHasta datetime)
as
select df.cantidad, a.nombreApunte, a.cantHoja, f.fecha , (df.cantidad  *   a.cantHoja) as hojasTotales from factura f join DetalleFactura df ON f.idFactura = df.idFactura JOIN Apunte a on df.idItem = a.idApunte
where (f.fecha between @fechaDesde and @fechaHasta) AND (a.idTipoApunte = 1)







GO
/****** Object:  StoredProcedure [dbo].[sp_ventaXdia]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_ventaXdia]

(@fechaDesde datetime,
@fechaHasta datetime)
as
SELECT idFactura, fecha, total 
FROM dbo.Factura
where fecha between @fechaDesde and @fechaHasta






GO
/****** Object:  Table [dbo].[Apunte]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Apunte](
	[idApunte] [int] IDENTITY(1,1) NOT NULL,
	[stock] [int] NOT NULL,
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
	[urlImagenApunte] [varchar](100) NULL,
	[urlArchivoApunte] [varchar](100) NULL,
 CONSTRAINT [PK_Apunte_1] PRIMARY KEY CLUSTERED 
(
	[idApunte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Carrera]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[CarreraXMateria]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Ciudad]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 01/12/2016 20:30:25 ******/
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
	[nroDni] [int] NULL,
	[idTipoDNI] [int] NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[idCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClienteXCarrera]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[DetalleFactura]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[DetalleIngresoLibro]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DetalleIngresoLibro](
	[idDetalleIngresoLibro] [int] IDENTITY(1,1) NOT NULL,
	[idIngresoLibro] [int] NOT NULL,
	[idLibro] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[precioUnitario] [float] NOT NULL,
	[cantidadDescarga] [int] NULL,
 CONSTRAINT [PK_DetalleIngresoLibro] PRIMARY KEY CLUSTERED 
(
	[idDetalleIngresoLibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Editorial]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[EditorialXProveedor]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Empleado]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[idEmpleados] [int] IDENTITY(1,1) NOT NULL,
	[nombreEmpleado] [varchar](50) NOT NULL,
	[apellidoEmpleado] [varchar](50) NOT NULL,
	[dni] [int] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[idTipoDNI] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[EstadoOrdenImpresion]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[EstadoPago]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EstadoPago](
	[idEstadoPago] [int] NOT NULL,
	[descripcion] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Factura]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Factura](
	[idFactura] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[total] [float] NOT NULL,
	[idUsuarioCliente] [int] NULL,
	[idUsuarioEmpleado] [int] NULL,
	[idEstadoPago] [int] NULL,
	[idFacturaMP] [varchar](50) NULL,
	[idTipoPago] [int] NOT NULL,
 CONSTRAINT [PK_Factura] PRIMARY KEY CLUSTERED 
(
	[idFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facultad]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[IngresoLibro]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IngresoLibro](
	[idIngresoLibro] [int] IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[idProveedor] [int] NOT NULL,
	[total] [float] NOT NULL,
	[idUsuario] [int] NOT NULL,
 CONSTRAINT [PK_IngresoLibro] PRIMARY KEY CLUSTERED 
(
	[idIngresoLibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Item]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Libro]    Script Date: 01/12/2016 20:30:25 ******/
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
	[urlImagenLibro] [varchar](100) NULL,
	[urlArchivoLibro] [varchar](100) NULL,
 CONSTRAINT [PK_Libro_1] PRIMARY KEY CLUSTERED 
(
	[idLibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[MateriaXProfesor]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[OrdenImpresion]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdenImpresion](
	[idOrdenImpresion] [int] IDENTITY(1,1) NOT NULL,
	[idApunte] [int] NOT NULL,
	[cantidad] [int] NOT NULL,
	[idEstadoOrdenImpresion] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
 CONSTRAINT [PK_OrdenImpresion] PRIMARY KEY CLUSTERED 
(
	[idOrdenImpresion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PrecioXHoja]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Profesor]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profesor](
	[idProfesor] [int] IDENTITY(1,1) NOT NULL,
	[nombreProfesor] [varchar](50) NOT NULL,
	[apellidoProfesor] [varchar](50) NOT NULL,
	[baja] [bit] NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[idProfesor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Proveedor]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Provincia]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Rol]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rol](
	[idRol] [int] IDENTITY(1,1) NOT NULL,
	[nombreRol] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[idRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoApunte]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[TipoDNI]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[TipoPago]    Script Date: 01/12/2016 20:30:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoPago](
	[idTipoPago] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_TipoPago] PRIMARY KEY CLUSTERED 
(
	[idTipoPago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Universidad]    Script Date: 01/12/2016 20:30:25 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 01/12/2016 20:30:25 ******/
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

INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria], [urlImagenApunte], [urlArchivoApunte]) VALUES (1, 54, 15, 123, N'Algoritmos y estructura de datos', N'', 2016, N'1234', 4, 3, 2, 1, NULL, 8, 0, 101, NULL, NULL)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria], [urlImagenApunte], [urlArchivoApunte]) VALUES (2, 10, 61.5, 123, N'Algoritmos y estructura de datos', N'', 2016, N'1234', 4, 3, 1, 1, NULL, 8, 0, 101, NULL, NULL)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria], [urlImagenApunte], [urlArchivoApunte]) VALUES (3, 0, 30, 125, N'Ingés 2', N'Inglés técnico de segundo nivel', 2016, N'', NULL, 1, 2, 1, NULL, 9, 0, 103, NULL, NULL)
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria], [urlImagenApunte], [urlArchivoApunte]) VALUES (4, 0, 10, 153, N'Ingés 2', N'Ingles técnico de segundo nivel', 2016, N'', NULL, 1, 2, 1, NULL, 9, 0, 103, N'~\Archivos\Apuntes\4.pdf', N'~\imagenes\apunte\4.jpg')
INSERT [dbo].[Apunte] ([idApunte], [stock], [precioApunte], [cantHoja], [nombreApunte], [descripcionApunte], [anoApunte], [codigoBarraApunte], [idPrecioHoja], [idCategoria], [idTipoApunte], [idEditorial], [idEstado], [idProfesor], [baja], [idMateria], [urlImagenApunte], [urlArchivoApunte]) VALUES (5, 0, 15, 123, N'Ingés 2', N'Ingles técnico de segundo nivel', 2016, N'', NULL, 1, 2, 1, NULL, 9, 0, 103, N'~\Archivos\Apuntes\5.pdf', N'~\imagenes\apunte\5.jpg')
SET IDENTITY_INSERT [dbo].[Apunte] OFF
SET IDENTITY_INSERT [dbo].[Carrera] ON 

INSERT [dbo].[Carrera] ([idCarrera], [nombreCarrera], [baja], [idFacultad]) VALUES (1, N'Ingeniería en Sistemas de Información ', 0, 1)
SET IDENTITY_INSERT [dbo].[Carrera] OFF
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 100)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 101)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 102)
INSERT [dbo].[CarreraXMateria] ([idCarrera], [idMateria]) VALUES (1, 103)
SET IDENTITY_INSERT [dbo].[Categoria] ON 

INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (1, N'3er Año', 0)
INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (2, N'2do Año', 0)
INSERT [dbo].[Categoria] ([idCategoria], [nombreCategoria], [baja]) VALUES (3, N'1er Año', 0)
SET IDENTITY_INSERT [dbo].[Categoria] OFF
SET IDENTITY_INSERT [dbo].[Ciudad] ON 

INSERT [dbo].[Ciudad] ([idCiudad], [nombreCiudad], [idProvincia], [baja]) VALUES (1, N'Córdoba', 1, 0)
SET IDENTITY_INSERT [dbo].[Ciudad] OFF
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (2, N'Juan', N'Moyano', 38500329, 1, N'juan.moyano.94@gmail.com')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (3, N'Sebastián', N'Pucheta', 12456789, 1, NULL)
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (4, N'Ruben', N'Urteaga', 40256542, 1, NULL)
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (5, N'Amato', N'Loco', 45678945, 1, NULL)
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (6, N'Pepe', N'Argento', NULL, NULL, N'pepe_argento@gmail.com')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (7, N'muriarte', N'uriarte', NULL, NULL, N'muriarte@muriarte.muriarte')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (8, N'Augusto', N'Pizarro', NULL, NULL, N'augusto@gmail.com')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (9, N'Juan ', N'Alberto de la olla', NULL, NULL, N'juanalbertodelaolla@gmail.com')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (10, N'', N'', NULL, NULL, N'')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (11, N'', N'', NULL, NULL, N'')
INSERT [dbo].[Cliente] ([idCliente], [nombreCliente], [apellidoCliente], [nroDni], [idTipoDNI], [email]) VALUES (12, N'', N'', NULL, NULL, N'')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
SET IDENTITY_INSERT [dbo].[DetalleFactura] ON 

INSERT [dbo].[DetalleFactura] ([idDetalleFactura], [idItem], [cantidad], [subtotal], [idFactura], [idTipoItem]) VALUES (15, 2, 2, 123, 1, 2)
INSERT [dbo].[DetalleFactura] ([idDetalleFactura], [idItem], [cantidad], [subtotal], [idFactura], [idTipoItem]) VALUES (16, 2, 2, 123, 2, 2)
INSERT [dbo].[DetalleFactura] ([idDetalleFactura], [idItem], [cantidad], [subtotal], [idFactura], [idTipoItem]) VALUES (17, 4, 3, 1800, 3, 1)
INSERT [dbo].[DetalleFactura] ([idDetalleFactura], [idItem], [cantidad], [subtotal], [idFactura], [idTipoItem]) VALUES (18, 6, 5, 2800, 4, 1)
SET IDENTITY_INSERT [dbo].[DetalleFactura] OFF
SET IDENTITY_INSERT [dbo].[DetalleIngresoLibro] ON 

INSERT [dbo].[DetalleIngresoLibro] ([idDetalleIngresoLibro], [idIngresoLibro], [idLibro], [cantidad], [precioUnitario], [cantidadDescarga]) VALUES (1, 1, 6, 5, 560, NULL)
SET IDENTITY_INSERT [dbo].[DetalleIngresoLibro] OFF
SET IDENTITY_INSERT [dbo].[Editorial] ON 

INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (1, N'EDUCO', 0)
INSERT [dbo].[Editorial] ([idEditorial], [nombreEditorial], [baja]) VALUES (2, N'Alfaomega', 0)
SET IDENTITY_INSERT [dbo].[Editorial] OFF
INSERT [dbo].[EditorialXProveedor] ([idEditorial], [idProveedor]) VALUES (1, 1)
INSERT [dbo].[EditorialXProveedor] ([idEditorial], [idProveedor]) VALUES (2, 1)
SET IDENTITY_INSERT [dbo].[Empleado] ON 

INSERT [dbo].[Empleado] ([idEmpleados], [nombreEmpleado], [apellidoEmpleado], [dni], [email], [idTipoDNI]) VALUES (1, N'Domingo', N'Vicci', 9, N'domingo@educo.com', 1)
SET IDENTITY_INSERT [dbo].[Empleado] OFF
SET IDENTITY_INSERT [dbo].[EstadoOrdenImpresion] ON 

INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (1, N'Pendiente')
INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (2, N'Impreso')
INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (3, N'En Local')
INSERT [dbo].[EstadoOrdenImpresion] ([idEstadoOrdenImpresion], [nombreEstadoOrdenImpresion]) VALUES (4, N'Cancelada')
SET IDENTITY_INSERT [dbo].[EstadoOrdenImpresion] OFF
INSERT [dbo].[EstadoPago] ([idEstadoPago], [descripcion]) VALUES (1, N'Aprobado')
INSERT [dbo].[EstadoPago] ([idEstadoPago], [descripcion]) VALUES (2, N'Pendiente')
INSERT [dbo].[EstadoPago] ([idEstadoPago], [descripcion]) VALUES (3, N'Cancelado')
INSERT [dbo].[EstadoPago] ([idEstadoPago], [descripcion]) VALUES (4, N'Entregado')
SET IDENTITY_INSERT [dbo].[Factura] ON 

INSERT [dbo].[Factura] ([idFactura], [fecha], [total], [idUsuarioCliente], [idUsuarioEmpleado], [idEstadoPago], [idFacturaMP], [idTipoPago]) VALUES (1, CAST(0x0000A6CC0115E2EF AS DateTime), 123, NULL, 2, 1, NULL, 1)
INSERT [dbo].[Factura] ([idFactura], [fecha], [total], [idUsuarioCliente], [idUsuarioEmpleado], [idEstadoPago], [idFacturaMP], [idTipoPago]) VALUES (2, CAST(0x0000A6CC01169523 AS DateTime), 123, NULL, 2, 1, NULL, 1)
INSERT [dbo].[Factura] ([idFactura], [fecha], [total], [idUsuarioCliente], [idUsuarioEmpleado], [idEstadoPago], [idFacturaMP], [idTipoPago]) VALUES (3, CAST(0x0000A6CC01178225 AS DateTime), 1800, NULL, 2, 1, NULL, 1)
INSERT [dbo].[Factura] ([idFactura], [fecha], [total], [idUsuarioCliente], [idUsuarioEmpleado], [idEstadoPago], [idFacturaMP], [idTipoPago]) VALUES (4, CAST(0x0000A6CC013F452B AS DateTime), 2800, NULL, 14, 4, NULL, 1)
SET IDENTITY_INSERT [dbo].[Factura] OFF
SET IDENTITY_INSERT [dbo].[Facultad] ON 

INSERT [dbo].[Facultad] ([idFacultad], [nombreFacultad], [idUniversidad], [baja], [idCiudad]) VALUES (1, N'Facultad Regional Córdoba ', 1, 0, 1)
SET IDENTITY_INSERT [dbo].[Facultad] OFF
SET IDENTITY_INSERT [dbo].[IngresoLibro] ON 

INSERT [dbo].[IngresoLibro] ([idIngresoLibro], [fecha], [idProveedor], [total], [idUsuario]) VALUES (1, CAST(0x0000A6CC0140BE26 AS DateTime), 1, 2800, 14)
SET IDENTITY_INSERT [dbo].[IngresoLibro] OFF
INSERT [dbo].[Item] ([idItem], [descripcion]) VALUES (1, N'Libro')
INSERT [dbo].[Item] ([idItem], [descripcion]) VALUES (2, N'Apunte')
SET IDENTITY_INSERT [dbo].[Libro] ON 

INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria], [urlImagenLibro], [urlArchivoLibro]) VALUES (4, N'123', N'Señales y sistemas', N'Alan V Oppenheim', N'', 7, 960, 600, 1, NULL, 0, 100, NULL, NULL)
INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria], [urlImagenLibro], [urlArchivoLibro]) VALUES (5, N'9786077079200', N'Enciplopedia de Visual Studio', N'Javier Ceballos', N'La biblia de Visual Basic', 2, 1125, 750, 2, NULL, 0, 102, NULL, NULL)
INSERT [dbo].[Libro] ([idLibro], [codigoBarraLibro], [nombreLibro], [autorLibro], [descripcionLibro], [stock], [cantidadHojasLibro], [precioLibro], [idEditorial], [idEstado], [baja], [idMateria], [urlImagenLibro], [urlArchivoLibro]) VALUES (6, N'9788496512177', N'Computer Hoy', N'Axel Springer', N'Guía básica de computación ', 40, 258, 560, 2, NULL, 0, 102, N'~\imagenes\libro\6.jpg', NULL)
SET IDENTITY_INSERT [dbo].[Libro] OFF
SET IDENTITY_INSERT [dbo].[Materia] ON 

INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (100, N'Matematica Superior', 3, N'Señales y métodos numericos', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (101, N'Algoritmos y estructura de datos', 1, N'Phyton', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (102, N'Programación de aplicaciones visuales', 3, N'Biblia de Visual Basic', 0)
INSERT [dbo].[Materia] ([idMateria], [nombreMateria], [nivelCursado], [descripcionMateria], [baja]) VALUES (103, N'Inglés 2', 3, N'Técnico', 0)
SET IDENTITY_INSERT [dbo].[Materia] OFF
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (101, 8)
INSERT [dbo].[MateriaXProfesor] ([idMateria], [idProfesor]) VALUES (103, 9)
SET IDENTITY_INSERT [dbo].[OrdenImpresion] ON 

INSERT [dbo].[OrdenImpresion] ([idOrdenImpresion], [idApunte], [cantidad], [idEstadoOrdenImpresion], [fecha]) VALUES (1, 2, 2, 2, CAST(0x0000A6C2013D4407 AS DateTime))
INSERT [dbo].[OrdenImpresion] ([idOrdenImpresion], [idApunte], [cantidad], [idEstadoOrdenImpresion], [fecha]) VALUES (2, 2, 3, 2, CAST(0x0000A6CC01413B97 AS DateTime))
SET IDENTITY_INSERT [dbo].[OrdenImpresion] OFF
SET IDENTITY_INSERT [dbo].[PrecioXHoja] ON 

INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (1, 0.25, CAST(0x0000A62C00000000 AS DateTime))
INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (2, 60, CAST(0x0000A63100000000 AS DateTime))
INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (3, 50, CAST(0x0000A63200000000 AS DateTime))
INSERT [dbo].[PrecioXHoja] ([idPrecioHoja], [precioHoja], [fecha]) VALUES (4, 0.5, CAST(0x0000A63200000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[PrecioXHoja] OFF
SET IDENTITY_INSERT [dbo].[Profesor] ON 

INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (1, N'Judith', N'Meles', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (2, N'Elizabeth', N'Jeinson', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (3, N'Jorge Pablo', N'Tymoschuk', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (4, N'Veronica', N'de Loredo', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (5, N'Irene', N'Mac William', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (6, N'Nicola', N'Tesla', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (7, N' Nikola ', N'Tesla', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (8, N'Jorge Pablo ', N'Tymoschuk', 0)
INSERT [dbo].[Profesor] ([idProfesor], [nombreProfesor], [apellidoProfesor], [baja]) VALUES (9, N'Verónica', N'de Loredo', 0)
SET IDENTITY_INSERT [dbo].[Profesor] OFF
SET IDENTITY_INSERT [dbo].[Proveedor] ON 

INSERT [dbo].[Proveedor] ([idProveedor], [nombreProveedor], [telefono], [email], [direccion], [nombreContacto], [baja], [idCiudadEditorial]) VALUES (1, N'Librematic', N'1223123123', N'joseluis.17@librematic.com', N'Rosario Vera Peñaloza 47', N'Jose Luis Perale', 0, 1)
SET IDENTITY_INSERT [dbo].[Proveedor] OFF
SET IDENTITY_INSERT [dbo].[Provincia] ON 

INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (1, N'Córdoba', 0)
INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (2, N'Buenos Aires', 0)
INSERT [dbo].[Provincia] ([idProvincia], [nombreProvincia], [baja]) VALUES (3, N'Santa Fe ', 0)
SET IDENTITY_INSERT [dbo].[Provincia] OFF
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (1, N'Administrador')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (2, N'Alumno')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (3, N'Invitado')
INSERT [dbo].[Rol] ([idRol], [nombreRol]) VALUES (4, N'Empleado')
SET IDENTITY_INSERT [dbo].[Rol] OFF
SET IDENTITY_INSERT [dbo].[TipoApunte] ON 

INSERT [dbo].[TipoApunte] ([idTipoApunte], [nombreTipoApunte], [baja]) VALUES (1, N'Impreso', 0)
INSERT [dbo].[TipoApunte] ([idTipoApunte], [nombreTipoApunte], [baja]) VALUES (2, N'Digital', 0)
SET IDENTITY_INSERT [dbo].[TipoApunte] OFF
SET IDENTITY_INSERT [dbo].[TipoDNI] ON 

INSERT [dbo].[TipoDNI] ([idTipoDNI], [nombreTipoDNI]) VALUES (1, N'DNI')
INSERT [dbo].[TipoDNI] ([idTipoDNI], [nombreTipoDNI]) VALUES (2, N'Pasaporte')
SET IDENTITY_INSERT [dbo].[TipoDNI] OFF
SET IDENTITY_INSERT [dbo].[TipoPago] ON 

INSERT [dbo].[TipoPago] ([idTipoPago], [descripcion]) VALUES (1, N'Ventanilla')
INSERT [dbo].[TipoPago] ([idTipoPago], [descripcion]) VALUES (2, N'Web')
SET IDENTITY_INSERT [dbo].[TipoPago] OFF
SET IDENTITY_INSERT [dbo].[Universidad] ON 

INSERT [dbo].[Universidad] ([idUniversidad], [nombreUniversidad], [baja]) VALUES (1, N'Universidad Tecnológica Nacional', 0)
SET IDENTITY_INSERT [dbo].[Universidad] OFF
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (1, N'marvinien', N'123', 2, 1)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (2, N'pucheta', N'123456', 3, 1)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (3, N'elruben', N'123456', 4, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (5, N'amato', N'123456', 5, 3)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (6, N'pepe_argento@gmail.com', N'123', 6, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (7, N'muriarte@muriarte.muriarte', N'muriarte', 7, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (8, N'augusto@gmail.com', N'perepopo', 8, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (9, N'juanalbertodelaolla@gmail.com', N'123', 9, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (10, N'', N'', 10, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (11, N'', N'', 11, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (12, N'', N'', 12, 2)
INSERT [dbo].[Usuario] ([idUsuario], [nombreUsuario], [contrasena], [idCliente], [idRol]) VALUES (14, N'domingo', N'1234', 1, 1)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Apunte] FOREIGN KEY([idApunte])
REFERENCES [dbo].[Apunte] ([idApunte])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Apunte]
GO
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
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_Materia] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materia] ([idMateria])
GO
ALTER TABLE [dbo].[Apunte] CHECK CONSTRAINT [FK_Apunte_Materia]
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
ALTER TABLE [dbo].[DetalleIngresoLibro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleIngresoLibro_DetalleIngresoLibro] FOREIGN KEY([idDetalleIngresoLibro])
REFERENCES [dbo].[DetalleIngresoLibro] ([idDetalleIngresoLibro])
GO
ALTER TABLE [dbo].[DetalleIngresoLibro] CHECK CONSTRAINT [FK_DetalleIngresoLibro_DetalleIngresoLibro]
GO
ALTER TABLE [dbo].[DetalleIngresoLibro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleIngresoLibro_IngresoLibro] FOREIGN KEY([idIngresoLibro])
REFERENCES [dbo].[IngresoLibro] ([idIngresoLibro])
GO
ALTER TABLE [dbo].[DetalleIngresoLibro] CHECK CONSTRAINT [FK_DetalleIngresoLibro_IngresoLibro]
GO
ALTER TABLE [dbo].[DetalleIngresoLibro]  WITH CHECK ADD  CONSTRAINT [FK_DetalleIngresoLibro_Libro] FOREIGN KEY([idLibro])
REFERENCES [dbo].[Libro] ([idLibro])
GO
ALTER TABLE [dbo].[DetalleIngresoLibro] CHECK CONSTRAINT [FK_DetalleIngresoLibro_Libro]
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
ALTER TABLE [dbo].[Factura]  WITH CHECK ADD  CONSTRAINT [FK_Factura_Usuario] FOREIGN KEY([idUsuarioCliente])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[Factura] CHECK CONSTRAINT [FK_Factura_Usuario]
GO
ALTER TABLE [dbo].[Facultad]  WITH CHECK ADD  CONSTRAINT [FK_Facultad_Ciudad] FOREIGN KEY([idCiudad])
REFERENCES [dbo].[Ciudad] ([idCiudad])
GO
ALTER TABLE [dbo].[Facultad] CHECK CONSTRAINT [FK_Facultad_Ciudad]
GO
ALTER TABLE [dbo].[Facultad]  WITH CHECK ADD  CONSTRAINT [FK_Facultad_Facultad] FOREIGN KEY([idFacultad])
REFERENCES [dbo].[Facultad] ([idFacultad])
GO
ALTER TABLE [dbo].[Facultad] CHECK CONSTRAINT [FK_Facultad_Facultad]
GO
ALTER TABLE [dbo].[Facultad]  WITH CHECK ADD  CONSTRAINT [FK_Facultad_Universidad] FOREIGN KEY([idUniversidad])
REFERENCES [dbo].[Universidad] ([idUniversidad])
GO
ALTER TABLE [dbo].[Facultad] CHECK CONSTRAINT [FK_Facultad_Universidad]
GO
ALTER TABLE [dbo].[IngresoLibro]  WITH CHECK ADD  CONSTRAINT [FK_IngresoLibro_IngresoLibro] FOREIGN KEY([idIngresoLibro])
REFERENCES [dbo].[IngresoLibro] ([idIngresoLibro])
GO
ALTER TABLE [dbo].[IngresoLibro] CHECK CONSTRAINT [FK_IngresoLibro_IngresoLibro]
GO
ALTER TABLE [dbo].[IngresoLibro]  WITH CHECK ADD  CONSTRAINT [FK_IngresoLibro_Proveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedor] ([idProveedor])
GO
ALTER TABLE [dbo].[IngresoLibro] CHECK CONSTRAINT [FK_IngresoLibro_Proveedor]
GO
ALTER TABLE [dbo].[IngresoLibro]  WITH CHECK ADD  CONSTRAINT [FK_IngresoLibro_Usuario] FOREIGN KEY([idUsuario])
REFERENCES [dbo].[Usuario] ([idUsuario])
GO
ALTER TABLE [dbo].[IngresoLibro] CHECK CONSTRAINT [FK_IngresoLibro_Usuario]
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
ALTER TABLE [dbo].[Libro]  WITH CHECK ADD  CONSTRAINT [FK_Libro_Libro] FOREIGN KEY([idLibro])
REFERENCES [dbo].[Libro] ([idLibro])
GO
ALTER TABLE [dbo].[Libro] CHECK CONSTRAINT [FK_Libro_Libro]
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
ALTER TABLE [dbo].[OrdenImpresion]  WITH CHECK ADD  CONSTRAINT [FK_OrdenImpresion_OrdenImpresion] FOREIGN KEY([idOrdenImpresion])
REFERENCES [dbo].[OrdenImpresion] ([idOrdenImpresion])
GO
ALTER TABLE [dbo].[OrdenImpresion] CHECK CONSTRAINT [FK_OrdenImpresion_OrdenImpresion]
GO
ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Editorial_Ciudad] FOREIGN KEY([idCiudadEditorial])
REFERENCES [dbo].[Ciudad] ([idCiudad])
GO
ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [FK_Editorial_Ciudad]
GO
ALTER TABLE [dbo].[Proveedor]  WITH CHECK ADD  CONSTRAINT [FK_Proveedor_Proveedor] FOREIGN KEY([idProveedor])
REFERENCES [dbo].[Proveedor] ([idProveedor])
GO
ALTER TABLE [dbo].[Proveedor] CHECK CONSTRAINT [FK_Proveedor_Proveedor]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Rol] FOREIGN KEY([idRol])
REFERENCES [dbo].[Rol] ([idRol])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Rol]
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK_Usuario_Usuario] FOREIGN KEY([idRol])
REFERENCES [dbo].[Rol] ([idRol])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK_Usuario_Usuario]
GO
USE [master]
GO
ALTER DATABASE [ProyectoArtemisa] SET  READ_WRITE 
GO
