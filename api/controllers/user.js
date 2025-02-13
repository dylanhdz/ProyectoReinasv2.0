import { db } from "../db.js"

export const getUsuarios = (req, res) => {
  const id = req.params.id;
  //console.log(id);
  const sqlSelect = "SELECT * FROM users WHERE id NOT IN (SELECT id FROM (SELECT users.id FROM users join calificacion join candidata WHERE users.id = calificacion.USUARIO_ID AND calificacion.EVENTO_ID = 1 AND calificacion.CANDIDATA_ID = ? AND users.rol = 'Juez') as aa) AND users.rol = 'Juez';"
  db.query(sqlSelect, id, (err, result) => {
    if (err)
      console.log(err);

    // console.log(result);
    res.send(result)
  })
}

export const actualizarActivo = (req, res) => {
  const username = req.params.username;
  const sqlUpdate = "UPDATE users SET activo = 1 WHERE username = ?;";
  db.query(sqlUpdate, username, (err, result) => {
    if (err) {
      res.status(500).json({ message: "Internal server error" });
    } else {
      res.status(200).json({ message: "Se ha actualizado el estatus" });
    }
  });
};

export const actualizarEstadoEvento = (req, res) => {
  const idEvento = req.params.idEvento;
  const estado = req.params.estado;
  const sqlUpdate = "UPDATE evento SET evento_estado = ? WHERE evento_id = ?;";
  db.query(sqlUpdate, [estado, idEvento], (err, result) => {
    if (err) {
      console.log(err);
    } else {
      res.send(result);
    }
  });
};

export const limpiarVotaciones = (req, res) => {
  const sqlLimpiar = [
    "UPDATE votaciones SET vot_estado = 'no';",
    "UPDATE candidata SET cand_nota_final = 0;",
    "UPDATE candidata SET id_eleccion = 0;",
    "TRUNCATE TABLE calificacion;",
    "TRUNCATE TABLE finales;",
    "TRUNCATE TABLE desempate;"
  ];

  sqlLimpiar.forEach((sql) => {
    db.query(sql, (err, result) => {
      if (err) {
        console.log(err);
      }
    });
  });

  res.send("Votaciones limpiadas correctamente");
};


export const limpiarTabla = (req, res) => {
  const sqlLimpiar = "UPDATE votaciones SET vot_estado = 'no'";
  db.query(sqlLimpiar, (err, result) => {
    if (err) {
      console.log(err);
    } else {
      res.send(result);
    }
  });
};

export const checkVotes1 = (req, res) => {
  const { id } = req.query;
  const sqlSelect = 'SELECT COUNT(*) AS total FROM finales where CANDIDATA_ID = ? and EVENTO_ID=1;';
  //console.log(id);
  db.query(sqlSelect, [id], (err, result) => {
    if (err) {
      console.log(err);
      res.status(500).json({ error: 'An error occurred' });
    } else {
      res.status(200).json(result);
    }
  })
}
export const checkVotes2 = (req, res) => {
  const { id } = req.query;
  const sqlSelect = 'SELECT COUNT(*) AS total FROM finales where CANDIDATA_ID = ? and EVENTO_ID=2;';
  //console.log(id); 
  db.query(sqlSelect, [id], (err, result) => {
    if (err) {
      console.log(err);
      res.status(500).json({ error: 'An error occurred' });
    } else {
      res.status(200).json(result);
    }
  })
}
export const checkVotes3 = (req, res) => {
  const sqlSelect = 'SELECT COUNT(*) AS total FROM finales where CANDIDATA_ID = 12 and EVENTO_ID=3;';
  db.query(sqlSelect, (err, result) => {
    if (err) {
      console.log(err);
      res.status(500).json({ error: 'An error occurred' });
    } else {
      res.status(200).json(result);
    }
  })
}

export const verificarEmpate = (req, res) => {
  const sqlSelect = `
    SELECT candidata_id, SUM(calificacion_valor) AS suma
    FROM finales
    GROUP BY candidata_id
    ORDER BY suma DESC;`;

  db.query(sqlSelect, (err, result) => {
    if (err) {
      console.log(err);
      res.status(500).json({ error: 'An error occurred' });
      return;
    }

    if (result.length < 2) {
      res.status(200).json({ empate: false });
      return;
    }

    // Agrupar candidatas por puntuación
    const puntuacionesAgrupadas = result.reduce((acc, curr) => {
      const puntuacion = curr.suma;
      if (!acc[puntuacion]) {
        acc[puntuacion] = [];
      }
      acc[puntuacion].push(curr.candidata_id);
      return acc;
    }, {});

    // Ordenar puntuaciones de mayor a menor
    const puntuacionesOrdenadas = Object.entries(puntuacionesAgrupadas)
      .sort(([a], [b]) => parseFloat(b) - parseFloat(a));

    // Verificar empates en las tres primeras posiciones
    let todosLosEmpates = [];

    for (let i = 0; i < puntuacionesOrdenadas.length && i < 3; i++) {
      const [puntuacion, candidatas] = puntuacionesOrdenadas[i];
      
      if (candidatas.length > 1) {
        // Hay empate en esta posición
        const tipoEmpate = i === 0 ? 'primer-lugar' : 
                          i === 1 ? 'segundo-lugar' : 'tercer-lugar';
        
        todosLosEmpates.push({
          candidatas: candidatas,
          tipo: tipoEmpate,
          puntuacion: parseFloat(puntuacion)
        });
      }
    }

    if (todosLosEmpates.length > 0) {
      // Procesar todos los empates encontrados
      const procesarEmpates = todosLosEmpates.map(empate => {
        return new Promise((resolve, reject) => {
          // Verificar si las candidatas ya existen en la tabla desempate
          db.query(
            "SELECT * FROM desempate WHERE candidata_id IN (?)", 
            [empate.candidatas], 
            (err, existingResults) => {
              if (err) {
                reject(err);
                return;
              }

              const existingCandidataIds = existingResults.map(r => r.candidata_id);
              const candidatasToInsert = empate.candidatas
                .filter(id => !existingCandidataIds.includes(id))
                .map(id => [id, empate.puntuacion, empate.tipo]);

              if (candidatasToInsert.length > 0) {
                const sqlInsert = "INSERT INTO desempate (candidata_id, nota_final, tipo) VALUES ?";
                db.query(sqlInsert, [candidatasToInsert], (err) => {
                  if (err) {
                    reject(err);
                    return;
                  }
                  resolve();
                });
              } else {
                resolve();
              }
            }
          );
        });
      });

      // Ejecutar todas las inserciones
      Promise.all(procesarEmpates)
        .then(() => {
          res.status(200).json({ 
            empate: true, 
            empates: todosLosEmpates
          });
        })
        .catch(err => {
          console.log(err);
          res.status(500).json({ error: 'An error occurred' });
        });
    } else {
      res.status(200).json({ empate: false });
    }
  });
};