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
  `CAND_FECHANACIMIENTO` date DEFAULT NULL,
  `CAND_ACTIVIDAD_EXTRA` varchar(900) DEFAULT NULL,
  `CAND_ESTATURA` decimal(3,2) DEFAULT NULL COMMENT 'La estatura debe ser en metros',
  `CAND_HOBBIES` varchar(900) DEFAULT NULL,
  `CAND_IDIOMAS` varchar(100) DEFAULT NULL,
  `CAND_COLOROJOS` varchar(45) DEFAULT NULL,
  `CAND_COLORCABELLO` varchar(45) DEFAULT NULL,
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
INSERT INTO `candidata` VALUES (1,8,1,'Morillo','Rodríguez','Wendy','Elizabeth',NULL,'Para mi la Universidad de las Fuerzas Armadas ESPE, signfica una gran oportunidad para desarrollarse profesionalmente, aprender a trabajar tanto de manera individual como grupal y poder adquirir nuevas habilidades y experiencias necesarias para desenvolverse en la carrera elegida. La ESPE nos brinda un gran apoyo, valores, conocimientos, disciplina, liderazgo y responsabilidades muy importantes al momentos de llegar a enfretar los desafíos que se nos presenten a lo largo de este trayecto. ',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(2,3,1,'Reyes','Pérez','Jessenia','del Rocío',NULL,'La Universidad de las Fuerzas Armadas ESPE es la llama encendida de la valentía y la disciplina, donde se forjan almas con la nobleza del saber en el crisol del honor, guiadas por el ideal del servir y engrandecer la patria.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(3,10,1,'Estrella','Paladines','Yariely','Nicole',NULL,'La ESPE simboliza para mí, el compromiso con la defensa y el progreso de nuestro país, guiándome en el camino de la responsabilidad y el liderazgo con integridad.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(4,9,1,'Morán','Vega','Andrea','Gisselle',NULL,'Para mi significa más que un lugar de aprendizaje, es un segundo hogar donde he crecido personal y academicamente. Aquí, he encontrado inspiración en los profesores, he formado lazos con mis compañeros y he descubierto mis pasiones y habilidades. Esta Universidad me ha enseñado el valor de la perseverancia, la colaboración y el pensamiento crítico, estoy orgullosa de ser parte de una comunidad que fomenta la excelencia y el desarrollo integral.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(5,4,1,'Fuertes','Ortega','Liz','Scarlet',NULL,'La universidad para mí es un viaje de descubrimiento y crecimiento, es donde encuentro mi pasión, hago amistades para toda la vida y aprendo más sobre mí misma. Es un lugar donde mis sueños toman forma y mi futuro comienza a construirse. ',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(6,2,1,'Aguirre','Espinosa','Gabriela','Nicole',NULL,'Para mí, la gloriosa ESPE (Universidad de las Fuerzas Armadas) representa un período de crecimiento, formación y madurez en mi vida, donde he desarrollado habilidades y conocimientos valiosos que me han permitido crecer como persona. Es un lugar donde he encontrado apoyo, amistades y mentoría que me han ayudado a encontrar mi camino y a alcanzar mis objetivos.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(7,7,1,'Sancan','Portillo','Martha','Dayana',NULL,'La Universidad de las Fuerzas Armadas ESPE simboliza para mí el privilegio de aprender, servir, y desarrollarme con excelencia y disciplina, inspirándome a alcanzar grandes metas.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(8,1,1,'Díaz','Pozo','Rebeca','Anahí',NULL,'La universidad de las fuerzas Armadas para mi representa un conjunto de valores; es el compromiso con el que los profesores nos transmiten su conocimiento día a día, es el poder de representar a una comunidad de jóvenes que desean llegar a ser buenos profesionales en la vida, es la calidad de educación que transmiten a sus estudiantes con el objetivo de crear lideres de esta sociedad',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(9,11,1,'Montalván','Maldonado','Ariana','Daniela',NULL,'Para mí la Universidad ESPE genera disciplina, lealtad, civismo y patriotismo crea personas con un espíritu de liderazgo, nos brinda la seguridad de expresarnos y ser mejores ciudadanos, forma a los estudiantes como grandes profesionales, con un pensamiento lleno de valores y madurez mental, la Universidad es un lugar donde no solo vas a crecer en conocimiento si no como persona aprenderás a trabajar en equipo y a desenvolverte en la sociedad, creas amistades inolvidables, en conclusión nuestra gran universidad forma grandes profesionales, y te deja grandes anécdotas, por algo somos una de las mejores universidades del Ecuador, categoría A.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(10,12,1,'Briones','Mosquera','Kimberly','Brisney',NULL,'ESPE, integración y empatía, personas amables que emprenden una dura batalla para lograr sus objetivos; más que un conjunto de maestros, estudiantes y entidades, es unión, compañerismo, aprendizaje colectivo que nos proyecta a un futuro más desarrollado y lleno del conocimiento que imparten nuestros queridos maestros. Me es un privilegio inmenso poder decir que esta Universidad, se ha ganado un espacio en mi corazon y cada pequeño aporte de quienes conformamos esta institución, sumará para la educación de futuras generaciones.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(11,6,1,'Acosta','Acosta','Rachel','Alexandra',NULL,'Para mí, La Universidad de las Fuerzas Armadas - ESPE es más que un lugar de aprendizaje; es un refugio donde mis sueños toman forma y mis habilidades se cultivan. Es aquí donde encuentro inspiración, apoyo y la oportunidad de crecer no solo intelectualmente, sino también como persona. Gracias a esta institución cada clase es una puerta hacia el conocimiento y cada profesor un guía en mi viaje hacia el éxito.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL),(12,5,1,'Arreaga','Riera','Estefani','Nicole',NULL,'La Universidad ESPE significa para mí un pilar fundamental en mi desarrollo académico, profesional y personal, donde he adquirido conocimientos valiosos para crecer como persona, enfrentando y superando desafíos, desarrollando independencia , madurez y forjado amistades duraderas.',NULL,NULL,NULL,NULL,NULL,NULL,0.0000,0,NULL);
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
INSERT INTO `departamento` VALUES (1,'Ciencias Económicas, Administrativas y de Comercio','Matriz'),(2,'Eléctrica, Electrónica y Telecomunicaciones','Matriz'),(3,'Ciencias Humanas y Sociales','Matriz'),(4,'Ciencias de la Energía y Mecánica','Matriz'),(5,'Sede Santo Domingo','Santo Domingo'),(6,'Sede Latacunga','Latacunga'),(7,'Ciencias Médicas','Matriz'),(8,'Ciencias de la Computación','Matriz'),(9,'Ciencias de la Vida y Agricultura','Matriz'),(10,'Ciencias de la Tierra y la Construcción ','Matriz'),(11,'Seguridad y Defensa','Matriz'),(12,'Ciencias Exactas','Matriz');
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
INSERT INTO `eleccion` VALUES (1,'May2024-Sept2024');
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
INSERT INTO `evento` VALUES (1,1,'Traje Típico',35,1,'no'),(2,1,'Traje Gala',35,1,'no'),(3,1,'Preguntas',30,1,'no');
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
INSERT INTO `foto_candidata` VALUES (1,1,'FX','C:\\fakepath\\WEMRH.jpg'),(2,2,'FX','C:\\fakepath\\JRRPH.jpg'),(3,3,'FX','C:\\fakepath\\YNEPH.jpg'),(4,4,'FX','C:\\fakepath\\AGMVH.jpg'),(5,5,'FX','C:\\fakepath\\LSFOH.jpg'),(6,6,'FX','C:\\fakepath\\GNAEH.jpg'),(7,7,'FX','C:\\fakepath\\MDSPH.jpg'),(8,8,'FX','C:\\fakepath\\RADPH.jpg'),(9,9,'FX','C:\\fakepath\\ADMMH.jpg'),(10,10,'FX','C:\\fakepath\\KBBMH.jpg'),(11,11,'FX','C:\\fakepath\\RAAAH.jpg'),(12,12,'FX','C:\\fakepath\\ENARH.jpg'),(13,3,'FP','C:\\fakepath\\SYFP.jpg'),(14,4,'FP','C:\\fakepath\\NRFP.jpg'),(15,5,'FP','C:\\fakepath\\DLFP.jpg'),(16,6,'FP','C:\\fakepath\\ABFP.jpg'),(17,7,'FP','C:\\fakepath\\JSFP.jpg'),(18,8,'FP','C:\\fakepath\\BEFP.jpg'),(19,9,'FP','C:\\fakepath\\AEFP.jpg'),(20,10,'FP','C:\\fakepath\\IAFP.jpg');
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
INSERT INTO `users` VALUES (1,1,'Juez1',NULL,'$2a$10$F4IojLNcgsfQCwruggqgDe7GEyG4qmWXwdn94RfC0.XqxzKbeqT46','Monserrath','Mejía de Molina','juez',0),(2,1,'Juez2',NULL,'$2a$10$eX6uL5CRS3phJH1gHK2TiuylPamL7wnXSrDfpFT5avuEXeNdGMgeG','Victoria','García de Proaño','juez',0),(3,1,'Juez3',NULL,'$2a$10$IsxENTUmumv93Elw61AISeXSJASgV5aWNMinVhAYaBFWCVyQsbV0G','Cumandá','Sarmiento de Velasco','juez',0),(4,1,'Juez4',NULL,'$2a$10$QqR6eG0ln.tIQTw8Y0bO0OSG56RDX6xhp8ADmckKSnt/HtS7jXBc6','Irene','Ocaña de Villavicencio','juez',0),(5,1,'Juez5',NULL,'$2a$10$iA6wDU48sc/uZHy2lgifPu8yqqRlMClDjVZrLH8.vKlDIbMNevksS','Fabián','Iza Marcillo','juez',0),(6,1,'Veedor',NULL,'$2a$10$Tr3ifQmgZYwoZZtOCrpWcOz3jPiNOHTFnlPviy1kLiFWZAdXOxWSO','Marcelo','Mejía Mena','Notario',0),(7,1,'admin','','$2a$10$rAuZfWne.JEOVb05mpXvheZp59F8qJxA3j7oBH/ruQ4ZJP1kPolDG','Dylan','Hernández','admin',0),(8,1,'luca',NULL,'$2a$10$6RpFCoR2MHDR0wAi7/f7OeNtlZ5gBXxEU62UZz4bgoOszNEjVHRPm','Luca','De Veintemilla','admin',0),(9,1,'juan',NULL,'$2a$10$r4vMi4U3tAnt/BEwDAda5OatG8DCfI3LbVEyXS7iWsSX2.1g1VIuW','Juan','Reyes','admin',0),(10,1,'kevin',NULL,'$2a$10$D71aXX4ggNlI50PHu.1Iver7lFlcYHJmSzLdU29Jmup.Gti2E.L9u','Kevin','Vargas','admin',0);
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
INSERT INTO `votaciones` VALUES (1,1,1,1,'no'),(2,1,1,2,'no'),(3,1,1,3,'no'),(4,1,1,4,'no'),(5,1,1,5,'no'),(6,1,1,6,'no'),(7,1,1,7,'no'),(8,1,1,8,'no'),(9,1,1,9,'no'),(10,1,1,10,'no'),(11,1,1,11,'no'),(12,1,1,12,'no'),(13,1,2,1,'no'),(14,1,2,2,'no'),(15,1,2,3,'no'),(16,1,2,4,'no'),(17,1,2,5,'no'),(18,1,2,6,'no'),(19,1,2,7,'no'),(20,1,2,8,'no'),(21,1,2,9,'no'),(22,1,2,10,'no'),(23,1,2,11,'no'),(24,1,2,12,'no'),(25,1,3,1,'no'),(26,1,3,2,'no'),(27,1,3,3,'no'),(28,1,3,4,'no'),(29,1,3,5,'no'),(30,1,3,6,'no'),(31,1,3,7,'no'),(32,1,3,8,'no'),(33,1,3,9,'no'),(34,1,3,10,'no'),(35,1,3,11,'no'),(36,1,3,12,'no'),(37,2,1,1,'no'),(38,2,1,2,'no'),(39,2,1,3,'no'),(40,2,1,4,'no'),(41,2,1,5,'no'),(42,2,1,6,'no'),(43,2,1,7,'no'),(44,2,1,8,'no'),(45,2,1,9,'no'),(46,2,1,10,'no'),(47,2,1,11,'no'),(48,2,1,12,'no'),(49,2,2,1,'no'),(50,2,2,2,'no'),(51,2,2,3,'no'),(52,2,2,4,'no'),(53,2,2,5,'no'),(54,2,2,6,'no'),(55,2,2,7,'no'),(56,2,2,8,'no'),(57,2,2,9,'no'),(58,2,2,10,'no'),(59,2,2,11,'no'),(60,2,2,12,'no'),(61,2,3,1,'no'),(62,2,3,2,'no'),(63,2,3,3,'no'),(64,2,3,4,'no'),(65,2,3,5,'no'),(66,2,3,6,'no'),(67,2,3,7,'no'),(68,2,3,8,'no'),(69,2,3,9,'no'),(70,2,3,10,'no'),(71,2,3,11,'no'),(72,2,3,12,'no'),(73,3,1,1,'no'),(74,3,1,2,'no'),(75,3,1,3,'no'),(76,3,1,4,'no'),(77,3,1,5,'no'),(78,3,1,6,'no'),(79,3,1,7,'no'),(80,3,1,8,'no'),(81,3,1,9,'no'),(82,3,1,10,'no'),(83,3,1,11,'no'),(84,3,1,12,'no'),(85,3,2,1,'no'),(86,3,2,2,'no'),(87,3,2,3,'no'),(88,3,2,4,'no'),(89,3,2,5,'no'),(90,3,2,6,'no'),(91,3,2,7,'no'),(92,3,2,8,'no'),(93,3,2,9,'no'),(94,3,2,10,'no'),(95,3,2,11,'no'),(96,3,2,12,'no'),(97,3,3,1,'no'),(98,3,3,2,'no'),(99,3,3,3,'no'),(100,3,3,4,'no'),(101,3,3,5,'no'),(102,3,3,6,'no'),(103,3,3,7,'no'),(104,3,3,8,'no'),(105,3,3,9,'no'),(106,3,3,10,'no'),(107,3,3,11,'no'),(108,3,3,12,'no'),(109,4,1,1,'no'),(110,4,1,2,'no'),(111,4,1,3,'no'),(112,4,1,4,'no'),(113,4,1,5,'no'),(114,4,1,6,'no'),(115,4,1,7,'no'),(116,4,1,8,'no'),(117,4,1,9,'no'),(118,4,1,10,'no'),(119,4,1,11,'no'),(120,4,1,12,'no'),(121,4,2,1,'no'),(122,4,2,2,'no'),(123,4,2,3,'no'),(124,4,2,4,'no'),(125,4,2,5,'no'),(126,4,2,6,'no'),(127,4,2,7,'no'),(128,4,2,8,'no'),(129,4,2,9,'no'),(130,4,2,10,'no'),(131,4,2,11,'no'),(132,4,2,12,'no'),(133,4,3,1,'no'),(134,4,3,2,'no'),(135,4,3,3,'no'),(136,4,3,4,'no'),(137,4,3,5,'no'),(138,4,3,6,'no'),(139,4,3,7,'no'),(140,4,3,8,'no'),(141,4,3,9,'no'),(142,4,3,10,'no'),(143,4,3,11,'no'),(144,4,3,12,'no'),(145,5,1,1,'no'),(146,5,1,2,'no'),(147,5,1,3,'no'),(148,5,1,4,'no'),(149,5,1,5,'no'),(150,5,1,6,'no'),(151,5,1,7,'no'),(152,5,1,8,'no'),(153,5,1,9,'no'),(154,5,1,10,'no'),(155,5,1,11,'no'),(156,5,1,12,'no'),(157,5,2,1,'no'),(158,5,2,2,'no'),(159,5,2,3,'no'),(160,5,2,4,'no'),(161,5,2,5,'no'),(162,5,2,6,'no'),(163,5,2,7,'no'),(164,5,2,8,'no'),(165,5,2,9,'no'),(166,5,2,10,'no'),(167,5,2,11,'no'),(168,5,2,12,'no'),(169,5,3,1,'no'),(170,5,3,2,'no'),(171,5,3,3,'no'),(172,5,3,4,'no'),(173,5,3,5,'no'),(174,5,3,6,'no'),(175,5,3,7,'no'),(176,5,3,8,'no'),(177,5,3,9,'no'),(178,5,3,10,'no'),(179,5,3,11,'no'),(180,5,3,12,'no');
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

-- Dump completed on 2024-06-07 23:10:08
