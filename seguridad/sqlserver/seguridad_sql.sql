-- Comprobar el login actual 

SELECT SUSER_NAME() AS loginActual;

--Verificar los privilegios sysadmin -> ES UN ROL DE SERVIDOR 

SELECT IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin]

-- 1 -> Pertenece al rol consultado
-- 0 -> No pertenece a ese rol
--NULL -> cuando no pertenece ese login a ese rol

--HACERLO EN EL .md

SELECT 
	SUSER_NAME() AS LoginActual,
	IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin]
GO

--consultar el estado sa

SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';

-- name -> nombre del principal o del usurario, rol, login 
-- type_desc -> tipo principal, para este caso el principal es SQL_LOGIN 
--	is_disabled -> 0 significa habilitado y 1 desabilitado

--verificar la bd actual 
SELECT DB_NAME() AS DBActual;

-- master es la bd administrativa de sqlserver 

--consulta completa del contexto 
SELECT 
	SUSER_SNAME() AS LoginActual,
	USER_NAME() AS UsiarioBDActual,
	DB_NAME() AS BDActual,
	IS_SRVROLEMEMBER('sysadmin') AS EsSysadmin;


-- creacion de prueba de un administrador alernativo 
--para hacer un login siempre se tiene que estar en master

USE master;

-- Crear login llamado admin_sql

CREATE LOGIN admin_sql
WITH PASSWORD = 'Admin.cloud12',
CHECK_POLICY = ON;

--verificar si existe y esta habilitado 

SELECT
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'admin_sql';

--demostrar que crear un login no lo hace administrador
SELECT IS_SRVROLEMEMBER('sysadmin', 'admin_sql') AS EsSysadmin
--Quiere decir que al marcar 0 nuestro login no es sysadmin

 
 -- agregar admin_sql al rol servidor sysadmin
 ALTER SERVER ROLE sysadmin
 ADD MEMBER admin_sql;

 --validad la nueva membresia
SELECT IS_SRVROLEMEMBER('sysadmin', 'admin_sql') AS EsSysadmin

--desabilitacion controlada de sa 

ALTER LOGIN sa DISABLE;

--consultar el estado de sa

SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';