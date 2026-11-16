-- Permisos sobre talbas y listas
-- Asignación directa a usuarios o roles sobre talbas especificas

-------------------------------------
EXECUTE AS USER = 'admin_server';

SELECT 
	SUSER_NAME() AS [LOGIN],
	SUSER_NAME() AS [USUARIO ACTUAL];

REVERT;
GO
---------------------------------------------

USE CampusCloud;

CREATE VIEW v_solicitudes_2026
AS
SELECT 
	e.Nombre,
	s.FechaSolicitud,
	s.Estado
FROM Estudiantes AS e
INNER JOIN Solicitudes AS s
ON e.IdEstudiante = s.IdEstudiante
WHERE DATEPART(YEAR,s.FechaSolicitud)=2026;

SELECT * FROM v_solicitudes_2026;

-- permitir la lectura en una tabla especifica 
GRANT SELECT ON dbo.Estudiantes 
TO admin_server;

EXECUTE AS USER = 'admin_server';

SELECT * FROM dbo.Estudiantes;
SELECT * FROM dbo.Servicios;
SELECT * FROM dbo.Solicitudes;

REVERT;

-- permitir inserción y actualización en la tabla Servios
GRANT INSERT,UPDATE 
ON dbo.Servicios
TO admin_server;

GRANT SELECT 
ON dbo.Servicios
TO admin_server;

EXECUTE AS USER = 'admin_server';

SELECT * FROM Servicios;

INSERT INTO Servicios
VALUES (6,'BECAS','serv b',1);

UPDATE Servicios
SET Descripcion = 'Poco dinero'
WHERE IdServicio = 4;

REVERT
GO

--permiso total de codigo sql DML sobre una tabla 
GRANT SELECT,INSERT, UPDATE, DELETE 
ON dbo.solicitudes
TO admin_server;

EXECUTE AS USER = 'admin_server';

SELECT * FROM Solicitudes;

INSERT INTO Solicitudes
VALUES (1003, 2, 5, '2026-10-12', 'Pendiente');

UPDATE Solicitudes
SET Estado = 'Pendiente'
WHERE IdSolicitud = 1003;

DELETE Solicitudes
WHERE IdSolicitud = 1003;

-- Denegar explicitamente la eliminacion de registro
DENY DELETE ON dbo.Solicitudes TO admin_server;

REVERT;
GO

-- Quitar los permisos 
REVOKE UPDATE,DELETE,INSERT,SELECT ON dbo.Solicitudes
FROM admin_server;