-- Indices

-- 1. Índice para búsqueda por fecha de venta
CREATE NONCLUSTERED INDEX idx_venta_fecha ON Venta(fecha_venta);

-- 2. Índice para mejorar búsqueda por categoría en productos
CREATE NONCLUSTERED INDEX idx_producto_categoria ON Producto(id_categoria);

-- 3. Índice para búsqueda de empleados por cargo
CREATE NONCLUSTERED INDEX idx_empleado_cargo ON Empleado(cargo);

EXEC sp_helpindex 'Empleado'
