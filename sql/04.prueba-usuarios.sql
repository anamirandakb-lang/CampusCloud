SELECT * FROM Estudiantes;

INSERT INTO Estudiantes
VALUES (4 , 24300635,'ANA KAREN MIRANDA BARRETO','24300635@UTTT.EDU.MX');

UPDATE Estudiantes
SET Nombre = 'Hector LARA Luna'
WHERE IdEstudiante = 8;

DELETE Estudiantes
WHERE IdEstudiante = 2;

--cambiar al contexto del usuario
EXECUTE AS USER = 'consulta_campus';
GO

SELECT * FROM Estudiantes;
SELECT * FROM Servicios;
SELECT * FROM Solicitudes;

--regresar
REVERT
GO

--Cambiarnos al contexto de el usuario operador 
EXECUTE AS USER = 'operador_campus'
GO

SELECT 
	SYSTEM_USER AS [LOGIN ORIGINAL],
	CURRENT_USER AS [USUARIO DB ACTUAL],
	USER_NAME() AS [NOMBRE USUARIO]

--regresar al que estabamos
REVERT