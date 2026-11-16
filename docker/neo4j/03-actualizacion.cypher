// ANTES
MATCH (e:Estudiante {estudiante_id: 2})-[u:USA]->(s:Servicio {servicio_id: 103})
RETURN e.nombre AS estudiante, s.nombre AS servicio, u.frecuencia AS frecuencia, u.veces AS veces;

// Modificacion controlada: solo esa relacion
MATCH (e:Estudiante {estudiante_id: 2})-[u:USA]->(s:Servicio {servicio_id: 103})
SET u.frecuencia = 'semanal', u.veces = u.veces + 1
RETURN e.nombre AS estudiante, s.nombre AS servicio, u.frecuencia AS frecuencia, u.veces AS veces;

// DESPUES (el total de relaciones no cambia)
MATCH (e:Estudiante {estudiante_id: 2})-[u:USA]->(s:Servicio {servicio_id: 103})
RETURN e.nombre AS estudiante, s.nombre AS servicio, u.frecuencia AS frecuencia, u.veces AS veces;
MATCH ()-[r]->() RETURN count(r) AS total_relaciones;