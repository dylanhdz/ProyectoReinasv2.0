import React, { useEffect, useState, useContext } from "react";
import Axios from 'axios';
import { AuthContext } from "../context/authContext";
import Popup from "reactjs-popup";
import Espera from "../components/Espera.jsx";
import { API_BASE_URL } from "./ip";
import Navbar from "../components/Navbar";
import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';
import "./popup.scss";

function Desempate() {
  const { currentUser } = useContext(AuthContext);
  const [elements, setElements] = useState([]);
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [vacioIsOpen, setVacioIsOpen] = useState(false);
  const [pop, setPop] = useState(false);
  const [candidatasEmpatadas, setCandidatasEmpatadas] = useState([]);
  const [candidatasDetalles, setCandidatasDetalles] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await Axios.get(`${API_BASE_URL}/cali/verificar_empate`);
        setCandidatasEmpatadas(response.data.candidatasEmpatadas);
        setElements(Array(response.data.candidatasEmpatadas.length).fill({ nota: 0, nota_final: 0 }));

        const detallesPromises = response.data.candidatasEmpatadas.map(async (candidataId) => {
          const candidataResponse = await Axios.get(`${API_BASE_URL}/candidatas/${candidataId}`);
          return candidataResponse.data;
        });

        const detalles = await Promise.all(detallesPromises);
        setCandidatasDetalles(detalles);
      } catch (err) {
        console.log(err);
      }
    };
    fetchData();
  }, []);

  const cortarParteDerecha = (cadena) => {
    if (typeof cadena !== 'string') {
      console.error("La cadena no es válida");
      return "";
    }

    let parteDerecha = "";
    let i = cadena.length - 1;

    while (i >= 0 && cadena[i] !== "\\") {
      parteDerecha = cadena[i] + parteDerecha;
      i--;
    }

    return parteDerecha;
  };

const handleClick = async () => {
  try {
    const notas = elements.map((element, index) => ({
      candidata_id: candidatasEmpatadas[index].CANDIDATA_ID,
      nota_final: element.nota
    }));

    await Axios.post(`${API_BASE_URL}/cali/desempate`, { notas });
    setPop(true);
    console.log("Calificaciones enviadas");
  } catch (err) {
    console.log(err);
  }
};

  const Enviar = () => {
    if (elements.some(element => element.nota === 0)) {
      setVacioIsOpen(true);
    } else {
      setModalIsOpen(true);
    }
  };

  const handleModalClose = () => {
    setModalIsOpen(false);
  };

  const handleVacioClose = () => {
    setVacioIsOpen(false);
  };

  const setValue = (index, value) => {
    setElements((prevElements) => {
      const newElements = [...prevElements];
      newElements[index] = { ...newElements[index], nota: value };
      return newElements;
    });
  };

  let currentDropdown = null;

  const handleSelectClick = (e) => {
    e.stopPropagation();
    if (currentDropdown && currentDropdown !== e.currentTarget) {
      currentDropdown.querySelector(".menu").classList.remove("menu-open");
    }

    const dropdown = e.currentTarget.querySelector(".menu");
    dropdown.classList.toggle("menu-open");

    currentDropdown = dropdown.classList.contains("menu-open") ? e.currentTarget : null;

    const handleClickOutside = (event) => {
      if (!dropdown.contains(event.target)) {
        dropdown.classList.remove("menu-open");
        window.removeEventListener('click', handleClickOutside);

        if (currentDropdown === e.currentTarget) {
          currentDropdown = null;
        }
      }
    };

    window.addEventListener('click', handleClickOutside);
  };

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
          <Navbar texto="Desempate" />
          {pop && <Espera />}
          <div className="main-container">
            <div className="reinas-container">
              {candidatasEmpatadas.map((candidata, index) => (
                  <div className="item-reina" key={candidata.CANDIDATA_ID}>
                    <div className="espacio-imagen">
                      <img
                          alt="Foto candidata"
                          className="foto-candidata"
                          src={
                            candidata.FOTO_URL
                                ? "/reinas/" + cortarParteDerecha(candidata.FOTO_URL)
                                : '/reinas/default.jpg'
                          }
                      />
                      <div className="datos-candidata">
                        <h3>{candidata.CAND_NOMBRE1} {candidata.CAND_APELLIDOPATERNO}</h3>
                        <h4>{candidata.DEPARTMENTO_NOMBRE}</h4>                      </div>
                    </div>
                    <div className="dropdown" onClick={handleSelectClick}>
                      <div className="botones-container">
                        <div className="select">
                      <span className="selected">
                        {elements[index].nota !== 0 ? `${elements[index].nota} de 10` : 'Votar'}
                      </span>
                        </div>
                        <ul className="menu" aria-label="Action event example">
                          {Array.from({ length: 10 }, (_, i) => (
                              <li
                                  key={i + 1}
                                  onClick={() => setValue(index, i + 1)}
                                  className={elements[index].nota === i + 1 ? "active" : ""}
                              >
                                {i + 1}
                              </li>
                          ))}
                        </ul>
                      </div>
                    </div>
                  </div>
              ))}
            </div>
            <div id="enviarbarra" className="enviar">
              <Button type="button" className="btn-enviar" onClick={Enviar}>
                ENVIAR
              </Button>
              <Popup open={modalIsOpen} onClose={handleModalClose}>
                <div className="modal">
                  <h2 className="modal-title">¿Está seguro de registrar su voto?</h2>
                  <div className="botones-modal">
                    <Stack direction="row" spacing={4} justifyContent="center" alignItems="center">
                      <Button color="success" variant="contained" onClick={() => { handleModalClose(); handleClick(); setPop(true); }} className="btn-confirmar">
                        Si
                      </Button>
                      <Button color="error" variant="outlined" onClick={handleModalClose} className="btn-cancelar">
                        No
                      </Button>
                    </Stack>
                  </div>
                </div>
              </Popup>
              <Popup open={vacioIsOpen} onClose={handleVacioClose}>
                <div className="modal">
                  <h2 className="modal-title">Por favor, registre su voto por cada candidata.</h2>
                  <div className="botones-modal">
                    <Button onClick={handleVacioClose} className="btn-confirmar">
                      Aceptar
                    </Button>
                  </div>
                </div>
              </Popup>
            </div>
          </div>
        </>
    );
  }
}

export default Desempate;
