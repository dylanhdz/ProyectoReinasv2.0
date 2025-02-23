// Register.jsx
import React, { useState, useContext } from "react";
import { AuthContext } from "../context/authContext";
import axios from "axios";
import { useNavigate } from "react-router-dom"; // Add this import at the top

import "./styleRegister.scss";
import { API_BASE_URL } from "./ip.js";
import Logo from "../img/logoespereina.png";

const Register = () => {
  const { currentUser } = React.useContext(AuthContext);
  const navigate = useNavigate(); // Add this line after the imports

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

  const handleChange = (e) => {
    setInputs((prev) => ({ ...prev, [e.target.name]: e.target.value }));
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post(`${API_BASE_URL}/auth/register`, inputs);
      navigate("/login"); // Redirect to login page after successful registration
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
  }

  return (
    <div className="register-container">
      <div className="register-card">
        <div className="register-header">
          
          <h2>Registro de Usuario</h2>
        </div>

        <form onSubmit={handleSubmit} className="register-form">
          <div className="form-row">
            <div className="input-group">
              <label>Nombre</label>
              <input
                type="text"
                name="nombre"
                placeholder="Ingrese el nombre"
                onChange={handleChange}
                required
              />
            </div>
            <div className="input-group">
              <label>Apellido</label>
              <input
                type="text"
                name="lastname"
                placeholder="Ingrese el apellido"
                onChange={handleChange}
                required
              />
            </div>
          </div>

          <div className="form-row">
            <div className="input-group">
              <label>Usuario</label>
              <input
                type="text"
                name="username"
                placeholder="Ingrese el usuario"
                onChange={handleChange}
                required
              />
            </div>
            <div className="input-group">
              <label>Contraseña</label>
              <input
                type="password"
                name="password"
                placeholder="Ingrese la contraseña"
                onChange={handleChange}
                required
              />
            </div>
          </div>

          <div className="input-group">
            <label>Rol</label>
            <select
              name="rol"
              onChange={handleChange}
              required
              className="role-select"
            >
              <option value="">Seleccione un rol</option>
              <option value="juez">juez</option>
              <option value="admin">admin</option>
              <option value="Notario">Notario</option>
            </select>
          </div>

          {err && <div className="error-message">{err}</div>}

          <button type="submit" className="submit-btn">
            Registrar Usuario
    
          </button>
        </form>
      </div>
    </div>
  );
};

export default Register;