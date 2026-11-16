const cc = db.getSiblingDB('campuscloud');
const proy = { _id: 0, servicio_id: 1, nombre: 1, cupo_maximo: 1, modalidades: 1, etiquetas: 1 };

print('--- ANTES ---');
printjson(cc.detalles_servicio.findOne({ servicio_id: 101 }, proy));

const r = cc.detalles_servicio.updateOne(
  { servicio_id: 101 },
  { $set: { cupo_maximo: 20 }, $addToSet: { etiquetas: 'cupo-ampliado' } }
);
print('Coincidencias: ' + r.matchedCount + ' | Modificados: ' + r.modifiedCount);

print('--- DESPUES ---');
printjson(cc.detalles_servicio.findOne({ servicio_id: 101 }, proy));