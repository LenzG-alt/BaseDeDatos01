USE Proyecto

-- Para vistas (Detalle completo de una venta)

CREATE VIEW Vista_DetalleVentas AS
SELECT 
  V.id_venta,
  V.fecha_venta,
  C.nombres + ' ' + C.apellido_paterno + ' ' + C.apellido_materno AS cliente,
  P.nombre AS producto,
  DV.cantidad,
  DV.precio_unitario,
  DV.subtotal
FROM Venta V
JOIN Cliente C ON V.id_cliente = C.id_cliente
JOIN DetalleVenta DV ON V.id_venta = DV.id_venta
JOIN Producto P ON DV.id_producto = P.id_producto;

-- Para el stock bajo

CREATE VIEW Vista_ProductosStockBajo AS
SELECT nombre, stock
FROM Producto
WHERE stock <= 5;

SELECT * FROM Vista_DetalleVentas
SELECT * FROM Vista_ProductosStockBajo
