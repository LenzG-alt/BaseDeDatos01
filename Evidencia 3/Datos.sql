USE Proyecto;
GO

-- INSERTAR PERSONAS PARA CLIENTES
INSERT INTO Persona (nombre, apellido, email, telefono, direccion) VALUES
('Carlos', 'Ramírez', 'carlos.ramirez@example.com', '987654321', 'Av. Siempre Viva 123'),
('María', 'González', 'maria.g@example.com', '912345678', 'Calle Falsa 456'),
('Luis', 'Torres', 'luis.torres@example.com', '934567890', 'Jr. Amazonas 321'),
('Ana', 'López', 'ana.lopez@example.com', '987123456', 'Av. Perú 100'),
('Pedro', 'Martínez', 'pedro.martinez@example.com', '956789123', 'Jr. Lima 234');

-- INSERTAR CLIENTES (referenciando personas)
INSERT INTO Cliente (id_persona, fecha_registro) VALUES
(1, '2023-01-15'),
(2, '2023-02-10'),
(3, '2023-03-05'),
(4, '2023-03-20'),
(5, '2023-04-01');

-- INSERTAR PERSONAS PARA EMPLEADOS
INSERT INTO Persona (nombre, apellido, email, telefono, direccion) VALUES
('Andrea', 'Pérez', NULL, NULL, NULL),
('Jorge', 'Sánchez', NULL, NULL, NULL),
('Lucía', 'Fernández', NULL, NULL, NULL),
('Ricardo', 'Núñez', NULL, NULL, NULL),
('Valeria', 'Salinas', NULL, NULL, NULL);

-- INSERTAR EMPLEADOS (referenciando personas)
INSERT INTO Empleado (id_persona, cargo, fecha_ingreso) VALUES
(6, 'Vendedora', '2022-05-10'),
(7, 'Almacenero', '2021-11-20'),
(8, 'Cajera', '2023-03-01'),
(9, 'Gerente de tienda', '2020-07-01'),
(10, 'Encargada de inventario', '2022-10-25');

-- INSERTAR MARCAS
INSERT INTO Marca (nombre, pais_origen) VALUES
('Nike', 'Estados Unidos'),
('Adidas', 'Alemania'),
('Puma', 'Alemania'),
('Reebok', 'Inglaterra'),
('Under Armour', 'Estados Unidos');

-- INSERTAR CATEGORÍAS
INSERT INTO Categoria (nombre_categoria) VALUES
('Camisetas'),
('Zapatillas'),
('Pantalones'),
('Chaquetas'),
('Accesorios');

-- INSERTAR TALLAS
INSERT INTO Talla (descripcion) VALUES
('XS'), ('S'), ('M'), ('L'), ('XL'), ('XXL');

-- INSERTAR PRODUCTOS (sin columna precio)
INSERT INTO Producto (nombre, descripcion, id_marca, id_categoria, id_talla) VALUES
('Camiseta Deportiva', 'Camiseta de algodón con logo', 1, 1, 3),
('Zapatillas Running', 'Zapatillas con suela antideslizante', 2, 2, 4),
('Pantalón Jogger', 'Pantalón cómodo para entrenamiento', 3, 3, 4),
('Zapatillas Urbanas', 'Diseño moderno y casual', 1, 2, 5),
('Chaqueta Deportiva', 'Chaqueta impermeable con capucha', 4, 4, 5),
('Gorra Clásica', 'Gorra con visera curva y logo', 2, 5, 2),
('Cinturón Deportivo', 'Cinturón ajustable para correr', 5, 5, 1);

-- INSERTAR HISTORIAL DE PRECIOS
INSERT INTO HistorialPrecio (id_producto, precio, fecha_inicio, fecha_fin) VALUES
(1, 59.90, '2023-01-01', NULL),
(2, 150.00, '2023-01-01', NULL),
(3, 89.50, '2023-01-01', NULL),
(4, 120.00, '2023-01-01', NULL),
(5, 160.00, '2023-01-01', NULL),
(6, 29.90, '2023-01-01', NULL),
(7, 25.00, '2023-01-01', NULL);

-- INSERTAR VENTAS
INSERT INTO Venta (fecha_venta, id_cliente, id_empleado, total) VALUES
('2024-01-10', 1, 1, 209.90),
('2024-02-05', 2, 2, 150.00),
('2024-02-20', 3, 3, 120.00),
('2024-03-10', 4, 4, 59.90),
('2024-03-15', 5, 5, 185.00);

-- INSERTAR DETALLE DE VENTAS
INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 59.90, 59.90),
(1, 3, 1, 89.50, 89.50),
(1, 4, 1, 60.50, 60.50),
(2, 2, 1, 150.00, 150.00),
(3, 4, 1, 120.00, 120.00),
(4, 1, 1, 59.90, 59.90),
(5, 5, 1, 160.00, 160.00),
(5, 6, 1, 25.00, 25.00);

-- INSERTAR PROVEEDORES
INSERT INTO Proveedor (nombre, telefono, email, direccion) VALUES
('Distribuciones Globales', '989898989', 'ventas@distribuciones.com', 'Av. Industrial 123'),
('Fashion Import', '977777777', 'contacto@fashionimport.com', 'Calle Comercio 99'),
('SportStyle Co.', '933333333', 'ventas@sportstyle.com', 'Av. Los Negocios 456');

-- INSERTAR COMPRAS
INSERT INTO Compra (id_proveedor, fecha_compra, total) VALUES
(1, '2023-12-01', 1200.00),
(2, '2024-01-15', 800.00),
(3, '2024-02-10', 950.00);

-- INSERTAR DETALLE DE COMPRAS
INSERT INTO DetalleCompra (id_compra, id_producto, cantidad, precio_compra, subtotal) VALUES
(1, 1, 10, 50.00, 500.00),
(1, 2, 5, 140.00, 700.00),
(2, 3, 8, 60.00, 480.00),
(2, 4, 4, 80.00, 320.00),
(3, 5, 5, 120.00, 600.00),
(3, 6, 10, 25.00, 250.00),
(3, 7, 4, 25.00, 100.00);

-- Insertar movimientos de inventario para productos con stock positivo
INSERT INTO MovimientoInventario (id_producto, tipo_movimiento, cantidad, fecha, id_empleado)
VALUES
(1, 'entrada', 20, '2025-05-30', 2),
(1, 'salida', 5, '2025-05-31', 1),
(2, 'entrada', 15, '2025-05-29', 2),
(3, 'entrada', 10, '2025-05-28', 3);
