Use Proyecto

-- INSERTAR CLIENTES
INSERT INTO Cliente (nombre, apellido, email, telefono, direccion, fecha_registro) VALUES
('Carlos', 'Ramírez', 'carlos.ramirez@example.com', '987654321', 'Av. Siempre Viva 123', '2023-01-15'),
('María', 'González', 'maria.g@example.com', '912345678', 'Calle Falsa 456', '2023-02-10'),
('Luis', 'Torres', 'luis.torres@example.com', '934567890', 'Jr. Amazonas 321', '2023-03-05'),
('Ana', 'López', 'ana.lopez@example.com', '987123456', 'Av. Perú 100', '2023-03-20'),
('Pedro', 'Martínez', 'pedro.martinez@example.com', '956789123', 'Jr. Lima 234', '2023-04-01');

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

-- INSERTAR PRODUCTOS
INSERT INTO Producto (nombre, descripcion, precio, stock, id_marca, id_categoria, id_talla) VALUES
('Camiseta Deportiva', 'Camiseta de algodón con logo', 59.90, 50, 1, 1, 3),
('Zapatillas Running', 'Zapatillas con suela antideslizante', 150.00, 30, 2, 2, 4),
('Pantalón Jogger', 'Pantalón cómodo para entrenamiento', 89.50, 20, 3, 3, 4),
('Zapatillas Urbanas', 'Diseño moderno y casual', 120.00, 40, 1, 2, 5),
('Chaqueta Deportiva', 'Chaqueta impermeable con capucha', 160.00, 15, 4, 4, 5),
('Gorra Clásica', 'Gorra con visera curva y logo', 29.90, 60, 2, 5, 2),
('Cinturón Deportivo', 'Cinturón ajustable para correr', 25.00, 80, 5, 5, 1);

-- INSERTAR VENTAS
INSERT INTO Venta (fecha_venta, id_cliente, total) VALUES
('2024-01-10', 1, 209.90),
('2024-02-05', 2, 150.00),
('2024-02-20', 3, 120.00),
('2024-03-10', 4, 59.90),
('2024-03-15', 5, 185.00);

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

-- INSERTAR EMPLEADOS
INSERT INTO Empleado (nombre, apellido, cargo, fecha_ingreso) VALUES
('Andrea', 'Pérez', 'Vendedora', '2022-05-10'),
('Jorge', 'Sánchez', 'Almacenero', '2021-11-20'),
('Lucía', 'Fernández', 'Cajera', '2023-03-01'),
('Ricardo', 'Núñez', 'Gerente de tienda', '2020-07-01'),
('Valeria', 'Salinas', 'Encargada de inventario', '2022-10-25');

