USE Proyecto

--Consultas bádicas - Total de ventas por cliente

SELECT C.id_cliente, dbo.fn_NombreCompletoCliente(C.id_cliente) AS nombre_completo, COUNT(V.id_venta) AS num_ventas, SUM(V.total) AS total_gastado
FROM Cliente C
JOIN Venta V ON C.id_cliente = V.id_cliente
GROUP BY C.id_cliente;

-- Producto más vendido

SELECT P.nombre, SUM(DV.cantidad) AS total_vendidos
FROM Producto P
JOIN DetalleVenta DV ON P.id_producto = DV.id_producto
GROUP BY P.nombre
ORDER BY total_vendidos DESC;

