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

## Unidad II · Prácticas NoSQL (Actividad de Evaluación 2: Operación CampusCloud)

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



### Iniciar, verificar y detener

Desde `campus-cloud-project\`:

```powershell
docker compose up -d mongodb neo4j cassandra
docker ps --filter "name=campuscloud"
docker compose stop mongodb neo4j cassandra
```

Cassandra tarda de 1 a 2 minutos: `docker exec campuscloud-cassandra nodetool status` debe mostrar `UN`. No hace falta tener los tres activos a la vez.

### Ejecutar los scripts

Las contraseñas se piden en la terminal; no se escriben en comandos ni archivos. Desde la raíz del repo:

```powershell
# MongoDB (repetir con 02 a 06)
docker cp .\docker\mongodb mongodb-campuscloud:/tmp/mongodb
docker exec -it mongodb-campuscloud mongosh --quiet -u admin -p --authenticationDatabase admin --file /tmp/mongodb/01-crear-coleccion.js

# Neo4j (repetir con 02 y 03; el 04 es para persistencia)
docker cp .\docker\neo4j neo4j-campuscloud:/tmp/neo4j
docker exec -it neo4j-campuscloud cypher-shell -u neo4j -f /tmp/neo4j/01-crear-nodos-relaciones.cypher

# Cassandra (repetir con 02 a 06; también se ejecutó desde TablePlus)
docker cp .\docker\cassandra campuscloud-cassandra:/tmp/cassandra
docker exec campuscloud-cassandra cqlsh -f /tmp/cassandra/01-crear-keyspace-tabla.cql
```

### Resultados esperados

- **MongoDB:** 6 documentos (servicios 101 a 106, 3 tipos); tras actualizar el 101 y eliminar el 106 quedan 5.
- **Neo4j:** 5 estudiantes, 4 servicios, 11 relaciones (9 `USA`, 2 `COMPANERO_DE`).
- **Cassandra:** 13 eventos de 3 estudiantes; tras el DELETE quedan 12. Partition key `estudiante_id`, clustering `fecha_evento DESC, evento_id`.

### Evidencias y seguridad

- Capturas en `evidencias/`; la explicación de cada prueba está en [docs/pruebas.md](docs/pruebas.md).
- `.env` ignorado por Git; solo se versiona `.env.example`. Ningún script contiene contraseñas.
- Cassandra no tiene autenticación en este entorno local; se documenta como limitación.