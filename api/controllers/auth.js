import { db } from "../db.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import nodemailer from "nodemailer";

// Enviar correo de restablecimiento
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
            req.body.username,
            email,
            hash,
            req.body.name,
            req.body.lastname,
            "usuario", // Rol predeterminado para nuevos registros
        ];

        db.query(sqlInsert, values, (err, result) => {
            if (err) return res.status(500).json(err);
            res.status(200).json("Usuario registrado correctamente.");
        });
    });
};


export const login = (req, res) => {
    //CHECK USER
    const q = "SELECT * FROM users WHERE username = ?";

    db.query(q, [req.body.username], (err, data) => {
        if (err) return res.status(500).json(err);
        if (data.length === 0) return res.status(404).json("¡Usuario no encontrado!");

        //Check password
        const isPasswordCorrect = bcrypt.compareSync(
            req.body.password,
            data[0].password
        );
            
        if (!isPasswordCorrect)
            return res.status(400).json("¡Usuario o Contraseña incorrectos!");
        if (data[0].activo === 1)
            return res.status(400).json("El usuario no puede acceder en dos lugares al mismo tiempo!");
        //Create and assign a token

        const token = jwt.sign({ id: data[0].id }, "jwtkey");
        const { password, ...other } = data[0];

        res.cookie("access_token", token, {
            httpOnly: true,
        })
            .status(200).json(other);
    });

}

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
    const sqlSelect = "SELECT * FROM users WHERE email = ?";

    db.query(sqlSelect, [email], (err, data) => {
        if (err || data.length === 0) return res.status(404).json("Usuario no encontrado.");

        const resetToken = Math.random().toString(36).substring(2); // Generar token simple
        const sqlUpdate = "UPDATE users SET password_reset_token = ? WHERE email = ?";
        db.query(sqlUpdate, [resetToken, email], (err) => {
            if (err) return res.status(500).json(err);

            // Configurar y enviar el correo
            const transporter = nodemailer.createTransport({
                service: "gmail",
                auth: {
                    user: "tu_correo@gmail.com",
                    pass: "tu_contraseña",
                },
            });

            const mailOptions = {
                from: "tu_correo@gmail.com",
                to: email,
                subject: "Restablecimiento de Contraseña",
                text: `Para restablecer tu contraseña, haz clic en el siguiente enlace: http://tu-aplicacion.com/reset-password/${resetToken}`,
            };

            transporter.sendMail(mailOptions, (error, info) => {
                if (error) return res.status(500).json(error);
                res.status(200).json("Correo de restablecimiento enviado.");
            });
        });
    });
};
