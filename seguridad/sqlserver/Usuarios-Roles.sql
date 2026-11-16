--create data base for new users

--seleccionar a master y crear la db

USE master;
GO

CREATE DATABASE empresaVentas;
GO

--Verificar que la db existe 

SELECT
	name,
	state_desc
FROM sys.databases
WHERE name = 'empresaVentas';

USE empresaVentas;
GO 

CREATE TABLE dbo.productos (
	Idproducto INT PRIMARY KEY,
	Nombre VARCHAR(100) NOT NULL,
	Precio DECIMAL(10 ,2) NOT NULL,
	Existencia INT NOT NULL
);

--verificar que el login sea sysadmin
SELECT 
	IS_SRVROLEMEMBER('sysadmin','vendedor1') AS EsSysadmin;

--crear usuario asociado al login

USE empresaVentas;
GO

CREATE USER vendedor1 
FOR LOGIN vendedor1;

CREATE TABLE dbo.clientes (
	Idcliente INT PRIMARY KEY,
	Nombre VARCHAR(100) NOT NULL,
	Correo VARCHAR(150)
);
GO
CREATE TABLE dbo.ventas (
	Idventa INT PRIMARY KEY,
	Idcliente INT NOT NULL,
	Fecha DATE NOT NULL,
	Total DECIMAL(10,2)
);
GO 

CREATE SCHEMA rh;
GO 

CREATE TABLE rh.nomina (
	id INT PRIMARY KEY IDENTITY(1,1),
	numero_nomina VARCHAR(50) NOT NULL UNIQUE,
	total DECIMAL(10,2) NOT NULL,
	CHECK (total > 0.0)
	);
GO

INSERT INTO dbo.productos (Idproducto,Nombre,Precio,Existencia)
VALUES 
(1, 'Laptop', 1800.0,10),
(2, 'Monitor', 6789.5,10),
(3, 'Teclado', 850.0,10),
(4, 'Mouse', 229.0,10),
(5, 'Extensión', 199.0,10),
(6, 'Cargador', 978.0,10);
GO
INSERT INTO dbo.clientes (Idcliente,Nombre,Correo)
VALUES
(1, 'Ana Miranda', 'miranda@gmail.com'),
(2, 'Alfedo Moroni', 'moroni@gmail.com'),
(3, 'Andrea Torres', 'torres@gmail.com'),
(4, 'Denisse Garcia', 'denisse@gmail.com'),
(5, 'Zoe Barreto', 'barreto@gmail.com'),
(6, 'Karen Barreto', 'barreto@gmail.com');

INSERT INTO dbo.ventas (Idventa,Idcliente,Fecha, Total)
VALUES
	(1,1,'2026-10-01',1800.0),
	(2,2,'2026-10-04',234.0),
	(3,3,'2026-10-05',6352.0),
	(4,4,'2026-10-06',1842.0),
	(5,5,'2026-10-11',573.0),
	(6,6,'2026-10-17',5483.0),
	(7,1,'2026-10-16',1789.0);

--crear un login operativo vendedor1
--los login son a nivel servidor y los usuarios son a niver db
USE master;
GO
SELECT DB_NAME() AS [Base de Datos Actual];
--crear login
CREATE LOGIN vendedor1
WITH PASSWORD = 'v@ENDEDOR1.',
CHECK_POLICY = ON;
GO
--verificar que el login existe
SELECT
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'vendedor1';


--verificar que el login sea sysadmin
SELECT 
	IS_SRVROLEMEMBER('sysadmin','vendedor1') AS EsSysadmin;

--crear usuario asociado al login

USE empresaVentas;
GO

CREATE USER vendedor1 
FOR LOGIN vendedor1;


SELECT 
	name,
	type_desc,
	authentication_type_desc
FROM sys.database_principals
WHERE name = 'vendedor1';


--conceder permisos de select pero directamente al usuario vendedor1 
REVOKE SELECT 
ON dbo.clientes
TO vendedor1;

REVOKE SELECT 
ON dbo.productos
TO vendedor1;

REVOKE SELECT 
ON dbo.ventas
TO vendedor1;

REVOKE INSERT 
ON dbo.ventas
TO vendedor1;
--quitar 
REVOKE SELECT 
ON dbo.productos
FROM vendedor1;

SELECT
pr.name AS PRINCIPAL,
pe.permission_name AS PERMISO,
pe.state_desc AS ESTADO,
OBJECT_NAME(pe.major_id) AS OBJETO
FROM sys.database_permissions AS pe
INNER JOIN sys.database_principals AS pr
ON pe.grantee_principal_id = pr.principal_id
WHERE pr.name = 'vendedor1'

--Crear un rol vendedor y administracion de permisos mediante roles
USE empresaVentas;
--crear rol 
CREATE ROLE rol_vendedor;

--verificar rol 
SELECT 
	name,
	type_desc
FROM sys.database_principals
WHERE name = 'rol_vendedor';

--quitar el permiso de select a vendedor1 de la tabla productos
REVOKE SELECT
ON dbo.productos
FROM vendedor1;
--agregar vendedor1 al rol_vendedor
ALTER ROLE rol_vendedor
ADD MEMBER vendedor1;

--verificar que esta la membrecia del usuario en el rol 
SELECT 
	r.name AS [ROL],
	u.name AS [USUARIO]
FROM sys.database_role_members AS drm
INNER JOIN sys.database_principals AS r
ON drm.role_principal_id = r.principal_id
INNER JOIN sys.database_principals AS u
ON drm.member_principal_id = u.principal_id
WHERE r.name = 'rol_vendedor';

--Conseder permisos de select sobre al rol 
GRANT SELECT 
ON dbo.productos 
TO rol_vendedor;
GO
GRANT INSERT, UPDATE
ON dbo.clientes
TO rol_vendedor;
GO
GRANT SELECT 
ON dbo.productos
TO rol_vendedor;
GO
GRANT SELECT 
ON dbo.ventas
TO rol_vendedor;
GO
GRANT INSERT 
ON dbo.ventas
TO rol_vendedor;
GO
GRANT SELECT
ON rh.nomina
TO rol_vendedor;

-- hacer vendedor2 y ascociar al rol 
USE master;
GO

CREATE LOGIN vendedor2
WITH PASSWORD = 'v@ENDEDOR2.',
CHECK_POLICY = ON;
GO

--crear usuario asociado al login

USE empresaVentas;
GO

CREATE USER vendedor2 
FOR LOGIN vendedor2;

--agregar vendedor2 al rol_vendedor
ALTER ROLE rol_vendedor
ADD MEMBER vendedor2;

-- Consultar los permisos 

SELECT 
	pr.name AS PRINCIPAL,
	p.permission_name AS PERMISO
FROM sys.database_permissions AS p
INNER JOIN sys.database_principals AS pr
ON p.grantee_principal_id = pr.principal_id;
--permisos de rol especifico
SELECT 
	pr.name AS PRINCIPAL,
	p.permission_name AS PERMISO,
	p.state_desc AS ESTADO,
	OBJECT_NAME(p.major_id) AS OBJETO
FROM sys.database_permissions AS p
INNER JOIN sys.database_principals AS pr
ON p.grantee_principal_id = pr.principal_id
WHERE pr.name = 'rol_vendedor';