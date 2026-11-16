const cc = db.getSiblingDB('campuscloud');
const proy = { _id: 0, servicio_id: 1, tipo: 1, nombre: 1, cupo_maximo: 1, modalidades: 1 };

print('--- Filtro 1: igualdad (tipo = laboratorio) ---');
cc.detalles_servicio.find({ tipo: 'laboratorio' }, proy).sort({ servicio_id: 1 }).forEach(d => printjson(d));

print('--- Filtro 2: comparacion (cupo_maximo >= 20) ---');
cc.detalles_servicio.find({ cupo_maximo: { $gte: 20 } }, proy).sort({ servicio_id: 1 }).forEach(d => printjson(d));

print('--- Filtro 3: array (modalidades contiene virtual) y activo = true ---');
cc.detalles_servicio.find({ modalidades: 'virtual', activo: true }, proy).sort({ servicio_id: 1 }).forEach(d => printjson(d));

print('--- Filtro 4: subdocumento (responsable.area = Biblioteca) ---');
cc.detalles_servicio.find({ 'responsable.area': 'Biblioteca' }, { _id: 0, servicio_id: 1, nombre: 1, responsable: 1 }).forEach(d => printjson(d));