-- ALTER: Modifica la estructura de una tabla.
-- Ejemplo: Agrega una nueva columna llamada 'ciudad' a la tabla 'Cliente'.
ALTER TABLE Cliente
ADD ciudad NVARCHAR(50) NULL;

-- DROP: Elimina un objeto de la base de datos.
-- Ejemplo: Elimina la columna 'ciudad' de la tabla 'Cliente'.
ALTER TABLE Cliente
DROP COLUMN ciudad;

-- WHERE: Filtra registros basados en una condición.
-- Ejemplo: Selecciona todos los productos con un precio mayor a 100.
SELECT nombre, precio
FROM Producto
WHERE precio > 100;

-- YEAR y DAY: Funciones para extraer partes de una fecha.
-- Ejemplo: Selecciona todas las ventas realizadas en el año 2024.
SELECT *
FROM Venta
WHERE YEAR(fecha_venta) = 2024;

-- Ejemplo: Selecciona el día de la semana de la fecha de venta.
SELECT fecha_venta, DAY(fecha_venta) AS dia_de_venta
FROM Venta;

-- ORDER BY: Ordena el resultado de una consulta.
-- Ejemplo: Ordena los productos por precio de forma ascendente.
SELECT nombre, precio
FROM Producto
ORDER BY precio ASC;

-- TOP: Limita el número de registros devueltos.
-- Ejemplo: Selecciona los 3 productos más caros.
SELECT TOP 3 nombre, precio
FROM Producto
ORDER BY precio DESC;

-- LIKE: Busca patrones en cadenas de caracteres.
-- Ejemplo: Selecciona todos los clientes cuyo apellido comienza con 'G'.
SELECT nombre, apellido
FROM Cliente
WHERE apellido LIKE 'G%';

-- INNER JOIN (JOIN): Devuelve solo las filas que coinciden en ambas tablas.
-- Ejemplo: Selecciona el nombre del cliente y el total de sus ventas.
SELECT c.nombre, v.total
FROM Cliente c
JOIN Venta v ON c.id_cliente = v.id_cliente;

-- LEFT JOIN (LEFT OUTER JOIN): Devuelve todas las filas de la tabla izquierda y las filas coincidentes de la tabla derecha.
--Si no hay coincidencia, los resultados de la tabla derecha son NULL.
-- Ejemplo: Selecciona todos los clientes y sus ventas, incluso si no han realizado ninguna venta.
SELECT c.nombre, v.total
FROM Cliente c
LEFT JOIN Venta v ON c.id_cliente = v.id_cliente;

-- RIGHT JOIN (RIGHT OUTER JOIN): Devuelve todas las filas de la tabla derecha y las filas coincidentes de la tabla izquierda.
--Si no hay coincidencia, los resultados de la tabla izquierda son NULL.
-- Ejemplo: Selecciona todas las ventas y los clientes correspondientes, incluso si no hay cliente.
SELECT c.nombre, v.total
FROM Cliente c
RIGHT JOIN Venta v ON c.id_cliente = v.id_cliente;

-- DISTINCT: Elimina filas duplicadas de los resultados de una consulta.
-- Ejemplo: Selecciona todos los diferentes paises de origen de las marcas.
SELECT DISTINCT pais_origen
FROM Marca;


ALTER TABLE Venta
ADD id_empleado INT NULL,
CONSTRAINT fk_venta_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado);

SELECT v.id_cliente, c.nombre, SUM(v.total) AS total_ventas
FROM Venta v
JOIN Cliente c ON v.id_cliente = c.id_cliente
GROUP BY v.id_cliente, c.nombre
HAVING SUM(v.total) > 100;
