import { db } from "../db.js";
import jwt from "jsonwebtoken";

export const getCali = (req, res) => {
    const sqlSelect = "SELECT * from calificacion";

    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        return res.status(200).json(data);
    });
};

export const addCali = (req, res) => {
    const token = req.cookies.access_token;
    if (!token) return res.status(401).json("No autenticado!");

    jwt.verify(token, "jwtkey", (err, userInfo) => {
        if (err) return res.status(403).json("Token no es valido!");

        const q = "INSERT INTO calificacion(`EVENTO_ID`, `USUARIO_ID`, `CANDIDATA_ID`,`CALIFICACION_NOMBRE`, `CALIFICACION_PESO`, `CALIFICACION_VALOR`) VALUES (?)";
        const promises = [];

        for (let i = 0; i < 12; i++) {
            const values = [
                req.body.EVENTO_ID,
                userInfo.id,
                1 + i,
                req.body.CALIFICACION_NOMBRE,
                req.body.CALIFICACION_PESO,
                Number(req.body.notas[i]),
            ];
            promises.push(new Promise((resolve, reject) => {
                db.query(q, [values], (err, data) => {
                    if (err) return reject(err);
                    resolve(data);
                });
            }));
        }

        Promise.all(promises)
            .then(() => {
                res.status(200).json("Calificación agregada exitosamente");
            })
            .catch((err) => {
                res.status(500).json(err);
            });
    });
};


export const getCalificacionCandidatas = (req, res) => {
    const sqlSelect = "SELECT c.CANDIDATA_ID, c.USUARIO_ID, c.EVENTO_ID from calificacion c WHERE CANDIDATA_ID = ? AND USUARIO_ID = ? AND EVENTO_ID = ?;";
    db.query(sqlSelect, [req.params.candidataId, userInfo.id, req.params.eventoId], (err, result) => {
        if (err) console.log(err);
        res.send(result);
    });
};
export const updateDesempate = (req, res) => {
    const token = req.cookies.access_token;
    if (!token) return res.status(401).json("No autenticado!");

    jwt.verify(token, "jwtkey", (err, userInfo) => {
        if (err) return res.status(403).json("Token no es valido!");

        // Validamos los datos de entrada
        if (!Array.isArray(req.body.notas)) {
            return res.status(400).json("Formato de notas inválido");
        }

        const notasValidadas = req.body.notas.map(nota => ({
            candidata_id: parseInt(nota.candidata_id),
            nota_final: parseFloat(nota.nota_final)
        }));

        if (notasValidadas.some(nota => isNaN(nota.candidata_id) || isNaN(nota.nota_final))) {
            return res.status(400).json("Datos de calificación inválidos");
        }

        // Primero verificamos si este juez ya votó
        const checkJuezVoto = `
            SELECT COUNT(*) as ya_voto 
            FROM calificacion 
            WHERE USUARIO_ID = ? 
            AND EVENTO_ID = 4 
            AND CALIFICACION_NOMBRE = 'Desempate'`;

        db.query(checkJuezVoto, [userInfo.id], (err, votedResult) => {
            if (err) {
                console.error("Error al verificar voto del juez:", err);
                return res.status(500).json(err);
            }

            if (votedResult[0].ya_voto > 0) {
                return res.status(400).json("Ya has emitido tu voto para el desempate");
            }

            // Si no ha votado, insertamos en la tabla calificacion
            const q = "INSERT INTO calificacion(`EVENTO_ID`, `USUARIO_ID`, `CANDIDATA_ID`, `CALIFICACION_NOMBRE`, `CALIFICACION_PESO`, `CALIFICACION_VALOR`) VALUES ?";
            const values = notasValidadas.map(nota => [
                4, // Evento ID fijo para desempate
                userInfo.id,
                nota.candidata_id,
                'Desempate',
                100, // Peso del desempate
                nota.nota_final
            ]);

            db.query(q, [values], (err, result) => {
                if (err) return res.status(500).json(err);
                return res.json("Calificaciones de desempate registradas correctamente");
            });
        });
    });
};


export const getDesempateNotas = (req, res) => {
    const sqlSelect = "SELECT candidata_id, nota_final FROM desempate";
    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        return res.status(200).json(data);
    });
};

export const getCandidatasEmpatadas = (req, res) => {
    const sql = `
        SELECT 
            ca.CANDIDATA_ID,
            ca.CAND_NOMBRE1, 
            ca.CAND_APELLIDOPATERNO,
            dpto.DEPARTAMENTO_SEDE,
            dpto.DEPARTMENTO_NOMBRE, 
            fc.FOTO_URL 
        FROM 
            desempate d
            INNER JOIN candidata ca ON d.candidata_id = ca.CANDIDATA_ID
            INNER JOIN carrera car ON ca.CARRERA_ID = car.CARRERA_ID
            INNER JOIN departamento dpto ON car.DEPARTAMENTO_ID = dpto.DEPARTAMENTO_ID
            INNER JOIN foto_candidata fc ON ca.CANDIDATA_ID = fc.CANDIDATA_ID AND fc.FOTO_DESCRIPCION = 'FX';
    `;
    db.query(sql, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'An error occurred' });
        } else {
            res.status(200).json({ candidatasEmpatadas: result });
        }
    });
};
