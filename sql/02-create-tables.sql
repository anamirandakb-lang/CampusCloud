USE CampusCloud;
GO

IF OBJECT_ID(N'dbo.Estudiantes', N'U') IS NULL
CREATE TABLE dbo.Estudiantes (
    IdEstudiante INT IDENTITY(1,1) NOT NULL,
    Matricula    VARCHAR(20)       NOT NULL,
    Nombre       NVARCHAR(100)     NOT NULL,
    Correo       NVARCHAR(150)     NOT NULL,
    CONSTRAINT PK_Estudiantes           PRIMARY KEY (IdEstudiante),
    CONSTRAINT UQ_Estudiantes_Matricula UNIQUE (Matricula),
    CONSTRAINT UQ_Estudiantes_Correo    UNIQUE (Correo),
    CONSTRAINT CK_Estudiantes_Correo    CHECK (Correo LIKE N'%_@_%._%')
);
GO

IF OBJECT_ID(N'dbo.Servicios', N'U') IS NULL
CREATE TABLE dbo.Servicios (
    IdServicio     INT IDENTITY(1,1) NOT NULL,
    NombreServicio NVARCHAR(100)     NOT NULL,
    Descripcion    NVARCHAR(300)     NULL,
    Activo         BIT               NOT NULL CONSTRAINT DF_Servicios_Activo DEFAULT (1),
    CONSTRAINT PK_Servicios        PRIMARY KEY (IdServicio),
    CONSTRAINT UQ_Servicios_Nombre UNIQUE (NombreServicio)
);
GO

IF OBJECT_ID(N'dbo.Solicitudes', N'U') IS NULL
CREATE TABLE dbo.Solicitudes (
    IdSolicitud    INT IDENTITY(1,1) NOT NULL,
    IdEstudiante   INT               NOT NULL,
    IdServicio     INT               NOT NULL,
    FechaSolicitud DATETIME2(0)      NOT NULL CONSTRAINT DF_Solicitudes_Fecha  DEFAULT (SYSDATETIME()),
    Estado         VARCHAR(20)       NOT NULL CONSTRAINT DF_Solicitudes_Estado DEFAULT ('Pendiente'),
    CONSTRAINT PK_Solicitudes             PRIMARY KEY (IdSolicitud),
    CONSTRAINT FK_Solicitudes_Estudiantes FOREIGN KEY (IdEstudiante) REFERENCES dbo.Estudiantes (IdEstudiante),
    CONSTRAINT FK_Solicitudes_Servicios   FOREIGN KEY (IdServicio)   REFERENCES dbo.Servicios (IdServicio),
    CONSTRAINT CK_Solicitudes_Estado      CHECK (Estado IN ('Pendiente', 'En proceso', 'Atendida', 'Cancelada'))
);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Solicitudes_IdEstudiante' AND object_id = OBJECT_ID(N'dbo.Solicitudes'))
    CREATE INDEX IX_Solicitudes_IdEstudiante ON dbo.Solicitudes (IdEstudiante);
GO
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = N'IX_Solicitudes_IdServicio' AND object_id = OBJECT_ID(N'dbo.Solicitudes'))
    CREATE INDEX IX_Solicitudes_IdServicio ON dbo.Solicitudes (IdServicio);
GO

SELECT TABLE_NAME AS Tabla FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
GO
