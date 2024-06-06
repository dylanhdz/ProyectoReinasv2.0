import React, { useState } from "react";
import Navbar from "../components/Navbar";
import Dropdown from 'react-bootstrap/Dropdown';
import 'bootstrap/dist/css/bootstrap.min.css';
import './PanelVotacion.scss';
const PanelVotacion = () => {
    const [votes, setVotes] = useState({
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
    });

    const candidates = [
        { name: 'Barbara Regil', career: 'Ciencias Exactas' },
        { name: 'Maria Perez', career: 'Ciencias de la Computación' },
        { name: 'Laura Gomez', career: 'Ciencias de Energía y Mecánica' },
        { name: 'Ana Sanchez', career: 'Ciencias de la Tierra y la Construcción' },
        { name: 'Sofia Rodriguez', career: 'Ciencias de la Vida y la Agricultura' },
        { name: 'Carla Morales', career: 'Ciencias Económicas, Administrativas y del Comercio' },
        { name: 'Luisa Fernández', career: 'Ciencias Humanas y Sociales' },
        { name: 'Paula Martínez', career: 'Seguridad y Defensa' },
        { name: 'Teresa Jimenez', career: 'Eléctrica, Electrónica y Telecomunicaciones' },
        { name: 'Isabel Ortiz', career: 'Ciencias Médicas' },
    ];

    const handleVote = (candidate, score) => {
        setVotes((prevVotes) => ({
            ...prevVotes,
            [score]: prevVotes[score] + 1,
        }));
    };

    return (
        <div className="candidates">
            {candidates.map((candidate, index) => (
                <div key={index} className="candidate">
                    <img
                        className="candidate-image"
                        src={require(`../candidatas/candidate${index + 1}.jpg`)}
                        alt={`Candidate ${index + 1}`}
                    />

                    <div className="candidate-info">
                        <span className="candidate-name">{candidate.name}</span>
                        <span className="candidate-career">{candidate.career}</span>
                    </div>

                    <div className="vote-button">
                        <Dropdown onSelect={(eventKey) => handleVote(index + 1, eventKey)}>
                            <Dropdown.Toggle variant="success" id="dropdown-basic">
                                Votar
                            </Dropdown.Toggle>
                            <Dropdown.Menu>
                                {[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((score) => (
                                    <Dropdown.Item eventKey={score} key={score}>
                                        {score}
                                    </Dropdown.Item>
                                ))}
                            </Dropdown.Menu>
                        </Dropdown>
                    </div>
                </div>
            ))}
        </div>
    );
};

export default PanelVotacion;