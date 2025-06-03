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
        if (err) return res.status(403).json("Token no es válido!");

        const notasValidadas = req.body.notas.map(nota => ({
            candidata_id: parseInt(nota.candidata_id),
            nota_final: parseFloat(nota.nota_final)
        }));

        // Verificar si el juez ya votó para este tipo específico de desempate
        const checkJuezVoto = `
            SELECT COUNT(*) as ya_voto 
            FROM calificacion c
            JOIN desempate d ON c.CANDIDATA_ID = d.candidata_id
            WHERE c.USUARIO_ID = ? 
            AND c.EVENTO_ID = 4 
            AND c.CALIFICACION_NOMBRE = 'Desempate'
            AND d.tipo = (
                SELECT tipo FROM desempate 
                WHERE candidata_id = ?
                LIMIT 1
            )`;

        db.query(checkJuezVoto, [userInfo.id, notasValidadas[0].candidata_id], (err, votedResult) => {
            if (err) {
                console.error("Error al verificar voto del juez:", err);
                return res.status(500).json(err);
            }

            if (votedResult[0].ya_voto > 0) {
                return res.status(400).json("Ya has emitido tu voto para este tipo de desempate");
            }

            // Si no ha votado este tipo de desempate, insertamos en la tabla calificacion
            const q = "INSERT INTO calificacion(`EVENTO_ID`, `USUARIO_ID`, `CANDIDATA_ID`, `CALIFICACION_NOMBRE`, `CALIFICACION_PESO`, `CALIFICACION_VALOR`) VALUES ?";
            const values = notasValidadas.map(nota => [
                4,
                userInfo.id,
                nota.candidata_id,
                'Desempate',
                100,
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
            fc.FOTO_URL,
            d.tipo 
        FROM 
            desempate d
            INNER JOIN candidata ca ON d.candidata_id = ca.CANDIDATA_ID
            INNER JOIN carrera car ON ca.CARRERA_ID = car.CARRERA_ID
            INNER JOIN departamento dpto ON car.DEPARTAMENTO_ID = dpto.DEPARTAMENTO_ID
            INNER JOIN foto_candidata fc ON ca.CANDIDATA_ID = fc.CANDIDATA_ID AND fc.FOTO_DESCRIPCION = 'FX'
        ORDER BY 
            CASE d.tipo
                WHEN 'primer-lugar' THEN 1
                WHEN 'segundo-lugar' THEN 2
                WHEN 'tercer-lugar' THEN 3
            END;
    `;
    
    db.query(sql, (err, result) => {
        if (err) {
            console.log(err);
            return res.status(500).json(err);
        }

        // Agrupar por tipo de empate
        const empatesPorTipo = result.reduce((acc, candidata) => {
            if (!acc[candidata.tipo]) {
                acc[candidata.tipo] = [];
            }
            acc[candidata.tipo].push(candidata);
            return acc;
        }, {});

        // Ordenar los tipos de empate
        const ordenEmpates = ['primer-lugar', 'segundo-lugar', 'tercer-lugar'];
        const empatesOrdenados = ordenEmpates
            .filter(tipo => empatesPorTipo[tipo])
            .map(tipo => ({
                tipo: tipo,
                candidatas: empatesPorTipo[tipo]
            }));

        res.status(200).json({
            empates: empatesOrdenados,
            tieneMultiplesEmpates: empatesOrdenados.length > 1
        });
    });
};

export const checkDesempateStatus = (req, res) => {
    const token = req.cookies.access_token;
    if (!token) return res.status(401).json("No autenticado!");

    jwt.verify(token, "jwtkey", (err, userInfo) => {
        if (err) return res.status(403).json("Token no es valido!");

        const sql = `
            SELECT DISTINCT tipo
            FROM calificacion c
            JOIN desempate d ON c.CANDIDATA_ID = d.candidata_id
            WHERE c.USUARIO_ID = ? 
            AND c.CALIFICACION_NOMBRE = 'Desempate'
        `;

        db.query(sql, [userInfo.id], (err, result) => {
            if (err) return res.status(500).json(err);
            
            const votadosPorTipo = result.map(r => r.tipo);
            res.status(200).json({
                primer_lugar: votadosPorTipo.includes('primer_lugar'),
                segundo_lugar: votadosPorTipo.includes('segundo_lugar'),
                tercer_lugar: votadosPorTipo.includes('tercer_lugar')
            });
        });
    });
};

export const addCalificacion = (req, res) => {
  try {
    const { notas, EVENTO_ID, CALIFICACION_NOMBRE, CALIFICACION_PESO } = req.body;
    const USUARIO_ID = req.userId;
    
    // Verificar que notas es un objeto o array
    if (!notas || (typeof notas !== 'object')) {
      return res.status(400).json({ error: "Formato de calificaciones inválido" });
    }
    
    // Crear un array para almacenar todas las promesas de inserción
    const insertPromises = [];
    
    // Si notas es un objeto (nuevo formato), procesar las claves como IDs de candidata
    if (!Array.isArray(notas)) {
      Object.entries(notas).forEach(([candidataId, valor]) => {
        const CANDIDATA_ID = parseInt(candidataId, 10);
        const CALIFICACION_VALOR = parseInt(valor, 10);
        
        // Verificar que tenemos valores válidos
        if (isNaN(CANDIDATA_ID) || isNaN(CALIFICACION_VALOR)) {
          console.warn(`Valores no numéricos para candidata ${candidataId}: ${valor}`);
          return;
        }
        
        // Solo insertar si el valor es mayor que cero
        if (CALIFICACION_VALOR > 0) {
          const insertPromise = new Promise((resolve, reject) => {
            const query = `
              INSERT INTO calificacion (
                EVENTO_ID, 
                USUARIO_ID, 
                CANDIDATA_ID, 
                CALIFICACION_NOMBRE, 
                CALIFICACION_PESO, 
                CALIFICACION_VALOR
              ) VALUES (?, ?, ?, ?, ?, ?)
            `;
            
            db.query(
              query,
              [
                EVENTO_ID,
                USUARIO_ID,
                CANDIDATA_ID,
                CALIFICACION_NOMBRE,
                CALIFICACION_PESO,
                CALIFICACION_VALOR
              ],
              (err, result) => {
                if (err) {
                  console.error("Error en inserción:", err);
                  reject(err);
                } else {
                  resolve(result);
                }
              }
            );
          });
          
          insertPromises.push(insertPromise);
        }
      });
    } else {
      // Mantener compatibilidad con el formato de array (código anterior)
      notas.forEach((valor, index) => {
        const CANDIDATA_ID = index + 1;
        const CALIFICACION_VALOR = parseInt(valor, 10);
        
        if (isNaN(CALIFICACION_VALOR)) {
          console.warn(`Valor no numérico para candidata ${CANDIDATA_ID}: ${valor}`);
          return;
        }
        
        if (CALIFICACION_VALOR > 0) {
          const insertPromise = new Promise((resolve, reject) => {
            const query = `
              INSERT INTO calificacion (
                EVENTO_ID, 
                USUARIO_ID, 
                CANDIDATA_ID, 
                CALIFICACION_NOMBRE, 
                CALIFICACION_PESO, 
                CALIFICACION_VALOR
              ) VALUES (?, ?, ?, ?, ?, ?)
            `;
            
            db.query(
              query,
              [
                EVENTO_ID,
                USUARIO_ID,
                CANDIDATA_ID,
                CALIFICACION_NOMBRE,
                CALIFICACION_PESO,
                CALIFICACION_VALOR
              ],
              (err, result) => {
                if (err) {
                  console.error("Error en inserción:", err);
                  reject(err);
                } else {
                  resolve(result);
                }
              }
            );
          });
          
          insertPromises.push(insertPromise);
        }
      });
    }
    
    // Ejecutar todas las inserciones
    Promise.all(insertPromises)
      .then(() => {
        res.status(200).json({ message: "Calificaciones registradas correctamente" });
      })
      .catch((error) => {
        console.error("Error en el proceso de calificación:", error);
        res.status(500).json({ error: "Error al registrar calificaciones" });
      });
      
  } catch (error) {
    console.error("Error en addCalificacion:", error);
    res.status(500).json({ error: "Error interno del servidor" });
  }
};
