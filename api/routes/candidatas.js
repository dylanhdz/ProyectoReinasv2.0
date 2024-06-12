import express  from "express";
import { getCandidatas } from "../controllers/candidatas.js";
import { getCandidatasFotos } from "../controllers/candidatas.js";
import { getCandidatasTrajeTipico } from "../controllers/candidatas.js";
import { getJueces } from "../controllers/candidatas.js";
import { getVotacionesNotario} from "../controllers/candidatas.js";
import { getCandidatasTrajeGala } from "../controllers/candidatas.js";
import { getCandidataCarrusel } from "../controllers/candidatas.js";
import { verificarDesempate } from "../controllers/candidatas.js";

const router = express.Router();

router.get("/", getCandidatas);
router.get("/carruselCandidatas", getCandidataCarrusel);
router.get("/jueces", getJueces);
router.get("/votaciones", getVotacionesNotario);
router.get("/tt", getCandidatasTrajeTipico);
router.get("/tg", getCandidatasTrajeGala);
router.get("/:id", getCandidatasFotos);
router.get("/verificarDesempate", verificarDesempate);

// router.post("/", addComments);

export default router;