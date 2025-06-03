CREATE DATABASE  IF NOT EXISTS `reinado` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `reinado`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: reinado
-- ------------------------------------------------------
-- Server version	8.0.37

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `manejar_desempate` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
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
INSERT INTO `candidata` VALUES (1,8,1,'Villareal','Salgado','Evelyn','Haydée',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(2,10,1,'Romero','Cazares','Tiffany','Patricia',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(3,4,1,'Torres','Loor','María','Daniela',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(4,2,1,'Zuleta','Gallegos','Adriana','Milé',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(5,9,1,'Aguirre','Flores','María','Paula',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(6,5,1,'Noboa','Soto','Jhadith','Galas',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(7,12,1,'Bastidas','Yela','María','Cristina',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(8,11,1,'Torres','Alomía','Emily','Alejandra',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(9,6,1,'Menéndez','Solórzano','Wendy','Nathaly',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(10,3,1,'Ramírez','Sánchez','Emily','Jael',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(11,7,1,'Gallegos','Uquillas','Romina','Gabriela',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL),(12,1,1,'Díaz','López','Shary','Alexa',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,0,NULL);
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
INSERT INTO `departamento` VALUES (1,'Ciencias Económicas','Matriz'),(2,'Eléctrica, Electrónica y Telecomunicaciones','Matriz'),(3,'Ciencias Humanas y Sociales','Matriz'),(4,'Ciencias de la Energía y Mecánica','Matriz'),(5,'Sede Santo Domingo','Santo Domingo'),(6,'Sede Latacunga','Latacunga'),(7,'Ciencias Médicas','Matriz'),(8,'Ciencias de la Computación','Matriz'),(9,'Ciencias de la Vida y Agricultura','Matriz'),(10,'Ciencias de la Tierra y la Construcción ','Matriz'),(11,'Seguridad y Defensa','Matriz'),(12,'Ciencias Exactas y Unidad de Admisión','Matriz');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `desempate`
--

DROP TABLE IF EXISTS `desempate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `desempate` (
  `id` int NOT NULL AUTO_INCREMENT,
  `candidata_id` int DEFAULT NULL,
  `nota_final` int DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `candidata_id` (`candidata_id`),
  CONSTRAINT `desempate_ibfk_1` FOREIGN KEY (`candidata_id`) REFERENCES `candidata` (`CANDIDATA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `desempate`
--

LOCK TABLES `desempate` WRITE;
/*!40000 ALTER TABLE `desempate` DISABLE KEYS */;
/*!40000 ALTER TABLE `desempate` ENABLE KEYS */;
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
INSERT INTO `evento` VALUES (1,1,'Traje Típico',100,1,'si'),(2,1,'Traje Gala',100,1,'si'),(3,1,'Preguntas',100,1,'si'),(4,0,'Desempate',100,1,'');
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `computar_final` AFTER INSERT ON `finales` FOR EACH ROW BEGIN
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
END */;;
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
INSERT INTO `foto_candidata` VALUES (1,1,'FX','C:\\fakepath\\EHVSH.JPG'),(2,2,'FX','C:\\fakepath\\TPRCH.JPG'),(3,3,'FX','C:\\fakepath\\MDTLH.JPG'),(4,4,'FX','C:\\fakepath\\AMZGH.JPG'),(5,5,'FX','C:\\fakepath\\MPAFH.JPG'),(6,6,'FX','C:\\fakepath\\JGNSH.JPG'),(7,7,'FX','C:\\fakepath\\MCBYH.JPG'),(8,8,'FX','C:\\fakepath\\EATAH.JPG'),(9,9,'FX','C:\\fakepath\\WNMSH.JPG'),(10,10,'FX','C:\\fakepath\\EJRSH.JPG'),(11,12,'FX','C:\\fakepath\\SADLH.JPG');
/*!40000 ALTER TABLE `foto_candidata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trigger_timing`
--

DROP TABLE IF EXISTS `trigger_timing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trigger_timing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `trigger_name` varchar(50) DEFAULT NULL,
  `start_time` timestamp(6) NULL DEFAULT NULL,
  `end_time` timestamp(6) NULL DEFAULT NULL,
  `execution_time_ms` decimal(10,6) DEFAULT NULL,
  `candidata_id` int DEFAULT NULL,
  `evento_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trigger_timing`
--

LOCK TABLES `trigger_timing` WRITE;
/*!40000 ALTER TABLE `trigger_timing` DISABLE KEYS */;
INSERT INTO `trigger_timing` VALUES (1,'computar_final','2025-05-15 16:22:14.999611','2025-05-15 16:22:14.999611',0.000000,1,1),(2,'computar_final','2025-05-15 16:22:15.019918','2025-05-15 16:22:15.019918',0.000000,2,1),(3,'computar_final','2025-05-15 16:23:47.036654','2025-05-15 16:23:47.036654',0.000000,1,2),(4,'computar_final','2025-05-15 16:23:47.050961','2025-05-15 16:23:47.050961',0.000000,2,2),(5,'computar_final','2025-05-15 16:33:21.306013','2025-05-15 16:33:21.306013',0.000000,1,1),(6,'computar_final','2025-05-15 16:33:21.314666','2025-05-15 16:33:21.314666',0.000000,2,1),(7,'computar_final','2025-05-15 16:34:50.982865','2025-05-15 16:34:50.982865',0.000000,1,2),(8,'computar_final','2025-05-15 16:34:50.992380','2025-05-15 16:34:50.992380',0.000000,2,2),(9,'computar_final','2025-05-15 16:46:02.823338','2025-05-15 16:46:02.823338',0.000000,1,1),(10,'computar_final','2025-05-15 16:46:02.835882','2025-05-15 16:46:02.835882',0.000000,2,1),(11,'computar_final','2025-05-15 16:46:22.290254','2025-05-15 16:46:22.290254',0.000000,1,2),(12,'computar_final','2025-05-15 16:46:22.303102','2025-05-15 16:46:22.303102',0.000000,2,2),(13,'computar_final','2025-05-15 16:53:47.296871','2025-05-15 16:53:47.296871',0.000000,1,1),(14,'computar_final','2025-05-15 16:53:47.307656','2025-05-15 16:53:47.307656',0.000000,2,1),(15,'computar_final','2025-05-15 16:54:07.855484','2025-05-15 16:54:07.855484',0.000000,1,2),(16,'computar_final','2025-05-15 16:54:07.866982','2025-05-15 16:54:07.866982',0.000000,2,2),(17,'computar_final','2025-05-15 16:56:33.213359','2025-05-15 16:56:33.213359',0.000000,1,3),(18,'computar_final','2025-05-15 16:56:33.227635','2025-05-15 16:56:33.227635',0.000000,2,3);
/*!40000 ALTER TABLE `trigger_timing` ENABLE KEYS */;
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
INSERT INTO `users` VALUES (1,1,'Juez1',NULL,'$2a$10$F4IojLNcgsfQCwruggqgDe7GEyG4qmWXwdn94RfC0.XqxzKbeqT46','Flor','De Vela','juez',0),(2,1,'Juez2',NULL,'$2a$10$eX6uL5CRS3phJH1gHK2TiuylPamL7wnXSrDfpFT5avuEXeNdGMgeG','Irene','Ocaña de Villavicencio','juez',0),(3,1,'Veedor',NULL,'$2a$10$Tr3ifQmgZYwoZZtOCrpWcOz3jPiNOHTFnlPviy1kLiFWZAdXOxWSO','Marcelo','Mejía Mena','Notario',0),(4,1,'admin','','$2a$10$rAuZfWne.JEOVb05mpXvheZp59F8qJxA3j7oBH/ruQ4ZJP1kPolDG','Administrador','del Sistema','admin',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votaciones`
--

LOCK TABLES `votaciones` WRITE;
/*!40000 ALTER TABLE `votaciones` DISABLE KEYS */;
INSERT INTO `votaciones` VALUES (1,1,1,1,'no'),(2,1,1,2,'no'),(3,1,1,3,'no'),(4,1,1,4,'no'),(5,1,1,5,'no'),(6,1,1,6,'no'),(7,1,1,7,'no'),(8,1,1,8,'no'),(9,1,1,9,'no'),(10,1,1,10,'no'),(11,1,1,11,'no'),(12,1,1,12,'no'),(13,1,2,1,'no'),(14,1,2,2,'no'),(15,1,2,3,'no'),(16,1,2,4,'no'),(17,1,2,5,'no'),(18,1,2,6,'no'),(19,1,2,7,'no'),(20,1,2,8,'no'),(21,1,2,9,'no'),(22,1,2,10,'no'),(23,1,2,11,'no'),(24,1,2,12,'no'),(25,1,3,1,'no'),(26,1,3,2,'no'),(27,1,3,3,'no'),(28,1,3,4,'no'),(29,1,3,5,'no'),(30,1,3,6,'no'),(31,1,3,7,'no'),(32,1,3,8,'no'),(33,1,3,9,'no'),(34,1,3,10,'no'),(35,1,3,11,'no'),(36,1,3,12,'no'),(37,2,1,1,'no'),(38,2,1,2,'no'),(39,2,1,3,'no'),(40,2,1,4,'no'),(41,2,1,5,'no'),(42,2,1,6,'no'),(43,2,1,7,'no'),(44,2,1,8,'no'),(45,2,1,9,'no'),(46,2,1,10,'no'),(47,2,1,11,'no'),(48,2,1,12,'no'),(49,2,2,1,'no'),(50,2,2,2,'no'),(51,2,2,3,'no'),(52,2,2,4,'no'),(53,2,2,5,'no'),(54,2,2,6,'no'),(55,2,2,7,'no'),(56,2,2,8,'no'),(57,2,2,9,'no'),(58,2,2,10,'no'),(59,2,2,11,'no'),(60,2,2,12,'no'),(61,2,3,1,'no'),(62,2,3,2,'no'),(63,2,3,3,'no'),(64,2,3,4,'no'),(65,2,3,5,'no'),(66,2,3,6,'no'),(67,2,3,7,'no'),(68,2,3,8,'no'),(69,2,3,9,'no'),(70,2,3,10,'no'),(71,2,3,11,'no'),(72,2,3,12,'no');
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;
UNLOCK TABLES;

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

-- Dump completed on 2025-06-02 20:55:18
