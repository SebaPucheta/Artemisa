USE [ProyectoArtemisa3]
GO
/****** Object:  StoredProcedure [dbo].[sp_facturaXIdFactura]    Script Date: 05/11/2016 20:34:54 ******/
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
        ISNULL (C.nombreCliente + ' ' + C.apellidoCliente, ' ') AS nombreEmpleado


FROM Factura F INNER JOIN DetalleFactura DF
    ON F.idFactura = DF.idFactura
    LEFT JOIN  Usuario U
    ON U.idUsuario = F.idUsuario
    LEFT JOIN Cliente C
    ON C.idCliente = U.idUsuario
	where F.idFactura = @idFactura

GO
/****** Object:  StoredProcedure [dbo].[sp_ingresoLibros]    Script Date: 05/11/2016 20:34:54 ******/
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
SELECT I.fecha, P.nombreProveedor, ISNULL(C.nombreCliente,'') + ' ' + ISNULL(C.apellidoCliente, '') AS nombreUsuario, i.total
FROM IngresoLibro I LEFT JOIN Usuario U
                ON I.idUsuario = U.idUsuario
                LEFT JOIN Cliente C
                ON C.idCliente = U.idCliente
                INNER JOIN Proveedor P
                ON P.idProveedor = I.idProveedor
WHERE (I.fecha between @fechaDesde and @fechaHasta) AND P.nombreProveedor LIKE (CASE WHEN @NOMBREPROVEEDOR='*' THEN   '%%' ELSE  '%'+@NOMBREPROVEEDOR+'%' END ) AND C.apellidoCliente LIKE (CASE WHEN @APELLIDOUSUARIO='*' THEN   '%%' ELSE  '%'+@APELLIDOUSUARIO+'%' END ) AND C.nombreCliente LIKE (CASE WHEN @NOMBREUSUARIO='*' THEN   '%%' ELSE '%'+@NOMBREUSUARIO+'%' END )

GO
/****** Object:  StoredProcedure [dbo].[sp_venta]    Script Date: 05/11/2016 20:34:54 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ventaXapunte]    Script Date: 05/11/2016 20:34:54 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_ventaXdia]    Script Date: 05/11/2016 20:34:54 ******/
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
