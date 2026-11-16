// Crea la coleccion de detalles extendidos de servicios (la identidad sigue en SQL Server)
const cc = db.getSiblingDB('campuscloud');

if (!cc.getCollectionNames().includes('detalles_servicio')) {
  cc.createCollection('detalles_servicio', {
    validator: {
      $jsonSchema: {
        bsonType: 'object',
        required: ['servicio_id', 'tipo', 'nombre'],
        properties: {
          servicio_id: { bsonType: 'int' },
          tipo: { enum: ['tutoria', 'laboratorio', 'biblioteca'] },
          nombre: { bsonType: 'string' }
        }
      }
    }
  });
}

cc.detalles_servicio.createIndex({ servicio_id: 1 }, { unique: true });

print('Base: ' + cc.getName());
print('Colecciones:');
printjson(cc.getCollectionNames());
print('Indices:');
printjson(cc.detalles_servicio.getIndexes().map(i => i.name));