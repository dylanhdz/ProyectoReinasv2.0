import { db } from "../db.js"
import jwt from "jsonwebtoken";
import multer from 'multer';
import path from 'path';
import fs from 'fs';


export const getCandidatas = (req, res) => {
    const sqlSelect = "SELECT candidata.*, foto_candidata.foto_url FROM candidata NATURAL JOIN foto_candidata;";
    
    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
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


export const getVotacionesNotario = (req, res) => {
    const sqlSelect = "SELECT USUARIO_ID, EVENTO_ID, CANDIDATA_ID, VOT_ESTADO FROM votaciones";
    db.query(sqlSelect, (err, result) => {
        if (err) console.log(err);
        res.send(result);
    });
};


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
    const sqlSelect = `
        SELECT 
            c.*, 
            carr.CARRERA_NOMBRE, 
            d.DEPARTMENTO_NOMBRE, 
            d.DEPARTAMENTO_SEDE, 
            MIN(fc.foto_url) AS foto_url -- Selecciona solo una foto, puedes usar MIN o MAX
        FROM 
            candidata AS c
        JOIN 
            carrera AS carr ON c.CARRERA_ID = carr.CARRERA_ID
        JOIN 
            departamento AS d ON carr.DEPARTAMENTO_ID = d.DEPARTAMENTO_ID
        LEFT JOIN 
            foto_candidata AS fc ON c.CANDIDATA_ID = fc.CANDIDATA_ID
        GROUP BY 
            c.CANDIDATA_ID; -- Asegúrate de agrupar por el identificador único de la candidata
    `;
    
    db.query(sqlSelect, (err, data) => {
        if (err) return res.status(500).json(err);
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


// En candidatas.js
export const getTopCandidatas = (req, res) => {
    const sqlSelect = `
        SELECT CANDIDATA_ID, CAND_NOMBRE1, CAND_APELLIDOPATERNO, CAND_PUNTUACION_TOTAL
        FROM vista_puntuaciones
        ORDER BY CAND_PUNTUACION_TOTAL DESC
        LIMIT 3;
    `;
    db.query(sqlSelect, (err, data) => {
        if (err) {
            console.error("Error ejecutando la consulta:", err);
            return res.status(500).json(err);
        }
        console.log("Datos obtenidos:", data); // Log para depuración
        return res.status(200).json(data);
    });
};

//crud candidatas


// CREATE
export const createCandidata = (req, res) => {
    const { CARRERA_ID, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO, CAND_NOMBRE1 } = req.body;
    const sql = `
      INSERT INTO candidata (CARRERA_ID, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO, CAND_NOMBRE1)
      VALUES (?, ?, ?, ?)
    `;
    db.query(sql, [CARRERA_ID, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO, CAND_NOMBRE1], (err) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Candidata creada exitosamente.");
    });
  }
  
  // UPDATE
  export const updateCandidata = (req, res) => {
    const candidataId = req.params.id;
    const { CARRERA_ID, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO, CAND_NOMBRE1 } = req.body;
    const sql = `
      UPDATE candidata
      SET CARRERA_ID = ?, CAND_APELLIDOPATERNO = ?, CAND_APELLIDOMATERNO = ?, CAND_NOMBRE1 = ?
      WHERE CANDIDATA_ID = ?
    `;
    db.query(sql, [CARRERA_ID, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO, CAND_NOMBRE1, candidataId], (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Candidata actualizada.");
    });
  }
  
  // DELETE
  export const deleteCandidata = (req, res) => {
    const candidataId = req.params.id;
    const sql = "DELETE FROM candidata WHERE CANDIDATA_ID = ?";
    db.query(sql, [candidataId], (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Candidata eliminada.");
    });
  }

//subir fotos de las candidatas

// 1) Configurar multer
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      // Carpta temporal en el server, por ejemplo
      cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
      // Deja que sea el server el que decida luego renombrar
      cb(null, Date.now() + path.extname(file.originalname));
    },
  });
  export const upload = multer({ storage: storage });
  
  // 2) Supongamos un endpoint "updateCandidataFoto"
  export const updateCandidataFoto = async (req, res) => {
    try {
      const candidataId = req.params.id; // ID de la candidata
      // req.body con los datos: CAND_NOMBRE1, CAND_NOMBRE2, etc.
      const { CAND_NOMBRE1, CAND_NOMBRE2, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO } = req.body;
      // req.file con la foto
      if (!req.file) {
        return res.status(400).json("No se recibió archivo de imagen.");
      }
  
      // 3) Generar el "nuevo nombre" con las iniciales
      //    Ej: N1(0), N2(0), ApP(0), ApM(0)
      //    "Wendy Elizabeth Morillo Rodríguez" => "WEMR.jpg"
      const n1 = CAND_NOMBRE1?.charAt(0) || '';
      const n2 = CAND_NOMBRE2?.charAt(0) || '';
      const ap1 = CAND_APELLIDOPATERNO?.charAt(0) || '';
      const ap2 = CAND_APELLIDOMATERNO?.charAt(0) || '';
  
      // Sufijo = extension
      const ext = path.extname(req.file.originalname); // .jpg, .png, etc.
      const nuevoNombre = `${n1}${n2}${ap1}${ap2}${ext}`.toUpperCase(); 
      // Ej: "WEMR.jpg"
  
      // 4) Mover/copiar el archivo a "D:\\ReinasApp\\assets\\candidatas\\"
      const folderDestino = `D:\\ReinasApp\\assets\\candidatas\\`;
      const newPath = path.join(folderDestino, nuevoNombre);
  
      fs.renameSync(req.file.path, newPath); 
      // Mueve el archivo subido de 'uploads/<temporal>' -> 'D:\ReinasApp\assets\candidatas\WEMR.jpg'
  
      // 5) Guardar en BD la ruta "C:\\fakepath\\WEMRH.jpg" u otra
      //    Podrías guardar: "D:\\ReinasApp\\assets\\candidatas\\WEMR.jpg"
      //    O la “fakepath” que usas, o algo similar
      const fotoUrl = `C:\\fakepath\\${nuevoNombre}`; 
      // O la que quieras
      const sqlUpdate = `
        UPDATE candidata 
        SET CAND_NOMBRE1=?, CAND_NOMBRE2=?, CAND_APELLIDOPATERNO=?, CAND_APELLIDOMATERNO=?, 
            foto_url=?
        WHERE CANDIDATA_ID=?
      `;
      db.query(sqlUpdate, [CAND_NOMBRE1, CAND_NOMBRE2, CAND_APELLIDOPATERNO, CAND_APELLIDOMATERNO, fotoUrl, candidataId], 
      (err, result) => {
        if (err) {
          console.log(err);
          return res.status(500).json("Error al actualizar la candidata en BD.");
        }
        return res.status(200).json("Candidata actualizada con foto.");
      });
    } catch (err) {
      console.log(err);
      return res.status(500).json("Error en updateCandidataFoto.");
    }
  };
