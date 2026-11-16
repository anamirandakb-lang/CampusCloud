# Pruebas de la Unidad II

Entorno: Windows, Docker Desktop y PowerShell. Datos ficticios. Compose y `.env` en `campus-cloud-project/`; scripts en `docker/mongodb`, `docker/neo4j` y `docker/cassandra`; capturas en `evidencias/unidad-ii/`.

## 1. MongoDB (base `campuscloud`, colección `detalles_servicio`)

| Prueba | Script | Resultado | Captura |
|---|---|---|---|
| Conexión | `ping`, `Test-NetConnection` | Puerto 27018 abierto, versión 8.0.8 | `mongodb/01-conexion.png` |
| Inserción | `02-insertar-documentos.js` | 6 documentos de 3 tipos, con arrays y subdocumento `responsable` | `02-documentos-insertados.png` |
| Filtros | `03-consultas-filtros.js` | Igualdad, comparación, array y subdocumento | `03-consultas-filtros.png` |
| Actualización | `04-actualizar.js` | Servicio 101: `cupo_maximo` de 15 a 20 | `04-actualizacion-antes-despues.png` |
| Eliminación | `05-eliminar.js` | Se elimina el servicio 106; quedan 5 | `05-eliminacion.png` |
| Agregación | `06-agregacion.js` | Conteo y cupo promedio por tipo | `06-agregacion.png` |
| Persistencia | `docker restart` | 5 documentos antes y después; el cambio persiste | `07-persistencia.png` |
| Autenticación | consulta sin y con usuario | Sin credenciales: `requires authentication` | `08-autenticacion.png` |

## 2. Neo4j

| Prueba | Script | Resultado | Captura |
|---|---|---|---|
| Conexión | `dbms.components()` | Puertos 7474 y 7687 abiertos | `neo4j/01-conexion.png` |
| Carga | `01-crear-nodos-relaciones.cypher` | 5 Estudiante, 4 Servicio, 9 USA, 2 COMPANERO_DE | `02-nodos-relaciones.png` |
| Consulta 1 | `02-consultas.cypher` | Servicios de Valeria Torres (101, 104, 105) | `03-consulta-servicios-estudiante.png` |
| Consulta 2 | `02-consultas.cypher` | Quiénes comparten el servicio 104 | `04-consulta-companeros.png` |
| Consulta 3 | `02-consultas.cypher` | Recomendación para Luis Mendoza (101 y 105) | `05-consulta-recomendacion.png` |
| Modificación | `03-actualizacion.cypher` | Luis-Laboratorio de Redes: ocasional/2 a semanal/3 | `06-modificacion-antes-despues.png` |
| Grafo | Neo4j Browser | 9 nodos y 11 relaciones | `07-grafo.png` |
| Persistencia | `04-persistencia.cypher` + reinicio | Mismos conteos y valores | `08-persistencia.png` |
| Autenticación | consulta sin y con usuario | Sin credenciales: fallo de autenticación | `09-autenticacion.png` |

## 3. Cassandra (keyspace `campuscloud_eventos`, tabla `eventos_por_estudiante`)

Diseño: partition key `estudiante_id`; clustering `fecha_evento DESC, evento_id ASC`.

| Prueba | Script | Resultado | Captura |
|---|---|---|---|
| Conexión | `system.local`, puerto 9042 | Conectado con TablePlus y `cqlsh` | `cassandra/01-conexion.png` |
| Estructura | `01-crear-keyspace-tabla.cql` | Partition key y clustering verificados | `02-keyspace-tabla.png` |
| Carga | `02-insertar-eventos.cql` | 13 eventos de 3 estudiantes | `03-eventos-insertados.png` |
| Consulta por periodo | `03-consultas.cql` | Estudiante 1, 1 a 15 nov 2026: 4 filas | `04-consulta-periodo.png` |
| UPDATE | `04-actualizar.cql` | Cambia el `detalle` de EVT-1002 | `05-actualizacion-antes-despues.png` |
| DELETE | `05-eliminar.cql` | Se elimina EVT-1005; quedan 12 | `06-eliminacion-antes-despues.png` |
| Limitaciones | `06-limitaciones.cql` | Sin clave falla; `ALLOW FILTERING` escanea todo | `07-limitaciones.png` |
| Acceso | `cassandra.yaml` | `AllowAllAuthenticator`: sin autenticación | `08-acceso-sin-autenticacion.png` |

## 4. Controles generales

| Control | Resultado | Captura |
|---|---|---|
| Conectividad | Tres contenedores `Up`; puertos 27018, 7687 y 9042 abiertos | `generales/01-conectividad-tres-gestores.png` |
| Secretos | `.env` ignorado y no rastreado; sin contraseñas en scripts | `generales/02-revision-secretos.png` |

## 5. Incidencias

**Incidencia 1: ruta del Compose**
- Síntoma: `open docker\compose.yaml: el sistema no puede encontrar la ruta`.
- Causa: el comando usaba `-f docker\compose.yaml`, pero el compose está en `campus-cloud-project/`.
- Solución: ejecutar `docker compose` sin `-f` desde esa carpeta.
- Verificación: `docker compose config` sin errores; los tres servicios levantan.

**Incidencia 2: archivos sensibles fuera de lugar**
- Síntoma: había `.env` y `docker-run.ps1` dentro de `docker/mongodb` y `docker/neo4j`.
- Solución: se movieron fuera del repositorio y se reforzó `.gitignore` (`**/.env`, `**/.env.*`).
- Verificación: `git check-ignore -v` y `git ls-files` sin `.env` rastreado.

## 6. Limitaciones conocidas

- Cassandra sin autenticación: solo laboratorio local.
- Un nodo por gestor y `replication_factor` 1: sin tolerancia a fallos.
- Neo4j Community no incluye roles avanzados.