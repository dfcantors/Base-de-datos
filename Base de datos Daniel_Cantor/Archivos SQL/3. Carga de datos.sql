SHOW VARIABLES LIKE 'secure_file_priv'; -- Para verificar la carpeta para subir datos

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/clientes_final.csv'
INTO TABLE clientes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;  -- Ignora los encabezados
-- -----------------------------

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/usuarios_internos.csv'
INTO TABLE usuarios_internos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
-- ----------------------------

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/solicitudes.csv'
INTO TABLE solicitudes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(id_solicitud, id_client, id_asigned_to,state,created_at, @closed_at) -- variable intermedia para tratar los vacios
SET closed_at = NULLIF(@closed_at, '');
