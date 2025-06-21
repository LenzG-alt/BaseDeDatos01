--Estos son comandos que use para generar los Json desde el Manage
--json de personas
SELECT 
    p.id_persona AS _id,
    p.nombre,
    p.apellido,
    p.email,
    p.telefono,
    p.direccion,
    (SELECT fecha_registro 
     FROM Cliente c 
     WHERE c.id_persona = p.id_persona 
     FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS cliente,
    (SELECT cargo, fecha_ingreso 
     FROM Empleado e 
     WHERE e.id_persona = p.id_persona 
     FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS empleado
FROM Persona p
FOR JSON PATH;

--json de marcas
SELECT 
    id_marca AS _id,
    nombre,
    pais_origen
FROM Marca
FOR JSON PATH;

--json de categorias
SELECT 
    id_categoria AS _id,
    nombre_categoria
FROM Categoria
FOR JSON PATH;

--json de tallas
SELECT 
    id_talla AS _id,
    descripcion
FROM Talla
FOR JSON PATH;

--json de productos
SELECT 
    p.id_producto AS _id,
    p.nombre,
    p.descripcion,
    p.id_marca,
    p.id_categoria,
    p.id_talla,
    h.precio AS precio_actual,
    h.fecha_inicio AS fecha_inicio_precio
FROM Producto p
LEFT JOIN HistorialPrecio h ON p.id_producto = h.id_producto AND h.fecha_fin IS NULL
FOR JSON PATH;

--json shitorial_precios
SELECT 
    id_historial AS _id,
    id_producto,
    precio,
    fecha_inicio,
    fecha_fin
FROM HistorialPrecio
FOR JSON PATH;

--json movimientos_inventario
SELECT 
    id_movimiento AS _id,
    id_producto,
    tipo_movimiento,
    cantidad,
    fecha,
    id_empleado
FROM MovimientoInventario
FOR JSON PATH;

--json ventas
SELECT 
    v.id_venta AS _id,
    v.fecha_venta,
    v.id_cliente,
    v.id_empleado,
    v.total,
    (SELECT dv.id_producto, dv.cantidad, dv.precio_unitario, dv.subtotal
     FROM DetalleVenta dv
     WHERE dv.id_venta = v.id_venta
     FOR JSON PATH) AS detalles
FROM Venta v
FOR JSON PATH;

--json proveedores
SELECT 
    id_proveedor AS _id,
    nombre,
    telefono,
    email,
    direccion
FROM Proveedor
FOR JSON PATH;

--json compras
SELECT 
    c.id_compra AS _id,
    c.id_proveedor,
    c.fecha_compra,
    c.total,
    (SELECT dc.id_producto, dc.cantidad, dc.precio_compra, dc.subtotal
     FROM DetalleCompra dc
     WHERE dc.id_compra = c.id_compra
     FOR JSON PATH) AS detalles
FROM Compra c
FOR JSON PATH;