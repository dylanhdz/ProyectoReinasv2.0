import React, { useEffect, useState, useContext } from "react";
import Axios from 'axios';
import { AuthContext } from "../context/authContext";
import { Link, useLocation, useNavigate } from "react-router-dom";

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
  const [candidatasEmpatadas, setCandidatasEmpatadas] = useState([]);
  const [candidatasDetalles, setCandidatasDetalles] = useState([]);
  const [empateInfo, setEmpateInfo] = useState(null);
  const [showEmpatePopup, setShowEmpatePopup] = useState(true);
  const [tipoEmpate, setTipoEmpate] = useState('');
  const [empateActual, setEmpateActual] = useState(0);
  const [listaEmpates, setListaEmpates] = useState([]);
  const [candidatasActuales, setCandidatasActuales] = useState([]);
  const navigate = useNavigate();


  useEffect(() => {
    const fetchData = async () => {
        try {
            const response = await Axios.get(`${API_BASE_URL}/cali/verificar_empate`);
            if (response.data.empates) {
                setListaEmpates(response.data.empates);
                // Iniciar con el primer tipo de empate
                setEmpateActual(0);
                actualizarCandidatasActuales(0, response.data.empates);
            }
        } catch (err) {
            console.error("Error al obtener datos de empate:", err);
            setVacioIsOpen(true);
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
  const actualizarCandidatasActuales = (index, empates) => {
    if (index < empates.length) {
        const empateActual = empates[index];
        setCandidatasActuales(empateActual.candidatas);
        setElements(Array(empateActual.candidatas.length).fill({ nota: 0 }));
        setTipoEmpate(empateActual.tipo);
        
        const mensaje = {
            'primer-lugar': 'primer lugar',
            'segundo-lugar': 'segundo lugar',
            'tercer-lugar': 'tercer lugar'
        }[empateActual.tipo];

        setEmpateInfo({
            candidatas: empateActual.candidatas.map(c => 
                `${c.CAND_NOMBRE1} ${c.CAND_APELLIDOPATERNO}`
            ).join(', '),
            tipo: mensaje
        });
    }
};

const handleClick = async () => {
  try {
    const notas = elements.map((element, index) => ({
      candidata_id: candidatasActuales[index].CANDIDATA_ID,
      nota_final: parseFloat(element.nota)
    }));

    await Axios.post(`${API_BASE_URL}/cali/desempate`, {
      notas,
      CALIFICACION_NOMBRE: 'Desempate',
      EVENTO_ID: 4
    });

    // Si hay más empates por resolver, pasar al siguiente
    if (empateActual < listaEmpates.length - 1) {
      setEmpateActual(prev => prev + 1);
      actualizarCandidatasActuales(empateActual + 1, listaEmpates);
    } else {
      navigate("/Gracias");
    }
  } catch (err) {
    if (err.response && err.response.status === 400) {
      // Si el juez ya votó, pasar al siguiente empate si existe
      if (empateActual < listaEmpates.length - 1) {
        setEmpateActual(prev => prev + 1);
        actualizarCandidatasActuales(empateActual + 1, listaEmpates);
      } else {
        navigate("/Gracias");
      }
    } else {
      console.error("Error:", err);
      alert("Error al enviar las calificaciones");
    }
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

  const EmpateModal = () => (
    <Popup open={showEmpatePopup} onClose={() => setShowEmpatePopup(false)}>
        <div className="modal">
            <h2 className="modal-title">¡Atención! Empate Detectado</h2>
            {empateInfo && (
                <div className="modal-content">
                    <p>Se está resolviendo el empate por el <b>{empateInfo.tipo}</b></p>
                    <br/>
                    <p>Candidatas empatadas:</p>
                    <br/>
                    <p className="candidatas-empatadas">{empateInfo.candidatas}</p>
                    <br/>
                    {listaEmpates.length > 1 && (
                        <p className="empate-info">
                            (Empate {empateActual + 1} de {listaEmpates.length})
                        </p>
                    )}
                    <br/>
                    <p>Por favor, proceda a calificar a estas candidatas.</p>
                </div>
            )}
            <div className="botones-modal">
                <button onClick={() => setShowEmpatePopup(false)} className="btn-confirmar">
                    Entendido
                </button>
            </div>
        </div>
    </Popup>
);

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
          <div className="main-container">
            {empateInfo && (
              <div className={`empate-banner ${tipoEmpate}`}>
                <h2>Desempate por {empateInfo.tipo}</h2>
                <p>Calificación para resolver el empate entre: {empateInfo.candidatas}</p>
              </div>
            )}
            <div className="reinas-container">
            {candidatasActuales.map((candidata, index) => (
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
                      <Button color="success" variant="contained" onClick={() => { handleModalClose(); handleClick();  }} className="btn-confirmar">
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
            <EmpateModal />
          </div>
        </>
    );
  }
}

export default Desempate;
