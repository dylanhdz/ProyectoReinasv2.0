import { useContext } from "react";
import React from "react";
import { Link, useNavigate } from "react-router-dom";
import { AuthContext } from "../context/authContext";
import "./CRG_Tipico.scss";
import logoTipico from "../img/logoespereina.png";

const CRG_Tipico = () => {
  const { currentUser } = useContext(AuthContext);
  if (
    currentUser === null ||
    (currentUser.rol !== "juez" && currentUser.rol !== "admin")
  ) {
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
      <>
        {
          <div className="esperaTipico">
            <figure className="cortina_izquierda"></figure>
            <figure className="cortina_derecha"></figure>
            <img src={logoTipico} alt="logo" className="logoespereinaTipico" />
            <h1 className="tituloTipico" contenteditable data-heading="Traje Típico">
              Traje Típico
            </h1>
            <div className="boton-crg" id="btn-crg">
              <Link to="/TrajeTipico">
                <button className="btn" >INICIAR VOTACIÓN</button>
              </Link>
            </div>
          </div>
        }
      </>
    );
  }
};
export default CRG_Tipico;
