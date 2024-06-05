import express  from "express";
import { login, logout, register, salirDispositivo } from "../controllers/auth.js";


const router = express.Router()

router.post("/register",register)
router.post("/login",login)
router.post("/logout",logout)
router.put("/:username",salirDispositivo)



export default router