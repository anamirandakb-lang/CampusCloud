const cc = db.getSiblingDB('campuscloud');

print('--- ANTES --- total: ' + cc.detalles_servicio.countDocuments());
cc.detalles_servicio.find({ servicio_id: 106 }, { _id: 0, servicio_id: 1, tipo: 1, nombre: 1, activo: 1 }).forEach(d => printjson(d));

const r = cc.detalles_servicio.deleteOne({ servicio_id: 106 });
print('Eliminados: ' + r.deletedCount);

print('--- DESPUES --- total: ' + cc.detalles_servicio.countDocuments());
print('Servicio 106 existe: ' + (cc.detalles_servicio.countDocuments({ servicio_id: 106 }) > 0));
cc.detalles_servicio.find({}, { _id: 0, servicio_id: 1, nombre: 1 }).sort({ servicio_id: 1 }).forEach(d => printjson(d));