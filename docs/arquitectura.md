# Arquitectura de CampusCloud (Unidad II)

SQL Server sigue siendo la fuente de verdad de identidad y solicitudes. Los gestores NoSQL lo **complementan**; no lo sustituyen.

```
PC (Docker Desktop) ── red: campus-network
 ├─ sqlserver-cloud         (Unidad I)  puerto 14330
 ├─ postgres-cloud, pgadmin (Unidad I)  puertos 54320, 8082
 ├─ mongodb-campuscloud     documentos   puerto 27018   volumen campuscloud_mongo_data
 ├─ neo4j-campuscloud       grafos       puertos 7474/7687  volumen campuscloud_neo4j_data
 └─ campuscloud-cassandra   eventos      puerto 9042    volumen campuscloud_cassandra_data
```

## Elección de modelos

| Necesidad | Modelo | Gestor |
|---|---|---|
| Atributos distintos por tipo de servicio | Documental | MongoDB |
| Vínculos y recomendaciones entre estudiantes y servicios | Grafos | Neo4j |
| Eventos de uso consultados por estudiante y fecha | Columnas anchas | Cassandra |

## Enlace entre gestores

`servicio_id` (101 a 106) y `estudiante_id` (1 a 5) son los identificadores comunes con SQL Server.
Cassandra se diseñó desde la consulta: partition key `estudiante_id`, clustering `fecha_evento DESC, evento_id`.

## Configuración

`campus-cloud-project/docker-compose.yml` define servicios, puertos, volúmenes y variables. Las contraseñas están solo en `.env` (ignorado por Git); se versiona `.env.example`.