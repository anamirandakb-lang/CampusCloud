MATCH (e:Estudiante) WITH count(e) AS estudiantes
MATCH (s:Servicio) WITH estudiantes, count(s) AS servicios
MATCH ()-[r]->() RETURN estudiantes, servicios, count(r) AS relaciones;

MATCH (e:Estudiante {estudiante_id: 2})-[u:USA]->(s:Servicio {servicio_id: 103})
RETURN e.nombre AS estudiante, s.nombre AS servicio, u.frecuencia AS frecuencia, u.veces AS veces;