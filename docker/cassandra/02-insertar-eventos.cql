USE campuscloud_eventos;

-- Estudiante 1 (5 eventos; el primero queda fuera del periodo de consulta)
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (1, '2026-10-28 09:15:00+0000', 'EVT-1001', 101, 'CONSULTA_CATALOGO', 'Consulta del catalogo de tutorias');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (1, '2026-11-03 09:20:00+0000', 'EVT-1002', 101, 'SOLICITUD_CREADA', 'Solicitud de tutoria de bases de datos');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (1, '2026-11-10 16:00:00+0000', 'EVT-1003', 101, 'ASISTENCIA', 'Asistio a sesion de tutoria');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (1, '2026-11-12 11:30:00+0000', 'EVT-1004', 104, 'DESCARGA_RECURSO', 'Descarga de guia digital');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (1, '2026-11-14 13:45:00+0000', 'EVT-1005', 105, 'CONSULTA_CATALOGO', 'Registro duplicado por error de cliente');

-- Estudiante 2 (4 eventos)
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (2, '2026-11-02 10:00:00+0000', 'EVT-2001', 103, 'CONSULTA_CATALOGO', 'Consulta de laboratorios');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (2, '2026-11-04 12:10:00+0000', 'EVT-2002', 103, 'SOLICITUD_CREADA', 'Reserva de laboratorio');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (2, '2026-11-09 08:50:00+0000', 'EVT-2003', 103, 'ASISTENCIA', 'Uso de laboratorio');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (2, '2026-11-13 17:20:00+0000', 'EVT-2004', 104, 'DESCARGA_RECURSO', 'Descarga de articulo');

-- Estudiante 3 (4 eventos)
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (3, '2026-11-01 15:00:00+0000', 'EVT-3001', 105, 'CONSULTA_CATALOGO', 'Consulta de servicios');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (3, '2026-11-05 09:30:00+0000', 'EVT-3002', 105, 'SOLICITUD_CREADA', 'Solicitud de servicio');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (3, '2026-11-11 14:00:00+0000', 'EVT-3003', 105, 'ASISTENCIA', 'Asistencia confirmada');
INSERT INTO eventos_por_estudiante (estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento, detalle) VALUES (3, '2026-11-15 10:10:00+0000', 'EVT-3004', 105, 'CANCELACION', 'Cancelacion por el estudiante');

SELECT count(*) AS total_eventos FROM eventos_por_estudiante;
SELECT estudiante_id, fecha_evento, evento_id, servicio_id, tipo_evento FROM eventos_por_estudiante;