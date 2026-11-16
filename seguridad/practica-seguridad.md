# **ADMINISTRACIÓN DE SEGURIDAD SQL SERVER** 

## Fundamentos 

| Concepto | Nivel | Repósitorio | Ejemplo | 
|---|---|---|---|
|**Login**| Instancia de SQL Server | Autenticaruna identidad ante el Servidor | 'admin_sql' |
|**User**| Base de Datos | Representa la identidad ante la identidad ante el servidor | 'dbo' |
|**Rol de Servidor**| Instancia | Agrupa privilegios administrados a nivel servidor | 'sysadmin' |
|**Base de Datos Actual**| Sesión | Determina el contexto de ejecución de una consulta | 'master' | 

## 1. Diagnóstico de la conexión Administrativa


```sql
-- Comprobar el login actual 
SELECT SUSER_NAME() AS loginActual;
```
```sql
--Verificar los privilegios sysadmin -> ES UN ROL DE SERVIDOR 
SELECT IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin]
```

| Resultado | Interpretacion |  
|---|---|
| **1** | Pertenece al rol consultado
| **0**| No pertenece a ese rol
|**NULL**| cuando no pertenece ese login a ese rol

```sql
SELECT 
	SUSER_NAME() AS LoginActual,
	IS_SRVROLEMEMBER('sysadmin') AS [EsSysadmin]
GO
```
```sql
--consultar el estado sa
SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';
```

| Resultado | Interpretacion |  
|---|---|
|**name** | nombre del principal o del usurario, rol, login 
| **type_desc** | tipo principal, para este caso el principal es SQL_LOGIN 
|**is_disabled** | 0 significa habilitado y 1 desabilitado
```sql
--verificar la bd actual 
SELECT DB_NAME() AS DBActual;
```
- master es la bd administrativa de sqlserver 
```sql
--consulta completa del contexto 
SELECT 
	SUSER_SNAME() AS LoginActual,
	USER_NAME() AS UsiarioBDActual,
	DB_NAME() AS BDActual,
	IS_SRVROLEMEMBER('sysadmin') AS EsSysadmin;

```

## Creación y prueba de un Administrador Alternativo

```sql
--para hacer un login siempre se tiene que estar en master
USE master;
```
```sql
-- Crear login llamado admin_sql
CREATE LOGIN admin_sql
WITH PASSWORD = 'Admin.cloud12',
CHECK_POLICY = ON;
````
`CREATE LOGIN admin_sql` : este crea una identidad que puede autenticarse ante la instancia 

`WITH PASSWORD ` : Define una contraseña de autenticaciÓn SQL Server

`CHECK_POLICY = ON` : Activa las piliticas 

```sql
--desabilitacion controlada de sa 

ALTER LOGIN sa DISABLE;

--consultar el estado de sa

SELECT 
	name,
	type_desc,
	is_disabled
FROM sys.server_principals
WHERE name = 'sa';
```