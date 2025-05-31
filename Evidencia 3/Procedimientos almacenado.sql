-- Actualizar Precio con validación
CREATE PROCEDURE dbo.usp_ActualizarPrecio
    @id_producto INT,
    @nuevo_precio DECIMAL(10,2),
    @fecha_inicio DATE
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Producto WHERE id_producto = @id_producto)
    BEGIN
        PRINT 'Producto no encontrado';
        RETURN;
    END

    UPDATE HistorialPrecio
    SET fecha_fin = DATEADD(day, -1, @fecha_inicio)
    WHERE id_producto = @id_producto AND fecha_fin IS NULL;

    INSERT INTO HistorialPrecio (id_producto, precio, fecha_inicio, fecha_fin)
    VALUES (@id_producto, @nuevo_precio, @fecha_inicio, NULL);

    PRINT 'Precio actualizado correctamente para el producto ' + CAST(@id_producto AS NVARCHAR(10));
END;
GO

-- Prueba con producto inexistente
EXEC dbo.usp_ActualizarPrecio @id_producto = 9999, @nuevo_precio = 99.99, @fecha_inicio = GETDATE();

-- Historial ventas cliente con mensaje
CREATE PROCEDURE dbo.usp_HistorialVentasCliente
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM Cliente WHERE id_cliente = @id_cliente)
    BEGIN
        PRINT 'Cliente no encontrado';
        RETURN;
    END

    IF NOT EXISTS (
        SELECT 1 FROM Venta WHERE id_cliente = @id_cliente
    )
    BEGIN
        PRINT 'No se encontraron ventas para este cliente';
        RETURN;
    END

    SELECT v.id_venta, v.fecha_venta, v.total,
           dv.id_producto, dv.cantidad, dv.precio_unitario, dv.subtotal
    FROM Venta v
    INNER JOIN DetalleVenta dv ON v.id_venta = dv.id_venta
    WHERE v.id_cliente = @id_cliente
    ORDER BY v.fecha_venta DESC;
END;
GO

-- Prueba cliente sin ventas
EXEC dbo.usp_HistorialVentasCliente @id_cliente = 9999;


