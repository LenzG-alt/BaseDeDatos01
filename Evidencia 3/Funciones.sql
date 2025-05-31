-- Nombre completo de persona
CREATE FUNCTION dbo.fn_NombreCompleto(@id_persona INT)
RETURNS NVARCHAR(101)
AS
BEGIN
    DECLARE @nombreCompleto NVARCHAR(101);

    SELECT @nombreCompleto = nombre + ' ' + apellido
    FROM Persona
    WHERE id_persona = @id_persona;

    IF @nombreCompleto IS NULL
        RETURN 'No se encontró persona con ese ID';

    RETURN @nombreCompleto;
END;
GO

-- Ver nombre completo persona con id 1:
SELECT dbo.fn_NombreCompleto(100) AS NombreCompleto;

-- Precio actual de un producto
CREATE FUNCTION dbo.fn_PrecioActual(@id_producto INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @precio DECIMAL(10,2);

    SELECT @precio = precio
    FROM HistorialPrecio
    WHERE id_producto = @id_producto AND fecha_fin IS NULL;

    IF @precio IS NULL
        RETURN 'No hay precio actual registrado';

    RETURN CAST(@precio AS NVARCHAR(50));
END;
GO

-- Ver precio actual producto con id 1:
SELECT dbo.fn_PrecioActual(50) AS PrecioActual;

-- Stock actual de un producto
CREATE FUNCTION dbo.fn_StockActual(@id_producto INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @stock INT;

    SELECT @stock = 
        SUM(CASE WHEN tipo_movimiento = 'entrada' THEN cantidad 
                 WHEN tipo_movimiento = 'salida' THEN -cantidad 
                 ELSE 0 END)
    FROM MovimientoInventario
    WHERE id_producto = @id_producto;

    IF @stock IS NULL OR @stock = 0
        RETURN 'No hay movimientos de este producto';

    RETURN 'Stock actual: ' + CAST(@stock AS NVARCHAR(20));
END;
GO

-- Ver stock actual producto con id 1:
SELECT dbo.fn_StockActual(50) AS StockActual;

