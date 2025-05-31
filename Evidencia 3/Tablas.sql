-- CREAR BASE DE DATOS
CREATE DATABASE Proyecto;
GO
USE Proyecto;
GO

-- TIPOS DE DATOS PERSONALIZADOS
EXEC sp_addtype TNoNulo, 'nvarchar(50)', 'Not null';
EXEC sp_addtype TNulo, 'nvarchar(50)', 'Null';
GO

-- TABLA PERSONA
CREATE TABLE Persona (
  id_persona INT IDENTITY(1,1) PRIMARY KEY,
  nombre TNoNulo,
  apellido TNoNulo,
  email TNulo,
  telefono TNulo,
  direccion TNulo
);

-- TABLA CLIENTE
CREATE TABLE Cliente (
  id_cliente INT IDENTITY(1,1) PRIMARY KEY,
  id_persona INT NOT NULL,
  fecha_registro DATE NULL,
  FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

-- TABLA EMPLEADO
CREATE TABLE Empleado (
  id_empleado INT IDENTITY(1,1) PRIMARY KEY,
  id_persona INT NOT NULL,
  cargo TNoNulo,
  fecha_ingreso DATE NULL,
  FOREIGN KEY (id_persona) REFERENCES Persona(id_persona)
);

-- TABLA MARCA
CREATE TABLE Marca (
  id_marca INT IDENTITY(1,1) PRIMARY KEY,
  nombre TNoNulo,
  pais_origen TNulo
);

-- TABLA CATEGORIA
CREATE TABLE Categoria (
  id_categoria INT IDENTITY(1,1) PRIMARY KEY,
  nombre_categoria TNoNulo
);

-- TABLA TALLA
CREATE TABLE Talla (
  id_talla INT IDENTITY(1,1) PRIMARY KEY,
  descripcion TNoNulo
);

-- TABLA PRODUCTO
CREATE TABLE Producto (
  id_producto INT IDENTITY(1,1) PRIMARY KEY,
  nombre TNoNulo,
  descripcion NVARCHAR(255) NULL,
  id_marca INT NULL,
  id_categoria INT NULL,
  id_talla INT NULL,
  FOREIGN KEY (id_marca) REFERENCES Marca(id_marca),
  FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  FOREIGN KEY (id_talla) REFERENCES Talla(id_talla)
);

-- HISTORIAL DE PRECIOS
CREATE TABLE HistorialPrecio (
  id_historial INT IDENTITY(1,1) PRIMARY KEY,
  id_producto INT NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NULL,
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- INVENTARIO (MOVIMIENTOS EN VEZ DE STOCK DIRECTO)
CREATE TABLE MovimientoInventario (
  id_movimiento INT IDENTITY(1,1) PRIMARY KEY,
  id_producto INT NOT NULL,
  tipo_movimiento VARCHAR(20),
  cantidad INT NOT NULL,
  fecha DATE NOT NULL,
  id_empleado INT NULL,
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

-- TABLA VENTA
CREATE TABLE Venta (
  id_venta INT IDENTITY(1,1) PRIMARY KEY,
  fecha_venta DATE NULL,
  id_cliente INT NULL,
  id_empleado INT NULL,
  total DECIMAL(10,2) NULL,
  FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
  FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado)
);

-- DETALLE DE VENTA
CREATE TABLE DetalleVenta (
  id_detalleV INT IDENTITY(1,1) PRIMARY KEY,
  id_venta INT NULL,
  id_producto INT NULL,
  cantidad INT NULL,
  precio_unitario DECIMAL(10,2) NULL,
  subtotal DECIMAL(10,2) NULL,
  FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- TABLA PROVEEDOR
CREATE TABLE Proveedor (
  id_proveedor INT IDENTITY(1,1) PRIMARY KEY,
  nombre TNoNulo,
  telefono TNulo,
  email TNulo,
  direccion TNulo
);

-- TABLA COMPRA 
CREATE TABLE Compra (
  id_compra INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_Compra PRIMARY KEY,
  id_proveedor INT NOT NULL,
  fecha_compra DATE NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);


-- DETALLE DE COMPRA
CREATE TABLE DetalleCompra (
  id_detalleC INT IDENTITY(1,1) PRIMARY KEY,
  id_compra INT NULL,
  id_producto INT NULL,
  cantidad INT NULL,
  precio_compra DECIMAL(10,2) NULL,
  subtotal DECIMAL(10,2) NULL,
  FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
  FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TYPE dbo.ProductosVentaType AS TABLE (
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2)
);
GO
