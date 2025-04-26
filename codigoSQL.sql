CREATE TABLE Cliente (
  id_cliente INT PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  email VARCHAR(100),
  telefono VARCHAR(20),
  direccion VARCHAR(100),
  fecha_registro DATE
);

CREATE TABLE Marca (
  id_marca INT PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(50),
  pais_origen VARCHAR(50)
);

CREATE TABLE Categoria (
  id_categoria INT PRIMARY KEY IDENTITY(1,1),
  nombre_categoria VARCHAR(50)
);

CREATE TABLE Talla (
  id_talla INT PRIMARY KEY IDENTITY(1,1),
  descripcion VARCHAR(10)
);

CREATE TABLE Producto (
  id_producto INT PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(50),
  descripcion TEXT,
  precio DECIMAL(10, 2),
  stock INT,
  id_marca INT,
  id_categoria INT,
  id_talla INT,
  CONSTRAINT fk_producto_marca FOREIGN KEY (id_marca) REFERENCES Marca(id_marca),
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
  CONSTRAINT fk_producto_talla FOREIGN KEY (id_talla) REFERENCES Talla(id_talla)
);

CREATE TABLE Venta (
  id_venta INT PRIMARY KEY IDENTITY(1,1),
  fecha_venta DATE,
  id_cliente INT,
  total DECIMAL(10, 2),
  CONSTRAINT fk_venta_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE DetalleVenta (
  id_detalleV INT PRIMARY KEY IDENTITY(1,1),
  id_venta INT,
  id_producto INT,
  cantidad INT,
  precio_unitario DECIMAL(10, 2),
  subtotal DECIMAL(10, 2),
  CONSTRAINT fk_detalleventa_venta FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
  CONSTRAINT fk_detalleventa_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Proveedor (
  id_proveedor INT PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(50),
  telefono VARCHAR(20),
  email VARCHAR(100),
  direccion VARCHAR(100)
);

CREATE TABLE Compra (
  id_compra INT PRIMARY KEY IDENTITY(1,1),
  id_proveedor INT,
  fecha_compra DATE,
  total DECIMAL(10, 2),
  CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);

CREATE TABLE DetalleCompra (
  id_detalleC INT PRIMARY KEY IDENTITY(1,1),
  id_compra INT,
  id_producto INT,
  cantidad INT,
  precio_compra DECIMAL(10, 2),
  subtotal DECIMAL(10, 2),
  CONSTRAINT fk_detallecompra_compra FOREIGN KEY (id_compra) REFERENCES Compra(id_compra),
  CONSTRAINT fk_detallecompra_producto FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

CREATE TABLE Empleado (
  id_empleado INT PRIMARY KEY IDENTITY(1,1),
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  cargo VARCHAR(50),
  fecha_ingreso DATE
);
