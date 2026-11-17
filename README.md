# CampusCloud

Proyecto académico de la asignatura Bases de Datos en la Nube.
**Autora:** Ana Karen Miranda Barreto

## Objetivo general

Construir progresivamente una Nube Académica Local que permita comprender:

- bases de datos relacionales;
- bases de datos NoSQL;
- persistencia;
- usuarios, roles y privilegios;
- conexión local y remota;
- integración mediante API;
- Docker y Docker Compose como herramientas de soporte.

## Unidad I · Base relacional

PC → Docker → SQL Server → Volumen → CampusCloud

Tecnologías: Docker Desktop, SQL Server 2025, PostgreSQL, pgAdmin, cliente SQL, Git y Visual Studio Code.
Se conservan sin cambios `api/`, `seguridad/`, `sql/` y los servicios PostgreSQL, pgAdmin y SQL Server. El README original está en `docs/README-unidad-i.md`.

## Unidad II · Prácticas NoSQL 

Tres gestores NoSQL que **complementan** a SQL Server, sin sustituirlo. Todos los datos son ficticios.

| Gestor | Modelo | Uso en CampusCloud |
|---|---|---|
| MongoDB 8.0.8 | Documental | Detalles extendidos y flexibles de cada servicio |
| Neo4j 5 Community | Grafos | Vínculos estudiante-servicio y recomendaciones |
| Cassandra 5 | Columnas anchas | Bitácora de eventos por estudiante y fecha |

### Estructura

```
CampusCloud/
├── campus-cloud-project/   docker-compose.yml y .env.example
├── docker/
│   ├── mongodb/            scripts .js
│   ├── neo4j/              scripts .cypher
│   ├── cassandra/          scripts .cql
│   └── postgreSQL, pgadmin, sqlserver (Unidad I)
├── evidencias/unidad-ii/   capturas (mongodb, neo4j, cassandra, generales)
├── docs/                   pruebas.md y documentación
└── api/ seguridad/ sql/ images_docker/   (Unidad I)
```

### Servicios y puertos

| Servicio | Contenedor | Puerto host | Volumen | Acceso |
|---|---|---|---|---|
| mongodb | mongodb-campuscloud | 27018 | campuscloud_mongo_data | Usuario `admin` |
| neo4j | neo4j-campuscloud | 7474 (Browser), 7687 (Bolt) | campuscloud_neo4j_data | Usuario `neo4j` |
| cassandra | campuscloud-cassandra | 9042 | campuscloud_cassandra_data | Sin autenticación (laboratorio local) |


