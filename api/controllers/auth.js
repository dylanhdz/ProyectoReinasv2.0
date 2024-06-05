import { db } from "../db.js";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

export const register = (req, res) => {
    //CHECK EXISTING USER
    const q = "SELECT * FROM users WHERE username = ?";

    db.query(q, [req.body.email, req.body.username], (err, data) => {
        if (err) return res.status(500).json(err);
        if (data.length) return res.status(409).json("El Usuario ya existe!");

        //Encriptado
        //Hash the password and create a user
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(req.body.password, salt);

        const q = "INSERT INTO users(`ELECCION_ID`,`username`,`password`,`name`,`lastname`,`rol`) VALUES (?)";
        const values = [
            1,
            req.body.username,
            hash,
            req.body.nombre,
            req.body.lastname,
            req.body.rol,];

        db.query(q, [values], (err, data) => {
            if (err) return console.log(err);
            return res.status(200).json("Se creó el usuario");
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


