import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../context/authContext";
import { Link, useLocation, useNavigate } from "react-router-dom";
import Axios, { all } from 'axios';
import ReactModal from "react-modal";
import Popup from "reactjs-popup";
import "./popup.scss";
import Espera from "../components/Espera.jsx";
import { API_BASE_URL } from "./ip";
import Navbar from "../components/Navbar";


function Traje() {
    const cat = useLocation().search;
    const navigate = useNavigate();
    const location = useLocation();
    const { currentUser } = useContext(AuthContext);
    const [allJudgesVoted, setAllJudgesVoted] = useState(false);
    const [listaReinas, setListaReinas] = useState([]);
    const [listaUsuarios, setListaUsuarios] = useState([]);
    const [nota1, setNota1] = useState("");
    const [nota2, setNota2] = useState("");
    const [pop, setPop] = useState(false);
    const [popupAlerta, setPopAlerta] = useState(false);
    const [modalIsOpen, setModalIsOpen] = useState(false);
    const puntuacionMax = 10;
    const puntuacion = [];

    useEffect(() => {
        const fetchData = async () => {
            try {
                const res = await Axios.get(`${API_BASE_URL}/candidatas/tt`);
                setListaReinas(res.data);
            } catch (err) {
                console.log(err);
            }
        };
        fetchData();
    }, [cat + "tt"]);

    const cortarParteDerecha = (cadena) => {
        let parteDerecha = '';
        let i = cadena.length - 1;

        while (i >= 0 && cadena[i] !== '\\') {
            parteDerecha = cadena[i] + parteDerecha;
            i--;
        }

        return parteDerecha;
    }

    useEffect(() => {
        const fetchData = async () => {
            try {
                const response1 = await Axios.get(`${API_BASE_URL}/user/ck1?id=${listaReinas[0].CANDIDATA_ID}`);
                //console.log(listaReinas[0].CANDIDATA_ID);
                //console.log(response1.data[0].total);
                if (response1.data[0].total === 0) {
                    setAllJudgesVoted(false);
                } else {
                    if (listaReinas[0].CANDIDATA_ID === 10) {
                        navigate("/CRG_Gala");
                    } else {
                        window.location.reload();
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
    }, [cat + "ck1", listaReinas]);

    /*Metodo Post para el ingreso de las calificaciones*/
    const handleClick1 = async (e) => {
        try {
            await Axios.post(`${API_BASE_URL}/cali`, {
                EVENTO_ID: 1,
                CANDIDATA_ID: listaReinas[0].CANDIDATA_ID,
                CALIFICACION_NOMBRE: "Traje Tipico",
                CALIFICACION_PESO: 60,
                CALIFICACION_VALOR: nota1,
            });

        } catch (err) {
            console.log(err)
        }
        try {
            await Axios.post(`${API_BASE_URL}/cali`, {
                EVENTO_ID: 1,
                CANDIDATA_ID: listaReinas[0].CANDIDATA_ID,
                CALIFICACION_NOMBRE: "Actitud Escenica",
                CALIFICACION_PESO: 40,
                CALIFICACION_VALOR: nota2,
            });
            setPop(true);
            // window.location.reload();
        } catch (err) {
            console.log(err)
        }

    }

    /*Ingresa en el array para posterior generador de botones*/
    for (let i = 0; i < puntuacionMax; i++) {
        puntuacion.push(i + 1);
    }

    const Enviar = () => {
        /*Control para que esten llenas las 2 notas*/
        if (nota1 === "" || nota2 === "") {
            setPopAlerta(true);
        } else {
            setModalIsOpen(true);
            /* Aqui es donde tengo las dos calificaciones para mandar*/
            console.log("Nota 1: " + nota1 + " Nota 2: " + nota2);
        }
    };
    /* Para cerrar el Modal*/
    const handleModalClose = () => {
        setModalIsOpen(false);
    };

    const handlePopupAlertaClose = () => {
        setPopAlerta(false);
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
                <Navbar texto="Evento - Traje Típico" />
                {pop === true && <Espera />}
                <div className="gridCentrao">
                    {listaReinas.length > 0 ? (
                        <React.Fragment>
                            <div class="datos">
                                <br></br>
                                <h3 className="Nombres-heading">{"Candidata " + listaReinas[0].CANDIDATA_ID + ": " + listaReinas[0].CAND_NOMBRE1 + " " + listaReinas[0].CAND_APELLIDOPATERNO}</h3>

                            </div>
                            <div class="foto">
                                <br></br>

                                <img src={'/reinas/' + cortarParteDerecha(listaReinas[0].FOTO_URL)} width="350px" alt="chica"></img>
                            </div>

                        </React.Fragment>
                    ) : (
                        <div>Loading...</div>
                    )}
                    <div class="caja_botones">
                        <div class="nota">
                            <h2 class="titulo-puntuacion">Puntuación de TRAJE</h2>
                            {puntuacion.map((i) => (
                                <>
                                    <button
                                        className={`btn-nota1 ${nota1 === i ? "click" : ""}`}
                                        name="btn-nota1"
                                        onClick={(e) => setNota1(i)}
                                    >
                                        {i}
                                    </button>
                                </>
                            ))}
                        </div>
                        <div class="nota">
                            <h2 class="titulo-puntuacion">Puntuación de ACTITUD</h2>
                            {puntuacion.map((i) => (
                                <>
                                    <button
                                        className={`btn-nota2 ${nota2 === i ? "click" : ""}`}
                                        name="btn-nota2"
                                        onClick={(e) => setNota2(i)}
                                    >
                                        {i}
                                    </button>
                                </>
                            ))}
                        </div>
                    </div>
                    <div id='enviarTT' className="enviar">
                        <button id="enviarTT" type="button" className="btn-enviar" onClick={(e) => Enviar()}>
                            ENVIAR
                        </button>

                        <Popup open={modalIsOpen} onClose={handleModalClose}>
                            <div className="modal">
                                <h2 className="modal-title">¿Está seguro de registrar su voto?</h2>
                                <h2 className="modal-title">
                                    Traje: {nota1} Actitud: {nota2}
                                </h2>
                                <div className="botones-modal">
                                    <button onClick={handleModalClose} className="btn-cancelar">
                                        Cancelar
                                    </button>
                                    <button
                                        onClick={() => {
                                            handleModalClose();
                                            handleClick1();
                                        }}
                                        className="btn-confirmar"
                                    >
                                        Aceptar
                                    </button>
                                </div>
                            </div>
                        </Popup>
                        <Popup open={popupAlerta} onClose={handlePopupAlertaClose}>
                            <div className="modal">
                                <h2 className="modal-title">¡Alerta!</h2>
                                <h2 className="modal-title">Debe ingresar todas las calificaciones correspondientes antes de enviar.</h2>
                                <div className="botones-modal">
                                    <button onClick={handlePopupAlertaClose} className="btn-cancelar">
                                        Cerrar
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

export default Traje;
