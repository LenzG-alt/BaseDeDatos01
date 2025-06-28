import pyodbc
from faker import Faker
import random
from datetime import datetime, timedelta
from tqdm import tqdm

# ================================
# LIBRERÍAS NECESARIAS:
# pip install faker pyodbc tqdm
# ================================

# 1. CONEXIÓN A LA BASE DE DATOS SQL SERVER
conn = pyodbc.connect(
    'DRIVER={ODBC Driver 17 for SQL Server};'
    'SERVER=DESKTOP-09L3ADS;'
    'DATABASE=Proyecto;'
    'Trusted_Connection=yes;'
)
cursor = conn.cursor()

fake = Faker('es_ES')

# 2. INSERTAR PERSONAS
def insertar_personas(n=50000):
    for _ in tqdm(range(n), desc="Personas"):
        nombre = fake.first_name()
        apellido = fake.last_name()
        email = fake.email()
        telefono = fake.phone_number()
        direccion = fake.address().replace('\n', ', ')[:50]
        cursor.execute("""
            INSERT INTO Persona (nombre, apellido, email, telefono, direccion)
            VALUES (?, ?, ?, ?, ?)
        """, (nombre, apellido, email, telefono, direccion))
    conn.commit()

# 3. CLIENTES Y EMPLEADOS
def insertar_clientes_empleados():
    cursor.execute("SELECT id_persona FROM Persona ORDER BY id_persona")
    personas = cursor.fetchall()
    for p in personas[:30000]:
        fecha = fake.date_between(start_date='-2y', end_date='today')
        cursor.execute("INSERT INTO Cliente (id_persona, fecha_registro) VALUES (?, ?)", (p[0], fecha))

    cargos = ['Vendedor'] * 15 + ['Administrador'] * 3 + ['Almacenero'] * 2
    for idx, p in enumerate(personas[30000:]):
        cargo = cargos[idx % len(cargos)]
        fecha = fake.date_between(start_date='-3y', end_date='-1y')
        cursor.execute("INSERT INTO Empleado (id_persona, cargo, fecha_ingreso) VALUES (?, ?, ?)", (p[0], cargo, fecha))
    conn.commit()

# 4. MARCAS, CATEGORIAS, TALLAS
def insertar_estaticos():
    for _ in range(20):
        cursor.execute("INSERT INTO Marca (nombre, pais_origen) VALUES (?, ?)", (fake.company(), fake.country()))
    for cat in ['Camisas', 'Pantalones', 'Zapatos', 'Accesorios', 'Casacas']:
        cursor.execute("INSERT INTO Categoria (nombre_categoria) VALUES (?)", (cat,))
    for t in ['S', 'M', 'L', 'XL', 'XXL']:
        cursor.execute("INSERT INTO Talla (descripcion) VALUES (?)", (t,))
    conn.commit()
 
# 5. PRODUCTOS y PRECIOS
def insertar_productos(n=5000):
    cursor.execute("SELECT id_marca FROM Marca")
    marcas = [row[0] for row in cursor.fetchall()]
    cursor.execute("SELECT id_categoria FROM Categoria")
    categorias = [row[0] for row in cursor.fetchall()]
    cursor.execute("SELECT id_talla FROM Talla")
    tallas = [row[0] for row in cursor.fetchall()]

    for _ in tqdm(range(n), desc="Productos"):
        nombre = fake.word().capitalize()[:50]
        descripcion = fake.sentence()[:255]
        id_marca = random.choice(marcas)
        id_categoria = random.choice(categorias)
        id_talla = random.choice(tallas)
        cursor.execute("""
            INSERT INTO Producto (nombre, descripcion, id_marca, id_categoria, id_talla)
            VALUES (?, ?, ?, ?, ?)
        """, (nombre, descripcion, id_marca, id_categoria, id_talla))
    conn.commit()

def insertar_historial_precios():
    cursor.execute("SELECT id_producto FROM Producto")
    productos = cursor.fetchall()
    for prod in productos:
        fecha_inicio = fake.date_between(start_date='-1y', end_date='-3mo')
        precio = round(random.uniform(20, 500), 2)
        cursor.execute("INSERT INTO HistorialPrecio (id_producto, precio, fecha_inicio) VALUES (?, ?, ?)", (prod[0], precio, fecha_inicio))
    conn.commit()

