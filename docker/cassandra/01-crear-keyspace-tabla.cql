-- Modelo orientado a la consulta: "actividad de un estudiante en un periodo"
CREATE KEYSPACE IF NOT EXISTS campuscloud_eventos
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE campuscloud_eventos;

CREATE TABLE IF NOT EXISTS eventos_por_estudiante (
    estudiante_id int,
    fecha_evento  timestamp,
    evento_id     text,
    servicio_id   int,
    tipo_evento   text,
    detalle       text,
    PRIMARY KEY ((estudiante_id), fecha_evento, evento_id)
) WITH CLUSTERING ORDER BY (fecha_evento DESC, evento_id ASC);

DESCRIBE KEYSPACE campuscloud_eventos;