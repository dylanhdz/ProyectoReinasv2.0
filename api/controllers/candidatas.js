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

export const setCandidatas = (req, res) => {
    // First get the next available ID
    const getMaxId = "SELECT MAX(CANDIDATA_ID) as max_id FROM candidata";
    
    db.query(getMaxId, (err, result) => {
        if (err) {
            console.error("Error getting max ID:", err);
            return res.status(500).json(err);
        }

        const nextId = (result[0].max_id || 0) + 1;

        const sqlInsert = `
            INSERT INTO candidata (
                CANDIDATA_ID,
                CAND_NOMBRE1, 
                CAND_NOMBRE2, 
                CAND_APELLIDOPATERNO, 
                CAND_APELLIDOMATERNO, 
                CAND_NOTA_FINAL, 
                CARRERA_ID, 
                ELECCION_ID, 
                ID_ELECCION
            ) VALUES (?)
        `;
        
        const values = [
            nextId,
            req.body.CAND_NOMBRE1,
            req.body.CAND_NOMBRE2 || '',
            req.body.CAND_APELLIDOPATERNO,
            req.body.CAND_APELLIDOMATERNO,
            0.00,  // CAND_NOTA_FINAL
            req.body.CARRERA_ID,
            1,     // ELECCION_ID
            0      // ID_ELECCION
        ];

        db.query(sqlInsert, [values], (err, result) => {
            if (err) {
                console.error("Error en setCandidatas:", err);
                return res.status(500).json(err);
            }
            return res.status(200).json({
                message: "Candidata creada con éxito!",
                id: nextId
            });
        });
    });
};

export const uploadFoto = (req, res) => {
    if (!req.file) {
        return res.status(400).json({ 
            message: "No se proporcionó ningún archivo" 
        });
    }

    // Return success with filename
    return res.status(200).json({
        message: "Archivo subido exitosamente",
        filename: req.file.filename
    });
};

export const setCandidatasFotos = (req, res) => {
    // First get the next available FOTO_ID
    const getMaxId = "SELECT MAX(FOTO_ID) as max_id FROM foto_candidata";
    
    db.query(getMaxId, (err, result) => {
        if (err) {
            console.error("Error getting max FOTO_ID:", err);
            return res.status(500).json(err);
        }

        const nextFotoId = (result[0].max_id || 0) + 1;

        const sqlInsert = `
            INSERT INTO foto_candidata (
                FOTO_ID,
                CANDIDATA_ID, 
                FOTO_DESCRIPCION, 
                FOTO_URL
            ) VALUES (?)
        `;
        
        const values = [
            nextFotoId,
            req.body.CANDIDATA_ID,
            'FX',
            req.body.FOTO_URL
        ];

        db.query(sqlInsert, [values], (err, data) => {
            if (err) {
                console.error("Error en setCandidatasFotos:", err);
                return res.status(500).json(err);
            }
            return res.status(200).json({
                message: "Foto registrada con éxito!",
                id: nextFotoId
            });
        });
    });
};

export const getDepartamentos = (req, res) => {
    const sqlSelect = "SELECT * from departamento;"
    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
        //console.log(data);
        return res.status(200).json(data);
    });
}

// Backend: Verificar si hay registros en la tabla de desempate y si el proceso de desempate ha terminado
export const verificarDesempate = (req, res) => {
    const sqlSelect = `SELECT COUNT(*) AS count FROM desempate;`;
    db.query(sqlSelect, (err, result) => {
        if (err) {
            console.log(err);
            res.status(500).json({ error: 'An error occurred' });
        } else {
            const desempateCount = result[0].count;
            if (desempateCount > 0) {
                res.status(200).json({ desempate: true });
            } else {
                res.status(200).json({ desempate: false });
            }
        }
    });
};

