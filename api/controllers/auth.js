import { db } from "../db.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";

export const register = (req, res) => {
    const email = req.body.email;

    // Validar dominio del correo
    if (!email.endsWith("@espe.edu.ec")) {
        return res.status(400).json("Debe usar un correo institucional con dominio @espe.edu.ec.");
    }

    const q = "SELECT * FROM users WHERE email = ?";
    db.query(q, [email], (err, data) => {
        if (err) return res.status(500).json(err);
        if (data.length) return res.status(409).json("El usuario ya existe.");

        // Encriptar contraseña
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(req.body.password, salt);

        const sqlInsert = `
            INSERT INTO users (username, email, password, name, lastname, rol)
            VALUES (?, ?, ?, ?, ?, ?);
        `;
        const values = [
            email, // El usuario será el correo mismo
            email,
            hash,
            req.body.nombre,
            req.body.lastname,
            "usuario", // Rol predeterminado para nuevos registros
        ];

        db.query(sqlInsert, values, (err, result) => {
            if (err) return res.status(500).json(err);

            // Configurar y enviar el correo
            const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                    user: "kalexandervargas@gmail.com",
                    pass: "dniajoxqdawpjchm",
                },
            });

            const mailOptions = {
                from: "kalexandervargas@gmail.com",
                to: email,
                subject: "Registro Exitoso",
                text: `Te has registrado exitosamente. Tus credenciales son:\nUsuario: ${email}\nContraseña: ${req.body.password}`,
            };

            transporter.sendMail(mailOptions, (error, info) => {
                if (error) return res.status(500).json(error);
                res.status(200).json("Usuario registrado correctamente y correo enviado.");
            });
        });
    });
};

export const login = (req, res) => {
    const q = "SELECT * FROM users WHERE username = ?";
  
    db.query(q, [req.body.username], (err, data) => {
      if (err) return res.status(500).json({ error: "Error interno del servidor" });
      if (data.length === 0) return res.status(404).json({ error: "¡Usuario no encontrado!" });
  
      // Verifica la contraseña
      const isPasswordCorrect = bcrypt.compareSync(req.body.password, data[0].password);
  
      if (!isPasswordCorrect)
        return res.status(400).json({ error: "¡Usuario o Contraseña incorrectos!" });
  
      if (data[0].activo === 1)
        return res.status(400).json({ error: "El usuario no puede acceder en dos lugares al mismo tiempo!" });
  
      // Crea un token
      const token = jwt.sign({ id: data[0].id }, "jwtkey");
  
      // Excluye la contraseña de la respuesta
      const { password, ...userData } = data[0];
  
      res.cookie("access_token", token, {
        httpOnly: true,
        secure: true,
        sameSite: "none",
      })
        .status(200)
        .json({ user: userData }); // Enviar el usuario dentro de un objeto con clave 'user'
    });
  };


export const logout = (req, res) => {
    res.clearCookie("access_token", {
        sameSite: "none",
        secure: true
    }
        
    ).status(200).json("User has been logged out.");
};

export const salirDispositivo = (req, res) => {
    const q = "UPDATE users SET activo = 0 WHERE username = ?";

    db.query(q, [req.params.username], (err, data) => {
        if (err) return res.status(500).json(err);
        return res.status(200).json("Ha salido el usuario del dispositivo");
    });
};



export const enviarCorreoRestablecimiento = (req, res) => {
    const { email } = req.body;

    console.log("Recibido email:", email); // Log para confirmar el email recibido

    const sqlSelect = "SELECT * FROM users WHERE email = ?";
    db.query(sqlSelect, [email], (err, data) => {
        if (err) {
            console.error("Error en la consulta SQL:", err);
            return res.status(500).json("Error en el servidor.");
        }
        if (data.length === 0) return res.status(404).json("Usuario no encontrado.");

        const resetToken = Math.random().toString(36).substring(2); // Generar token simple
        const sqlUpdate = "UPDATE users SET password_reset_token = ? WHERE email = ?";
        db.query(sqlUpdate, [resetToken, email], (err) => {
            if (err) {
                console.error("Error al actualizar token:", err);
                return res.status(500).json("Error al actualizar el token.");
            }

            // Configurar y enviar el correo
            const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                    user: "kalexandervargas@gmail.com",
                    pass: "dniajoxqdawpjchm",
                },
            });

            const mailOptions = {
                from: "kalexandervargas@gmail.com",
                to: email,
                subject: "Restablecimiento de Contraseña",
                text: `Para restablecer tu contraseña, haz clic en el siguiente enlace: http://localhost:3000/reset-password/${resetToken}`,
            };

            transporter.sendMail(mailOptions, (error, info) => {
                if (error) {
                    console.error("Error al enviar correo:", error);
                    return res.status(500).json("Error al enviar el correo.");
                }
                res.status(200).json("Correo de restablecimiento enviado.");
            });
        });
    });
};


export const resetPassword = (req, res) => {
    const { token, password } = req.body;

    const q = "SELECT * FROM users WHERE password_reset_token = ?";
    db.query(q, [token], (err, data) => {
        if (err || data.length === 0) return res.status(404).json("Token no válido.");

        // Encriptar nueva contraseña
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(password, salt);

        const sqlUpdate = "UPDATE users SET password = ?, password_reset_token = NULL WHERE password_reset_token = ?";
        db.query(sqlUpdate, [hash, token], (err) => {
            if (err) return res.status(500).json(err);
            res.status(200).json("Contraseña restablecida exitosamente.");
        });
    });
};