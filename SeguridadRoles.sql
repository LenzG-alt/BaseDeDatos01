USE Proyecto

-- Para ver aspectos básicos de seguridad

-- Crear roles de lectura
CREATE ROLE rol_lectura;
GRANT SELECT ON Cliente TO rol_lectura;
GRANT SELECT ON Producto TO rol_lectura;
GRANT SELECT ON Venta TO rol_lectura;

CREATE LOGIN UsuarioLector2 WITH PASSWORD = 'Lector2025';
CREATE USER UsuarioLector2 FOR LOGIN UsuarioLector2;
EXEC sp_addrolemember 'rol_lectura', 'UsuarioLector2';


