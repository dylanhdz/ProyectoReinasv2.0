import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../context/authContext";
import { Link, useLocation, useNavigate } from "react-router-dom";
import Axios, { all } from 'axios';
import ReactModal from "react-modal";
import Popup from "reactjs-popup";
import "./popup.scss";
import "./trajes.scss";
import Espera from "../components/Espera.jsx";
import { API_BASE_URL } from "./ip";
import Navbar from "../components/Navbar";
import Stack from '@mui/material/Stack';
import Button from '@mui/material/Button';

function TGala() {

  const cat = useLocation().search;
  const { currentUser } = useContext(AuthContext);
  const [elements, setElements] = useState([]);
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [vacioIsOpen, setVacioIsOpen] = useState(false);
  const [pop, setPop] = useState(false);
  const navigate = useNavigate();

  const cortarParteDerecha = (cadena) => {
    let parteDerecha = "";
    let i = cadena.length - 1;

    while (i >= 0 && cadena[i] !== "\\") {
      parteDerecha = cadena[i] + parteDerecha;
      i--;
    }

    return parteDerecha;
  };

  const setValue = (candidataId, value) => {
    setElements((prevElements) => {
      const newElements = [...prevElements];
      // Encontrar el índice real de la candidata en el array
      const index = listaCandidatas.findIndex(c => c.CANDIDATA_ID === candidataId);
      if (index !== -1) {
        newElements[index] = value;
      }
      return newElements;
    });
  };

  const handleClick = () => {
    setTimeout(async () => {
      try {
        // Creamos un array de calificaciones en lugar de un objeto
        const notasArray = [];
        
        listaCandidatas.forEach((candidata) => {
          const index = listaCandidatas.findIndex(c => c.CANDIDATA_ID === candidata.CANDIDATA_ID);
          const valor = parseInt(elements[index], 10) || 0;
          
          // Guardamos cada calificación como un objeto con ID y valor explícitos
          notasArray.push({
            candidataId: String(candidata.CANDIDATA_ID),
            valor: String(valor)
          });
          
          console.log(`Preparando candidata ${candidata.CANDIDATA_ID}: ${valor}`);
        });
        
        console.log("Datos a enviar:", notasArray);
        
        await Axios.post(`${API_BASE_URL}/cali`, {
          notasArray: notasArray,
          EVENTO_ID: 2,
          CALIFICACION_NOMBRE: "Traje Gala",
          CALIFICACION_PESO: 100,
        });
        setPop(true);
        console.log("Calificaciones enviadas");
      } catch (err) {
        console.log(err);
      }
    }, 2000);
  };

  const Enviar = () => {
    if (elements.includes(0)) {
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

  const [listaCandidatas, setListaCandidatas] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Get the candidates first if not already loaded
        if (listaCandidatas.length === 0) {
          const candidatasRes = await Axios.get(`${API_BASE_URL}/barra`);
          setListaCandidatas(candidatasRes.data);
          setElements(Array.from({ length: candidatasRes.data.length }, () => 0));
        }
        
        // Check if we have candidates to verify
        if (listaCandidatas.length > 0) {
          // Check the last candidate (assumes candidates are numbered sequentially)
          const lastCandidateId = listaCandidatas[listaCandidatas.length - 1].CANDIDATA_ID;
          const response1 = await Axios.get(`${API_BASE_URL}/user/ck2?id=${lastCandidateId}`);
          
          if (response1.data[0].total === 0) {
            // No votes for the last candidate yet, stay on this page
          } else {
            navigate("/CRG_Barra");
          }
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
  }, [cat + "ck2", listaCandidatas, navigate]);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await Axios.get(`${API_BASE_URL}/barra`);
        setListaCandidatas(res.data);
        setElements(Array.from({ length: res.data.length }, () => 0));
      } catch (err) {
        console.log(err);
      }
    };
    fetchData();
  }, [cat + "1"]);

  const handleSelectClick = (e) => {
    e.stopPropagation();
    e.preventDefault();
    
    const selectButton = e.currentTarget;
    const dropdown = selectButton.parentNode.querySelector(".dropdown");
    const card = selectButton.closest('.item-reina');
    
    // Cerrar todos los dropdowns abiertos primero
    document.querySelectorAll('.dropdown.menu-open').forEach(openDropdown => {
      if (openDropdown !== dropdown) {
        openDropdown.classList.remove('menu-open');
        const openCard = openDropdown.closest('.item-reina');
        if (openCard) openCard.classList.remove('dropdown-active');
      }
    });

    const isOpening = !dropdown.classList.contains("menu-open");
    
    if (isOpening) {
      // Calcular posición del botón para dropdown fixed
      const buttonRect = selectButton.getBoundingClientRect();
      const dropdownWidth = 120;
      const dropdownHeight = 150; // Altura más conservadora
      
      // Centrar el dropdown respecto al botón y posicionarlo arriba
      let leftPosition = buttonRect.left + (buttonRect.width / 2) - (dropdownWidth / 2);
      let topPosition = buttonRect.top - dropdownHeight - 5;
      
      // Asegurarse de que no se salga de la pantalla
      if (leftPosition < 10) leftPosition = 10;
      if (topPosition < 10) topPosition = buttonRect.bottom + 5; // Si no cabe arriba, ponerlo abajo
      
      dropdown.style.left = `${leftPosition}px`;
      dropdown.style.top = `${topPosition}px`;
      dropdown.style.transform = 'none'; // Asegurar que no hay transform conflictivo
      
      // Abrir dropdown
      dropdown.classList.add("menu-open");
      if (card) card.classList.add("dropdown-active");
      
      console.log("Dropdown opened at:", { left: leftPosition, top: topPosition });
      
      // Manejar clicks fuera del dropdown con un pequeño delay
      setTimeout(() => {
        const handleClickOutside = (event) => {
          if (!selectButton.contains(event.target) && !dropdown.contains(event.target)) {
            dropdown.classList.remove("menu-open");
            if (card) card.classList.remove("dropdown-active");
            document.removeEventListener('click', handleClickOutside);
          }
        };
        document.addEventListener('click', handleClickOutside);
      }, 100);
      
    } else {
      // Cerrar dropdown
      dropdown.classList.remove("menu-open");
      if (card) card.classList.remove("dropdown-active");
    }
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
      <div className="modern-voting-container">
        <Navbar texto="Etapa 2 - Traje de Gala" />
        {pop === true && <Espera />}

        <div className="reinas-container">
          {listaCandidatas.map((candidata, index) => (
            <div 
              className={`item-reina ${elements[listaCandidatas.findIndex(c => c.CANDIDATA_ID === candidata.CANDIDATA_ID)] !== 0 ? 'calificada' : ''}`} 
              key={candidata.CANDIDATA_ID}
            >
              <div className="espacio-imagen">
                <img
                  alt="Foto candidata"
                  className="foto-candidata"
                  src={"/reinas/" + cortarParteDerecha(candidata.FOTO_URL)}
                />
                <div className="datos-candidata">
                  <h3>
                    {candidata.CAND_NOMBRE1} {candidata.CAND_APELLIDOPATERNO}
                  </h3>
                  <h4>{candidata.DEPARTMENTO_NOMBRE}</h4>
                </div>
              </div>
              
              <div className="botones-container">
                <div className="select" onClick={handleSelectClick}>
                  <span className="selected">
                    {elements[listaCandidatas.findIndex(c => c.CANDIDATA_ID === candidata.CANDIDATA_ID)] !== 0 ? 
                      `${elements[listaCandidatas.findIndex(c => c.CANDIDATA_ID === candidata.CANDIDATA_ID)]} de 10` : 'Seleccionar puntuación'}
                  </span>
                </div>
                <ul className="dropdown" aria-label="Opciones de puntuación">
                  {Array.from({ length: 10 }, (_, i) => (
                    <li
                      key={i + 1}
                      onClick={() => {
                        setValue(candidata.CANDIDATA_ID, i + 1);
                      }}
                      className={elements[listaCandidatas.findIndex(c => c.CANDIDATA_ID === candidata.CANDIDATA_ID)] === i + 1 ? "active" : ""}
                    >
                      {i + 1}
                    </li>
                  ))}
                </ul>
              </div>
            </div>
          ))}
        </div>
        
        <div className="enviar">
          <button type="button" className="btn-enviar" onClick={Enviar}>
            ENVIAR CALIFICACIONES
          </button>
        </div>

        <Popup open={modalIsOpen} onClose={handleModalClose}>
          {modalIsOpen && <div className="overlay" onClick={handleModalClose}></div>}
          <div className="modal">
            <h2 className="modal-title">¿Está seguro de registrar sus votos?</h2>
            <div className="botones-modal">
              <button onClick={handleModalClose} className="btn-cancelar">
                Cancelar
              </button>
              <button 
                onClick={() => {
                  handleModalClose(); 
                  handleClick(); 
                  setPop(true);
                }} 
                className="btn-confirmar"
              >
                Confirmar
              </button>
            </div>
          </div>
        </Popup>
        
        <Popup open={vacioIsOpen} onClose={handleVacioClose}>
          {vacioIsOpen && <div className="overlay" onClick={handleVacioClose}></div>}
          <div className="modal">
            <h2 className="modal-title">¡Atención!</h2>
            <h2 className="modal-title">Por favor, registre su voto por cada candidata.</h2>
            <div className="botones-modal">
              <button onClick={handleVacioClose} className="btn-confirmar">
                Entendido
              </button>
            </div>
          </div>
        </Popup>
      </div>
    );
  }
}

export default TGala;
