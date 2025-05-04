import express from "express";
import { 
    getCandidatas,
    getCandidatasFotos,
    getCandidatasTrajeTipico,
    setCandidatas,
    getDepartamentos,
    setCandidatasFotos,
    uploadFoto,
    getJueces,
    getVotacionesNotario,
    getCandidatasTrajeGala,
    getCandidataCarrusel,
    verificarDesempate,
    deleteCandidatas
} from "../controllers/candidatas.js";
import multer from 'multer';
import path from 'path';

const upload = multer({ 
    storage: multer.diskStorage({
        destination: (req, file, cb) => {
            cb(null, '../client/public/reinas/');
        },
        filename: (req, file, cb) => {
            // Access the nombreArchivo from the body - this should now be available
            const nombreArchivo = req.body.nombreArchivo;
            if (!nombreArchivo) {
                return cb(new Error('Nombre de archivo no proporcionado'));
            }
            cb(null, nombreArchivo);
        }
    }),
    fileFilter: (req, file, cb) => {
        if (!file.mimetype.startsWith('image/')) {
            return cb(new Error('Solo se permiten archivos de imagen'));
        }
        cb(null, true);
    }
}).single('foto');

// This middleware function will now just handle errors
const fileUploadHandler = (req, res, next) => {
    upload(req, res, function(err) {
        if (err instanceof multer.MulterError) {
            console.error("Multer error:", err);
            return res.status(400).json({ error: "Error al subir el archivo: " + err.message });
        } else if (err) {
            console.error("Upload error:", err);
            return res.status(400).json({ error: err.message });
        }
        // If we get here, the file was successfully uploaded
        next();
    });
};

const router = express.Router();

// Basic routes
router.get("/", getCandidatas);
router.post("/", setCandidatas);
router.delete("/:id", deleteCandidatas);

// File handling routes
router.post("/fotos", setCandidatasFotos);
router.post("/upload", fileUploadHandler, uploadFoto);

// Specialized get routes
router.get("/carruselCandidatas", getCandidataCarrusel);
router.get("/departamentos", getDepartamentos);
router.get("/jueces", getJueces);
router.get("/votaciones", getVotacionesNotario);
router.get("/tt", getCandidatasTrajeTipico);
router.get("/tg", getCandidatasTrajeGala);
router.get("/verificarDesempate", verificarDesempate);

// Parameter routes - must be last
router.get("/:id", getCandidatasFotos);

export default router;