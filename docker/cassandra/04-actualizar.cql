USE campuscloud_eventos;

-- ANTES
SELECT estudiante_id, fecha_evento, evento_id, tipo_evento, detalle
FROM eventos_por_estudiante
WHERE estudiante_id = 1 AND fecha_evento = '2026-11-03 09:20:00+0000' AND evento_id = 'EVT-1002';

-- UPDATE controlado: PK completa (en Cassandra un UPDATE sobre PK inexistente crearia la fila)
UPDATE eventos_por_estudiante
SET detalle = 'Solicitud de tutoria aprobada por el coordinador'
WHERE estudiante_id = 1 AND fecha_evento = '2026-11-03 09:20:00+0000' AND evento_id = 'EVT-1002';

-- DESPUES
SELECT estudiante_id, fecha_evento, evento_id, tipo_evento, detalle
FROM eventos_por_estudiante
WHERE estudiante_id = 1 AND fecha_evento = '2026-11-03 09:20:00+0000' AND evento_id = 'EVT-1002';