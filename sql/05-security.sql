use master;
GO 

--crear un login 
CREATE LOGIN consulta_campus
WITH PASSWORD = 'Pssw0rd123Consulta!';

--seleccionamos Campus cloud y creamos el usuario asociado 
USE CampusCloud;
GO 

CREATE USER consulta_campus
FOR LOGIN consulta_campus;
GO 

--crear rol_consulta
CREATE ROLE rol_consulta;

--permisos de lectura
GRANT SELECT TO rol_consulta;

--agregamos el usuario al rol 
ALTER ROLE rol_consulta
ADD MEMBER consulta_campus;

--login operador 
USE master;
GO

CREATE LOGIN operador_campus
WITH PASSWORD = 'OperadorP@ssw0rd123?'

USE CampusCloud;
GO 

CREATE USER operador_campus
FOR LOGIN operador_campus;

CREATE ROLE rol_operador;

GRANT SELECT, INSERT, UPDATE
TO rol_operador;
GO

ALTER ROLE rol_operador
ADD MEMBER operador_campus;
GO 

-- CREAR ADMIN
USE master;
GO 

CREATE LOGIN admin_campus
WITH PASSWORD = 'Admin1P@ssword09.'

USE CampusCloud;
GO 

CREATE USER admin_campus
FROM LOGIN admin_campus;
GO 

ALTER ROLE db_owner
ADD MEMBER admin_campus;
 