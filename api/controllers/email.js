import nodemailer from "nodemailer";
import { db } from "../db.js";

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
                    user: "kalexandervargas@gmail.com",
                    pass: "dniajoxqdawpjchm",
                },
            });

            const mailOptions = {
                from: "kalexandervargas@gmail.com",
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
