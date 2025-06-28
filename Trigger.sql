USE Proyecto

-- Para triggers

CREATE TRIGGER trg_PrecioProductoUpdate
ON Producto
AFTER UPDATE
AS
BEGIN
  INSERT INTO HistorialPrecioProducto (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
  SELECT 
    I.id_producto,
    D.precio,
    I.precio,
    GETDATE()
  FROM inserted I
  JOIN deleted D ON I.id_producto = D.id_producto
  WHERE I.precio <> D.precio;
END;

DELETE FROM Cliente WHERE id_cliente = 3;

SELECT * FROM HistorialPrecioProducto
