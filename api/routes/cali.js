import express  from "express";
import { getCali } from "../controllers/cali.js";
import { addCali } from "../controllers/cali.js";
import { getCalificacionCandidatas } from "../controllers/cali.js";
import { updateDesempate } from "../controllers/cali.js";
import { getDesempateNotas } from "../controllers/cali.js";
import { getCandidatasEmpatadas } from "../controllers/cali.js";
import { votarPublico } from "../controllers/cali.js";
import { actualizarPuntajeFinal } from "../controllers/cali.js";
import { cerrarVotaciones } from "../controllers/cali.js";

const router = express.Router();

router.get("/calificacion", getCali);
router.post("/", addCali);
router.get("/1",getCalificacionCandidatas);
router.post("/desempate", updateDesempate);
router.get("/desempate_notas", getDesempateNotas); // Nueva ruta para obtener las notas de desempate
router.get('/verificar_empate', getCandidatasEmpatadas);
router.post("/votarPublico", votarPublico);
router.put("/actualizarPuntajeFinal", actualizarPuntajeFinal);
router.put("/cerrarVotaciones", cerrarVotaciones);



export default router;