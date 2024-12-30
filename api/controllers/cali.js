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
  
      // 1) Revisar si el evento está abierto
      const checkEventSql = "SELECT EVENTO_ESTADO FROM evento WHERE EVENTO_ID = ?";
      db.query(checkEventSql, [req.body.EVENTO_ID], (err, checkResult) => {
        if (err) return res.status(500).json(err);
  
        // Si no hay registro o está 'no', rechazar
        if (!checkResult.length || checkResult[0].EVENTO_ESTADO === "no") {
          return res
            .status(403)
            .json("El evento está cerrado. No se aceptan más calificaciones.");
        }
  
        // 2) Evento abierto => Insertar/actualizar en calificacion y votaciones
        const qCali = `
          INSERT INTO calificacion (EVENTO_ID, USUARIO_ID, CANDIDATA_ID, CALIFICACION_NOMBRE, CALIFICACION_PESO, CALIFICACION_VALOR)
          VALUES (?)
        `;
        const qVot = `
          INSERT INTO votaciones (USUARIO_ID, EVENTO_ID, CANDIDATA_ID, VOT_ESTADO)
          VALUES (?, ?, ?, 'si')
          ON DUPLICATE KEY UPDATE VOT_ESTADO = 'si'
        `;
  
        const promises = [];
  
        for (let i = 0; i < 12; i++) {
          // Datos para calificacion
          const valuesCali = [
            req.body.EVENTO_ID,
            userInfo.id,
            1 + i,
            req.body.CALIFICACION_NOMBRE,
            req.body.CALIFICACION_PESO,
            Number(req.body.notas[i]),
          ];
          // Datos para votaciones
          const valuesVot = [
            userInfo.id,         // USUARIO_ID
            req.body.EVENTO_ID,
            1 + i                // CANDIDATA_ID
          ];
  
          // Promesa que primero inserta en calificacion, luego en votaciones
          promises.push(
            new Promise((resolve, reject) => {
              db.query(qCali, [valuesCali], (err) => {
                if (err) return reject(err);
  
                db.query(qVot, valuesVot, (err2) => {
                  if (err2) return reject(err2);
                  resolve("Ok");
                });
              });
            })
          );
        }
  
        // 3) Esperar todas las inserciones
        Promise.all(promises)
          .then(() => {
            res.status(200).json("Calificación agregada y votaciones actualizadas exitosamente.");
          })
          .catch((err) => {
            res.status(500).json(err);
          });
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

        const q = "UPDATE candidata SET CAND_NOTA_FINAL = CAND_NOTA_FINAL + ? WHERE CANDIDATA_ID = ?";
        const promises = req.body.notas.map(nota => {
            const values = [nota.nota_final, nota.candidata_id];
            return new Promise((resolve, reject) => {
                db.query(q, values, (err, data) => {
                    if (err) return reject(err);
                    resolve(data);
                });
            });
        });

        Promise.all(promises)
            .then(() => {
                res.status(200).json("Calificaciones de desempate actualizadas exitosamente.");
            })
            .catch(err => {
                res.status(500).json(err);
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

export const votarPublico = (req, res) => {
    const { usuarioId, candidataId } = req.body;
    const eventoId = 4; // ID del evento público
  
    // 1) Revisar si el evento público (ID=4) está abierto
    const sqlCheck = "SELECT EVENTO_ESTADO FROM evento WHERE EVENTO_ID = 4";
    db.query(sqlCheck, (err, checkResult) => {
      if (err) return res.status(500).json(err);
  
      if (!checkResult.length || checkResult[0].EVENTO_ESTADO === "no") {
        return res
          .status(403)
          .json("El evento público ya ha finalizado. No se aceptan más votos.");
      }
  
      // 2) Evento público abierto => Insertar en 'calificacion'
      const sqlInsertCali = `
        INSERT INTO calificacion (EVENTO_ID, USUARIO_ID, CANDIDATA_ID, CALIFICACION_NOMBRE, CALIFICACION_PESO, CALIFICACION_VALOR)
        VALUES (?, ?, ?, 'Voto Público', 1, 1)
        ON DUPLICATE KEY UPDATE CALIFICACION_VALOR = CALIFICACION_VALOR + 1;
      `;
      db.query(sqlInsertCali, [eventoId, usuarioId, candidataId], (err, result) => {
        if (err) return res.status(500).json(err);
  
        // 3) Insertar/actualizar en 'votaciones' para marcarlo como "si"
        const qVot = `
          INSERT INTO votaciones (USUARIO_ID, EVENTO_ID, CANDIDATA_ID, VOT_ESTADO)
          VALUES (?, ?, ?, 'si')
          ON DUPLICATE KEY UPDATE VOT_ESTADO = 'si'
        `;
        const valuesVot = [usuarioId, eventoId, candidataId];
        db.query(qVot, valuesVot, (err2) => {
          if (err2) return res.status(500).json(err2);
  
          res.status(200).json("Voto público registrado correctamente.");
        });
      });
    });
  };
  

  export const cerrarVotaciones = (req, res) => {
    const sqlUpdate = "UPDATE evento SET EVENTO_ESTADO = 'no' WHERE EVENTO_ID IN (1, 2, 3, 4)";
    db.query(sqlUpdate, (err, result) => {
      if (err) return res.status(500).json(err);
      res.status(200).json("Votaciones cerradas correctamente.");
    });
  };
  
  export const actualizarPuntajeFinal = (req, res) => {
    const sqlUpdate = `
      UPDATE candidata c
      JOIN (
        SELECT CANDIDATA_ID, SUM(CALIFICACION_VALOR) AS total_votos
        FROM calificacion
        WHERE EVENTO_ID IN (1, 2, 3, 4)
        GROUP BY CANDIDATA_ID
      ) v ON c.CANDIDATA_ID = v.CANDIDATA_ID
      SET c.CAND_NOTA_FINAL = v.total_votos
    `;
    db.query(sqlUpdate, (err, result) => {
      if (err) return res.status(500).json(err);
      res.status(200).json("Puntaje final actualizado correctamente.");
    });
  };
