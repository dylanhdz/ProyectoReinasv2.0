
import React, { useEffect, useState, useContext } from "react";
import { AuthContext } from "../context/authContext";
import { Link, useLocation, useNavigate } from "react-router-dom";
import Axios, { all } from 'axios';
import ReactModal from "react-modal";
import Popup from "reactjs-popup";
import "./popup.scss";
import Espera from "../components/Espera.jsx";
import { API_BASE_URL } from "./ip";
import 'bootstrap/dist/css/bootstrap.min.css';
import Navbar from "../components/Navbar";
import 'bootstrap/dist/css/bootstrap.min.css';

import Dropdown from 'react-bootstrap/Dropdown';

function Traje() {
    const cat = useLocation().search;
    const navigate = useNavigate();
    const location = useLocation();
    const { currentUser } = useContext(AuthContext);
    const [listaCandidatas, setListaCandidatas] = useState([]);
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
                const res = await Axios.get(`${API_BASE_URL}/barra`);
                setListaCandidatas(res.data);
            } catch (err) {
                console.log(err);
            }
        };
        fetchData();
    }, [cat + "1"]);

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


    // Function to handle sending data to the database
    const handleSendData = async () => {
        // Loop through the selectedScores state object
        for (let candidateIndex in selectedScores) {
            // Get the score for the current candidate
            let score = selectedScores[candidateIndex];

            // Send the data to the database
            try {
                await Axios.post(`${API_BASE_URL}/cali`, {
                    EVENTO_ID: 1,
                    CANDIDATA_ID: candidateIndex,
                    CALIFICACION_NOMBRE: "Traje Tipico",
                    CALIFICACION_PESO: 100,
                    CALIFICACION_VALOR: score,
                });
            } catch (err) {
                console.log(err)
            }
        }
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

    const [selectedScores, setSelectedScores] = useState({});
    const [votes, setVotes] = useState({
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
    });

    const handleVote = (candidate, score) => {
        setVotes((prevVotes) => ({
            ...prevVotes,
            [score]: prevVotes[score] + 1,
        }));
    };

    const handleScoreSelect = (candidateIndex, score) => {
        setSelectedScores((prevSelectedScores) => ({
            ...prevSelectedScores,
            [candidateIndex]: score,
        }));
        handleVote(candidateIndex, score);
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
                <Navbar texto="Etapa 1 - Traje Tradicional" />
                {pop === true && <Espera />}
                <div className="panelVotacion">
                    {listaReinas.length > 0 ? (
                        <div className="candidates">
                            {listaReinas.map((candidate, index) => (
                                <div key={index} className="candidate">
                                    <img
                                        className="candidate-image"
                                        src={'/reinas/' + cortarParteDerecha(listaReinas[index].FOTO_URL)}
                                        alt={`Candidate ${index + 1}`}
                                    />

                                    <div className="candidate-info">
                                        <span className="candidate-name">{candidate.CANDIDATA_ID}. {candidate.CAND_NOMBRE1 + " " + candidate.CAND_APELLIDOPATERNO}</span>
                                        <span className="candidate-career">{listaCandidatas[index].DEPARTMENTO_NOMBRE.replace("Departamento de ", "")}</span>
                                    </div>

                                    <div className="vote-button">
                                        <Dropdown onSelect={(eventKey) => handleScoreSelect(index + 1, eventKey)}>
                                            <Dropdown.Toggle variant="success" id="dropdown-basic">
                                                {selectedScores[index + 1] || "Votar"}
                                            </Dropdown.Toggle>
                                            <Dropdown.Menu>
                                                {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((score) => (
                                                    <Dropdown.Item
                                                        eventKey={score}
                                                        key={score}
                                                    >
                                                        {score}
                                                    </Dropdown.Item>
                                                ))}
                                            </Dropdown.Menu>
                                        </Dropdown>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <div>Loading...</div>
                    )}

                    <div id='enviarTT' className="enviar">
                        <button id="enviarTT" type="button" className="btn-enviar" onClick={handleSendData}>
                            ENVIAR
                        </button>

                        <Popup open={modalIsOpen} onClose={handleModalClose}>
                            <div className="modal">
                                <h2 className="modal-title">¿Desea enviar las calificaciones?</h2>
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
