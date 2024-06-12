import express  from "express";
import { getCali } from "../controllers/cali.js";
import { addCali } from "../controllers/cali.js";
import { getCalificacionCandidatas } from "../controllers/cali.js";
import { updateDesempate } from "../controllers/cali.js";
import { getDesempateNotas } from "../controllers/cali.js";

const router = express.Router();

router.get("/calificacion", getCali);
router.post("/", addCali);
router.get("/1",getCalificacionCandidatas);
router.post("/desempate", updateDesempate);
router.get("/desempate_notas", getDesempateNotas); // Nueva ruta para obtener las notas de desempate



// router.post("/", addComments);

export default router;