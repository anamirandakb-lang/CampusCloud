use empresaVentas;

SELECT 
SUSER_NAME() AS [Login Actual],
SUSER_NAME() AS [Usuario Actual],
DB_NAME() AS [DB Actual]

--solo vendedor1 tiene acceso a la bd de empresaVentas pero no a sus tablas o a otra db 
SELECT * FROM dbo.ventas;
SELECT * FROM dbo.clientes;
SELECT * FROM dbo.productos;
SELECT * FROM rh.nomina;

-- se le dio permiso a la tabla productos y se le revocaron 
SELECT * FROM dbo.ventas;

INSERT INTO dbo.ventas
VALUES
	(8,2,'2026-10-11',745643.5);

	--se le dio permiso a todas las tablas de empresaVentas de Select y solo de insert a la de ventas

--darle permisos a rh de inser pero no de select

--operaciones no permitidas 
UPDATE dbo.ventas
SET Total = 3000.0
WHERE Idventa = 2;

DELETE dbo.ventas
WHERE Idventa = 3;

--crear un usuario en la bd campusclaude 
