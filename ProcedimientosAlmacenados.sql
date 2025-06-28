USE Proyecto

CREATE PROCEDURE dbo.usp_ActualizarPrecio
    @id_producto INT,
    @nuevo_precio DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Producto WHERE id_producto = @id_producto)
    BEGIN
        RAISERROR('Producto no encontrado.', 16, 1);
        RETURN;
    END

    UPDATE Producto
    SET precio = @nuevo_precio
    WHERE id_producto = @id_producto;

    PRINT 'Precio actualizado correctamente para el producto ' + CAST(@id_producto AS NVARCHAR(10));
END;
GO


CREATE PROCEDURE dbo.usp_HistorialVentasCliente
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE id_cliente = @id_cliente)
    BEGIN
        RAISERROR('Cliente no encontrado.', 16, 1);
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Venta WHERE id_cliente = @id_cliente)
    BEGIN
        RAISERROR('No se encontraron ventas para este cliente.', 10, 1);
        RETURN;
    END

    SELECT 
        V.id_venta,
        V.fecha_venta,
        V.total AS total_venta,
        P.nombre AS producto,
        DV.cantidad,
        DV.precio_unitario,
        DV.subtotal
    FROM Venta V
    INNER JOIN DetalleVenta DV ON V.id_venta = DV.id_venta
    INNER JOIN Producto P ON DV.id_producto = P.id_producto
    WHERE V.id_cliente = @id_cliente
    ORDER BY V.fecha_venta DESC;
END;
GO

-- Producto inexistente
EXEC dbo.usp_ActualizarPrecio @id_producto = 9999, @nuevo_precio = 199.99, @fecha_inicio = GETDATE()
EXEC dbo.usp_ActualizarPrecio @id_producto = 11, @nuevo_precio = 75.99;

-- Cliente sin ventas
EXEC dbo.usp_HistorialVentasCliente @id_cliente = 4;

SELECT * FROM Producto
SELECT * FROM HistorialPrecioProducto
