import express from "express";
import { enviarCorreoRestablecimiento } from "../controllers/email.js";

const router = express.Router();

router.post("/enviarCorreoRestablecimiento", enviarCorreoRestablecimiento);

export default router;
