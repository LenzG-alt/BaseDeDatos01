# 📦 Migración de Base de Datos MySQL a MongoDB - Proyecto Tienda

Este proyecto documenta la estructura y comandos necesarios para representar en **MongoDB** una base de datos originalmente diseñada en **MySQL** para una tienda. El modelo de Mongo aprovecha la flexibilidad de documentos y colecciones para representar entidades como `Persona`, `Cliente`, `Empleado`, `Producto`, `Venta`, etc.

---

## 🛠️ Base de Datos en MySQL (Original)

### Tablas principales:
- `Persona`: Datos personales comunes a clientes y empleados
- `Cliente`, `Empleado`: Extienden a `Persona`
- `Producto`: Información de productos
- `Marca`, `Categoria`, `Talla`: Atributos auxiliares del producto
- `HistorialPrecio`: Precios por periodo
- `MovimientoInventario`: Entradas/salidas por producto
- `Venta`, `DetalleVenta`: Información de ventas
- `Proveedor`, `Compra`, `DetalleCompra`: Información de compras

---

## 🍃 Estructura en MongoDB

MongoDB no usa claves foráneas ni JOINs. En su lugar:

- Se agrupan datos relacionados en un solo documento (incrustación).
- Se usa `_id` como identificador único.
- Las referencias (similares a claves foráneas) se hacen manualmente si es necesario.

---

## 📁 Estructura sugerida de colecciones MongoDB

```js
// Base de datos
use proyectoDB;
```

### 🧍‍♂️ personas
```js
db.personas.insertMany([
  {
    _id: 1,
    nombre: "Carlos",
    apellido: "Ramírez",
    email: "carlos.ramirez@example.com",
    telefono: "987654321",
    direccion: "Av. Siempre Viva 123"
  },
  {
    _id: 2,
    nombre: "María",
    apellido: "González",
    email: "maria.g@example.com",
    telefono: "912345678",
    direccion: "Calle Falsa 456"
  }
])
```

### 👥 clientes
```js
db.clientes.insertMany([
  { _id: 1, id_persona: 1, fecha_registro: ISODate("2023-01-15") },
  { _id: 2, id_persona: 2, fecha_registro: ISODate("2023-02-10") }
])
```

### 👷‍♂️ empleados
```js
db.empleados.insertMany([
  { _id: 1, id_persona: 6, cargo: "Vendedora", fecha_ingreso: ISODate("2022-05-10") },
  { _id: 2, id_persona: 7, cargo: "Almacenero", fecha_ingreso: ISODate("2021-11-20") }
])
```

### 🏷️ marcas, categorías, tallas
```js
db.marcas.insertMany([
  { _id: 1, nombre: "Nike", pais_origen: "Estados Unidos" },
  { _id: 2, nombre: "Adidas", pais_origen: "Alemania" }
])

db.categorias.insertMany([
  { _id: 1, nombre_categoria: "Camisetas" },
  { _id: 2, nombre_categoria: "Zapatillas" }
])

db.tallas.insertMany([
  { _id: 1, descripcion: "XS" },
  { _id: 2, descripcion: "S" },
  { _id: 3, descripcion: "M" }
])
```

### 🛒 productos
```js
db.productos.insertMany([
  {
    _id: 1,
    nombre: "Camiseta Deportiva",
    descripcion: "Camiseta de algodón con logo",
    id_marca: 1,
    id_categoria: 1,
    id_talla: 3
  },
  {
    _id: 2,
    nombre: "Zapatillas Running",
    descripcion: "Zapatillas con suela antideslizante",
    id_marca: 2,
    id_categoria: 2,
    id_talla: 4
  }
])
```

### 💰 historial_precios
```js
db.historial_precios.insertMany([
  {
    _id: 1,
    id_producto: 1,
    precio: 59.90,
    fecha_inicio: ISODate("2023-01-01"),
    fecha_fin: null
  }
])
```

### 📦 inventario
```js
db.movimientos_inventario.insertMany([
  {
    _id: 1,
    id_producto: 1,
    tipo_movimiento: "entrada",
    cantidad: 20,
    fecha: ISODate("2025-05-30"),
    id_empleado: 2
  }
])
```

### 🧾 ventas y detalles
```js
db.ventas.insertMany([
  {
    _id: 1,
    fecha_venta: ISODate("2024-01-10"),
    id_cliente: 1,
    id_empleado: 1,
    total: 209.90
  }
])

db.detalles_venta.insertMany([
  {
    id_venta: 1,
    id_producto: 1,
    cantidad: 1,
    precio_unitario: 59.90,
    subtotal: 59.90
  }
])
```

### 🚚 proveedores, compras y detalles
```js
db.proveedores.insertMany([
  {
    _id: 1,
    nombre: "Distribuciones Globales",
    telefono: "989898989",
    email: "ventas@distribuciones.com",
    direccion: "Av. Industrial 123"
  }
])

db.compras.insertMany([
  {
    _id: 1,
    id_proveedor: 1,
    fecha_compra: ISODate("2023-12-01"),
    total: 1200.00
  }
])

db.detalles_compra.insertMany([
  {
    id_compra: 1,
    id_producto: 1,
    cantidad: 10,
    precio_compra: 50.00,
    subtotal: 500.00
  }
])
```

---

## 📌 Comandos útiles

| Acción                    | Comando MongoDB                                                                 |
|---------------------------|----------------------------------------------------------------------------------|
| Crear BD                  | `use proyectoDB`                                                                |
| Ver colecciones           | `show collections`                                                              |
| Ver todos los documentos  | `db.ventas.find().pretty()`                                                     |
| Buscar por campo          | `db.personas.find({nombre: "Carlos"}).pretty()`                                |
| Actualizar documento      | `db.personas.updateOne({_id: 1}, {$set: {telefono: "936321950"}})`              |
| Eliminar documento        | `db.ventas.deleteOne({_id: 1})`                                                 |

---

## 📚 Notas

- MongoDB permite mucha más flexibilidad: puedes añadir campos nuevos sin modificar el esquema.
- Si necesitas anidar objetos (por ejemplo, `detalle_venta` dentro de `venta`), también es posible.
- Las relaciones complejas se deben manejar desde la lógica de tu aplicación, ya que MongoDB no hace JOINs nativamente.

---
