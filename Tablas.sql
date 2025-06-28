-- Crear base de datos
CREATE DATABASE Proyecto;
GO
USE Proyecto;
GO

-- Para los clientes --
CREATE TABLE Cliente (
  id_cliente INT IDENTITY(1,1) PRIMARY KEY,
  nombres NVARCHAR(50) NOT NULL,
  apellido_paterno NVARCHAR(50) NOT NULL,
  apellido_materno NVARCHAR(50) NOT NULL,
  email NVARCHAR(100),
  telefono NVARCHAR(20),
  direccion NVARCHAR(255),
  fecha_registro DATE DEFAULT GETDATE(),
  activo BIT DEFAULT 1
);

-- Para la marca --
CREATE TABLE Marca (
  id_marca INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(50) NOT NULL,
  pais_origen NVARCHAR(50)
);

-- ´Para la categoría -- 
CREATE TABLE Categoria (
  id_categoria INT IDENTITY(1,1) PRIMARY KEY,
  nombre_categoria NVARCHAR(50) NOT NULL
);

-- Para la talla --
CREATE TABLE Talla (
  id_talla INT IDENTITY(1,1) PRIMARY KEY,
  descripcion NVARCHAR(20) NOT NULL
);

-- Para el producto --
CREATE TABLE Producto (
  id_producto INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(50) NOT NULL,
  descripcion NVARCHAR(255),
  precio DECIMAL(10,2) CHECK (precio >= 0),
  stock INT CHECK (stock >= 0),
  id_marca INT,
  id_categoria INT,
  id_talla INT,
  activo BIT DEFAULT 1,
  FOREIGN KEY (id_marca) REFERENCES Marca(id_marca),
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  FOREIGN KEY (id_talla) REFERENCES Talla(id_talla)
);

-- Para el proveedor --
CREATE TABLE Proveedor (
  id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
  nombre NVARCHAR(50) NOT NULL,
  telefono NVARCHAR(20),
  email NVARCHAR(100),
  direccion NVARCHAR(255)
);

-- Para la compra --
CREATE TABLE Compra (
  id_compra INT IDENTITY(1,1) PRIMARY KEY,
  id_proveedor INT,
  fecha_compra DATE DEFAULT GETDATE(),
  total DECIMAL(10,2) CHECK (total >= 0),
  FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- Para detalle compras --
CREATE TABLE DetalleCompra (
  id_detalle_compra INT IDENTITY(1,1) PRIMARY KEY,
  id_compra INT,
  id_producto INT,
  cantidad INT CHECK (cantidad > 0),
  precio_compra DECIMAL(10,2) CHECK (precio_compra >= 0),
  subtotal AS (cantidad * precio_compra) PERSISTED,
  FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Para el empleado --
CREATE TABLE Empleado (
  id_empleado INT IDENTITY(1,1) PRIMARY KEY,
  nombres NVARCHAR(50) NOT NULL,
  apellido_paterno NVARCHAR(50) NOT NULL,
  apellido_materno NVARCHAR(50) NOT NULL,
  cargo NVARCHAR(50) NOT NULL,
  fecha_ingreso DATE DEFAULT GETDATE(),
  activo BIT DEFAULT 1
);

-- Para la venta --
CREATE TABLE Venta (
  id_venta INT IDENTITY(1,1) PRIMARY KEY,
  fecha_venta DATE DEFAULT GETDATE(),
  id_cliente INT,
  total DECIMAL(10,2) CHECK (total >= 0),
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Para el DetalleVenta --
CREATE TABLE DetalleVenta (
  id_detalle_venta INT IDENTITY(1,1) PRIMARY KEY,
  id_venta INT,
  id_producto INT,
  cantidad INT CHECK (cantidad > 0),
  precio_unitario DECIMAL(10,2) CHECK (precio_unitario >= 0),
  subtotal AS (cantidad * precio_unitario) PERSISTED,
  FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Historico de precios
CREATE TABLE HistorialPrecioProducto (
  id_historial INT IDENTITY(1,1) PRIMARY KEY,
  id_producto INT,
  precio_anterior DECIMAL(10,2),
  precio_nuevo DECIMAL(10,2),
  fecha_cambio DATETIME DEFAULT GETDATE(),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
