// candidatas.js
import express from "express";
import { 
    getCandidatas, 
    getCandidatasFotos, 
    getCandidatasTrajeTipico, 
    getJueces, 
    getVotacionesNotario, 
    getCandidatasTrajeGala, 
    getCandidatasBarra, 
    getCandidataCarrusel, 
    verificarDesempate, 
    getTopCandidatas,
    createCandidata,
    updateCandidata,
    deleteCandidata
} from "../controllers/candidatas.js";

const router = express.Router();

// Rutas específicas primero
router.get("/carruselCandidatas", getCandidataCarrusel);
router.get("/jueces", getJueces);
router.get("/votaciones", getVotacionesNotario);
router.get("/tt", getCandidatasTrajeTipico);
router.get("/tg", getCandidatasTrajeGala);
router.get("/verificarDesempate", verificarDesempate);
router.get("/topCandidatas", getTopCandidatas); // Nueva ruta específica

// Rutas genéricas después
router.get("/:id", getCandidatasFotos);
router.get("/", getCandidatas);

//obtener candidatas
// POST -> create
router.get("/", getCandidatas);
router.post("/", createCandidata);
router.put("/:id", updateCandidata);
router.delete("/:id", deleteCandidata);

export default router;
