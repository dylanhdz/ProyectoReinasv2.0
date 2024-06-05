import React, { useState, useContext } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import axios from "axios";
import Edit from "../img/logo3.png";
import "./styleRegister.css";
import { API_BASE_URL } from "./ip.js";
const Register = () => {
  const { currentUser } = React.useContext(AuthContext);
  const [inputs, setInputs] = useState({
    id: "",
    username: "",
    email: "",
    password: "",
    nombre: "",
    lastname: "",
    rol: "",
  });
  const [err, setError] = useState(null);
  const navigate = useNavigate();
  const handleChange = (e) => {
    setInputs((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post(`${API_BASE_URL}/auth/register`, inputs);
    } catch (err) {
      setError(err.response.data);
    }
  };
  if (currentUser === null || currentUser.rol !== "admin") {
    return (
      <div className="App">
        <main>
          <div>
            <h1>Lo sentimos, no tienes permiso para ver esta página.</h1>
          </div>
        </main>
      </div>
    );
  } else {
    return (
      <div className="contenedor-registro1" >
        <div className="rect-negro1">
          <img className="logoespereina1" src={require("../img/logoespereina.png")} alt="Logo ESPE REINA" />
        </div>
        <div className="container1">
          <div className="title">Registro</div>
          <div className="content">
            <form action="#">
              <div className="user-details">
                <div className="input-box">
                  <span className="details">Nombre </span>
                  <input
                    required
                    type="text"
                    placeholder="nombre"
                    name="nombre"
                    onChange={handleChange}
                  />
                </div>
                <div className="input-box">
                  <span className="details">Apellido</span>
                  <input
                    required
                    type="text"
                    placeholder="apellido"
                    name="lastname"
                    onChange={handleChange}
                  />
                </div>
                <div className="input-box">
                  <span className="details">Usuario</span>
                  <input
                    required
                    type="text"
                    placeholder="Usuario"
                    name="username"
                    onChange={handleChange}
                  />
                </div>
                <div className="input-box">
                  <span className="details">Contraseña</span>
                  <input
                    required
                    type="password"
                    placeholder="contraseña"
                    name="password"
                    onChange={handleChange}
                  />
                </div>
                <div className="input-box">
                  <span className="details">Rol</span>
                  <input
                    required
                    type="text"
                    placeholder="rol"
                    name="rol"
                    onChange={handleChange}
                  />
                </div>
              </div>
            </form>
            <div id="boton-de-registro" className="boton-siguiente">
              <button onClick={handleSubmit}> Registrate</button>
              {err && <p>{err}</p>}
            </div>
          </div>
        </div>
      </div>
    );
  };
};
export default Register;
