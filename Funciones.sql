USE Proyecto

-- Funcion para obtener el nombre completo de un cliente --

CREATE FUNCTION fn_NombreCompletoCliente(@id_cliente INT)
RETURNS NVARCHAR(150)
AS
BEGIN
  DECLARE @nombre NVARCHAR(150)
  SELECT @nombre = nombres + ' ' + apellido_paterno + ' ' + apellido_materno
  FROM Cliente
  WHERE id_cliente = @id_cliente
  RETURN @nombre
END;

-- Para calcular el total vendido en un año -- 

CREATE FUNCTION fn_TotalVentas(@year INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
  DECLARE @total DECIMAL(10,2)
  SELECT @total = SUM(total)
  FROM Venta
  WHERE YEAR(fecha_venta) = @year;
  RETURN ISNULL(@total, 0);
END;

-- Para calcular el total vendido en un año -- 

CREATE FUNCTION fn_TotalCompras(@year INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
  DECLARE @total DECIMAL(10,2)
  SELECT @total = SUM(total)
  FROM Compra
  WHERE YEAR(fecha_compra) = @year;
  RETURN ISNULL(@total, 0);
END;

SELECT dbo.fn_TotalCompras(2024) AS Total_Ventas_2024;
SELECT dbo.fn_TotalVentas(2024) AS Total_Compras_2024;
SELECT dbo.fn_NombreCompletoCliente(3) AS NombreCompleto;




