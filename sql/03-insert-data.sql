USE CampusCloud;
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Estudiantes)
INSERT INTO dbo.Estudiantes (Matricula, Nombre, Correo) VALUES
 ('A2026001', N'Ana Lopez Ramirez',       N'a2026001@campuscloud.test'),
 ('A2026002', N'Bruno Garcia Torres',     N'a2026002@campuscloud.test'),
 ('A2026003', N'Carla Mendoza Ruiz',      N'a2026003@campuscloud.test'),
 ('A2026004', N'Diego Hernandez Soto',    N'a2026004@campuscloud.test'),
 ('A2026005', N'Elena Vargas Cruz',       N'a2026005@campuscloud.test'),
 ('A2026006', N'Fernando Castillo Rios',  N'a2026006@campuscloud.test'),
 ('A2026007', N'Gabriela Morales Paz',    N'a2026007@campuscloud.test'),
 ('A2026008', N'Hector Jimenez Luna',     N'a2026008@campuscloud.test'),
 ('A2026009', N'Irene Ortega Salinas',    N'a2026009@campuscloud.test'),
 ('A2026010', N'Jorge Navarro Medina',    N'a2026010@campuscloud.test');
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Servicios)
INSERT INTO dbo.Servicios (NombreServicio, Descripcion, Activo) VALUES
 (N'Constancia de estudios',    N'Emision de constancia oficial de estudios',   1),
 (N'Credencial universitaria',  N'Alta o reposicion de credencial',             1),
 (N'Asesoria academica',        N'Cita con tutor o asesor academico',           1),
 (N'Soporte tecnico',           N'Atencion a incidencias de equipo y red',      1),
 (N'Prestamo de equipo',        N'Prestamo temporal de laptop o proyector',     0);
GO

IF NOT EXISTS (SELECT 1 FROM dbo.Solicitudes)
INSERT INTO dbo.Solicitudes (IdEstudiante, IdServicio, FechaSolicitud, Estado)
SELECT e.IdEstudiante, s.IdServicio, v.Fecha, v.Estado
FROM (VALUES
 ('A2026001', N'Constancia de estudios',   '2026-09-01T09:15:00', 'Atendida'),
 ('A2026001', N'Credencial universitaria', '2026-09-03T10:00:00', 'Pendiente'),
 ('A2026002', N'Asesoria academica',       '2026-09-02T11:30:00', 'En proceso'),
 ('A2026003', N'Soporte tecnico',          '2026-09-02T12:45:00', 'Atendida'),
 ('A2026004', N'Constancia de estudios',   '2026-09-04T08:20:00', 'Pendiente'),
 ('A2026004', N'Soporte tecnico',          '2026-09-05T13:10:00', 'Cancelada'),
 ('A2026005', N'Credencial universitaria', '2026-09-05T09:40:00', 'Atendida'),
 ('A2026006', N'Asesoria academica',       '2026-09-06T15:00:00', 'Pendiente'),
 ('A2026007', N'Constancia de estudios',   '2026-09-07T10:25:00', 'En proceso'),
 ('A2026007', N'Asesoria academica',       '2026-09-08T16:05:00', 'Atendida'),
 ('A2026008', N'Soporte tecnico',          '2026-09-09T11:00:00', 'Pendiente'),
 ('A2026009', N'Credencial universitaria', '2026-09-10T09:00:00', 'En proceso'),
 ('A2026009', N'Constancia de estudios',   '2026-09-11T14:30:00', 'Pendiente'),
 ('A2026010', N'Asesoria academica',       '2026-09-12T12:00:00', 'Atendida'),
 ('A2026010', N'Soporte tecnico',          '2026-09-13T10:15:00', 'Pendiente')
) AS v (Matricula, Servicio, Fecha, Estado)
JOIN dbo.Estudiantes e ON e.Matricula      = v.Matricula
JOIN dbo.Servicios   s ON s.NombreServicio = v.Servicio;
GO

SELECT (SELECT COUNT(*) FROM dbo.Estudiantes) AS Estudiantes,
       (SELECT COUNT(*) FROM dbo.Servicios)   AS Servicios,
       (SELECT COUNT(*) FROM dbo.Solicitudes) AS Solicitudes;
GO
