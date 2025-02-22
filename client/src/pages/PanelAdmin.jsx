import React, { useEffect, useState, useContext } from "react";
import { Link, useLocation} from "react-router-dom";
import { useNavigate } from 'react-router-dom';
import { AuthContext } from "../context/authContext";
import Popup from "reactjs-popup";
import Axios from "axios";
import { API_BASE_URL } from "./ip";

const PanelAdmin = () => {

    const { currentUser, logout } = useContext(AuthContext);
    const [votaciones, setVotaciones] = useState([]);
    const navigate = useNavigate();
    const [datos, setDatos] = useState([]);
    const [listaJueces, setListaJueces] = useState([]);
    const [listaReinas, setListaReinas] = useState([]);
    const [votacionTerminada, isVotacionTerminada] = useState(false);
    const [desempateTerminado, setDesempateTerminado] = useState(false);

    const [mostrarPopUp, setMostrarPopUp] = useState(false);
    const cat = useLocation().search;
    

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await Axios.get(`${API_BASE_URL}/candidatas`);
                setListaReinas(res.data);
                const resDesempate = await Axios.get(`${API_BASE_URL}/candidatas/verificarDesempate`);
                setDesempateTerminado(resDesempate.data.desempate);
                //console.log(listaReinas);
            } catch (err) {
                console.log(err);
            }
        };
        const interval = setInterval(() => {
            fetchData();
        }, 1000);

        return () => {
            clearInterval(interval);
        };
    }, [cat]);

    useEffect(() => {
        const verificacion = listaReinas.every((reina) => reina.CAND_NOTA_FINAL !== 0.00);
        isVotacionTerminada(verificacion);
        console.log(verificacion);
    }, [listaReinas]);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await Axios.get(`${API_BASE_URL}/candidatas/jueces`);
                setListaJueces(res.data);
                //console.log(listaJueces);
            } catch (err) {
                console.log(err);
            }
        };
        const interval = setInterval(() => {
            fetchData();
        }, 1000);

        return () => {
            clearInterval(interval);
        };
    }, [cat]);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await Axios.get(`${API_BASE_URL}/candidatas/votaciones`);
                setVotaciones(res.data);
                //console.log(votaciones);
            } catch (err) {
                console.log(err);
            }
        };
        const interval = setInterval(() => {
            fetchData();
        }, 1000);

        return () => {
            clearInterval(interval);
        };
    }, [cat]);

    // PopUps
    const handleModalClose = () => {
        setMostrarPopUp(false);
    };

    const handleClick = () => {
        setMostrarPopUp(false);
        limpiarVotaciones();
    }
    // Operaciones de Administración
    const cambiarEvento = async (idEvento, estado) => {
        await Axios.put(`/user/cambio/${estado}/${idEvento}`);
    };

    const limpiarVotaciones = async () => {
        await Axios.post(`/user/limpiarVotaciones`);
    };

    if (currentUser === null || (currentUser.rol !== "admin")) {
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
            <div className="App">
                <main>
                    <div className="carousel-item-text">
                        <br></br>
                        <h1 className="reporte">Panel de Administración</h1>
                        <h2>Eventos</h2>
                        <p>Evento 1: </p>
                        <div className="carousel-item-text">
                            <button className="btn" onClick={() => cambiarEvento(1, "si")}>Empezar</button>
                            <button className="btn" onClick={() => cambiarEvento(1, "no")}>Cerrar</button>
                        </div>
                        <p>Evento 2:</p>
                        <div className="carousel-item-text">
                            <button className="btn" onClick={() => cambiarEvento(2, "si")}>Empezar</button>
                            <button className="btn" onClick={() => cambiarEvento(2, "no")}>Cerrar</button>
                        </div>
                        <p>Evento 3:</p>
                        <div className="carousel-item-text">
                            <button className="btn" onClick={() => cambiarEvento(3, "si")}>Empezar</button>
                            <button className="btn" onClick={() => cambiarEvento(3, "no")}>Cerrar</button>
                        </div>
                        <h2>Votaciones</h2>
                        <div className="carousel-item-text">
                            <button className="btn" onClick={() => setMostrarPopUp(true)}>Reiniciar Votaciones</button>
                        </div>
                        <div className="carousel-item-text">
                        <button className="btn" onClick={() => navigate('/register')}>Crear Cuenta Nueva</button>
                        </div>
                    </div>
                    <h1 className="reina-informacion"><br></br>Tabla de Notario</h1>
                    {listaReinas.length > 0 ? (
                        <React.Fragment>
                            {listaReinas.map((item1, index) => {
                                return (
                                    <div className="matrix">
                                        
                                        <div>
                                            <br></br>
                                            <h1>{item1.CAND_NOMBRE1} {item1.CAND_APELLIDOPATERNO}</h1>
                                        </div>
                                        <div>
                                            <section class="wrapper">

                                                <main class="row title">
                                                    <ul>
                                                        <li>Juez</li>
                                                        <li>Traje Típico</li>
                                                        <li>Traje de Gala</li>
                                                        <li>Preguntas</li>
                                                    </ul>
                                                </main>

                                                <section class="row-fadeIn-wrapper">
                                                    <article class="row fadeIn nfl">
                                                        {listaJueces.map((item2, index) => {
                                                            return (
                                                                <ul>
                                                                    <li>{item2.id} - {item2.name}</li>
                                                                    {votaciones.map((item3, index) => {
                                                                        if (item3.CANDIDATA_ID === item1.CANDIDATA_ID && item3.USUARIO_ID === item2.id) {
                                                                            return (
                                                                                <li className={item3.VOT_ESTADO === "no" ? "celda-roja" : "celda-verde"}>
                                                                                    {item3.VOT_ESTADO === "no" ? "Pendiente" : "Votado"}

                                                                                </li>
                                                                            );
                                                                        }
                                                                    })}
                                                                </ul>
                                                            );
                                                        })}
                                                    </article>
                                                </section>
                                            </section>
                                        </div>
                                    </div>
                                );
                            }
                            )}
                        </React.Fragment>
                    ) : (
                        <div>Loading...</div>
                    )
                    }
                    {votacionTerminada ? <div class="boton">
                        <Link to="/reporte">
                            <button className='btn-reporte'>¡Verificar Reporte 📄!</button>
                        </Link>
                    </div> : null}
                    <Popup open={mostrarPopUp} onClose={handleModalClose}>
                        <div className="modal">
                            <h2 className="modal-title">¿Estás seguro de querer reiniciar la votación?</h2>

                            <div className="botones-modal">
                                <button onClick={handleModalClose} className="btn-cancelar">
                                    Cancelar
                                </button>
                                <button onClick={() => { handleModalClose(); handleClick()}} className="btn-confirmar">
                                    Aceptar
                                </button>
                            </div>
                        </div>
                    </Popup>
                </main>
            </div>
        );
    }
};

export default PanelAdmin;