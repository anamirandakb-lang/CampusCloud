USE campuscloud_eventos;

-- Filtrar por una columna que no es clave: Cassandra RECHAZA la consulta (error esperado)
SELECT * FROM eventos_por_estudiante WHERE tipo_evento = 'SOLICITUD_CREADA';

-- Con ALLOW FILTERING funciona, pero recorre todas las particiones (no escala)
SELECT estudiante_id, fecha_evento, tipo_evento
FROM eventos_por_estudiante WHERE tipo_evento = 'SOLICITUD_CREADA' ALLOW FILTERING;

-- Rango de fecha sin estudiante_id: tambien rechazado (error esperado)
SELECT * FROM eventos_por_estudiante WHERE fecha_evento >= '2026-11-01 00:00:00+0000';  