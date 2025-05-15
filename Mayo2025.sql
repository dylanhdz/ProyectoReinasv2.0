CREATE DATABASE  IF NOT EXISTS `reinado` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `reinado`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: reinado
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `calificacion`
--

DROP TABLE IF EXISTS `calificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `calificacion` (
  `CALIFICACION_ID` int NOT NULL AUTO_INCREMENT,
  `EVENTO_ID` int NOT NULL,
  `USUARIO_ID` int NOT NULL,
  `CANDIDATA_ID` int DEFAULT NULL,
  `CALIFICACION_NOMBRE` varchar(30) NOT NULL,
  `CALIFICACION_PESO` int NOT NULL,
  `CALIFICACION_VALOR` int NOT NULL,
  PRIMARY KEY (`CALIFICACION_ID`),
  KEY `FK_ABARCA` (`EVENTO_ID`),
  KEY `FK_ADMINISTRA` (`USUARIO_ID`),
  KEY `FK_TIENE_idx` (`CANDIDATA_ID`),
  CONSTRAINT `FK_ABARCA` FOREIGN KEY (`EVENTO_ID`) REFERENCES `evento` (`EVENTO_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_ADMINISTRA` FOREIGN KEY (`USUARIO_ID`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_TIENE` FOREIGN KEY (`CANDIDATA_ID`) REFERENCES `candidata` (`CANDIDATA_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_votacion` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
    DECLARE contador INT;
    SET contador = (SELECT COUNT(*) FROM calificacion WHERE USUARIO_ID = NEW.USUARIO_ID AND EVENTO_ID = NEW.EVENTO_ID AND CANDIDATA_ID = NEW.CANDIDATA_ID);

    IF contador = 1 THEN
        UPDATE votaciones
        SET VOT_ESTADO = 'si'
        WHERE USUARIO_ID = NEW.USUARIO_ID AND EVENTO_ID = NEW.EVENTO_ID AND CANDIDATA_ID = NEW.CANDIDATA_ID;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_votacion_evento3` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
 DECLARE contador INT;
    IF NEW.EVENTO_ID = 3 THEN
        SET contador = (SELECT COUNT(*) FROM calificacion WHERE EVENTO_ID = 3 AND USUARIO_ID = NEW.USUARIO_ID);
        
        IF contador = (select count(distinct candidata_id) from candidata) THEN
            UPDATE votaciones
            SET VOT_ESTADO = 'si'
            WHERE EVENTO_ID = 3 AND USUARIO_ID = NEW.USUARIO_ID;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pasar_evento` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
  DECLARE total_jueces INT;
  DECLARE jueces_votados INT;
  DECLARE existe_final INT;
  
  -- Solo proceder si NO es un evento de desempate
  IF NEW.EVENTO_ID != 4 THEN
    -- Contar total de jueces
    SELECT COUNT(*) INTO total_jueces 
    FROM users
    WHERE users.rol = 'juez';

    -- Contar el total de jueces que han votado por la candidata actual en la calificacion actual
    SELECT COUNT(DISTINCT usuario_id) INTO jueces_votados 
    FROM calificacion 
    WHERE candidata_id = NEW.candidata_id 
    AND calificacion_nombre = NEW.CALIFICACION_NOMBRE;

    -- Verificar si ya existe un registro final para esta candidata y evento
    SELECT COUNT(*) INTO existe_final
    FROM finales
    WHERE candidata_id = NEW.candidata_id 
    AND evento_id = NEW.EVENTO_ID
    AND calificacion_nombre = CONCAT(NEW.CALIFICACION_NOMBRE, '_FINAL');

    -- Verificar si todos los jueces ya votaron y no existe un registro final
    IF total_jueces = jueces_votados AND existe_final = 0 THEN
      -- Insertar la fila nueva de calificacion final
      INSERT INTO finales (
        candidata_id, 
        usuario_id, 
        evento_id, 
        calificacion_nombre, 
        calificacion_peso, 
        calificacion_valor
      ) 
      VALUES (
        NEW.candidata_id, 
        20, 
        NEW.evento_id, 
        CONCAT(NEW.CALIFICACION_NOMBRE, '_FINAL'), 
        NEW.CALIFICACION_PESO, 
        (SELECT SUM(calificacion_valor) 
         FROM calificacion 
         WHERE candidata_id = NEW.candidata_id 
         AND EVENTO_ID = NEW.EVENTO_ID 
         AND CALIFICACION_NOMBRE = NEW.CALIFICACION_NOMBRE)
      );
    END IF;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `candidata`
--

DROP TABLE IF EXISTS `candidata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `candidata` (
  `CANDIDATA_ID` int NOT NULL,
  `CARRERA_ID` int NOT NULL,
  `ELECCION_ID` int NOT NULL,
  `CAND_APELLIDOPATERNO` varchar(30) NOT NULL,
  `CAND_APELLIDOMATERNO` varchar(30) NOT NULL,
  `CAND_NOMBRE1` varchar(30) NOT NULL,
  `CAND_NOMBRE2` varchar(30) DEFAULT NULL,
  `CAND_FECHANACIMIENTO` date DEFAULT NULL,
  `CAND_ACTIVIDAD_EXTRA` varchar(900) DEFAULT NULL,
  `CAND_ESTATURA` decimal(3,2) DEFAULT NULL COMMENT 'La estatura debe ser en metros',
  `CAND_HOBBIES` varchar(900) DEFAULT NULL,
  `CAND_IDIOMAS` varchar(100) DEFAULT NULL,
  `CAND_COLOROJOS` varchar(45) DEFAULT NULL,
  `CAND_COLORCABELLO` varchar(45) DEFAULT NULL,
  `CAND_LOGROS_ACADEMICOS` varchar(900) DEFAULT NULL,
  `CAND_NOTA_FINAL` decimal(10,2) DEFAULT NULL,
  `ID_ELECCION` int NOT NULL,
  `CAND_CALIFICACIONFINAL` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`CANDIDATA_ID`),
  KEY `FK_ESTUDIA` (`CARRERA_ID`),
  KEY `FK_PERIODO_idx` (`ELECCION_ID`),
  KEY `ID_ELECCION_idx` (`ID_ELECCION`),
  CONSTRAINT `FK_ESTUDIA` FOREIGN KEY (`CARRERA_ID`) REFERENCES `carrera` (`CARRERA_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_PERIODO` FOREIGN KEY (`ELECCION_ID`) REFERENCES `eleccion` (`ELECCION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `candidata`
--

LOCK TABLES `candidata` WRITE;
/*!40000 ALTER TABLE `candidata` DISABLE KEYS */;
/*!40000 ALTER TABLE `candidata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carrera`
--

DROP TABLE IF EXISTS `carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carrera` (
  `CARRERA_ID` int NOT NULL,
  `DEPARTAMENTO_ID` int NOT NULL,
  `CARRERA_NOMBRE` varchar(100) NOT NULL,
  PRIMARY KEY (`CARRERA_ID`),
  KEY `FK_PERTENECE` (`DEPARTAMENTO_ID`),
  CONSTRAINT `FK_PERTENECE` FOREIGN KEY (`DEPARTAMENTO_ID`) REFERENCES `departamento` (`DEPARTAMENTO_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` VALUES (1,1,'Contabilidad y Auditoria'),(2,2,'Electronica y Telecomunicaciones'),(3,3,'Pedagogia de la actividad fisica y deporte'),(4,4,'Mecatronica'),(5,5,'Biotecnologia'),(6,6,'Petroquimica'),(7,7,'Medicina'),(8,8,'Tecnologias de la Informacion'),(9,9,'Agropecuaria'),(10,10,'Ingenieria Civil'),(11,11,'Seguridad y Defensa'),(12,12,'Ciencias Exactas');
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamento` (
  `DEPARTAMENTO_ID` int NOT NULL,
  `DEPARTMENTO_NOMBRE` varchar(500) NOT NULL,
  `DEPARTAMENTO_SEDE` varchar(100) NOT NULL,
  PRIMARY KEY (`DEPARTAMENTO_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'Ciencias Económicas','Matriz'),(2,'Eléctrica, Electrónica y Telecomunicaciones','Matriz'),(3,'Ciencias Humanas y Sociales','Matriz'),(4,'Ciencias de la Energía y Mecánica','Matriz'),(5,'Sede Santo Domingo','Santo Domingo'),(6,'Sede Latacunga','Latacunga'),(7,'Ciencias Médicas','Matriz'),(8,'Ciencias de la Computación','Matriz'),(9,'Ciencias de la Vida y Agricultura','Matriz'),(10,'Ciencias de la Tierra y la Construcción ','Matriz'),(11,'Seguridad y Defensa','Matriz'),(12,'Ciencias Exactas','Matriz');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eleccion`
--

DROP TABLE IF EXISTS `eleccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eleccion` (
  `ELECCION_ID` int NOT NULL,
  `ELECCION_PERIODO` varchar(30) NOT NULL,
  PRIMARY KEY (`ELECCION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eleccion`
--

LOCK TABLES `eleccion` WRITE;
/*!40000 ALTER TABLE `eleccion` DISABLE KEYS */;
INSERT INTO `eleccion` VALUES (1,'May2025-Sept2025');
/*!40000 ALTER TABLE `eleccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `evento` (
  `EVENTO_ID` int NOT NULL,
  `ELECCION_ID` int NOT NULL,
  `EVENTO_NOMBRE` varchar(30) NOT NULL,
  `EVENTO_PESO` int NOT NULL,
  `CALIF_POR_EVENTO` int NOT NULL,
  `EVENTO_ESTADO` varchar(45) NOT NULL,
  PRIMARY KEY (`EVENTO_ID`),
  KEY `FK_CORRESPONDE` (`ELECCION_ID`),
  CONSTRAINT `FK_CORRESPONDE` FOREIGN KEY (`ELECCION_ID`) REFERENCES `eleccion` (`ELECCION_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES (1,1,'Traje Típico',100,1,'si'),(2,1,'Traje Gala',100,1,'si'),(3,1,'Preguntas',100,1,'si');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

-- First create a table to store execution times
CREATE TABLE trigger_timing (
    id INT AUTO_INCREMENT PRIMARY KEY,
    trigger_name VARCHAR(50),
    start_time TIMESTAMP(6),
    end_time TIMESTAMP(6),
    execution_time_ms DECIMAL(10,6),
    candidata_id INT,
    evento_id INT
);

--
-- Table structure for table `finales`
--

DROP TABLE IF EXISTS `finales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `finales` (
  `CALIFICACION_ID` int NOT NULL AUTO_INCREMENT,
  `EVENTO_ID` int NOT NULL,
  `USUARIO_ID` int NOT NULL,
  `CANDIDATA_ID` int DEFAULT NULL,
  `CALIFICACION_NOMBRE` varchar(30) NOT NULL,
  `CALIFICACION_PESO` int NOT NULL,
  `CALIFICACION_VALOR` decimal(6,4) NOT NULL,
  PRIMARY KEY (`CALIFICACION_ID`),
  KEY `FK_ABARCA` (`EVENTO_ID`),
  KEY `FK_ADMINISTRA` (`USUARIO_ID`),
  KEY `FK_TIENE_idx` (`CANDIDATA_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finales`
--

LOCK TABLES `finales` WRITE;
/*!40000 ALTER TABLE `finales` DISABLE KEYS */;
/*!40000 ALTER TABLE `finales` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE TRIGGER `computar_final` AFTER INSERT ON `finales` 
FOR EACH ROW 
BEGIN
    -- Timing variables
    DECLARE start_ts TIMESTAMP(6);
    DECLARE end_ts TIMESTAMP(6);
    DECLARE exec_time DECIMAL(10,6);
    DECLARE calificaciones_realizadas INT;
    DECLARE total_candidatas INT;
    DECLARE total_notas INT;
    DECLARE total_eventos INT;
    DECLARE contador INT DEFAULT 1;
    DECLARE calificacion_ponderada DECIMAL(10,4);
    SET start_ts = CURRENT_TIMESTAMP(6);
    
    -- Si es un evento de desempate
    IF NEW.evento_id = 4 THEN
        UPDATE candidata 
        SET cand_nota_final = cand_nota_final + NEW.calificacion_valor
        WHERE candidata_id = NEW.candidata_id;
    ELSE
        -- Lógica existente para otros eventos
        SELECT COUNT(DISTINCT candidata_id) INTO total_candidatas 
        FROM candidata;
        
        SELECT sum(calif_por_evento) INTO total_notas 
        FROM evento 
        WHERE evento_id != 4;
        
        SELECT COUNT(DISTINCT evento_id) INTO total_eventos 
        FROM evento 
        WHERE evento_id != 4;
        
        SELECT COUNT(*) INTO calificaciones_realizadas 
        FROM finales 
        WHERE candidata_id = NEW.candidata_id 
        AND evento_id != 4;
        
        IF calificaciones_realizadas = total_notas THEN
            SET calificacion_ponderada = 0;
            WHILE contador <= total_eventos DO
                SET calificacion_ponderada = calificacion_ponderada + (
                    SELECT SUM((CALIFICACION_PESO/100)*CALIFICACION_VALOR*
                    ((SELECT evento_peso FROM evento WHERE evento_id = contador)/100)) 
                    FROM finales 
                    WHERE candidata_id = NEW.candidata_id 
                    AND evento_id = contador
                );
                SET contador = contador + 1;
            END WHILE;
            
            UPDATE candidata 
            SET cand_nota_final = calificacion_ponderada 
            WHERE candidata_id = NEW.candidata_id;
        END IF;
    END IF;
    -- Store end time and calculate duration
    SET end_ts = CURRENT_TIMESTAMP(6);
    SET exec_time = TIMESTAMPDIFF(MICROSECOND, start_ts, end_ts) / 1000.0;
    
    -- Log the execution time
    INSERT INTO trigger_timing (
        trigger_name, 
        start_time, 
        end_time, 
        execution_time_ms,
        candidata_id,
        evento_id
    ) VALUES (
        'computar_final',
        start_ts,
        end_ts,
        exec_time,
        NEW.candidata_id,
        NEW.evento_id
    );
END;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `foto_candidata`
--

DROP TABLE IF EXISTS `foto_candidata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `foto_candidata` (
  `FOTO_ID` int NOT NULL,
  `CANDIDATA_ID` int NOT NULL,
  `FOTO_DESCRIPCION` varchar(30) NOT NULL COMMENT 'Foto gala y tipico. Fotos generales de cada candidata',
  `FOTO_URL` varchar(40) NOT NULL,
  PRIMARY KEY (`FOTO_ID`),
  KEY `FK_DISPONE` (`CANDIDATA_ID`),
  CONSTRAINT `FK_DISPONE` FOREIGN KEY (`CANDIDATA_ID`) REFERENCES `candidata` (`CANDIDATA_ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `foto_candidata`
--

LOCK TABLES `foto_candidata` WRITE;
/*!40000 ALTER TABLE `foto_candidata` DISABLE KEYS */;
/*!40000 ALTER TABLE `foto_candidata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ELECCION_ID` int DEFAULT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `rol` varchar(45) NOT NULL,
  `activo` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_JUZGA_idx` (`ELECCION_ID`),
  CONSTRAINT `FK_JUZGA` FOREIGN KEY (`ELECCION_ID`) REFERENCES `eleccion` (`ELECCION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Juez1',NULL,'$2a$10$F4IojLNcgsfQCwruggqgDe7GEyG4qmWXwdn94RfC0.XqxzKbeqT46','Flor','De Vela','juez',0),(2,1,'Juez2',NULL,'$2a$10$eX6uL5CRS3phJH1gHK2TiuylPamL7wnXSrDfpFT5avuEXeNdGMgeG','Irene','Ocaña de Villavicencio','juez',0),(3,1,'Veedor',NULL,'$2a$10$Tr3ifQmgZYwoZZtOCrpWcOz3jPiNOHTFnlPviy1kLiFWZAdXOxWSO','Marcelo','Mejía Mena','Notario',0),(4,1,'admin','','$2a$10$rAuZfWne.JEOVb05mpXvheZp59F8qJxA3j7oBH/ruQ4ZJP1kPolDG','Dylan','Hernández','admin',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votaciones`
--

DROP TABLE IF EXISTS `votaciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `votaciones` (
  `VOT_ID` int NOT NULL AUTO_INCREMENT,
  `USUARIO_ID` int NOT NULL,
  `EVENTO_ID` int NOT NULL,
  `CANDIDATA_ID` int NOT NULL,
  `VOT_ESTADO` varchar(45) NOT NULL DEFAULT 'No',
  PRIMARY KEY (`VOT_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votaciones`
--

LOCK TABLES `votaciones` WRITE;
/*!40000 ALTER TABLE `votaciones` DISABLE KEYS */;
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;
UNLOCK TABLES;

CREATE TABLE IF NOT EXISTS desempate (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidata_id INT,
    nota_final DECIMAL(10, 2),
    FOREIGN KEY (candidata_id) REFERENCES candidata(candidata_id)
);


ALTER TABLE desempate MODIFY nota_final INT;
ALTER TABLE desempate ADD COLUMN tipo VARCHAR(20);
INSERT INTO evento (EVENTO_ID, EVENTO_NOMBRE, EVENTO_PESO, calif_por_evento) 
VALUES (4, 'Desempate', 100, 1);
--
-- Dumping events for database 'reinado'
--

--
-- Dumping routines for database 'reinado'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-09  0:00:02
DELIMITER ;;
CREATE TRIGGER `manejar_desempate` AFTER INSERT ON `calificacion` 
FOR EACH ROW 
BEGIN
  DECLARE total_jueces INT;
  DECLARE jueces_votados INT;
  DECLARE existe_final INT;
  DECLARE max_puntaje DECIMAL(10,2);
  DECLARE puntaje_empatadas DECIMAL(10,2);
  DECLARE tipo_empate VARCHAR(20);
  DECLARE suma_calificaciones DECIMAL(10,2);
  DECLARE puntaje_final DECIMAL(10,2);
  DECLARE max_puntaje_superior DECIMAL(10,2);
  DECLARE factor_escala DECIMAL(10,2);
  
  IF NEW.EVENTO_ID = 4 THEN
    -- Obtener el puntaje y tipo de empate de la candidata actual
    SELECT cand_nota_final, d.tipo INTO puntaje_empatadas, tipo_empate
    FROM candidata c
    JOIN desempate d ON c.candidata_id = d.candidata_id
    WHERE c.candidata_id = NEW.candidata_id;
    
    -- Contar total de jueces y votos
    SELECT COUNT(*) INTO total_jueces 
    FROM users
    WHERE users.rol = 'juez';

    SELECT COUNT(DISTINCT usuario_id) INTO jueces_votados 
    FROM calificacion 
    WHERE candidata_id = NEW.candidata_id 
    AND evento_id = 4
    AND calificacion_nombre = 'Desempate';

    -- Verificar si ya existe un registro final
    SELECT COUNT(*) INTO existe_final
    FROM finales
    WHERE candidata_id = NEW.candidata_id 
    AND evento_id = 4
    AND calificacion_nombre = 'Desempate_FINAL';

    IF total_jueces = jueces_votados AND existe_final = 0 THEN
      -- Calcular la suma de calificaciones
      SELECT SUM(calificacion_valor) INTO suma_calificaciones
      FROM calificacion 
      WHERE candidata_id = NEW.candidata_id 
      AND evento_id = 4 
      AND calificacion_nombre = 'Desempate';
      
      -- Aplicar reglas según el tipo de empate
      CASE tipo_empate
        WHEN 'primer-lugar' THEN
          -- Para primer lugar, suma directa sin factor de escala
          SET puntaje_final = puntaje_empatadas + (suma_calificaciones / total_jueces);
          
        WHEN 'segundo-lugar' THEN
          -- Obtener el máximo puntaje de referencia (primer lugar o máximo general)
          SELECT COALESCE(
            (SELECT MIN(cand_nota_final) 
             FROM candidata c2 
             JOIN desempate d2 ON c2.candidata_id = d2.candidata_id 
             WHERE d2.tipo = 'primer-lugar'),
            (SELECT MAX(cand_nota_final) 
             FROM candidata 
             WHERE candidata_id NOT IN (SELECT candidata_id FROM desempate))
          ) INTO max_puntaje_superior;
          
          -- Establecer factor de escala para segundo lugar
          SET factor_escala = 0.5; -- Ajusta este valor según necesites
          
          -- Calcular el puntaje final con factor de escala
          SET puntaje_final = LEAST(
            max_puntaje_superior - 0.01,
            puntaje_empatadas + (suma_calificaciones * factor_escala / total_jueces)
          );
          
        WHEN 'tercer-lugar' THEN
          -- Obtener el segundo valor más alto como referencia
          SELECT DISTINCT cand_nota_final INTO max_puntaje_superior
          FROM candidata
          WHERE cand_nota_final < (
            SELECT MAX(cand_nota_final)
            FROM candidata
          )
          ORDER BY cand_nota_final DESC
          LIMIT 1;
          
          -- Establecer factor de escala para tercer lugar
          SET factor_escala = 0.3; -- Ajusta este valor según necesites
          
          -- Calcular el puntaje final con factor de escala
          SET puntaje_final = LEAST(
            max_puntaje_superior - 0.01,
            puntaje_empatadas + (suma_calificaciones * factor_escala / total_jueces)
          );
      END CASE;
      
      -- Insertar en finales
      INSERT INTO finales (
        candidata_id, usuario_id, evento_id, 
        calificacion_nombre, calificacion_peso, calificacion_valor
      ) VALUES (
        NEW.candidata_id, 20, 4,
        'Desempate_FINAL', 100, suma_calificaciones
      );
      
      -- Actualizar la nota final de la candidata
      UPDATE candidata 
      SET cand_nota_final = puntaje_final
      WHERE candidata_id = NEW.candidata_id;
    END IF;
  END IF;
END;;
DELIMITER ;