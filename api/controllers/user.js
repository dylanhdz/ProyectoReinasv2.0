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
    "TRUNCATE TABLE finales;"
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
  const sqlSelect = 'SELECT COUNT(*) AS total FROM finales where CANDIDATA_ID = 10 and EVENTO_ID=3;';
  db.query(sqlSelect, (err, result) => {
    if (err) {
      console.log(err);
      res.status(500).json({ error: 'An error occurred' });
    } else {
      res.status(200).json(result);
    }
  })
}