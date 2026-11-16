// Consulta 1: servicios usados por un estudiante (Valeria Torres, id 1)
MATCH (e:Estudiante {estudiante_id: 1})-[u:USA]->(s:Servicio)
RETURN e.nombre AS estudiante, s.servicio_id AS servicio_id, s.nombre AS servicio, u.frecuencia AS frecuencia, u.veces AS veces
ORDER BY servicio_id;

// Consulta 2: estudiantes que comparten un servicio (Biblioteca Digital, 104)
MATCH (e:Estudiante)-[:USA]->(s:Servicio {servicio_id: 104})
RETURN s.nombre AS servicio, e.estudiante_id AS id, e.nombre AS estudiante, e.carrera AS carrera
ORDER BY id;

// Consulta 3: recomendacion para Luis Mendoza (id 2)
// Servicios que usan los estudiantes con quienes comparte servicio y que el aun no usa
MATCH (yo:Estudiante {estudiante_id: 2})-[:USA]->(:Servicio)<-[:USA]-(par:Estudiante)-[:USA]->(rec:Servicio)
WHERE par <> yo AND NOT (yo)-[:USA]->(rec)
RETURN rec.servicio_id AS servicio_id, rec.nombre AS recomendado,
       count(DISTINCT par) AS pares_que_lo_usan, collect(DISTINCT par.nombre) AS recomendado_por
ORDER BY pares_que_lo_usan DESC, servicio_id;