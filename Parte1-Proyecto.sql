CREATE DATABASE Proyecto;

USE Proyecto;

CREATE TABLE EMPLEADO (
    Id_Empleado INT AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Fecha_Ingreso DATE NOT NULL,
    PRIMARY KEY (Id_Empleado)
);

CREATE TABLE Cliente (
    Id_Cliente INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion TEXT,
    Fecha_Registro DATE
);

CREATE TABLE Venta (
    Id_Venta INT PRIMARY KEY,
    Id_Cliente INT,
    Fecha_Venta DATE,
    Total FLOAT,
    CONSTRAINT fk_cliente_venta FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);
##MOdificar NOmbre y pasi
CREATE TABLE Marca (
    Id_Marca INT PRIMARY KEY,
    Nombre VARCHAR(100), 
    Pais VARCHAR(100)
);

ALTER TABLE Marca MODIFY Nombre VARCHAR(50);
ALTER TABLE Marca MODIFY Pais VARCHAR(50);

CREATE TABLE Proveedor (
	Id_Proveedor INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Telefono VARCHAR(20),
    Email VARCHAR(100),
    Direccion TEXT
);

CREATE TABLE Compra (
    Id_Compra INT PRIMARY KEY,
    Id_Proveedor INT,
    Fecha_Compra DATE,
    Total FLOAT,
    CONSTRAINT fk_proveedor_compra FOREIGN KEY (Id_Proveedor) REFERENCES Proveedor(Id_Proveedor)
);

CREATE TABLE Producto (
    Id_Producto INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Categoria VARCHAR(50),
    Talla VARCHAR(50),
    Stock INT,
    Precio FLOAT,
    Direccion TEXT,
    Id_Marca INT,
    CONSTRAINT fk_marca_producto FOREIGN KEY (Id_Marca) REFERENCES Marca(Id_Marca)
);

CREATE TABLE DetalleCompra (
    Id_DetalleC INT PRIMARY KEY,
    Id_Compra INT,
    Id_Producto INT,
    Cantidad INT,
    Precio_Compra FLOAT,
    Subtotal FLOAT,
    CONSTRAINT fk_compra_detalle FOREIGN KEY (Id_Compra) REFERENCES Compra(Id_Compra),
    CONSTRAINT fk_producto_detalleC FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);

CREATE TABLE DetalleVenta (
    Id_DetalleV INT PRIMARY KEY,
    Id_Venta INT,
    Id_Producto INT,
    Cantidad INT,
    Precio_Unitario FLOAT,
    Subtotal FLOAT,
    CONSTRAINT fk_venta_detalle FOREIGN KEY (Id_Venta) REFERENCES Venta(Id_Venta),
    CONSTRAINT fk_producto_detalle FOREIGN KEY (Id_Producto) REFERENCES Producto(Id_Producto)
);








