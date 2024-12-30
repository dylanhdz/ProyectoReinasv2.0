import React, { useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import { API_BASE_URL } from "./ip";
import "./reset.scss";

const ResetPassword = () => {
  const { token } = useParams(); // Obtiene el token desde la URL
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (password !== confirmPassword) {
      setError("Las contraseñas no coinciden.");
      return;
    }
    try {
      const res = await axios.post(`${API_BASE_URL}/auth/resetPassword`, { token, password });
      setMessage(res.data);
      setError("");
    } catch (err) {
      setError(err.response?.data || "Error al restablecer la contraseña.");
    }
  };

  return (
    <div className="ResetPassword">
      <div className="container">
        <h2>Restablecer Contraseña</h2>
        <form onSubmit={handleSubmit}>
          <div className="input-container">
            <label>Nueva Contraseña</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </div>
          <div className="input-container">
            <label>Confirmar Contraseña</label>
            <input
              type="password"
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
              required
            />
          </div>
          <button type="submit">Restablecer</button>
        </form>
        {message && <p className="success-message">{message}</p>}
        {error && <p className="error-message">{error}</p>}
      </div>
    </div>
  );
};

export default ResetPassword;
