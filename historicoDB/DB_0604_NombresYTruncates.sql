CREATE DATABASE  IF NOT EXISTS `blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog`;
-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blog
-- ------------------------------------------------------
-- Server version	8.0.31

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
    INSERT INTO finales (candidata_id, usuario_id, evento_id, calificacion_nombre, calificacion_peso, calificacion_valor) 
    VALUES (NEW.candidata_id, 20, NEW.evento_id, CONCAT(NEW.calificacion_nombre, '_FINAL'), NEW.calificacion_peso, (select avg(calificacion_valor) from calificacion where candidata_id = new.CANDIDATA_ID and EVENTO_ID = new.EVENTO_ID and CALIFICACION_NOMBRE = new.CALIFICACION_NOMBRE));
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
  `CAND_NOTA_FINAL` decimal(6,4) DEFAULT NULL,
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
INSERT INTO `candidata` VALUES (1,1,1,'Vásquez','Lascano','Melany','Patricia','2003-07-05','',1.63,'Tomar fotografías, pintar cerámica, conocer lugares nuevos e ir al gimnasio.','Inglés - Español','Verde','Castaño Claro',NULL,0.0000,0,NULL),(2,2,1,'Morocho','Ortiz','Simone','Carolina','1999-03-02','IEEE WIE, Organización y voluntariado en la fundación Héroes de Vida, Colaboración en rescate animal y apadrinamiento de animalitos rescatados, Voluntariado en CIBV (Centros Infantiles del Buen Vivir) en Catamayo-Loja, Diseñadora del sistema de monitoreo para la seguridad de la población del sector de Chachill - Pintag (en proceso)',1.55,' Leer, tejer, patinar, repostería, y aprender idiomas.','Inglés - Francés - Español','Café Claro','Castaño Oscuro','Certificación en Manejo de Software Packet Tracer otorgada por Cisco,Certificación WEBINAR : 3D BIONIC EXOSKELETONS por P4H Bionics,Curso en el SECAP de Introduccion a Electrónica ',0.0000,0,NULL),(3,3,1,'Yánez','Pérez','Sofía','Arlet','2001-08-06','Accesora Comercial de venta de automoviles',1.56,'Jugar Futbol','Español','Café','Castaño','Escolta del colegio Dario Figueroa Larco',0.0000,0,NULL),(4,4,1,'Rodríguez','Trujillo','Natzarenna','b','1998-02-27','',1.60,'Pintar, bailar y hacer manualidades','Español','Café','Rojo Cobrizo',NULL,0.0000,0,NULL),(5,5,1,'López','Barzallio','Stefany','Daniela','2001-06-19','Club cultural de danza y música',1.62,'Cantar, bailar, escuchar música','Español','Café','Rubio',NULL,0.0000,0,NULL),(6,6,1,'Borja','Calero','Alisson','Denisse','2002-07-01','Natación y Ciclismo',1.73,'Escuchar Música','Inglés - Español','Verde','Castaño Claro','Miembro del consejo estudiantil del colegio Sagrado Corazon de Jesus',0.0000,0,NULL),(7,7,1,'Saltos','Arequipa','Julianna','Belén','2000-12-28','Voluntariado en Toca de Assis Hermanas,Obra social en Latacunga',1.61,'Escribir, leer, bailar, aprender idiomas, hacer deporte, hacer manualidades,dibujar, pintar, pasar tiempo en familia y amigos.','Inglés - Español','Café','Castaño Oscuro','Becas Académicas,Brigadier Capitan,Abanderada del Pabellon Nacional y mejor egresada del colegio Liceo Naval Quito',0.0000,0,NULL),(8,8,1,'Espinoza','Torres','Bárbara','Emilia','2000-12-10','',1.71,'Deportes como atletismo y volley, e ir al gimnasio','Inglés - Español','Café','Castaño Oscuro','Perteneciente al grupo de alto rendimiento del ser bachiller',0.0000,0,NULL),(9,9,1,'Estrella','Tuárez','Angie','Leonela','2000-11-25','',1.67,'Aprender a cocinar postres, bailar, leer libros de suspensos, pintar, hacer ejercicio y ver películas y series','Inglés - Español','Café','Castaño Oscuro',NULL,0.0000,0,NULL),(10,10,1,'Aguilar','Montesdeoca','Imalín','Pamela','2000-04-09','Club EERI',1.70,'Hacer ejercicio y cocinar','Español','Café','Castaño Oscuro',NULL,0.0000,0,NULL);
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
INSERT INTO `departamento` VALUES (1,'Departamento de Ciencias Económicas, Administrativas y de Comercio','Matriz'),(2,'Departamento de Eléctrica, Electrónica y Telecomunicaciones','Matriz'),(3,'Departamento de Ciencias Humanas y Sociales','Matriz'),(4,'Departamento de Ciencias de la Energía y Mecánica','Matriz'),(5,'Departamento de Ciencias de la Vida','Santo Domingo'),(6,'Departamento de Ciencias de la Energía y Mecánica','Latacunga'),(7,'Departamento de Ciencias Médicas','Matriz'),(8,'Departamento de Ciencias de la Computación','Matriz'),(9,'Departamento de Ciencias de la Vida y Agricultura','Matriz'),(10,'Departamento de Ciencias de la Tierra y la Construcción ','Matriz');
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
  `CALIF_POR_EVENTO` int NOT NULL,
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
INSERT INTO `evento` VALUES (1,1,'Traje Típico',45,2),(2,1,'Traje Gala',45,2),(3,1,'Barra',10,1);
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
  DECLARE calificaciones_realizadas INT;
  DECLARE total_candidatas INT;
  DECLARE total_notas INT;
  DECLARE total_eventos INT;
  DECLARE contador int default 1;
  DECLARE calificacion_ponderada decimal(6,4);
  
    -- Contar total de candidatas
  SELECT COUNT(DISTINCT candidata_id) INTO total_candidatas 
  FROM candidata;
  
	-- Contar total de notas de los eventos
  SELECT sum(calif_por_evento) into total_notas from evento;
  
   -- Contar total de eventos
   SELECT count(distinct evento_id) into total_eventos from evento;
  
  -- Contar total de calificaciones finales de la candidata actual
  SELECT COUNT(*) into calificaciones_realizadas from finales where candidata_id = NEW.CANDIDATA_ID;
  
   -- Verificar si la candidata ya tiene todas sus calificaciones
  IF calificaciones_realizadas = total_notas THEN
  set calificacion_ponderada = 0;
  while contador <= total_eventos do
	set calificacion_ponderada = calificacion_ponderada + (select sum((CALIFICACION_PESO/100)*CALIFICACION_VALOR*((select evento_peso from evento where evento_id = contador)/100)) as suma from finales where candidata_id= new.CANDIDATA_ID and EVENTO_ID=contador);
    set contador = contador + 1;
  end while;
  update candidata set cand_nota_final = calificacion_ponderada where candidata_id = new.candidata_id;
  set contador = 1;
  END IF;

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
  `activo` tinyint NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_JUZGA_idx` (`ELECCION_ID`),
  CONSTRAINT `FK_JUZGA` FOREIGN KEY (`ELECCION_ID`) REFERENCES `eleccion` (`ELECCION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Juez1',NULL,'$2a$10$F4IojLNcgsfQCwruggqgDe7GEyG4qmWXwdn94RfC0.XqxzKbeqT46','Jenny','Rosas de Lara','juez',0),(2,1,'Juez2',NULL,'$2a$10$eX6uL5CRS3phJH1gHK2TiuylPamL7wnXSrDfpFT5avuEXeNdGMgeG','Victoria','García de Proaño','juez',0),(3,1,'Juez3',NULL,'$2a$10$IsxENTUmumv93Elw61AISeXSJASgV5aWNMinVhAYaBFWCVyQsbV0G','Cumandá','Sarmiento de Velasco','juez',0),(4,1,'Juez4',NULL,'$2a$10$QqR6eG0ln.tIQTw8Y0bO0OSG56RDX6xhp8ADmckKSnt/HtS7jXBc6','Irene','Ocaña de Villavicencio','juez',0),(5,1,'Juez5',NULL,'$2a$10$iA6wDU48sc/uZHy2lgifPu8yqqRlMClDjVZrLH8.vKlDIbMNevksS','Fabián','Iza Marcillo','juez',0),(6,1,'Juez6',NULL,'$2a$10$t/4ffO94Q8N.XT4WJ9lkauxXC.fgHOIfqXje8JplMjQTtvNrGlUSe','Jorge','Álvarez Veintimilla','juez',0),(7,1,'Juez7',NULL,'$2a$10$AdHn/1tt38jg90SO6cqyyOwDCOpGThxXtrM6GtgJJjGlGAcRnjGx.','Santiago','Sánchez','juez',0),(8,1,'Notario',NULL,'$2a$10$UyOgvWQXLMFYoaWy5eL26.kflBhBN50qxhNiMZyQfoYqcM41z/0Di','Notario','Notario','Notario',0),(9,1,'admin','','$2a$10$rAuZfWne.JEOVb05mpXvheZp59F8qJxA3j7oBH/ruQ4ZJP1kPolDG','Diego','Portilla','admin',0),(108,1,'dylan',NULL,'$2a$10$UcQDcpIGnF/lIfc8dTCm9uB6QQt3dlkt.CiI2u.81BG8KpkTnxnDq','dylan','dylan','admin',0),(109,1,'mathias',NULL,'$2a$10$FvBy3tprdx.JI4G1iEdg/uSywQ.4yDnpsw5ZNOuASCTV8VWeBLhNe','mathias','mathias','admin',0);
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
INSERT INTO `votaciones` VALUES (1,1,1,1,'no'),(2,1,1,2,'no'),(3,1,1,3,'no'),(4,1,1,4,'no'),(5,1,1,5,'no'),(6,1,1,6,'no'),(7,1,1,7,'no'),(8,1,1,8,'no'),(9,1,1,9,'no'),(10,1,1,10,'no'),(11,1,2,1,'no'),(12,1,2,2,'no'),(13,1,2,3,'no'),(14,1,2,4,'no'),(15,1,2,5,'no'),(16,1,2,6,'no'),(17,1,2,7,'no'),(18,1,2,8,'no'),(19,1,2,9,'no'),(20,1,2,10,'no'),(21,1,3,1,'no'),(22,1,3,2,'no'),(23,1,3,3,'no'),(24,1,3,4,'no'),(25,1,3,5,'no'),(26,1,3,6,'no'),(27,1,3,7,'no'),(28,1,3,8,'no'),(29,1,3,9,'no'),(30,1,3,10,'no'),(31,2,1,1,'no'),(32,2,1,2,'no'),(33,2,1,3,'no'),(34,2,1,4,'no'),(35,2,1,5,'no'),(36,2,1,6,'no'),(37,2,1,7,'no'),(38,2,1,8,'no'),(39,2,1,9,'no'),(40,2,1,10,'no'),(41,2,2,1,'no'),(42,2,2,2,'no'),(43,2,2,3,'no'),(44,2,2,4,'no'),(45,2,2,5,'no'),(46,2,2,6,'no'),(47,2,2,7,'no'),(48,2,2,8,'no'),(49,2,2,9,'no'),(50,2,2,10,'no'),(51,2,3,1,'no'),(52,2,3,2,'no'),(53,2,3,3,'no'),(54,2,3,4,'no'),(55,2,3,5,'no'),(56,2,3,6,'no'),(57,2,3,7,'no'),(58,2,3,8,'no'),(59,2,3,9,'no'),(60,2,3,10,'no'),(61,3,1,1,'no'),(62,3,1,2,'no'),(63,3,1,3,'no'),(64,3,1,4,'no'),(65,3,1,5,'no'),(66,3,1,6,'no'),(67,3,1,7,'no'),(68,3,1,8,'no'),(69,3,1,9,'no'),(70,3,1,10,'no'),(71,3,2,1,'no'),(72,3,2,2,'no'),(73,3,2,3,'no'),(74,3,2,4,'no'),(75,3,2,5,'no'),(76,3,2,6,'no'),(77,3,2,7,'no'),(78,3,2,8,'no'),(79,3,2,9,'no'),(80,3,2,10,'no'),(81,3,3,1,'no'),(82,3,3,2,'no'),(83,3,3,3,'no'),(84,3,3,4,'no'),(85,3,3,5,'no'),(86,3,3,6,'no'),(87,3,3,7,'no'),(88,3,3,8,'no'),(89,3,3,9,'no'),(90,3,3,10,'no'),(92,4,1,1,'no'),(93,4,1,2,'no'),(94,4,1,3,'no'),(95,4,1,4,'no'),(96,4,1,5,'no'),(97,4,1,6,'no'),(98,4,1,7,'no'),(99,4,1,8,'no'),(100,4,1,9,'no'),(101,4,1,10,'no'),(102,4,2,1,'no'),(103,4,2,2,'no'),(104,4,2,3,'no'),(105,4,2,4,'no'),(106,4,2,5,'no'),(107,4,2,6,'no'),(108,4,2,7,'no'),(109,4,2,8,'no'),(110,4,2,9,'no'),(111,4,2,10,'no'),(112,4,3,1,'no'),(113,4,3,2,'no'),(114,4,3,3,'no'),(115,4,3,4,'no'),(116,4,3,5,'no'),(117,4,3,6,'no'),(118,4,3,7,'no'),(119,4,3,8,'no'),(120,4,3,9,'no'),(121,4,3,10,'no'),(122,5,1,1,'no'),(123,5,1,2,'no'),(124,5,1,3,'no'),(125,5,1,4,'no'),(126,5,1,5,'no'),(127,5,1,6,'no'),(128,5,1,7,'no'),(129,5,1,8,'no'),(130,5,1,9,'no'),(131,5,1,10,'no'),(132,5,2,1,'no'),(133,5,2,2,'no'),(134,5,2,3,'no'),(135,5,2,4,'no'),(136,5,2,5,'no'),(137,5,2,6,'no'),(138,5,2,7,'no'),(139,5,2,8,'no'),(140,5,2,9,'no'),(141,5,2,10,'no'),(142,5,3,1,'no'),(143,5,3,2,'no'),(144,5,3,3,'no'),(145,5,3,4,'no'),(146,5,3,5,'no'),(147,5,3,6,'no'),(148,5,3,7,'no'),(149,5,3,8,'no'),(150,5,3,9,'no'),(151,5,3,10,'no'),(152,6,1,1,'no'),(153,6,1,2,'no'),(154,6,1,3,'no'),(155,6,1,4,'no'),(156,6,1,5,'no'),(157,6,1,6,'no'),(158,6,1,7,'no'),(159,6,1,8,'no'),(160,6,1,9,'no'),(161,6,1,10,'no'),(162,6,2,1,'no'),(163,6,2,2,'no'),(164,6,2,3,'no'),(165,6,2,4,'no'),(166,6,2,5,'no'),(167,6,2,6,'no'),(168,6,2,7,'no'),(169,6,2,8,'no'),(170,6,2,9,'no'),(171,6,2,10,'no'),(172,6,3,1,'no'),(173,6,3,2,'no'),(174,6,3,3,'no'),(175,6,3,4,'no'),(176,6,3,5,'no'),(177,6,3,6,'no'),(178,6,3,7,'no'),(179,6,3,8,'no'),(180,6,3,9,'no'),(181,6,3,10,'no'),(182,7,1,1,'no'),(183,7,1,2,'no'),(184,7,1,3,'no'),(185,7,1,4,'no'),(186,7,1,5,'no'),(187,7,1,6,'no'),(188,7,1,7,'no'),(189,7,1,8,'no'),(190,7,1,9,'no'),(191,7,1,10,'no'),(192,7,2,1,'no'),(193,7,2,2,'no'),(194,7,2,3,'no'),(195,7,2,4,'no'),(196,7,2,5,'no'),(197,7,2,6,'no'),(198,7,2,7,'no'),(199,7,2,8,'no'),(200,7,2,9,'no'),(201,7,2,10,'no'),(202,7,3,1,'no'),(203,7,3,2,'no'),(204,7,3,3,'no'),(205,7,3,4,'no'),(206,7,3,5,'no'),(207,7,3,6,'no'),(208,7,3,7,'no'),(209,7,3,8,'no'),(210,7,3,9,'no'),(211,7,3,10,'no');
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'blog'
--

