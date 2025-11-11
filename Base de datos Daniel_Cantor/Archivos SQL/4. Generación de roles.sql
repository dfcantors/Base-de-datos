-- Creación de roles 

CREATE ROLE 'admin';
CREATE ROLE 'soporte'; 
CREATE ROLE 'cliente';

-- Asignación de permisos
GRANT ALL PRIVILEGES ON *.* TO 'admin';
GRANT SELECT, UPDATE ON prueba_sql.solicitudes TO 'soporte';
GRANT SELECT ON prueba_sql.solicitudes TO 'cliente';
