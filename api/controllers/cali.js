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
        const q = "INSERT INTO calificacion(`EVENTO_ID`, `USUARIO_ID`, `CANDIDATA_ID`, `CALIFICACION_NOMBRE`, `CALIFICACION_PESO`, `CALIFICACION_VALOR`) VALUES (?)";
        const values = [
            req.body.EVENTO_ID,
            userInfo.id,
            req.body.CANDIDATA_ID,
            req.body.CALIFICACION_NOMBRE,
            req.body.CALIFICACION_PESO,
            req.body.CALIFICACION_VALOR,
        ]

        db.query(q, [values], (err, data) => {
            if (err) return console.log(err);
            return res.json("El comentario ha sido creado")

        });


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




// res.status(500).json(err)