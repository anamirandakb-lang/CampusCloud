//importar express, que se instalo previamente
import express from "express";
//importar el router salud
import SaludRoutes from "./routes/salud.routes.js";

// crea una aplicación express, a partir de este objeto 
//se podra configurar rutas y middlewares
const app = express();

//Agrega un middleware que permite interpretar cuerpos JSON de las peticiones HTTP
app.use(express.json());

//registrar la ruta 
app.use(SaludRoutes);

export default app;