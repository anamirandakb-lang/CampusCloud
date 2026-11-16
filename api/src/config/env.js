//importa la dependencia instaladad
import dotenv from "dotenv"

//Carga las variables de el archivo .env a process.env 
dotenv.config();

const PORT = Number(process.env.PORT ?? 3000)

if (!Number.isInteger(PORT) || PORT  < 1 || PORT > 65535) {
    throw new Error("PORT debe de ser un puerto válido entre 1 y 65535")
}

//configuracion de mongoDB 
const MONGO_HOST = process.env.MONGO_HOST
const MONGO_PORT = process.env.MONGO_PORT
const MONGO_USER = process.env.MONGO_USER
const MONGO_PASSWORD = process.env.MONGO_PASSWORD
const MONGO_DATABASE = process.env.MONGO_DATABASE
const MONGO_AUTH_SOURCE = process.env.MONGO_AUTH_SOURCE

//validad que no flate niniguna variable 
if(
    !MONGO_HOST ||
    !MONGO_USER ||
    !MONGO_PORT ||
    !MONGO_PASSWORD ||
    !MONGO_DATABASE ||
    !MONGO_AUTH_SOURCE 
){
    throw new Error("Faltan variables de configuración");
    
}

if(
    !Number.isInteger(MONGO_PORT) ||
    MONGO_PORT < 1 ||
    MONGO_PORT >65535
){
    throw new Error("MONGO_PORT debe de ser un puerto valido");
    
}


export const env = {
    port: PORT, 
    mongo:{  
    host:MONGO_HOST,
    user:MONGO_USER ,
    port:MONGO_PORT,
    password:MONGO_PASSWORD,
    database:MONGO_DATABASE,
    authSource:MONGO_AUTH_SOURCE 
    }
}
