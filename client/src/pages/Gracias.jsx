import { useContext, useState, useEffect } from "react";
import React from "react";
import { AuthContext } from "../context/authContext";
import "./Gracias.scss";
import logoEspeBarra from "../img/logoespereina.png";
import Confetti from "react-confetti";
const Gracias = () => {
  const { currentUser } = useContext(AuthContext);
  const [showConfetti, setShowConfetti] = useState(true);

  useEffect(() => {
    const confettiDuration = 6000;

    const timeout = setTimeout(() => {
      setShowConfetti(false);
    }, confettiDuration);

    return () => clearTimeout(timeout);
  }, []);

  if (
    currentUser === null ||
    (currentUser.rol !== "juez" && currentUser.rol !== "admin")
  ) {
    return (
      <div classNameName="App">
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
          <div
            className="contenedorGracias"
            style={{ width: "100%", height: "100vh", overflowX: "hidden" }}
          >
            {showConfetti && (
              <Confetti
                width={window.innerWidth}
                height={window.innerHeight}
                recycle={true}
                gravity={0.02}
                numberOfPieces={300}
                friction={0.99}
              />
            )}
            <section className="intro">
              Muchas gracias por tu participación en el concurso de la Elección
              de la Reina ESPE 2023
            </section>
            <section className="logoEspeBarra">
              <img src={logoEspeBarra} alt="Logo de la ESPE de la Reina" />
            </section>
            <div id="scroller">
              <div id="content">
                <h1 id="title">
                  Coordinador del Proyecto de Programación Web Avanzada
                </h1>
                <h2 id="nombreMiembro">PhD. Angel Rea</h2>

                <h1 id="title">Equipo de gestión del proyecto</h1>
                <p id="nombreMiembro">Diego Portilla</p>
                <p id="nombreMiembro">Dylan Hernández</p>

                <h1 id="title">Equipo de Requerimientos</h1>
                <h2 id="subtitle">Coordinadores</h2>
                <p id="nombreMiembro">Alex Paguay</p>
                <h1 id="subtitle">Desarrolladores Principales</h1>
                <p id="nombreMiembro">Santiago Sañay</p>
                <p id="nombreMiembro">Johan Godoy</p>
                <p id="nombreMiembro">Juan Gallardo</p>
                <p id="nombreMiembro">Adriana Diaz</p>

                <h1 id="title">Equipo de Desarrollo de Interfaces</h1>
                <h2 id="subtitle">Coordinadores</h2>
                <p id="nombreMiembro">Diego Portilla</p>
                <p id="nombreMiembro">Shared Tinoco</p>
                <p id="nombreMiembro">Kevin Vargas</p>

                <h1 id="subtitle">Desarrolladores Principales</h1>
                <p id="nombreMiembro">Diego Portilla</p>
                <p id="nombreMiembro">Shared Tinoco</p>
                <p id="nombreMiembro">Kevin Vargas</p>
                <p id="nombreMiembro">Jeremy Cadena</p>
                <p id="nombreMiembro">Santiago Chasiluisa</p>
                <p id="nombreMiembro">Omar Gualotuña</p>
                <p id="nombreMiembro">David Guarderas</p>
                <p id="nombreMiembro">Johan Godoy</p>
                <p id="nombreMiembro">Daniel Llumiquinga</p>
                <p id="nombreMiembro">Lizardo Tituaña</p>
                <p id="nombreMiembro">Cristopher Zambrano</p>

                <h1 id="subtitle">Desarrolladores de la Primera Versión</h1>
                <p id="nombreMiembro">Camila Rivera</p>

                <h1 id="title">Equipo de desarrollo de Base de Datos y CRUD</h1>
                <h2 id="subtitle">Coordinadores</h2>
                <p id="nombreMiembro">Diego Portilla</p>
                <p id="nombreMiembro">Christopher Iza</p>

                <h1 id="subtitle">Desarrolladores Principales</h1>
                <p id="nombreMiembro">Diego Portilla</p>
                <p id="nombreMiembro">Christopher Iza</p>
                <p id="nombreMiembro">Mathias Guevara</p>
                <p id="nombreMiembro">Dylan Hernández</p>
                <p id="nombreMiembro">Luca de Veintemilla</p>

                <h1 id="title">Equipo de Redes</h1>
                <h2 id="subtitle">Coordinadores</h2>
                <p id="nombreMiembro">Juan Reyes</p>

                <h1 id="title">Desarrolladores Principales</h1>
                <p id="nombreMiembro">Juan Reyes</p>
                <p id="nombreMiembro">Brandon Masacela</p>

                <h1 id="title">Soporte Adicional</h1>
                <p id="nombreMiembro">Alex Paguay</p>
                <p id="nombreMiembro">Santiago Sañay</p>


              </div>
            </div>
          </div>
        }
      </>
    );
  }
};
export default Gracias;