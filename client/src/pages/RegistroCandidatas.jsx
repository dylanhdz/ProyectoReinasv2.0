import React, { useState, useContext, useEffect } from "react";
import { AuthContext } from "../context/authContext.js";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import Popup from "reactjs-popup";
import "./styleCandidatas.scss";
import { API_BASE_URL } from "./ip.js";
import { IconButton } from '@mui/material';

const RegistroCandidatas = () => {
  const { currentUser } = useContext(AuthContext);
  const navigate = useNavigate();

  // Estados
  const [candidatas, setCandidatas] = useState([]);
  const [carreras, setCarreras] = useState([]);
  const [inputs, setInputs] = useState({
    CARRERA_ID: "",
    ELECCION_ID: 1,
    CAND_NOMBRE1: "",
    CAND_NOMBRE2: "",
    CAND_APELLIDOPATERNO: "",
    CAND_APELLIDOMATERNO: "",
    CAND_NOTA_FINAL: 0.00,
    ID_ELECCION: 0
  });
  const [foto, setFoto] = useState(null);
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [modalMessage, setModalMessage] = useState("");
  const [modalType, setModalType] = useState("success");

  const cortarParteDerecha = (cadena) => {
    if (!cadena) return '';
    let parteDerecha = "";
    let i = cadena.length - 1;

    while (i >= 0 && cadena[i] !== "\\") {
      parteDerecha = cadena[i] + parteDerecha;
      i--;
    }

    return parteDerecha;
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        // Fetch departamentos (carreras)
        const carrerasRes = await axios.get(`${API_BASE_URL}/candidatas/departamentos`);
        setCarreras(carrerasRes.data);
        console.log(carrerasRes.data);

        // Fetch candidatas using the same endpoint as TTipico
        const candidatasRes = await axios.get(`${API_BASE_URL}/barra`);
        setCandidatas(candidatasRes.data);
      } catch (err) {
        console.error("Error fetching data:", err);
      }
    };
    fetchData();
  }, []);

  // Handle candidata deletion
  const handleDelete = async (id) => {
    try {
      await axios.delete(`${API_BASE_URL}/candidatas/${id}`);
      setCandidatas(candidatas.filter(c => c.CANDIDATA_ID !== id));
      showModal("Candidata eliminada exitosamente", "success");
    } catch (err) {
      showModal("Error al eliminar candidata", "error");
    }
  };

  const handleChange = (e) => {
    setInputs(prev => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleFotoChange = (e) => {
    setFoto(e.target.files[0]);
  };

  const showModal = (message, type) => {
    setModalMessage(message);
    setModalType(type);
    setModalIsOpen(true);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
        // Validate required fields first
        if (!inputs.CAND_NOMBRE1 || !inputs.CAND_APELLIDOPATERNO || !inputs.CAND_APELLIDOMATERNO) {
            showModal("Por favor complete todos los campos obligatorios", "error");
            return;
        }

        // Check if a file was selected
        if (!foto) {
            showModal("Por favor seleccione una fotografía", "error");
            return;
        }

        // Generate filename first
        const fotoName = generateFotoName();
        console.log("Nombre de archivo generado:", fotoName); // Debug

        // First register candidata
        const candidataRes = await axios.post(`${API_BASE_URL}/candidatas`, inputs);
        const candidataId = candidataRes.data.id;

        // Create FormData for file upload
        const formData = new FormData();
        // Make sure to add nombreArchivo before the file
        formData.append('nombreArchivo', fotoName);
        formData.append('foto', foto);

        console.log("FormData contents:");
        for (let pair of formData.entries()) {
            console.log(pair[0] + ': ' + pair[1]);
        }

        // Upload photo
        const uploadRes = await axios.post(
            `${API_BASE_URL}/candidatas/upload`, 
            formData,
            {
                headers: {
                    'Content-Type': 'multipart/form-data'
                }
            }
        );

        // Register photo in database
        if (uploadRes.data.filename) {
            await axios.post(`${API_BASE_URL}/candidatas/fotos`, {
                CANDIDATA_ID: candidataId,
                FOTO_DESCRIPCION: 'FX',
                FOTO_URL: `C:\\fakepath\\${fotoName}`  // Use the generated name
            });
        }

        // Refresh candidatas list
        const candidatasRes = await axios.get(`${API_BASE_URL}/barra`);
        setCandidatas(candidatasRes.data);
        resetForm();
        showModal("Candidata registrada exitosamente", "success");
    } catch (err) {
        console.error("Error al registrar candidata:", err);
        showModal(
            err.response?.data?.error || err.response?.data?.message || "Error al registrar candidata", 
            "error"
        );
    }
  };

  const generateFotoName = () => {
    const {
        CAND_NOMBRE1,
        CAND_NOMBRE2,
        CAND_APELLIDOPATERNO,
        CAND_APELLIDOMATERNO
    } = inputs;

    // Ensure we have all required values
    if (!CAND_NOMBRE1 || !CAND_APELLIDOPATERNO || !CAND_APELLIDOMATERNO) {
        throw new Error('Faltan datos requeridos para generar el nombre del archivo');
    }

    const A = CAND_NOMBRE1.charAt(0);
    const B = CAND_NOMBRE2 ? CAND_NOMBRE2.charAt(0) : 'X';
    const C = CAND_APELLIDOPATERNO.charAt(0);
    const D = CAND_APELLIDOMATERNO.charAt(0);

    return `${A}${B}${C}${D}H.jpg`.toUpperCase();
  };

  const resetForm = () => {
    setInputs({
      CARRERA_ID: "",
      ELECCION_ID: 1,
      CAND_NOMBRE1: "",
      CAND_NOMBRE2: "",
      CAND_APELLIDOPATERNO: "",
      CAND_APELLIDOMATERNO: "",
      CAND_NOTA_FINAL: 0.00,
      ID_ELECCION: 0
    });
    setFoto(null);
  };

  return (
    <div className="register-container">
      {/* Candidatas existentes */}
      <div className="candidatas-list">
        <h3>Candidatas Registradas</h3>
        <div className="candidatas-grid">
          {candidatas.map(candidata => (
            <div key={candidata.CANDIDATA_ID} className="candidata-card">
              <img
                src={`/reinas/${candidata.FOTO_URL?.split('\\').pop()}`}
                alt={`${candidata.CAND_NOMBRE1} ${candidata.CAND_APELLIDOPATERNO}`}
              />
              <div className="candidata-info">
                <h4>{candidata.CAND_NOMBRE1} {candidata.CAND_APELLIDOPATERNO}</h4>
                <p>{candidata.DEPARTAMENTO_NOMBRE}</p>
                <IconButton onClick={() => handleDelete(candidata.CANDIDATA_ID)}>
                  <span className="material-icons">delete</span>
                </IconButton>
              </div>
            </div>
          ))}
        </div>
      </div>

      {/* Formulario de registro */}
      <div className="register-card">
        <h2>Registro de Nueva Candidata</h2>
        <form onSubmit={handleSubmit} className="register-form">
          <div className="form-row">
            <div className="input-group">
              <label>Primer Nombre</label>
              <input
                name="CAND_NOMBRE1"
                value={inputs.CAND_NOMBRE1}
                onChange={handleChange}
                required
              />
            </div>
            <div className="input-group">
              <label>Segundo Nombre</label>
              <input
                name="CAND_NOMBRE2"
                value={inputs.CAND_NOMBRE2}
                onChange={handleChange}
              />
            </div>
          </div>

          <div className="form-row">
            <div className="input-group">
              <label>Apellido Paterno</label>
              <input
                name="CAND_APELLIDOPATERNO"
                value={inputs.CAND_APELLIDOPATERNO}
                onChange={handleChange}
                required
              />
            </div>
            <div className="input-group">
              <label>Apellido Materno</label>
              <input
                name="CAND_APELLIDOMATERNO"
                value={inputs.CAND_APELLIDOMATERNO}
                onChange={handleChange}
                required
              />
            </div>
          </div>

          <div className="form-row">
            <div className="input-group">
              <label>Carrera</label>
              <select
                name="CARRERA_ID"
                value={inputs.CARRERA_ID}
                onChange={handleChange}
                required
              >
                <option value="">Seleccione una carrera</option>
                {carreras.map(carrera => (
                  <option
                    key={carrera.DEPARTAMENTO_ID}
                    value={carrera.DEPARTAMENTO_ID}
                  >
                    {carrera.DEPARTMENTO_NOMBRE}
                  </option>
                ))}
              </select>
            </div>
            <div className="input-group">
              <label>Fotografía</label>
              <input
                type="file"
                accept="image/*"
                onChange={handleFotoChange}
                required
              />
            </div>
          </div>

          <button type="submit" className="submit-btn">
            Registrar Candidata
          </button>
        </form>
      </div>

      {/* Modal de notificación */}
      <Popup open={modalIsOpen} onClose={() => setModalIsOpen(false)}>
        <div className={`modal ${modalType}`}>
          <h2>{modalMessage}</h2>
          <button onClick={() => setModalIsOpen(false)}>Aceptar</button>
        </div>
      </Popup>
    </div>
  );
};

export default RegistroCandidatas;