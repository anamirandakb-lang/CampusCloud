USE campuscloud_eventos;

-- ANTES
SELECT estudiante_id, fecha_evento, evento_id, detalle
FROM eventos_por_estudiante WHERE estudiante_id = 1;

-- DELETE controlado: solo el registro duplicado EVT-1005
DELETE FROM eventos_por_estudiante
WHERE estudiante_id = 1 AND fecha_evento = '2026-11-14 13:45:00+0000' AND evento_id = 'EVT-1005';

-- DESPUES
SELECT estudiante_id, fecha_evento, evento_id, detalle
FROM eventos_por_estudiante WHERE estudiante_id = 1;

SELECT count(*) AS total_eventos FROM eventos_por_estudiante;   