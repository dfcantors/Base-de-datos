
-- Creacion de tablas----------------------------
CREATE  TABLE clientes(
	id_cliente INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    name_client varchar(50) NOT NULL,
    age INT NOT NULL,
    email varchar(50) UNIQUE
);

CREATE TABLE usuarios_internos(
	intern_id int PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    name_intern varchar(50) NOT NULL,
    rol ENUM('Admin', 'Agente') NOT NULL
);


CREATE TABLE solicitudes(
	id_solicitud INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_client INT NOT NULL, -- clave foranea
    id_asigned_to INT NOT NULL, -- clave foranea, a quien se le asigno la solicitud
    state ENUM('Abierta', 'En proceso', 'Cerrada') NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP, -- da la hora de la solicitud
    closed_at  TIMESTAMP NULL, -- hora en que se cierra la solicitud 
    
    
    FOREIGN KEY(id_client) REFERENCES Clientes(id_cliente),
    FOREIGN KEY(id_asigned_to) REFERENCES Usuarios_internos(intern_id)
);

CREATE TABLE historial(
	id_historial INT PRIMARY KEY UNIQUE NOT NULL AUTO_INCREMENT,
    id_solicitud INT NOT NULL, -- clave foranea
    id_asigned_to INT NOT NULL, -- clave foranea de quien tomó la solicitud
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- hora de la solicitud
    
    FOREIGN KEY(id_solicitud) REFERENCES Solicitudes(id_solicitud),
    FOREIGN KEY(id_asigned_to) REFERENCES Usuarios_internos(intern_id)
);

