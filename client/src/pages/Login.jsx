import React, { useContext, useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import { FaUser, FaLock } from "react-icons/fa";
import { API_BASE_URL } from "./ip.js";
import axios from "axios";
import Popup from "reactjs-popup";
import "./login.scss";
import Logo from "../img/logoespereina.png";

const Login = () => {
  /*PopUp*/
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const handleModalClose = () => {
    setModalIsOpen(false);
  };
  /*Login*/
  const [inputs, setInputs] = useState({
    username: "",
    password: "",
  });
  const [err, setError] = useState(null);
  const navigate = useNavigate();
  const { login } = useContext(AuthContext);
  const handleChange = (e) => {
    setInputs((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await login(inputs);
      //await axios.put(`${API_BASE_URL}/user/${inputs.username}`);
      if (inputs.username === "Veedor") {
        navigate("/TablaNotario");
      } else if (inputs.username === "admin" || inputs.username === "dylan" || inputs.username === "mathias") {
        navigate("/PanelAdmin");
      }
      else {
        navigate("/CRG_Tipico");
      }
    } catch (err) {
      setModalIsOpen(true);
      setError(err.response.data);
      console.log(err.response.data);
    }
  };


  return (
    <div classNameName="Login">
      <section className="containerL">
        <div className="card-1">
          <div className="rect-negro">
            <div className="negro-imagen">
              <div className="logoContainer" id="logoLogin">
                <img src={Logo} alt="Logo Espereina" />
              </div>
            </div>
            {/* <img className="logoespereina" alt="" src={require("../img/logoespereina.png")}/> */}

          </div>
          <h2 className="iniciar-sesion"> Iniciar Sesión </h2>

          <div className="contenedorFormulario">
            <div className="input-container">
              <label>
                Usuario <span className="espacio"></span>
                <span className="icono">
                  <FaUser />
                </span>
              </label>
              <input
                type="text"
                id="username"
                name="username"
                placeholder="Usuario"
                onChange={handleChange}
              />
            </div>
            <div className="input-container">
              <label>
                Contraseña <span className="espacio"></span>
                <span className="icono">
                  <FaLock />
                </span>
              </label>
              <input
                type="password"
                id="password"
                name="password"
                placeholder="Contraseña"
                onChange={handleChange}
              />
            </div>

            <button className="loginBut" value="Iniciar Sesión" onClick={handleSubmit}>
              <p>Iniciar Sesión</p>
            </button>
            <p className="iniciar-sesion"> © - Derechos Reservados</p>
            <p className="iniciar-sesion"> Dpto. de Ciencias de la Computación</p>
            <Popup open={modalIsOpen} onClose={handleModalClose}>
              <div className="modal">
                <h2 className="modal-title">Error de Ingreso</h2>
                <p className="modal-p">{err}</p>
                <div className="botones-modal">
                  <button onClick={() => { handleModalClose();}} className="btn-confirmar">
                    Aceptar
                  </button>
                </div>
              </div>
            </Popup>
          </div>
        </div>

        <div className="card-2">
          <img className="siluetaReina" alt="" src={require("../img/siluetareina.png")} />
        </div>
      </section>
    </div>
  );
};
export default Login;
