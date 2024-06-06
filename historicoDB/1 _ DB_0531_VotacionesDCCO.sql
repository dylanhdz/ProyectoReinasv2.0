CREATE DATABASE  IF NOT EXISTS `blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog`;
-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	8.0.32

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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
INSERT INTO `calificacion` VALUES (1,1,1,1,'Traje Tipico',60,8),(2,1,1,1,'Actitud Escenica',40,1),(3,1,2,1,'Traje Tipico',60,7),(4,1,2,1,'Actitud Escenica',40,3),(5,1,2,2,'Traje Tipico',60,6),(6,1,2,2,'Actitud Escenica',40,7),(7,1,1,2,'Traje Tipico',60,8),(8,1,1,2,'Actitud Escenica',40,3),(9,1,2,3,'Traje Tipico',60,9),(10,1,2,3,'Actitud Escenica',40,10),(11,1,1,3,'Traje Tipico',60,5),(12,1,1,3,'Actitud Escenica',40,1),(13,1,1,4,'Traje Tipico',60,6),(14,1,1,4,'Actitud Escenica',40,1),(15,1,2,4,'Traje Tipico',60,7),(16,1,2,4,'Actitud Escenica',40,2),(17,1,1,5,'Traje Tipico',60,6),(18,1,1,5,'Actitud Escenica',40,1),(19,1,2,5,'Traje Tipico',60,6),(20,1,2,5,'Actitud Escenica',40,1),(21,1,1,6,'Traje Tipico',60,9),(22,1,1,6,'Actitud Escenica',40,3),(23,1,2,6,'Traje Tipico',60,7),(24,1,2,6,'Actitud Escenica',40,2),(25,1,1,7,'Traje Tipico',60,10),(26,1,1,7,'Actitud Escenica',40,10),(27,1,2,7,'Traje Tipico',60,10),(28,1,2,7,'Actitud Escenica',40,10),(29,1,1,8,'Traje Tipico',60,9),(30,1,1,8,'Actitud Escenica',40,9),(31,1,2,8,'Traje Tipico',60,9),(32,1,2,8,'Actitud Escenica',40,9),(33,1,1,9,'Traje Tipico',60,7),(34,1,1,9,'Actitud Escenica',40,7),(35,1,2,9,'Traje Tipico',60,6),(36,1,2,9,'Actitud Escenica',40,1),(37,1,1,10,'Traje Tipico',60,8),(38,1,1,10,'Actitud Escenica',40,8),(39,1,2,10,'Traje Tipico',60,7),(40,1,2,10,'Actitud Escenica',40,2),(41,2,2,1,'Traje Gala',40,9),(42,2,2,1,'Respuesta',60,9),(43,2,1,1,'Traje Gala',40,10),(44,2,1,1,'Respuesta',60,10),(45,2,2,2,'Traje Gala',40,8),(46,2,2,2,'Respuesta',60,8),(47,2,1,2,'Traje Gala',40,7),(48,2,1,2,'Respuesta',60,7),(49,2,2,3,'Traje Gala',40,6),(50,2,2,3,'Respuesta',60,6),(51,2,1,3,'Traje Gala',40,7),(52,2,1,3,'Respuesta',60,3),(53,2,1,4,'Traje Gala',40,8),(54,2,1,4,'Respuesta',60,6),(55,2,2,4,'Traje Gala',40,7),(56,2,2,4,'Respuesta',60,2),(57,2,1,5,'Traje Gala',40,6),(58,2,1,5,'Respuesta',60,5),(59,2,2,5,'Traje Gala',40,6),(60,2,2,5,'Respuesta',60,2),(61,2,1,6,'Traje Gala',40,7),(62,2,1,6,'Respuesta',60,1),(63,2,2,6,'Traje Gala',40,8),(64,2,2,6,'Respuesta',60,3),(65,2,1,7,'Traje Gala',40,10),(66,2,1,7,'Respuesta',60,10),(67,2,2,7,'Traje Gala',40,10),(68,2,2,7,'Respuesta',60,10),(69,2,1,8,'Traje Gala',40,8),(70,2,1,8,'Respuesta',60,2),(71,2,2,8,'Traje Gala',40,6),(72,2,2,8,'Respuesta',60,2),(73,2,1,9,'Traje Gala',40,3),(74,2,1,9,'Respuesta',60,2),(75,2,2,9,'Traje Gala',40,6),(76,2,2,9,'Respuesta',60,4),(77,2,1,10,'Traje Gala',40,9),(78,2,1,10,'Respuesta',60,8),(79,2,2,10,'Traje Gala',40,7),(80,2,2,10,'Respuesta',60,3),(81,3,1,1,'Barras',100,4),(82,3,1,2,'Barras',100,4),(83,3,1,3,'Barras',100,3),(84,3,1,4,'Barras',100,3),(85,3,1,5,'Barras',100,3),(86,3,1,6,'Barras',100,4),(87,3,1,7,'Barras',100,5),(88,3,1,8,'Barras',100,2),(89,3,1,9,'Barras',100,3),(90,3,1,10,'Barras',100,3),(91,3,2,1,'Barras',100,4),(92,3,2,2,'Barras',100,2),(93,3,2,3,'Barras',100,4),(94,3,2,4,'Barras',100,3),(95,3,2,5,'Barras',100,1),(96,3,2,6,'Barras',100,2),(97,3,2,7,'Barras',100,5),(98,3,2,8,'Barras',100,3),(99,3,2,9,'Barras',100,2),(100,3,2,10,'Barras',100,2);
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `pasar_evento` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
  DECLARE total_jueces INT;
  DECLARE jueces_votados INT;
  
  -- Contar total de jueces
  SELECT COUNT(*) INTO total_jueces 
  FROM users
  WHERE users.rol = 'juez';

  -- Contar el total de jueces que han votado por la candidata actual en la calificacion actual
  SELECT COUNT(DISTINCT usuario_id) INTO jueces_votados 
  FROM calificacion 
  WHERE candidata_id = NEW.candidata_id AND calificacion_nombre = NEW.calificacion_nombre;

  -- Verificar si todos los jueces ya votaron
  IF total_jueces = jueces_votados THEN
    -- Insertar la fila nueva de calificacion final
    INSERT INTO finales (candidata_id, evento_id, usuario_id, calificacion_nombre, calificacion_peso, calificacion_valor) 
    VALUES (NEW.candidata_id, NEW.evento_id, NEW.usuario_id, CONCAT(NEW.calificacion_nombre, '_FINAL'), NEW.calificacion_peso, (select avg(calificacion_valor) from calificacion where candidata_id = new.CANDIDATA_ID));
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_votacion` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
    DECLARE contador INT;
    SET contador = (SELECT COUNT(*) FROM calificacion WHERE USUARIO_ID = NEW.USUARIO_ID AND EVENTO_ID = NEW.EVENTO_ID AND CANDIDATA_ID = NEW.CANDIDATA_ID);

    IF contador = 2 THEN
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
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizar_votacion_evento3` AFTER INSERT ON `calificacion` FOR EACH ROW BEGIN
 DECLARE contador INT;
    IF NEW.EVENTO_ID = 3 THEN
        SET contador = (SELECT COUNT(*) FROM calificacion WHERE EVENTO_ID = 3 AND USUARIO_ID = NEW.USUARIO_ID);
        
        IF contador = 10 THEN
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
  `CAND_FECHANACIMIENTO` date NOT NULL,
  `CAND_ACTIVIDAD_EXTRA` varchar(900) DEFAULT NULL,
  `CAND_ESTATURA` decimal(3,2) NOT NULL COMMENT 'La estatura debe ser en metros',
  `CAND_HOBBIES` varchar(900) DEFAULT NULL,
  `CAND_IDIOMAS` varchar(100) NOT NULL,
  `CAND_COLOROJOS` varchar(45) NOT NULL,
  `CAND_COLORCABELLO` varchar(45) NOT NULL,
  `CAND_LOGROS_ACADEMICOS` varchar(900) DEFAULT NULL,
  `CAND_NOTA_FINAL` decimal(5,2) DEFAULT NULL,
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
INSERT INTO `candidata` VALUES (1,1,1,'Vásquez','Lascano','Melany','Patricia','2003-07-05','',1.63,'Tomar fotografías, pintar cerámica, conocer lugares nuevos e ir al gimnasio.','Inglés - Español','Verde','Castaño Claro',NULL,NULL,0,NULL),(2,2,1,'Morocho','Ortiz','Simone','Carolina','1999-03-02','IEEE WIE, Organización y voluntariado en la fundación Héroes de Vida, Colaboración en rescate animal y apadrinamiento de animalitos rescatados, Voluntariado en CIBV (Centros Infantiles del Buen Vivir) en Catamayo-Loja, Diseñadora del sistema de monitoreo para la seguridad de la población del sector de Chachill - Pintag (en proceso)',1.55,' Leer, tejer, patinar, repostería, y aprender idiomas.','Inglés - Francés - Español','Café Claro','Castaño Oscuro','Certificación en Manejo de Software Packet Tracer otorgada por Cisco,Certificación WEBINAR : 3D BIONIC EXOSKELETONS por P4H Bionics,Curso en el SECAP de Introduccion a Electrónica ',NULL,0,NULL),(3,3,1,'Yánez','Pérez','Sofía','Arlet','2001-08-06','Accesora Comercial de venta de automoviles',1.56,'Jugar Futbol','Español','Café','Castaño','Escolta del colegio Dario Figueroa Larco',NULL,0,NULL),(4,4,1,'Rodríguez','Trujillo','Natzarenna','b','1998-02-27','',1.60,'Pintar, bailar y hacer manualidades','Español','Café','Rojo Cobrizo',NULL,NULL,0,NULL),(5,5,1,'López','Barzallio','Stefany','Daniela','2001-06-19','Club cultural de danza y música',1.62,'Cantar, bailar, escuchar música','Español','Café','Rubio',NULL,NULL,0,NULL),(6,6,1,'Borja','Calero','Alisson','Denisse','2002-07-01','Natación y Ciclismo',1.73,'Escuchar Música','Inglés - Español','Verde','Castaño Claro','Miembro del consejo estudiantil del colegio Sagrado Corazon de Jesus',NULL,0,NULL),(7,7,1,'Saltos','Arequipa','Julianna','Belén','2000-12-28','Voluntariado en Toca de Assis Hermanas,Obra social en Latacunga',1.61,'Escribir, leer, bailar, aprender idiomas, hacer deporte, hacer manualidades,dibujar, pintar, pasar tiempo en familia y amigos.','Inglés - Español','Café','Castaño Oscuro','Becas Académicas,Brigadier Capitan,Abanderada del Pabellon Nacional y mejor egresada del colegio Liceo Naval Quito',NULL,0,NULL),(8,8,1,'Espinoza','Torres','Bárbara','Emilia','2000-12-10','',1.71,'Deportes como atletismo y volley, e ir al gimnasio','Inglés - Español','Café','Castaño Oscuro','Perteneciente al grupo de alto rendimiento del ser bachiller',NULL,0,NULL),(9,9,1,'Estrella','Tuárez','Angie','Leonela','2000-11-25','',1.67,'Aprender a cocinar postres, bailar, leer libros de suspensos, pintar, hacer ejercicio y ver películas y series','Inglés - Español','Café','Castaño Oscuro',NULL,NULL,0,NULL),(10,10,1,'Aguilar','Montesdeoca','Imalín','Pamela','2000-04-09','Club EERI',1.70,'Hacer ejercicio y cocinar','Español','Café','Castaño Oscuro',NULL,NULL,0,NULL);
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
INSERT INTO `carrera` VALUES (1,1,'Contabilidad y Auditoria'),(2,2,'Electronica y Telecomunicaciones'),(3,3,'Pedagogia de la actividad fisica y deporte'),(4,4,'Mecatronica'),(5,5,'Biotecnologia'),(6,6,'Petroquimica'),(7,7,'Medicina'),(8,8,'Tecnologias de la Informacion'),(9,9,'Agropecuaria'),(10,10,'Ingenieria Civil');
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
INSERT INTO `departamento` VALUES (1,'Departamento de Ciencias Económicas, Administrativas y de Comercio','Matriz'),(2,'Departamento de Eléctrica, Electrónica y Telecomunicaciones','Matriz'),(3,'Departamento de Ciencias Humanas y Sociales','Matriz'),(4,'Departamento de Ciencias de la Energía y Mecánica','Matriz'),(5,'Departamento de Ciencias de la Vida','Santo Domingo'),(6,'Departamento de Ciencias de la Energía y Mecánica','Latacunga'),(7,'Departamento de Ciencias Médicas','Matriz'),(8,'Departamento de Ciencias de la Computacion','Matriz'),(9,'Departamento de Ciencias de la Vida y Agricultura','Matriz'),(10,'Departamento de Ciencias de la Tierra y la Construcción ','Matriz');
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
INSERT INTO `eleccion` VALUES (1,'May2023-Sept2023');
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
INSERT INTO `evento` VALUES (1,1,'Traje Típico',45),(2,1,'Traje Gala',45),(3,1,'Barra',10);
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
  `CALIFICACION_VALOR` int NOT NULL,
  PRIMARY KEY (`CALIFICACION_ID`),
  KEY `FK_ABARCA` (`EVENTO_ID`),
  KEY `FK_ADMINISTRA` (`USUARIO_ID`),
  KEY `FK_TIENE_idx` (`CANDIDATA_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finales`
--

LOCK TABLES `finales` WRITE;
/*!40000 ALTER TABLE `finales` DISABLE KEYS */;
INSERT INTO `finales` VALUES (1,1,2,1,'Traje Tipico_FINAL',60,5),(2,1,2,1,'Actitud Escenica_FINAL',40,5),(3,1,1,2,'Traje Tipico_FINAL',60,7),(4,1,1,2,'Actitud Escenica_FINAL',40,6),(5,1,1,3,'Traje Tipico_FINAL',60,8),(6,1,1,3,'Actitud Escenica_FINAL',40,6),(7,1,2,4,'Traje Tipico_FINAL',60,5),(8,1,2,4,'Actitud Escenica_FINAL',40,4),(9,1,2,5,'Traje Tipico_FINAL',60,4),(10,1,2,5,'Actitud Escenica_FINAL',40,4),(11,1,2,6,'Traje Tipico_FINAL',60,6),(12,1,2,6,'Actitud Escenica_FINAL',40,5),(13,1,2,7,'Traje Tipico_FINAL',60,10),(14,1,2,7,'Actitud Escenica_FINAL',40,10),(15,1,2,8,'Traje Tipico_FINAL',60,9),(16,1,2,8,'Actitud Escenica_FINAL',40,9),(17,1,2,9,'Traje Tipico_FINAL',60,7),(18,1,2,9,'Actitud Escenica_FINAL',40,5),(19,1,2,10,'Traje Tipico_FINAL',60,8),(20,1,2,10,'Actitud Escenica_FINAL',40,6),(21,2,1,1,'Traje Gala_FINAL',40,7),(22,2,1,1,'Respuesta_FINAL',60,7),(23,2,1,2,'Traje Gala_FINAL',40,7),(24,2,1,2,'Respuesta_FINAL',60,7),(25,2,1,3,'Traje Gala_FINAL',40,6),(26,2,1,3,'Respuesta_FINAL',60,6),(27,2,2,4,'Traje Gala_FINAL',40,5),(28,2,2,4,'Respuesta_FINAL',60,5),(29,2,2,5,'Traje Gala_FINAL',40,4),(30,2,2,5,'Respuesta_FINAL',60,4),(31,2,2,6,'Traje Gala_FINAL',40,5),(32,2,2,6,'Respuesta_FINAL',60,5),(33,2,2,7,'Traje Gala_FINAL',40,10),(34,2,2,7,'Respuesta_FINAL',60,10),(35,2,2,8,'Traje Gala_FINAL',40,7),(36,2,2,8,'Respuesta_FINAL',60,7),(37,2,2,9,'Traje Gala_FINAL',40,5),(38,2,2,9,'Respuesta_FINAL',60,5),(39,2,2,10,'Traje Gala_FINAL',40,7),(40,2,2,10,'Respuesta_FINAL',60,7),(41,3,2,1,'Barras_FINAL',100,7),(42,3,2,2,'Barras_FINAL',100,6),(43,3,2,3,'Barras_FINAL',100,5),(44,3,2,4,'Barras_FINAL',100,5),(45,3,2,5,'Barras_FINAL',100,4),(46,3,2,6,'Barras_FINAL',100,5),(47,3,2,7,'Barras_FINAL',100,9),(48,3,2,8,'Barras_FINAL',100,6),(49,3,2,9,'Barras_FINAL',100,4),(50,3,2,10,'Barras_FINAL',100,6);
/*!40000 ALTER TABLE `finales` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `foto_candidata` VALUES (1,1,'FX','C:\\fakepath\\MVFX.jpg'),(2,2,'FX','C:\\fakepath\\SMFX.jpg'),(3,3,'FX','C:\\fakepath\\SYFX.jpg'),(4,4,'FX','C:\\fakepath\\NRFX.jpg'),(5,5,'FX','C:\\fakepath\\DLFX.jpg'),(6,6,'FX','C:\\fakepath\\ABFX.jpg'),(7,7,'FX','C:\\fakepath\\JSFX.jpg'),(8,8,'FX','C:\\fakepath\\BEFX.jpg'),(9,9,'FX','C:\\fakepath\\AEFX.jpg'),(10,10,'FX','C:\\fakepath\\IAFX.jpg'),(11,1,'FP','C:\\fakepath\\MVFP.jpg'),(12,2,'FP','C:\\fakepath\\SMFP.jpg'),(13,3,'FP','C:\\fakepath\\SYFP.jpg'),(14,4,'FP','C:\\fakepath\\NRFP.jpg'),(15,5,'FP','C:\\fakepath\\DLFP.jpg'),(16,6,'FP','C:\\fakepath\\ABFP.jpg'),(17,7,'FP','C:\\fakepath\\JSFP.jpg'),(18,8,'FP','C:\\fakepath\\BEFP.jpg'),(19,9,'FP','C:\\fakepath\\AEFP.jpg'),(20,10,'FP','C:\\fakepath\\IAFP.jpg');
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
  PRIMARY KEY (`id`),
  KEY `FK_JUZGA_idx` (`ELECCION_ID`),
  CONSTRAINT `FK_JUZGA` FOREIGN KEY (`ELECCION_ID`) REFERENCES `eleccion` (`ELECCION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Juez1',NULL,'$2a$10$F4IojLNcgsfQCwruggqgDe7GEyG4qmWXwdn94RfC0.XqxzKbeqT46','Alexis','Estévez','juez'),(2,1,'Juez2',NULL,'$2a$10$eX6uL5CRS3phJH1gHK2TiuylPamL7wnXSrDfpFT5avuEXeNdGMgeG','Johanna','Pila','juez'),(3,1,'Juez3',NULL,'$2a$10$IsxENTUmumv93Elw61AISeXSJASgV5aWNMinVhAYaBFWCVyQsbV0G','Aliz','Díaz','juez'),(4,1,'Juez4',NULL,'$2a$10$QqR6eG0ln.tIQTw8Y0bO0OSG56RDX6xhp8ADmckKSnt/HtS7jXBc6','Mathias','Guevara','juez'),(5,1,'Juez5',NULL,'$2a$10$iA6wDU48sc/uZHy2lgifPu8yqqRlMClDjVZrLH8.vKlDIbMNevksS','Dr.','Delgado','juez'),(6,1,'Juez6',NULL,'$2a$10$t/4ffO94Q8N.XT4WJ9lkauxXC.fgHOIfqXje8JplMjQTtvNrGlUSe','Kevin','Vargas','juez'),(7,1,'Juez7',NULL,'$2a$10$AdHn/1tt38jg90SO6cqyyOwDCOpGThxXtrM6GtgJJjGlGAcRnjGx.','Dra. Sonia','Cárdenas','juez'),(8,1,'Notario',NULL,'$2a$10$UyOgvWQXLMFYoaWy5eL26.kflBhBN50qxhNiMZyQfoYqcM41z/0Di','Notario','Notario','Notario'),(11,1,'admin','','$2a$10$rAuZfWne.JEOVb05mpXvheZp59F8qJxA3j7oBH/ruQ4ZJP1kPolDG','Diego','Portilla','admin');
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
INSERT INTO `votaciones` VALUES (1,1,1,1,'si'),(2,1,1,2,'si'),(3,1,1,3,'si'),(4,1,1,4,'si'),(5,1,1,5,'si'),(6,1,1,6,'si'),(7,1,1,7,'si'),(8,1,1,8,'si'),(9,1,1,9,'si'),(10,1,1,10,'si'),(11,1,2,1,'si'),(12,1,2,2,'si'),(13,1,2,3,'si'),(14,1,2,4,'si'),(15,1,2,5,'si'),(16,1,2,6,'si'),(17,1,2,7,'si'),(18,1,2,8,'si'),(19,1,2,9,'si'),(20,1,2,10,'si'),(21,1,3,1,'si'),(22,1,3,2,'si'),(23,1,3,3,'si'),(24,1,3,4,'si'),(25,1,3,5,'si'),(26,1,3,6,'si'),(27,1,3,7,'si'),(28,1,3,8,'si'),(29,1,3,9,'si'),(30,1,3,10,'si'),(31,2,1,1,'si'),(32,2,1,2,'si'),(33,2,1,3,'si'),(34,2,1,4,'si'),(35,2,1,5,'si'),(36,2,1,6,'si'),(37,2,1,7,'si'),(38,2,1,8,'si'),(39,2,1,9,'si'),(40,2,1,10,'si'),(41,2,2,1,'si'),(42,2,2,2,'si'),(43,2,2,3,'si'),(44,2,2,4,'si'),(45,2,2,5,'si'),(46,2,2,6,'si'),(47,2,2,7,'si'),(48,2,2,8,'si'),(49,2,2,9,'si'),(50,2,2,10,'si'),(51,2,3,1,'si'),(52,2,3,2,'si'),(53,2,3,3,'si'),(54,2,3,4,'si'),(55,2,3,5,'si'),(56,2,3,6,'si'),(57,2,3,7,'si'),(58,2,3,8,'si'),(59,2,3,9,'si'),(60,2,3,10,'si'),(61,3,1,1,'si'),(62,3,1,2,'si'),(63,3,1,3,'si'),(64,3,1,4,'si'),(65,3,1,5,'si'),(66,3,1,6,'si'),(67,3,1,7,'si'),(68,3,1,8,'si'),(69,3,1,9,'si'),(70,3,1,10,'si'),(71,3,2,1,'si'),(72,3,2,2,'si'),(73,3,2,3,'si'),(74,3,2,4,'si'),(75,3,2,5,'si'),(76,3,2,6,'si'),(77,3,2,7,'si'),(78,3,2,8,'si'),(79,3,2,9,'si'),(80,3,2,10,'si'),(81,3,3,1,'si'),(82,3,3,2,'si'),(83,3,3,3,'si'),(84,3,3,4,'si'),(85,3,3,5,'si'),(86,3,3,6,'si'),(87,3,3,7,'si'),(88,3,3,8,'si'),(89,3,3,9,'si'),(90,3,3,10,'si'),(92,4,1,1,'si'),(93,4,1,2,'si'),(94,4,1,3,'si'),(95,4,1,4,'si'),(96,4,1,5,'si'),(97,4,1,6,'si'),(98,4,1,7,'si'),(99,4,1,8,'si'),(100,4,1,9,'si'),(101,4,1,10,'si'),(102,4,2,1,'si'),(103,4,2,2,'si'),(104,4,2,3,'si'),(105,4,2,4,'si'),(106,4,2,5,'si'),(107,4,2,6,'si'),(108,4,2,7,'si'),(109,4,2,8,'si'),(110,4,2,9,'si'),(111,4,2,10,'si'),(112,4,3,1,'si'),(113,4,3,2,'si'),(114,4,3,3,'si'),(115,4,3,4,'si'),(116,4,3,5,'si'),(117,4,3,6,'si'),(118,4,3,7,'si'),(119,4,3,8,'si'),(120,4,3,9,'si'),(121,4,3,10,'si'),(122,5,1,1,'si'),(123,5,1,2,'si'),(124,5,1,3,'si'),(125,5,1,4,'si'),(126,5,1,5,'si'),(127,5,1,6,'si'),(128,5,1,7,'si'),(129,5,1,8,'si'),(130,5,1,9,'si'),(131,5,1,10,'si'),(132,5,2,1,'si'),(133,5,2,2,'si'),(134,5,2,3,'si'),(135,5,2,4,'si'),(136,5,2,5,'si'),(137,5,2,6,'si'),(138,5,2,7,'si'),(139,5,2,8,'si'),(140,5,2,9,'si'),(141,5,2,10,'si'),(142,5,3,1,'si'),(143,5,3,2,'si'),(144,5,3,3,'si'),(145,5,3,4,'si'),(146,5,3,5,'si'),(147,5,3,6,'si'),(148,5,3,7,'si'),(149,5,3,8,'si'),(150,5,3,9,'si'),(151,5,3,10,'si'),(152,6,1,1,'si'),(153,6,1,2,'si'),(154,6,1,3,'si'),(155,6,1,4,'si'),(156,6,1,5,'si'),(157,6,1,6,'si'),(158,6,1,7,'si'),(159,6,1,8,'si'),(160,6,1,9,'si'),(161,6,1,10,'si'),(162,6,2,1,'si'),(163,6,2,2,'si'),(164,6,2,3,'si'),(165,6,2,4,'si'),(166,6,2,5,'si'),(167,6,2,6,'si'),(168,6,2,7,'si'),(169,6,2,8,'si'),(170,6,2,9,'si'),(171,6,2,10,'si'),(172,6,3,1,'si'),(173,6,3,2,'si'),(174,6,3,3,'si'),(175,6,3,4,'si'),(176,6,3,5,'si'),(177,6,3,6,'si'),(178,6,3,7,'si'),(179,6,3,8,'si'),(180,6,3,9,'si'),(181,6,3,10,'si'),(182,7,1,1,'si'),(183,7,1,2,'si'),(184,7,1,3,'si'),(185,7,1,4,'si'),(186,7,1,5,'si'),(187,7,1,6,'si'),(188,7,1,7,'si'),(189,7,1,8,'si'),(190,7,1,9,'si'),(191,7,1,10,'si'),(192,7,2,1,'si'),(193,7,2,2,'si'),(194,7,2,3,'si'),(195,7,2,4,'si'),(196,7,2,5,'si'),(197,7,2,6,'si'),(198,7,2,7,'si'),(199,7,2,8,'si'),(200,7,2,9,'si'),(201,7,2,10,'si'),(202,7,3,1,'si'),(203,7,3,2,'si'),(204,7,3,3,'si'),(205,7,3,4,'si'),(206,7,3,5,'si'),(207,7,3,6,'si'),(208,7,3,7,'si'),(209,7,3,8,'si'),(210,7,3,9,'si'),(211,7,3,10,'si');
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'blog'
--

--
-- Dumping routines for database 'blog'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-31 21:47:00
