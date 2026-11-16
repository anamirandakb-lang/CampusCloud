const cc = db.getSiblingDB('campuscloud');

// Se limpia para poder repetir el script sin duplicar
cc.detalles_servicio.deleteMany({});

cc.detalles_servicio.insertMany([
  {
    servicio_id: NumberInt(101), tipo: 'tutoria', nombre: 'Tutoria de Bases de Datos',
    activo: true, cupo_maximo: 15,
    modalidades: ['presencial', 'virtual'],
    etiquetas: ['sql', 'nosql', 'academico'],
    horarios: ['Lunes 16:00', 'Miercoles 16:00'],
    responsable: { nombre: 'Mtra. Ana Ficticia', area: 'Tecnologias de la Informacion', correo: 'ana.ficticia@ejemplo.edu' }
  },
  {
    servicio_id: NumberInt(102), tipo: 'tutoria', nombre: 'Tutoria de Matematicas',
    activo: true, cupo_maximo: 12,
    modalidades: ['presencial'],
    etiquetas: ['calculo', 'algebra'],
    horarios: ['Martes 10:00', 'Jueves 10:00'],
    responsable: { nombre: 'Mtro. Luis Imaginario', area: 'Ciencias Basicas', correo: 'luis.imaginario@ejemplo.edu' }
  },
  {
    servicio_id: NumberInt(103), tipo: 'laboratorio', nombre: 'Laboratorio de Redes',
    activo: true, cupo_maximo: 20,
    modalidades: ['presencial'],
    etiquetas: ['redes', 'cisco', 'practicas'],
    equipo: ['switch', 'router', 'cableado'],
    requiere_reserva: true,
    responsable: { nombre: 'Ing. Marta Simulada', area: 'Laboratorios', correo: 'marta.simulada@ejemplo.edu' }
  },
  {
    servicio_id: NumberInt(104), tipo: 'biblioteca', nombre: 'Biblioteca Digital',
    activo: true, cupo_maximo: 100,
    modalidades: ['virtual'],
    etiquetas: ['libros', 'articulos', 'consulta'],
    formatos: ['pdf', 'epub'],
    prestamo_dias: 7,
    responsable: { nombre: 'Lic. Pedro Ejemplo', area: 'Biblioteca', correo: 'pedro.ejemplo@ejemplo.edu' }
  },
  {
    servicio_id: NumberInt(105), tipo: 'laboratorio', nombre: 'Laboratorio de Computo',
    activo: true, cupo_maximo: 30,
    modalidades: ['presencial', 'virtual'],
    etiquetas: ['programacion', 'software'],
    equipo: ['computadoras', 'proyector'],
    requiere_reserva: false,
    responsable: { nombre: 'Ing. Sofia Demo', area: 'Laboratorios', correo: 'sofia.demo@ejemplo.edu' }
  },
  {
    servicio_id: NumberInt(106), tipo: 'biblioteca', nombre: 'Sala de Lectura',
    activo: false, cupo_maximo: 25,
    modalidades: ['presencial'],
    etiquetas: ['lectura', 'silencio'],
    formatos: ['impreso'],
    prestamo_dias: 3,
    responsable: { nombre: 'Lic. Rosa Prueba', area: 'Biblioteca', correo: 'rosa.prueba@ejemplo.edu' }
  }
]);

print('Total de documentos: ' + cc.detalles_servicio.countDocuments());
cc.detalles_servicio.find({}, { _id: 0, servicio_id: 1, tipo: 1, nombre: 1, modalidades: 1, 'responsable.nombre': 1 })
  .sort({ servicio_id: 1 })
  .forEach(d => printjson(d));