// Limpia el grafo de practica para poder repetir el script
MATCH (n) DETACH DELETE n;

CREATE CONSTRAINT estudiante_id_unico IF NOT EXISTS FOR (e:Estudiante) REQUIRE e.estudiante_id IS UNIQUE;
CREATE CONSTRAINT servicio_id_unico IF NOT EXISTS FOR (s:Servicio) REQUIRE s.servicio_id IS UNIQUE;

// 5 nodos Estudiante
CREATE (:Estudiante {estudiante_id: 1, nombre: 'Valeria Torres',  carrera: 'TI', semestre: 5});
CREATE (:Estudiante {estudiante_id: 2, nombre: 'Luis Mendoza',    carrera: 'TI', semestre: 5});
CREATE (:Estudiante {estudiante_id: 3, nombre: 'Camila Rivera',   carrera: 'TI', semestre: 3});
CREATE (:Estudiante {estudiante_id: 4, nombre: 'Diego Herrera',   carrera: 'Mecatronica', semestre: 3});
CREATE (:Estudiante {estudiante_id: 5, nombre: 'Joaquin Salazar', carrera: 'Mecatronica', semestre: 1});

// 4 nodos Servicio (mismos servicio_id que en MongoDB y Cassandra)
CREATE (:Servicio {servicio_id: 101, nombre: 'Tutoria de Bases de Datos', tipo: 'tutoria'});
CREATE (:Servicio {servicio_id: 103, nombre: 'Laboratorio de Redes',      tipo: 'laboratorio'});
CREATE (:Servicio {servicio_id: 104, nombre: 'Biblioteca Digital',        tipo: 'biblioteca'});
CREATE (:Servicio {servicio_id: 105, nombre: 'Laboratorio de Computo',    tipo: 'laboratorio'});

// 9 relaciones USA (con propiedades)
UNWIND [
  {e: 1, s: 101, f: 'semanal',    v: 6},
  {e: 1, s: 104, f: 'mensual',    v: 3},
  {e: 1, s: 105, f: 'semanal',    v: 8},
  {e: 2, s: 103, f: 'ocasional',  v: 2},
  {e: 2, s: 104, f: 'mensual',    v: 4},
  {e: 3, s: 105, f: 'semanal',    v: 5},
  {e: 4, s: 101, f: 'ocasional',  v: 1},
  {e: 4, s: 103, f: 'semanal',    v: 7},
  {e: 5, s: 104, f: 'ocasional',  v: 2}
] AS r
MATCH (e:Estudiante {estudiante_id: r.e}), (s:Servicio {servicio_id: r.s})
CREATE (e)-[:USA {frecuencia: r.f, veces: r.v}]->(s);

// 2 relaciones COMPANERO_DE
UNWIND [
  {a: 1, b: 3, desde: '2026-08'},
  {a: 2, b: 4, desde: '2026-09'}
] AS r
MATCH (a:Estudiante {estudiante_id: r.a}), (b:Estudiante {estudiante_id: r.b})
CREATE (a)-[:COMPANERO_DE {desde: r.desde}]->(b);

// Verificacion
MATCH (n) RETURN labels(n)[0] AS tipo_nodo, count(*) AS total ORDER BY tipo_nodo;
MATCH ()-[r]->() RETURN type(r) AS relacion, count(*) AS total ORDER BY relacion;
MATCH (e:Estudiante)-[u:USA]->(s:Servicio)
RETURN e.estudiante_id AS id, e.nombre AS estudiante, s.servicio_id AS servicio, u.frecuencia AS frecuencia, u.veces AS veces
ORDER BY id, servicio;