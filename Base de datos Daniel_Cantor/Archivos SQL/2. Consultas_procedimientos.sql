-- Consultas  y procedimientos --------

-- 1 Todas las solicitudes abiertas por cliente
SELECT solicitudes.id_solicitud AS solicitud, 
		solicitudes.id_client,
        clientes.name_client AS Nombre_Cliente,
        state AS estado 
FROM solicitudes 
JOIN clientes 
	ON solicitudes.id_solicitud=clientes.id_cliente -- para mostrar el nombre
WHERE state= 'Abierta'
ORDER BY id_client;


-- 2 ---------
SELECT id_solicitud, TIMESTAMPDIFF(HOUR, created_at, closed_at) AS Tiempo_de_respuesta 
FROM Solicitudes
WHERE state = 'Cerrada';



-- 3 ----------
SELECT 	id_asigned_to, 
		usuarios_internos.name_intern AS Nombre_Usuario,
        COUNT(id_solicitud) AS Total_Solicitudes
FROM Solicitudes 
JOIN usuarios_internos
	ON solicitudes.id_asigned_to = usuarios_internos.intern_id -- nombre de los agentes
WHERE state ='Cerrada'
	AND closed_at >= DATE_SUB(NOW(), INTERVAL 1 MONTH)
GROUP BY id_asigned_to;


-- 4 ------
SELECT 	id_client,
		clientes.name_client AS Nombre_Cliente,
		COUNT(solicitudes.id_solicitud) AS Total_Solicitudes 
FROM solicitudes 		
JOIN clientes 
	ON solicitudes.id_solicitud=clientes.id_cliente
WHERE state = 'Abierta'
GROUP BY solicitudes.id_client, clientes.name_client 
ORDER BY Total_Solicitudes DESC;




-- 5 --------------
 
SELECT 
	AVG(TIMESTAMPDIFF(HOUR, solicitudes.created_at, historial_sub.PrimerCambio)) AS Tiempo_Promedio_Respuesta 
    FROM solicitudes
    JOIN ( 
		SELECT id_solicitud, MIN(changed_at) AS PrimerCambio 
        FROM historial 
        GROUP BY id_solicitud 
        ) historial_sub 
        ON solicitudes.id_solicitud = historial_sub.id_solicitud





-- Procedimiento de 30 dias

DELIMITER //
CREATE PROCEDURE Expiration()
BEGIN
	UPDATE solicitudes SET state ='Cerrada' 
    WHERE created_at < DATE_SUB(NOW(), INTERVAL 1 MONTH)
      AND state <> 'Cerrada'; -- evita renovar las ya cerradas
END//


Call Expiration;
