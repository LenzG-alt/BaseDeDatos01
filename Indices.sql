USE Proyecto

--Creamos índices --
CREATE INDEX idx_producto_marca ON Producto(id_marca);
CREATE INDEX idx_producto_categoria ON Producto(id_categoria);
CREATE INDEX idx_producto_talla ON Producto(id_talla);
CREATE INDEX idx_detalleventa_venta ON DetalleVenta(id_venta);
CREATE INDEX idx_detalleventa_producto ON DetalleVenta(id_producto);
CREATE INDEX idx_compra_proveedor ON Compra(id_proveedor);