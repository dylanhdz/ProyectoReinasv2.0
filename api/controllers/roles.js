import { db } from "../db.js";

export const getAllRoles = (req, res) => {
  const sql = "SELECT * FROM roles";
  db.query(sql, (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json(data);
  });
};

export const createRole = (req, res) => {
  const { role_name } = req.body;
  const sql = "INSERT INTO roles (role_name) VALUES (?)";
  db.query(sql, [role_name], (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Rol creado exitosamente.");
  });
};

export const updateRole = (req, res) => {
  const { role_name } = req.body;
  const roleId = req.params.id;
  const sql = "UPDATE roles SET role_name = ? WHERE role_id = ?";
  db.query(sql, [role_name, roleId], (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Rol actualizado exitosamente.");
  });
};

export const deleteRole = (req, res) => {
  const roleId = req.params.id;
  const sql = "DELETE FROM roles WHERE role_id = ?";
  db.query(sql, [roleId], (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Rol eliminado exitosamente.");
  });
};

//asignar permisos

// controllers/roles.js
export const assignPermissionToRole = (req, res) => {
    const { roleName, featureName } = req.params;
    // 1) Insertar una fila en features o actualizarla
    //    para indicar que 'featureName' está habilitada para 'roleName'
    const sql = `
      INSERT INTO features (name, enabled, role_name)
      VALUES (?, 1, ?)
      ON DUPLICATE KEY UPDATE enabled=1, role_name=?;
    `;
    db.query(sql, [featureName, roleName, roleName], (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Permiso asignado con éxito.");
    });
  };
  
  export const revokePermissionFromRole = (req, res) => {
    const { roleName, featureName } = req.params;
    // 2) O lo borras, o lo pones enabled=0
    const sql = `
      DELETE FROM features
      WHERE name=? AND role_name=?;
    `;
    db.query(sql, [featureName, roleName], (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Permiso revocado con éxito.");
    });
  };