# 6. PROVEEDORES y COMPRAS
def insertar_proveedores():
    for _ in range(50):
        cursor.execute("INSERT INTO Proveedor (nombre, telefono, email, direccion) VALUES (?, ?, ?, ?)",                   
            fake.company()[:50],
            fake.phone_number()[:50],
            fake.company_email()[:50],
            fake.address().replace('\n', ', ')[:50]
)

    conn.commit()

def insertar_compras(n=1000):
    cursor.execute("SELECT id_proveedor FROM Proveedor")
    proveedores = cursor.fetchall()
    cursor.execute("SELECT id_producto FROM Producto")
    productos = cursor.fetchall()
    for _ in tqdm(range(n), desc="Compras"):
        proveedor = random.choice(proveedores)[0]
        fecha = fake.date_between(start_date='-6mo', end_date='today')
        total = 0
        detalles = []
        for _ in range(random.randint(1, 5)):
            prod = random.choice(productos)[0]
            cantidad = random.randint(1, 10)
            precio = round(random.uniform(10, 200), 2)
            subtotal = cantidad * precio
            total += subtotal
            detalles.append((prod, cantidad, precio, subtotal))
        cursor.execute("INSERT INTO Compra (id_proveedor, fecha_compra, total) VALUES (?, ?, ?)", (proveedor, fecha, total))
        id_compra = cursor.execute("SELECT @@IDENTITY").fetchval()
        for d in detalles:
            cursor.execute("INSERT INTO DetalleCompra (id_compra, id_producto, cantidad, precio_compra, subtotal) VALUES (?, ?, ?, ?, ?)", (id_compra, d[0], d[1], d[2], d[3]))
    conn.commit()

# 7. VENTAS
def insertar_ventas(n=2000):
    cursor.execute("SELECT id_cliente FROM Cliente")
    clientes = cursor.fetchall()
    cursor.execute("SELECT id_empleado, cargo FROM Empleado")
    empleados = cursor.fetchall()
    vendedores = [e[0] for e in empleados if e[1] == 'Vendedor']
    cursor.execute("SELECT id_producto FROM Producto")
    productos = cursor.fetchall()

    for _ in tqdm(range(n), desc="Ventas"):
        cliente = random.choices(clientes, weights=[0.6]*10000 + [0.3]*10000 + [0.1]*10000, k=1)[0][0]
        empleado = random.choice(vendedores)
        fecha = fake.date_between(start_date='-3mo', end_date='today')
        total = 0
        detalles = []
        for _ in range(random.randint(1, 5)):
            prod = random.choice(productos)[0]
            cantidad = random.randint(1, 3)
            precio = round(random.uniform(25, 450), 2)
            subtotal = cantidad * precio
            total += subtotal
            detalles.append((prod, cantidad, precio, subtotal))
        cursor.execute("INSERT INTO Venta (fecha_venta, id_cliente, id_empleado, total) VALUES (?, ?, ?, ?)", (fecha, cliente, empleado, total))
        id_venta = cursor.execute("SELECT @@IDENTITY").fetchval()
        for d in detalles:
            cursor.execute("INSERT INTO DetalleVenta (id_venta, id_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?)", (id_venta, d[0], d[1], d[2], d[3]))
    conn.commit()

# 8. MOVIMIENTOS DE INVENTARIO
def insertar_movimientos(n=3000):
    cursor.execute("SELECT id_producto FROM Producto")
    productos = cursor.fetchall()
    cursor.execute("SELECT id_empleado FROM Empleado")
    empleados = cursor.fetchall()
    tipos = ['entrada', 'salida']
    for _ in tqdm(range(n), desc="MovInventario"):
        producto = random.choice(productos)[0]
        tipo = random.choices(tipos, weights=[0.4, 0.6])[0]
        cantidad = random.randint(1, 15)
        fecha = fake.date_between(start_date='-6mo', end_date='today')
        empleado = random.choice(empleados)[0]
        cursor.execute("INSERT INTO MovimientoInventario (id_producto, tipo_movimiento, cantidad, fecha, id_empleado) VALUES (?, ?, ?, ?, ?)", (producto, tipo, cantidad, fecha, empleado))
    conn.commit()

# EJECUCIÓN PRINCIPAL
def poblar_datos():
    insertar_personas()
    insertar_clientes_empleados()
    insertar_estaticos()
    insertar_productos()
    insertar_historial_precios()
    insertar_proveedores()
    insertar_compras()
    insertar_ventas()
    insertar_movimientos()
    print("\n✅ TODOS LOS DATOS INSERTADOS CORRECTAMENTE.")

poblar_datos()
conn.close()
