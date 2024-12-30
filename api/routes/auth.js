import express from "express";
import { login, logout, register, salirDispositivo, enviarCorreoRestablecimiento, resetPassword } from "../controllers/auth.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", logout);
router.put("/:username", salirDispositivo);
router.post("/enviarCorreoRestablecimiento", enviarCorreoRestablecimiento);
router.post("/resetPassword", resetPassword);

export default router;