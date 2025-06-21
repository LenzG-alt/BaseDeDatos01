# 📦 MySQL a MongoDB - Proyecto Tienda

Este proyecto documenta la estructura y comandos necesarios para representar en **MongoDB** una base de datos originalmente diseñada en **MySQL** para una tienda. El modelo de Mongo aprovecha la flexibilidad de documentos y colecciones para representar entidades como `Persona`, `Cliente`, `Empleado`, `Producto`, `Venta`, etc.

---

## 📌 Comandos útiles

| Acción                            | Comando MongoDB                                                                 |
|-----------------------------------|----------------------------------------------------------------------------------|
| Crear base de datos               | `use proyectoDB`                                                                |
| Ver todas las bases de datos      | `show dbs`                                                                      |
| Crear colección                   | `db.createCollection("productos")`                                              |
| Ver colecciones                   | `show collections`                                                              |
| Insertar un documento             | `db.personas.insertOne({ _id: 1, nombre: "Carlos", apellido: "Ramírez" })`      |
| Insertar con subdocumentos        | `db.ventas.insertOne({ _id: 1, total: 1200, detalles: [{ producto: "A", cantidad: 2 }] })` |
| Ver todos los documentos          | `db.ventas.find().pretty()`                                                     |
| Buscar por campo                  | `db.personas.find({ nombre: "Carlos" }).pretty()`                               |
| Buscar por subdocumento           | `db.ventas.find({ "detalles.producto": "A" }).pretty()`                          |
| Actualizar documento              | `db.personas.updateOne({ _id: 1 }, { $set: { telefono: "900000000" } })`        |
| Eliminar documento                | `db.ventas.deleteOne({ _id: 1 })`                                               |
| Eliminar todos los documentos     | `db.productos.deleteMany({})`                                                   |
| Eliminar una colección            | `db.productos.drop()`                                                           |                                    |
| Contar documentos                 | `db.personas.countDocuments()`                                                  |

---

## ✍️ Autores

Piero Adrián Delgado Chipana
Sebastian Adriano Castro Mamani
Davis Yovanny Arapa Chua
  
