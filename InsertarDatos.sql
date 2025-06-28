USE Proyecto

-- 5 CLIENTES

INSERT INTO Cliente (nombres, apellido_paterno, apellido_materno, email, telefono, direccion, fecha_registro)
VALUES ('Feliciana', 'Cantón', 'Amaya', 'feliciana.cantón@hotmail.com', '+34 833 21 81 96', 'Glorieta Joan Vazquez 408, Ceuta, 94026', '2024-03-18'),
('Leopoldo', 'Cortés', 'Garrido', 'leopoldo.cortés@yahoo.com', '+34 741 615 594', 'C. Cayetano Marcos 459 Puerta 1 , Sevilla, 41316', '2024-01-29'),
('Wilfredo', 'Patiño', 'Cánovas', 'wilfredo.patiño@yahoo.com', '+34 743 41 92 83','Callejón de Ángela Gimenez 40 Apt. 56 , Asturias, 95376', '2025-05-15'),
('Yaiza', 'Segarra', 'Clavero', 'yaiza.segarra@yahoo.com', '+34 938849696', 'Pasadizo Ana Bou 2, Santa Cruz de Tenerife, 69166', '2024-10-02'),
('Adelina', 'Ángel', 'Iglesias', 'adelina.ángel@hotmail.com', '+34 918 451 462', 'Pasadizo de María Belén Escalona 914, Burgos, 28809', '2024-03-05');

-- 10 PRODUCTOS
INSERT INTO Producto (nombre, descripcion, precio, stock, id_marca, id_categoria, id_talla)
VALUES
('Camisa Casual','Camisa de algodón color azul',49.90,20,1,1,2),
('Pantalón Jeans','Jean clásico corte recto',79.90,15,2,1,3),
('Zapatos Deportivos','Cómodos y resistentes',120.00,10,3,2,4),
('Smartphone X','Teléfono con cámara 12MP',599.99,30,4,3,NULL),
('Bolso de Mano','Bolso de cuero sintético',89.50,25,5,4,NULL),
('Laptop Ultra','Laptop 14\" i5 8GB',999.00,8,2,3,NULL),
('Cafetera','Cafetera automática 1.2L',150.00,12,3,5,NULL),
('Auriculares','In-ear con cancelación',199.99,18,4,3,NULL),
('Camiseta Deportiva','Secado rápido, cuello redondo',39.90,40,1,1,2),
('Reloj Inteligente','Smartwatch con GPS',249.99,22,4,3,NULL);

-- 5 TALLAS
INSERT INTO Talla (descripcion)
VALUES
('S'),
('M'),
('L'),
('XL'),
('XXL');

-- 5 categorías
INSERT INTO Categoria (nombre_categoria)
VALUES
('Ropa'),
('Calzado'),
('Electrónica'),
('Accesorios'),
('Hogar');

-- MARCA (5 marcas)
INSERT INTO Marca (nombre, pais_origen)
VALUES
('Marca A','Peru'),
('Marca B','USA'),
('Marca C','China'),
('Marca D','Alemania'),
('Marca E','Mexico');

-- PROVEEDOR (5 proveedores)
INSERT INTO Proveedor (nombre, telefono, email, direccion)
VALUES
('Proveedor A','+51912345678','contactoA@proveedor.com','Jr. Comercio 123'),
('Proveedor B','+51923456789','contactoB@proveedor.com','Jr. Central 456'),
('Proveedor C','+51934567890','contactoC@proveedor.com','Av. Principal 789'),
('Proveedor D','+51945678901','contactoD@proveedor.com','Calle Secundaria 101'),
('Proveedor E','+51956789012','contactoE@proveedor.com','Plaza 202');

-- EMPLEADO (10 empleados)
INSERT INTO Empleado (nombres, apellido_paterno, apellido_materno, cargo, fecha_ingreso)
VALUES
('Ana','Gonzales','Lopez','Vendedora', DATEADD(month,-12,GETDATE())),
('Luis','Martinez','Ramirez','Admin', DATEADD(year,-2,GETDATE())),
('Sofia','Perez','Sanchez','Contador', DATEADD(month,-18,GETDATE())),
('Carlos','Diaz','Torres','Bodeguero', DATEADD(month,-6,GETDATE())),
('Maria','Rios','Flores','Gerente', DATEADD(year,-3,GETDATE())),
('Jose','Vega','Mendoza','Vendedor', DATEADD(month,-9,GETDATE())),
('Lucia','Quispe','Huaman','Asistente', DATEADD(year,-1,GETDATE())),
('David','Chavez','Salas','Logistica', DATEADD(month,-15,GETDATE())),
('Elena','Tello','Castro','Marketing', DATEADD(month,-20,GETDATE())),
('Andres','Lozano','Cruz','Ventas', DATEADD(month,-8,GETDATE()));

-- Venta
DECLARE @id_venta1 INT;
INSERT INTO Venta (fecha_venta, id_cliente, total)
VALUES ('2024-12-02', 3, 320.38);
SET @id_venta1 = SCOPE_IDENTITY();
INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario)
VALUES (@id_venta1, 4, 2, 160.19);

DECLARE @id_venta2 INT;
INSERT INTO Venta (fecha_venta, id_cliente, total)
VALUES ('2024-09-22', 1, 99.55);
SET @id_venta2 = SCOPE_IDENTITY();
INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario)
VALUES (@id_venta2, 6, 1, 99.55);

-- COmpras
DECLARE @id_compra1 INT;
INSERT INTO Compra (id_proveedor, fecha_compra, total)
VALUES (3, '2024-08-02', 512.60);
SET @id_compra1 = SCOPE_IDENTITY();
INSERT INTO DetalleCompra (id_compra, id_producto, cantidad, precio_compra)
VALUES (@id_compra1, 9, 4, 128.15);

DECLARE @id_compra2 INT;
INSERT INTO Compra (id_proveedor, fecha_compra, total)
VALUES (1, '2025-05-19', 557.48);
SET @id_compra2 = SCOPE_IDENTITY();
INSERT INTO DetalleCompra (id_compra, id_producto, cantidad, precio_compra)
VALUES (@id_compra2, 6, 7, 79.64);

