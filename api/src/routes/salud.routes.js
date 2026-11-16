import {  Router } from "express";
import { obtenersalud } from "../controllers/salud.controller.js";
//crear un objeto Router 
const router = Router();

router.get("/salud", obtenersalud);

export default router;