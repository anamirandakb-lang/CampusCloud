USE campuscloud_eventos;

-- Consulta principal: actividad del estudiante 1 del 1 al 15 de noviembre de 2026
SELECT estudiante_id, fecha_evento, evento_id, tipo_evento, servicio_id
FROM eventos_por_estudiante
WHERE estudiante_id = 1
  AND fecha_evento >= '2026-11-01 00:00:00+0000'
  AND fecha_evento <  '2026-11-16 00:00:00+0000';

-- Variante: los 2 eventos mas recientes del estudiante 2
SELECT estudiante_id, fecha_evento, evento_id, tipo_evento
FROM eventos_por_estudiante
WHERE estudiante_id = 2
LIMIT 2;