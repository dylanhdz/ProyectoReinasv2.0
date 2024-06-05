import express  from "express";
import { getCali } from "../controllers/cali.js";
import { addCali } from "../controllers/cali.js";
import { getCalificacionCandidatas } from "../controllers/cali.js";

const router = express.Router();

router.get("/calificacion", getCali);
router.post("/", addCali);
router.get("/1",getCalificacionCandidatas);

// router.post("/", addComments);

export default router;