--
-- Dumping routines for database 'blog'
--
/*!50003 DROP PROCEDURE IF EXISTS `calculate_ponderada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calculate_ponderada`(IN dummyC INT, OUT caliP decimal(6,4))
BEGIN
  DECLARE contador INT DEFAULT 1;

  SET caliP = 0;

  WHILE contador <= (SELECT COUNT(DISTINCT evento_id) FROM evento) DO
    SET caliP = caliP + (
      SELECT SUM((CALIFICACION_PESO/100) * CALIFICACION_VALOR * ((SELECT evento_peso FROM evento WHERE evento_id = contador)/100)) AS suma
      FROM finales
      WHERE candidata_id = dummyC AND EVENTO_ID = contador
    );

    SET contador = contador + 1;
  END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `compute_final_score` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `compute_final_score`(IN dummy INT, OUT resultado INT)
BEGIN
  DECLARE calificaciones_realizadas INT;
  DECLARE total_candidatas INT;
  DECLARE total_notas INT;
  DECLARE total_eventos INT;
  DECLARE contador INT DEFAULT 1;
  DECLARE calificacion_ponderada INT;
  
  -- Contar total de candidatas
  SELECT COUNT(DISTINCT candidata_id) INTO total_candidatas FROM candidata;
  
  -- Contar total de notas de los eventos
  SELECT SUM(calif_por_evento) INTO total_notas FROM evento;
  
  -- Contar total de eventos
  SELECT COUNT(DISTINCT evento_id) INTO total_eventos FROM evento;
  
  -- Contar total de calificaciones finales de la candidata actual
  SELECT COUNT(*) INTO calificaciones_realizadas FROM finales WHERE candidata_id = dummy;
  
  -- Verificar si la candidata ya tiene todas sus calificaciones
  IF calificaciones_realizadas = total_notas THEN
    SET calificacion_ponderada = 0;
    WHILE contador <= total_eventos DO
      SET calificacion_ponderada = calificacion_ponderada + (
        SELECT SUM((CALIFICACION_PESO/100) * CALIFICACION_VALOR * ((SELECT evento_peso FROM evento WHERE evento_id = contador)/100)) AS suma
        FROM finales
        WHERE candidata_id = candidata_id AND EVENTO_ID = contador
      );
      SET contador = contador + 1;
    END WHILE;
    UPDATE candidata SET cand_nota_final = calificacion_ponderada WHERE candidata_id = candidata_id;
    SET contador = 1;
  END IF;
  SET resultado = calificacion_ponderada;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-04  9:52:14
