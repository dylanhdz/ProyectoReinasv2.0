import { db } from "../db.js"
import jwt from "jsonwebtoken";

export const getCali = (req, res) => {
    const sqlSelect = "SELECT * from calificacion"

    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        //console.log(data);
        return res.status(200).json(data);
    });
}

export const addCali = (req, res) => {
    const token = req.cookies.access_token
    if (!token) return res.status(401).json("No autenticado!")

    jwt.verify(token, "jwtkey", (err, userInfo) => {
        if (err) return res.status(403).json("Token no es valido!");

        const q = "INSERT INTO calificacion(`EVENTO_ID`, `USUARIO_ID`, `CANDIDATA_ID`,`CALIFICACION_NOMBRE`, `CALIFICACION_PESO`, `CALIFICACION_VALOR`) VALUES (?)";
        for (var i = 0; i < 12; i++) {
            const values = [
                req.body.EVENTO_ID,
                userInfo.id,
                1 + i,
                req.body.CALIFICACION_NOMBRE,
                req.body.CALIFICACION_PESO,
                Number(req.body.notas[i]), //Hay que multiplicar por 2 para que sea sobre 10
            ]
            db.query(q, [values], (err, data) => {
                if (err) return res.status(500).json(err);
            });
        }
    });
}

export const getCalificacionCandidatas = (req, res) => {
    const sqlSelect = "SELECT c.CANDIDATA_ID, c.USUARIO_ID, c.EVENTO_ID from calificacion c WHERE CANDIDATA_ID = ? AND USUARIO_ID = ? AND EVENTO_ID = ?;";
    db.query(sqlSelect, [req.params.candidataId,userInfo.id, req.params.eventoId], (err, result) => {
        if (err) 
            console.log(err);
        //console.log(result);
        res.send(result)
    }
    )
}

export const updateDesempate = (req, res) => {
    const token = req.cookies.access_token
    if (!token) return res.status(401).json("No autenticado!")

    jwt.verify(token, "jwtkey", (err, userInfo) => {
        if (err) return res.status(403).json("Token no es valido!");

        const q = "INSERT INTO desempate (candidata_id, nota_final) VALUES (?, ?) ON DUPLICATE KEY UPDATE nota_final = nota_final + VALUES(nota_final)";
        req.body.notas.forEach((nota, index) => {
            const values = [
                req.body.candidatas[index].candidata_id,
                nota
            ]
            db.query(q, values, (err, data) => {
                if (err) return res.status(500).json(err);
            });
        });
        res.status(200).json("Calificaciones de desempate actualizadas exitosamente.");
    });
}

export const getDesempateNotas = (req, res) => {
    const sqlSelect = "SELECT candidata_id, nota_final FROM desempate";
    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        return res.status(200).json(data);
    });
};


export const getCandidatasEmpatadas = (req, res) => {
    const sql = `
        SELECT candidata_id
        FROM desempate;
    `;
    db.query(sql, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'An error occurred' });
        } else {
            const candidatasEmpatadas = result.map(row => row.candidata_id);
            res.status(200).json({ candidatasEmpatadas });
        }
    });
};

// res.status(500).json(err)