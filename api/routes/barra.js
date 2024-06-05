import express  from "express";
import { getCandidatas } from "../controllers/barra.js";
import { getCandidatasFotos } from "../controllers/barra.js";
import { postBarras } from "../controllers/barra.js";
import { getEstadoEvento } from "../controllers/barra.js";

const router = express.Router();

router.get("/", getCandidatas);
router.get("/", getCandidatasFotos);
router.post("/1", postBarras);
router.get("/2", getEstadoEvento);


export default router;