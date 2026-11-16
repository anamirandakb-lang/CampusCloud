-- 1. Gestión de roles fijos

-- A. Nivel de Servidor 
use master;
GO
CREATE LOGIN admin_sqlserver
WITH PASSWORD = 'P@ssword.'

--Agregar un inicio de sesión (LOGIN) al rol de administrador de servidor
ALTER SERVER ROLE sysadmin
ADD MEMBER admin_sqlserver

----------------
CREATE LOGIN admin_server
WITH PASSWORD = 'P@ssword@'

--Agregar al rol de creador de base de datos
ALTER SERVER ROLE dbcreator 
ADD MEMBER admin_server;

-- B Nivel Base de Datos
USE CampusCloud;
GO

CREATE USER admin_server
FOR LOGIN admin_server;


-- permitir solo lectura con un select en todas las tablas y vistas 
ALTER ROLE db_datareader
ADD MEMBER admin_server;

EXECUTE AS USER = 'admin_server';

SELECT * FROM Servicios;

DELETE FROM Servicios WHERE IdServicio = 1;


-- permitir solo escritura 
ALTER ROLE db_datawriter
ADD MEMBER admin_server;

EXECUTE AS USER = 'admin_server';

SELECT 
	SUSER_NAME() AS [LOGIN],
	SUSER_NAME() AS [USUARIO ACTUAL];

SELECT * FROM Servicios;

UPDATE Servicios
SET NombreServicio = ('cafeteria')
WHERE IdServicio = 4;

DELETE FROM Servicios;

REVERT;
GO 

ALTER ROLE db_datareader
DROP MEMBER admin_server;

ALTER ROLE db_datawriter
DROP MEMBER admin_server;

--permisos de el usuario 
SELECT 
	pr.name AS PRINCIPAL,
	p.permission_name AS PERMISO,
	p.state_desc AS ESTADO,
	OBJECT_NAME(p.major_id) AS OBJETO
FROM sys.database_permissions AS p
INNER JOIN sys.database_principals AS pr
ON p.grantee_principal_id = pr.principal_id
WHERE pr.name = 'admin_server';

--permite administracion de objetos (create,alter,drop)
ALTER ROLE db_ddladmin
ADD MEMBER admin_server;

ALTER ROLE db_ddladmin
DROP MEMBER admin_server;


EXECUTE AS USER = 'admin_server';

SELECT * FROM Servicios;

CREATE TABLE prueba_admin_server(
	Id INT NOT NULL,
	Nombre VARCHAR(100)
	);

DROP TABLE prueba_admin_server;

REVERT 

