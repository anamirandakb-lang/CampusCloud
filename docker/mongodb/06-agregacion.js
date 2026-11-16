const cc = db.getSiblingDB('campuscloud');

print('--- Conteo y cupo promedio por tipo de servicio ---');
cc.detalles_servicio.aggregate([
  { $group: { _id: '$tipo', total_servicios: { $sum: 1 }, cupo_promedio: { $avg: '$cupo_maximo' } } },
  { $sort: { total_servicios: -1, _id: 1 } },
  { $project: { _id: 0, tipo: '$_id', total_servicios: 1, cupo_promedio: { $round: ['$cupo_promedio', 1] } } }
]).forEach(d => printjson(d));