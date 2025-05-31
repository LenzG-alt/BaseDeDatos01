-- Indices

-- 1. �ndice para b�squeda por fecha de venta
CREATE NONCLUSTERED INDEX idx_venta_fecha ON Venta(fecha_venta);

-- 2. �ndice para mejorar b�squeda por categor�a en productos
CREATE NONCLUSTERED INDEX idx_producto_categoria ON Producto(id_categoria);

-- 3. �ndice para b�squeda de empleados por cargo
CREATE NONCLUSTERED INDEX idx_empleado_cargo ON Empleado(cargo);

EXEC sp_helpindex 'Empleado'
