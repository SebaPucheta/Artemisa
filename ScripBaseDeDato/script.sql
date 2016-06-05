USE [master]
GO
/****** Object:  Database [EDUCOM]    Script Date: 05/06/2016 15:47:50 ******/
CREATE DATABASE [EDUCOM]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EDUCOM', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EDUCOM.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EDUCOM_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\EDUCOM_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EDUCOM] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EDUCOM].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EDUCOM] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EDUCOM] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EDUCOM] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EDUCOM] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EDUCOM] SET ARITHABORT OFF 
GO
ALTER DATABASE [EDUCOM] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EDUCOM] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [EDUCOM] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EDUCOM] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EDUCOM] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EDUCOM] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EDUCOM] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EDUCOM] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EDUCOM] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EDUCOM] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EDUCOM] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EDUCOM] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EDUCOM] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EDUCOM] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EDUCOM] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EDUCOM] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EDUCOM] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EDUCOM] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EDUCOM] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EDUCOM] SET  MULTI_USER 
GO
ALTER DATABASE [EDUCOM] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EDUCOM] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EDUCOM] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EDUCOM] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [EDUCOM]
GO
/****** Object:  Table [dbo].[Apunte]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Apunte](
	[stock] [int] NOT NULL,
	[precio] [float] NOT NULL,
	[cantHoja] [int] NOT NULL,
	[nombre] [char](50) NOT NULL,
	[descripcion] [char](200) NULL,
	[ano] [int] NOT NULL,
	[codigoBarraApunte] [char](50) NOT NULL,
	[idPrecioHoja] [int] NOT NULL,
	[idCategoria] [int] NOT NULL,
	[idTipoApunte] [int] NOT NULL,
	[idEditorial] [int] NOT NULL,
	[idEstado] [int] NOT NULL,
	[idProfesor] [int] NOT NULL,
 CONSTRAINT [PK_Apunte] PRIMARY KEY CLUSTERED 
(
	[codigoBarraApunte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ApunteXMateria]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ApunteXMateria](
	[codigoBarraApunte] [char](50) NOT NULL,
	[idMateria] [int] NOT NULL,
 CONSTRAINT [PK_ApunteXMateria] PRIMARY KEY CLUSTERED 
(
	[codigoBarraApunte] ASC,
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Carrera]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Carrera](
	[idCarrera] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](20) NOT NULL,
 CONSTRAINT [PK_Carrera] PRIMARY KEY CLUSTERED 
(
	[idCarrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CarreraXMateria]    Script Date: 05/06/2016 15:47:51 ******/
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
/****** Object:  Table [dbo].[Categoria]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categoria](
	[idCategoria] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](50) NOT NULL,
 CONSTRAINT [PK_Categoria] PRIMARY KEY CLUSTERED 
(
	[idCategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Editorial]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Editorial](
	[idEditorial] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](50) NOT NULL,
	[telefono] [char](50) NOT NULL,
	[email] [char](50) NOT NULL,
	[direccion] [char](50) NOT NULL,
	[nombreContacto] [char](50) NOT NULL,
 CONSTRAINT [PK_Editorial] PRIMARY KEY CLUSTERED 
(
	[idEditorial] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Estado]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estado](
	[idEstado] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](50) NOT NULL,
 CONSTRAINT [PK_Estado] PRIMARY KEY CLUSTERED 
(
	[idEstado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Facultad]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Facultad](
	[idFacultad] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](20) NOT NULL,
 CONSTRAINT [PK_Facultad] PRIMARY KEY CLUSTERED 
(
	[idFacultad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FacultadXCarrera]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacultadXCarrera](
	[idFacultad] [int] NOT NULL,
	[idCarrera] [int] NOT NULL,
 CONSTRAINT [PK_FacultadXCarrera] PRIMARY KEY CLUSTERED 
(
	[idFacultad] ASC,
	[idCarrera] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Libro]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Libro](
	[codigoBarraLibro] [char](50) NOT NULL,
	[nombre] [char](50) NOT NULL,
	[autor] [char](50) NOT NULL,
	[descripcion] [char](200) NULL,
	[stock] [int] NOT NULL,
	[cantHojas] [int] NOT NULL,
	[precio] [float] NOT NULL,
	[idEditorial] [int] NOT NULL,
	[idEstado] [int] NOT NULL,
 CONSTRAINT [PK_Libro] PRIMARY KEY CLUSTERED 
(
	[codigoBarraLibro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LibroXMateria]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LibroXMateria](
	[codigoBarraLibro] [char](50) NOT NULL,
	[idMateria] [int] NOT NULL,
 CONSTRAINT [PK_LibroXMateria] PRIMARY KEY CLUSTERED 
(
	[codigoBarraLibro] ASC,
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Materia]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Materia](
	[idMateria] [int] IDENTITY(100,1) NOT NULL,
	[nombre] [char](50) NOT NULL,
	[ano] [int] NOT NULL,
	[descripcion] [char](200) NULL,
 CONSTRAINT [PK_Materia] PRIMARY KEY CLUSTERED 
(
	[idMateria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MateriaXProfesor]    Script Date: 05/06/2016 15:47:51 ******/
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
/****** Object:  Table [dbo].[PrecioHoja]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrecioHoja](
	[idPrecioHoja] [int] IDENTITY(1,1) NOT NULL,
	[precio] [float] NOT NULL,
 CONSTRAINT [PK_PrecioHoja] PRIMARY KEY CLUSTERED 
(
	[idPrecioHoja] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Profesor]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profesor](
	[nombre] [char](50) NOT NULL,
	[apellido] [char](50) NOT NULL,
	[idProfesor] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Profesor] PRIMARY KEY CLUSTERED 
(
	[idProfesor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TipoApunte]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TipoApunte](
	[idTipoApunte] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](50) NOT NULL,
 CONSTRAINT [PK_TipoApunte] PRIMARY KEY CLUSTERED 
(
	[idTipoApunte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Universidad]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Universidad](
	[idUniversidad] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [char](50) NOT NULL,
 CONSTRAINT [PK_Universidad] PRIMARY KEY CLUSTERED 
(
	[idUniversidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UniversidadXFacultad]    Script Date: 05/06/2016 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UniversidadXFacultad](
	[idUniversidad] [int] NOT NULL,
	[idFacultad] [int] NOT NULL,
 CONSTRAINT [PK_UniversidadXFacultad] PRIMARY KEY CLUSTERED 
(
	[idUniversidad] ASC,
	[idFacultad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

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
ALTER TABLE [dbo].[Apunte]  WITH CHECK ADD  CONSTRAINT [FK_Apunte_PrecioHoja] FOREIGN KEY([idPrecioHoja])
REFERENCES [dbo].[PrecioHoja] ([idPrecioHoja])
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
ALTER TABLE [dbo].[ApunteXMateria]  WITH CHECK ADD  CONSTRAINT [FK_ApunteXMateria_Apunte] FOREIGN KEY([codigoBarraApunte])
REFERENCES [dbo].[Apunte] ([codigoBarraApunte])
GO
ALTER TABLE [dbo].[ApunteXMateria] CHECK CONSTRAINT [FK_ApunteXMateria_Apunte]
GO
ALTER TABLE [dbo].[ApunteXMateria]  WITH CHECK ADD  CONSTRAINT [FK_ApunteXMateria_Materia] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materia] ([idMateria])
GO
ALTER TABLE [dbo].[ApunteXMateria] CHECK CONSTRAINT [FK_ApunteXMateria_Materia]
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
ALTER TABLE [dbo].[FacultadXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_FacultadXCarrera_Carrera] FOREIGN KEY([idCarrera])
REFERENCES [dbo].[Carrera] ([idCarrera])
GO
ALTER TABLE [dbo].[FacultadXCarrera] CHECK CONSTRAINT [FK_FacultadXCarrera_Carrera]
GO
ALTER TABLE [dbo].[FacultadXCarrera]  WITH CHECK ADD  CONSTRAINT [FK_FacultadXCarrera_Facultad] FOREIGN KEY([idFacultad])
REFERENCES [dbo].[Facultad] ([idFacultad])
GO
ALTER TABLE [dbo].[FacultadXCarrera] CHECK CONSTRAINT [FK_FacultadXCarrera_Facultad]
GO
ALTER TABLE [dbo].[LibroXMateria]  WITH CHECK ADD  CONSTRAINT [FK_LibroXMateria_LibroXMateria] FOREIGN KEY([codigoBarraLibro])
REFERENCES [dbo].[Libro] ([codigoBarraLibro])
GO
ALTER TABLE [dbo].[LibroXMateria] CHECK CONSTRAINT [FK_LibroXMateria_LibroXMateria]
GO
ALTER TABLE [dbo].[LibroXMateria]  WITH CHECK ADD  CONSTRAINT [FK_LibroXMateria_Materia] FOREIGN KEY([idMateria])
REFERENCES [dbo].[Materia] ([idMateria])
GO
ALTER TABLE [dbo].[LibroXMateria] CHECK CONSTRAINT [FK_LibroXMateria_Materia]
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
ALTER TABLE [dbo].[UniversidadXFacultad]  WITH CHECK ADD  CONSTRAINT [FK_UniversidadXFacultad_Facultad] FOREIGN KEY([idFacultad])
REFERENCES [dbo].[Facultad] ([idFacultad])
GO
ALTER TABLE [dbo].[UniversidadXFacultad] CHECK CONSTRAINT [FK_UniversidadXFacultad_Facultad]
GO
ALTER TABLE [dbo].[UniversidadXFacultad]  WITH CHECK ADD  CONSTRAINT [FK_UniversidadXFacultad_Universidad] FOREIGN KEY([idUniversidad])
REFERENCES [dbo].[Universidad] ([idUniversidad])
GO
ALTER TABLE [dbo].[UniversidadXFacultad] CHECK CONSTRAINT [FK_UniversidadXFacultad_Universidad]
GO
USE [master]
GO
ALTER DATABASE [EDUCOM] SET  READ_WRITE 
GO
