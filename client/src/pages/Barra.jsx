import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../context/authContext";
import { Link, useLocation } from "react-router-dom";
import Axios from "axios";
import Popup from "reactjs-popup";
import { useNavigate } from "react-router-dom";
import "./popup.scss";
import Espera from "../components/Espera.jsx";
import Navbar from "../components/Navbar";
import { API_BASE_URL } from "./ip.js";
import "./Barras.scss";

const Barra = () => {
  const cat = useLocation().search;
  const { currentUser } = useContext(AuthContext);
  const [nota1, setnota1] = useState("");
  const [voto, setVoto] = useState([]);
  const [pop, setPop] = useState(false);
  const [elements, setElements] = useState([0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
  const setValue = (index, value) => {
    console.log(elements);
    setElements(prevElements => {
      const newElements = [...prevElements]; // Create a copy of the array
      newElements[index] = value; // Update the value at the specified index
      return newElements; // Set the updated array as the new state

    });
    console.log(elements);
  }
  const votacion = (valor) => {
    setVoto(valor);
    recuperarvoto(valor); // aaaaaaaaaaaaaaaaaaaa
  };

  const recuperarvoto = (valor) => {
    console.log(valor);
  };


  const buttons = document.querySelectorAll(".boton-votar-ej");

  buttons.forEach((button) => {
    button.addEventListener("click", () => {
      buttons.forEach((btn) => btn.classList.remove("active"));
      button.classList.add("active");
    });
  });
  //fucnion cortar URL
  const cortarParteDerecha = (cadena) => {
    let parteDerecha = "";
    let i = cadena.length - 1;

    while (i >= 0 && cadena[i] !== "\\") {
      parteDerecha = cadena[i] + parteDerecha;
      i--;
    }

    return parteDerecha;
  };
  //
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [vacioIsOpen, setVacioIsOpen] = useState(false);
  const hasZero = () => {
    for (const element of elements) {
      if (element === 0) {
        return true;
      }
    }
    return false;
  };
  const Enviar = () => {
    /*Control para que esten llenas las 2 notas*/
    if (hasZero()) {
      setVacioIsOpen(true);
      //alert("Debe ingresar todas las calificaciones ");
    } else {
      setModalIsOpen(true);
      /* Aqui es donde tengo las dos calificaciones para mandar*/
      console.log(elements);
    }
  };
  /* Para cerrar el Modal*/
  const handleModalClose = () => {
    setModalIsOpen(false);
  };
  const handleVacioClose = () => {
    setVacioIsOpen(false);
  };
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response1 = await Axios.get(`${API_BASE_URL}/user/ck3?id=${10}`,);
        if (response1.data[0].total === 0) {

        } else {
          navigate("/Gracias");
        }
      } catch (error) {
        console.error(error);
      }
    };

    const interval = setInterval(() => {
      fetchData();
    }, 5000);

    return () => {
      clearInterval(interval);
    };
  }, [cat + "ck3"]);
  const navigate = useNavigate();
  const handleClick = async e => {
    //e.preventDefault()
    //await handleModalClose();
    try {
      //console.log("entrooooo");
      await Axios.post(`${API_BASE_URL}/barra/1`, {
        notas: elements,
        EVENTO_ID: 3,
        CALIFICACION_NOMBRE: "Barras",
        CALIFICACION_PESO: 100,
      });
    } catch (err) {
      console.log(err)
    }
  }
  const handleSend = () => {
    handleModalClose();
    handleClick();
  }
  const [listaCandidatas, setListaCandidatas] = useState([]);
  const [listaNotas, setListaNotas] = useState([]);
  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await Axios.get(`${API_BASE_URL}/barra`);
        setListaCandidatas(res.data);
      } catch (err) {
        console.log(err);
      }
    };
    fetchData();
  }, [cat + "1"]);

  if (currentUser === null || (currentUser.rol !== "juez" && currentUser.rol !== "admin")) {
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
        <Navbar texto="Etapa 3 - Barras" />
        {pop === true && <Espera />}
        <br></br>
        <div className="main-container">

          <div className="reinas-container">
            {listaCandidatas.map((listaCandidatas) => (
              <div className="reina">
                <div className="reinas-cuadro">
                  <div className="reina-informacion">
                    <h3>
                      {listaCandidatas.DEPARTMENTO_NOMBRE}
                    </h3>
                    <h4>
                      <center>
                        Candidata {+ " " + listaCandidatas.CANDIDATA_ID + " : " + listaCandidatas.CAND_NOMBRE1 +
                          " " +
                          listaCandidatas.CAND_APELLIDOPATERNO}
                      </center>
                    </h4>
                    <div className="cuadroAmarillo">
                      <h3>
                        <center>
                          Sede : {listaCandidatas.DEPARTAMENTO_SEDE}
                        </center>
                      </h3>
                    </div>
                  </div>
                  <div className="reina-foto">
                    <img src={"/reinas/" + cortarParteDerecha(listaCandidatas.FOTO_URL)} alt="Foto candidata" />
                  </div>
                </div>
                <div className="botones-container">
                  Elige una calificación para esta Barra:
                  <button
                    className={`boton-votar ${elements[listaCandidatas.CANDIDATA_ID - 1] == 1 ? "selected" : ""}`}
                    value={1}
                    onClick={(e) => setValue(listaCandidatas.CANDIDATA_ID - 1, e.target.value)}
                    key={1}
                    id={listaCandidatas.CANDIDATA_ID}
                  >
                    1
                  </button>
                  <button
                    className={`boton-votar ${elements[listaCandidatas.CANDIDATA_ID - 1] == 2 ? "selected" : ""}`}
                    onClick={(e) => setValue(listaCandidatas.CANDIDATA_ID - 1, e.target.value)}
                    key={2}
                    id={listaCandidatas.CANDIDATA_ID}
                    value={2}
                  >
                    2
                  </button>
                  <button
                    className={`boton-votar ${elements[listaCandidatas.CANDIDATA_ID - 1] == 3 ? "selected" : ""}`}
                    onClick={(e) => setValue(listaCandidatas.CANDIDATA_ID - 1, e.target.value)}
                    key={3}
                    id={listaCandidatas.CANDIDATA_ID}
                    value={3}
                  >
                    3
                  </button>
                  <button
                    className={`boton-votar ${elements[listaCandidatas.CANDIDATA_ID - 1] == 4 ? "selected" : ""}`}
                    onClick={(e) => setValue(listaCandidatas.CANDIDATA_ID - 1, e.target.value)}
                    key={4}
                    id={listaCandidatas.CANDIDATA_ID}
                    value={4}
                  >
                    4
                  </button>
                  <button
                    className={`boton-votar ${elements[listaCandidatas.CANDIDATA_ID - 1] == 5 ? "selected" : ""}`}
                    onClick={(e) => setValue(listaCandidatas.CANDIDATA_ID - 1, e.target.value)}
                    key={5}
                    id={listaCandidatas.CANDIDATA_ID}
                    value={5}
                  >
                    5
                  </button>
                </div>
              </div>
            ))}
          </div>
          <div id='enviarbarra' className="enviar" >
            <button type="button" className="btn-enviar" onClick={(e) => Enviar()}>
              ENVIAR
            </button>

            <Popup open={modalIsOpen} onClose={handleModalClose}>
              <div className="modal">
                <h2 className="modal-title">¿Desea enviar las calificaciones?</h2>

                <div className="botones-modal">
                  <button onClick={handleModalClose} className="btn-cancelar">
                    Cancelar
                  </button>
                  <button onClick={() => { handleModalClose(); handleClick(); setPop(true); }} className="btn-confirmar">
                    Aceptar
                  </button>
                </div>
              </div>
            </Popup>
            {/*Popup de Alerta*/}
            <Popup open={vacioIsOpen} onClose={handleVacioClose}>
              <div className="modal">
                <h2 className="modal-title">Por favor, ingrese todas las calificaciones.</h2>

                <div className="botones-modal">
                  <button onClick={handleVacioClose} className="btn-confirmar">
                    Aceptar
                  </button>
                </div>
              </div>
            </Popup>
          </div>
        </div>
      </>
    );
  }
};

export default Barra;
