CREATE DATABASE Proyecto
USE Proyecto

EXEC sp_addtype TNoNulo, 'nvarchar(50)', 'Not null'
EXEC sp_addtype TNulo, 'nvarchar(50)', 'Null'

-- TABLA CLIENTE
CREATE TABLE Cliente (
  id_cliente INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Cliente PRIMARY KEY,
  nombre TNoNulo,
  apellido TNoNulo,
  email TNulo,
  telefono TNulo,
  direccion TNulo,
  fecha_registro DATE NULL
);

-- TABLA MARCA
CREATE TABLE Marca (
  id_marca INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Marca PRIMARY KEY,
  nombre TNoNulo,
  pais_origen TNulo
);

-- TABLA CATEGORIA
CREATE TABLE Categoria (
  id_categoria INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Categoria PRIMARY KEY,
  nombre_categoria TNoNulo
);

-- TABLA TALLA
CREATE TABLE Talla (
  id_talla INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Talla PRIMARY KEY,
  descripcion TNoNulo
);

-- TABLA PRODUCTO
CREATE TABLE Producto (
  id_producto INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Producto PRIMARY KEY,
  nombre TNoNulo,
  descripcion NVARCHAR(255) NULL,
  precio DECIMAL(10,2) NULL,
  stock INT NULL,
  id_marca INT NULL,
  id_categoria INT NULL,
  id_talla INT NULL,
  CONSTRAINT fk_producto_marca FOREIGN KEY (id_marca) REFERENCES Marca(id_marca),
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  CONSTRAINT fk_producto_talla FOREIGN KEY (id_talla) REFERENCES Talla(id_talla)
);

-- TABLA VENTA
CREATE TABLE Venta (
  id_venta INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Venta PRIMARY KEY,
  fecha_venta DATE NULL,
  id_cliente INT NULL,
  total DECIMAL(10,2) NULL,
  CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- TABLA DETALLEVENTA
CREATE TABLE DetalleVenta (
  id_detalleV INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DetalleVenta PRIMARY KEY,
  id_venta INT NULL,
  id_producto INT NULL,
  cantidad INT NULL,
  precio_unitario DECIMAL(10,2) NULL,
  subtotal DECIMAL(10,2) NULL,
  CONSTRAINT fk_detalleventa_venta FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
  CONSTRAINT fk_detalleventa_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- TABLA PROVEEDOR
CREATE TABLE Proveedor (
  id_proveedor INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Proveedor PRIMARY KEY,
  nombre TNoNulo,
  telefono TNulo,
  email TNulo,
  direccion TNulo
);

-- TABLA COMPRA
CREATE TABLE Compra (
  id_compra INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Compra PRIMARY KEY,
  id_proveedor INT NULL,
  fecha_compra DATE NULL,
  total DECIMAL(10,2) NULL,
  CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

-- TABLA DETALLECOMPRA
CREATE TABLE DetalleCompra (
  id_detalleC INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_DetalleCompra PRIMARY KEY,
  id_compra INT NULL,
  id_producto INT NULL,
  cantidad INT NULL,
  precio_compra DECIMAL(10,2) NULL,
  subtotal DECIMAL(10,2) NULL,
  CONSTRAINT fk_detallecompra_compra FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
  CONSTRAINT fk_detallecompra_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- TABLA EMPLEADO
CREATE TABLE Empleado (
  id_empleado INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Empleado PRIMARY KEY,
  nombre TNoNulo,
  apellido TNoNulo,
  cargo TNoNulo,
  fecha_ingreso DATE NULL
);
