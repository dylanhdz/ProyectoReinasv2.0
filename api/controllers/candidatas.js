import { db } from "../db.js"
import jwt from "jsonwebtoken";

export const getCandidatas = (req, res) => {
    const sqlSelect = "SELECT * from candidata"

    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        // console.log(data);
        return res.status(200).json(data);
    });
}


export const getJueces = (req, res) => {
    const sqlSelect = "SELECT * from users where rol = 'juez'";

    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        // console.log(data);
        return res.status(200).json(data);
    });
}


export const getCandidatasFotos = (req, res) => {
    const id = req.params.id;
    //console.log(id);
    const sqlSelect = "SELECT * from foto_candidata where CANDIDATA_ID = ?;";
    db.query(sqlSelect, id, (err, result) => {
        if (err) 
            console.log(err);

        // console.log(result);
        res.send(result)
    })
}

export const getCandidatasTrajeTipico = (req, res) => {
    const sqlSelect = "SELECT candidata.*, foto_candidata.FOTO_URL from candidata join foto_candidata where candidata.CANDIDATA_ID = foto_candidata.CANDIDATA_ID and foto_candidata.FOTO_DESCRIPCION = 'FX' and candidata.CANDIDATA_ID not in (select CANDIDATA_ID from finales where finales.EVENTO_ID = 1);";
    db.query(sqlSelect, (err, result) => {
        if (err) 
            console.log(err);

        // console.log(result);
        res.send(result)
    })
}


export const getVotacionesNotario = (req, res) =>
{
    const sqlSelect = "SELECT USUARIO_ID,EVENTO_ID,CANDIDATA_ID,VOT_ESTADO FROM votaciones";
    db.query(sqlSelect,(err, result) => {
        if (err) 
            console.log(err);

        //console.log(result);
        res.send(result)
    })
} 


export const getCandidatasTrajeGala = (req, res) => {
    const sqlSelect = "SELECT candidata.*, foto_candidata.FOTO_URL from candidata join foto_candidata where candidata.CANDIDATA_ID = foto_candidata.CANDIDATA_ID and foto_candidata.FOTO_DESCRIPCION = 'FX' and candidata.CANDIDATA_ID not in (select CANDIDATA_ID from finales where finales.EVENTO_ID = 2);";
    db.query(sqlSelect, (err, result) => {
        if (err) 
            console.log(err);

        // console.log(result);
        res.send(result)
    })
}

export const getCandidatasBarra = (req, res) => {
    const sqlSelect = "SELECT candidata.*, foto_candidata.FOTO_URL from candidata join foto_candidata where candidata.CANDIDATA_ID = foto_candidata.CANDIDATA_ID and foto_candidata.FOTO_DESCRIPCION = 'FX' and candidata.CANDIDATA_ID not in (select CANDIDATA_ID from finales where finales.EVENTO_ID = 2);";
    db.query(sqlSelect, (err, result) => {
        if (err) 
            console.log(err);

        // console.log(result);
        res.send(result)
    })
}

export const getCandidataCarrusel = (req, res) => {
    const sqlSelect = "SELECT c.*, carr.CARRERA_NOMBRE, d.DEPARTMENTO_NOMBRE, d.DEPARTAMENTO_SEDE FROM candidata AS c JOIN carrera AS carr ON c.CARRERA_ID = carr.CARRERA_ID JOIN departamento AS d ON carr.DEPARTAMENTO_ID = d.DEPARTAMENTO_ID;"
    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        //console.log(data);
        return res.status(200).json(data);
    });
}
