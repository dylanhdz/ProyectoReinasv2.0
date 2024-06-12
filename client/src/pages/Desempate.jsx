import React, { useEffect, useState, useContext } from "react";
import Axios from 'axios';
import { AuthContext } from "../context/authContext";

import Popup from "reactjs-popup";
import Espera from "../components/Espera.jsx";
import { API_BASE_URL } from "./ip";
import Navbar from "../components/Navbar";

function Desempate() {
  const { currentUser } = useContext(AuthContext);
  const [elements, setElements] = useState(Array.from({ length: 12 }, () => 0));
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [vacioIsOpen, setVacioIsOpen] = useState(false);
  const [pop, setPop] = useState(false);
  const [candidatasEmpatadas, setCandidatasEmpatadas] = useState([]);
  const [candidatasDetalles, setCandidatasDetalles] = useState([]);

  // Función para obtener las candidatas empatadas
  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await Axios.get(`${API_BASE_URL}/cali/verificar_empate`);
        setCandidatasEmpatadas(response.data.candidatasEmpatadas);
        setElements(Array(response.data.candidatasEmpatadas.length).fill({ nota: 0, nota_final: 0 }));

        // Obtener los detalles de cada candidata empatada
        const detallesPromises = response.data.candidatasEmpatadas.map(async (candidataId) => {
          const candidataResponse = await Axios.get(`${API_BASE_URL}/candidatas/${candidataId}`);
          return candidataResponse.data; // Suponiendo que devuelve los detalles de la candidata
        });

        const detalles = await Promise.all(detallesPromises);
        setCandidatasDetalles(detalles);
      } catch (err) {
        console.log(err);
      }
    };
    fetchData();
  }, []);


  

  const handleClick = async () => {
    try {
      // Obtener las candidatas en empate y sus notas actuales
      const response = await Axios.get(`${API_BASE_URL}/user/verificar_empate`);
      const candidatasEmpate = response.data.candidatas;

      // Obtener las notas actuales de la tabla desempate
      const desempateResponse = await Axios.get(`${API_BASE_URL}/cali/desempate_notas`);
      const desempateNotas = desempateResponse.data;

      // Mapear las nuevas notas sumando a las existentes
      const updatedElements = elements.map((element) => {
        const candidataDesempate = desempateNotas.find(c => c.candidata_id === element.candidata_id);
        return {
          ...element,
          nota_final: candidataDesempate ? element.nota + candidataDesempate.nota_final : element.nota
        };
      });

      // Enviar las calificaciones actualizadas
      await Axios.post(`${API_BASE_URL}/cali/desempate`, { notas: updatedElements });
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
  <div className="item-reina" key={index}>
    <img
                  alt="Foto candidata"
                  className="foto-candidata"
                  src={"/reinas/" + cortarParteDerecha(candidata.FOTO_URL)}

                />
    {/* Imprimir datos de la candidata */}
    <div className="datos-candidata">
  {/* Imprimir información de la candidata */}
  {console.log("Nombre completo:", candidata.CAND_NOMBRE1, candidata.CAND_APELLIDOPATERNO)}
  {console.log("Departamento:", candidata.DEPARTMENTO_NOMBRE)}

  <h3>
    {candidata.CAND_NOMBRE1} {candidata.CAND_APELLIDOPATERNO}
  </h3>
  <h4>{candidata.DEPARTMENTO_NOMBRE}</h4>
</div>

  </div>
))}

          </div>
          <div id="enviarbarra" className="enviar">
            <button type="button" className="btn-enviar" onClick={Enviar}>
              ENVIAR
            </button>
            <Popup open={modalIsOpen} onClose={handleModalClose}>
              <div className="modal">
                <h2 className="modal-title">¿Está seguro de registrar su voto?</h2>
                <div className="botones-modal">
                  <button onClick={() => { handleModalClose(); handleClick(); setPop(true); }} className="btn-confirmar">
                    Si
                  </button>
                  <button onClick={handleModalClose} className="btn-cancelar">
                    No
                  </button>
                </div>
              </div>
            </Popup>
            <Popup open={vacioIsOpen} onClose={handleVacioClose}>
              <div className="modal">
                <h2 className="modal-title">Por favor, registre su voto por cada candidata.</h2>
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
}

export default Desempate;
