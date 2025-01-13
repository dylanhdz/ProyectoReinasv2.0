import express  from "express";
import { getUsuarios } from "../controllers/user.js";
import { actualizarActivo } from "../controllers/user.js";
import { actualizarEstadoEvento } from "../controllers/user.js";
import { limpiarTabla } from "../controllers/user.js";
import { limpiarVotaciones } from "../controllers/user.js";
import { checkVotes1 } from "../controllers/user.js";
import { checkVotes2 } from "../controllers/user.js";
import { checkVotes3 } from "../controllers/user.js";
import { verificarEmpate } from "../controllers/user.js";
import { activarEventoPublico,     createUser,
    getAllUsers,
    getUserById,
    updateUser,
    deleteUser } from "../controllers/user.js";


const router = express.Router();

router.get("/", getUsuarios);
router.get("/ck1", checkVotes1);
router.get("/ck2", checkVotes2);
router.get("/ck3", checkVotes3);
router.get("/verificar_empate", verificarEmpate);
router.put("/:username", actualizarActivo);
router.put("/cambio/:estado/:idEvento", actualizarEstadoEvento);
router.post("/limpiarTabla", limpiarTabla);
router.post("/limpiarVotaciones", limpiarVotaciones);
router.put("/activarEventoPublico", activarEventoPublico);

//creacion de usuarios
router.get("/", getAllUsers);
router.get("/:id", getUserById);
router.post("/", createUser);
router.put("/:id", updateUser);
router.delete("/:id", deleteUser);
// router.post("/", addComments);

export default router;