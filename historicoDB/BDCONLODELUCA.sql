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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `calificacion`
--

LOCK TABLES `calificacion` WRITE;
/*!40000 ALTER TABLE `calificacion` DISABLE KEYS */;
INSERT INTO `calificacion` VALUES (1,1,1,1,'a',4,4),(2,1,1,1,'b',4,4);
/*!40000 ALTER TABLE `calificacion` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `candidata` VALUES (1,1,1,'Vasquez','Lascano','Melany','Patricia','2003-07-05','',1.63,'Tomar fotografías, pintar cerámica, conocer lugares nuevos e ir al gimnasio.','Ingles - Español','Verde','Castaño Claro',NULL,NULL,0,NULL),(2,2,1,'Morocho','Ortiz','Simone','Carolina','1999-03-02','IEEE WIE, Organizacion y voluntariado en la fundación Héroes de Vida, Colaboración en rescate animal y apadrinamiento de animalitos rescatados, Voluntariado en CIBV (Centros Infantiles del Buen Vivir) en Catamayo-Loja, Diseñadora del sistema de monitoreo para la seguridad de la población del sector de Chachill - Pintag (en proceso)',1.55,' Leer, tejer, patinar, repostería, y aprender idiomas.','Ingles - Frances - Español','Café Claro','Castaño Oscuro','Certificación en Manejo de Software Packet Tracer otorgada por Cisco,Certificación WEBINAR : 3D BIONIC EXOSKELETONS por P4H Bionics,Curso en el SECAP de Introduccion a Electrónica ',NULL,0,NULL),(3,3,1,'Yanez','Perez','Sofia','Arlet','2001-08-06','Accesora Comercial de venta de automoviles',1.56,'Jugar Futbol','Español','Café','Castaño','Escolta del colegio Dario Figueroa Larco',NULL,0,NULL),(4,4,1,'Rodriguez','Trujillo','Natzarenna','b','1998-02-27','',1.60,'Pintar, bailar y hacer manualidades','Español','Café','Rojo Cobrizo',NULL,NULL,0,NULL),(5,5,1,'Lopez','Barzallio','Stefany','Daniela','2001-06-19','Club cultural de danza y música',1.62,'Cantar, bailar, escuchar música','Español','Café','Rubio',NULL,NULL,0,NULL),(6,6,1,'Borja','Calero','Alisson','Denisse','2002-07-01','Natación y Ciclismo',1.73,'Escuchar Música','Ingles - Español','Verde','Castaño Claro','Miembro del consejo estudiantil del colegio Sagrado Corazon de Jesus',NULL,0,NULL),(7,7,1,'Saltos','Arequipa','Julianna','Belén','2000-12-28','Voluntariado en Toca de Assis Hermanas,Obra social en Latacunga',1.61,'Escribir, leer, bailar, aprender idiomas, hacer deporte, hacer manualidades,dibujar, pintar, pasar tiempo en familia y amigos.','Ingles - Español','Café','Castaño Oscuro','Becas Academicas,Brigadier Capitan,Abanderada del Pabellon Nacional y mejor egresada del colegio Liceo Naval Quito',NULL,0,NULL),(8,8,1,'Espinoza','Torres','Barbara','Emilia','2000-12-10','',1.71,'Deportes como atletismo y volley, e ir al gimnasio','Ingles - Español','Café','Castaño Oscuro','Perteneciente al grupo de alto rendimiento del ser bachiller',NULL,0,NULL),(9,9,1,'Estrella','Tuarez','Angie','Leonela','2000-11-25','',1.67,'Aprender a cocinar postres, bailar, leer libros de suspensos, pintar, hacer ejercicio y ver películas y series','Ingles - Español','Café','Castaño Oscuro',NULL,NULL,0,NULL),(10,10,1,'Aguilar','Montesdeoca','Imalin','Pamela','2000-04-09','Club EERI',1.70,'Hacer ejercicio y cocinar','Español','Café','Castaño Oscuro',NULL,NULL,0,NULL);
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
INSERT INTO `departamento` VALUES (1,'Departamento de Ciencias Economicas,administrativas y de comercio','Matriz'),(2,'Departamento de Electrica,Electronica y Telecomunicaciones','Matriz'),(3,'Departamento de Ciencias humanas y Sociales','Matriz'),(4,'Departamento de Ciencias de la energia y Mecanica','Matriz'),(5,'Departamento de Ciencias de la vida','Santo Domingo'),(6,'Departamento de Ciencias de la energia y Mecanica','Latacunga'),(7,'Departamento de Ciencias Medicas','Matriz'),(8,'Departamento de Ciencias de la Computacion','Matriz'),(9,'Departamento de Ciencias de la vida y Agricultura','Matriz'),(10,'Departamento de Ciencias de la Tierra y la Construccion ','Matriz');
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `finales`
--

LOCK TABLES `finales` WRITE;
/*!40000 ALTER TABLE `finales` DISABLE KEYS */;
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
INSERT INTO `foto_candidata` VALUES (1,1,'FX','C:\\fakepath\\MVFX.jpg'),(2,2,'FX','C:\\fakepath\\SMFX.jpg'),(3,3,'FX','C:\\fakepath\\SYFX.jpg'),(4,4,'FX','C:\\fakepath\\NRFX.jpg'),(5,5,'FX','C:\\fakepath\\DLFX.jpg'),(6,6,'FX','C:\\fakepath\\ABFX.jpg'),(7,7,'FX','C:\\fakepath\\JSFX.jpg'),(8,8,'FX','C:\\fakepath\\BEFX.jpg'),(9,9,'FX','C:\\fakepath\\AEFX.jpg'),(10,10,'FX','C:\\fakepath\\IAFX.jpg');
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
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Juez1',NULL,'$2a$10$F4IojLNcgsfQCwruggqgDe7GEyG4qmWXwdn94RfC0.XqxzKbeqT46','juez1','juez1','juez'),(2,1,'Juez2',NULL,'$2a$10$eX6uL5CRS3phJH1gHK2TiuylPamL7wnXSrDfpFT5avuEXeNdGMgeG','juez2','juez2','juez'),(3,1,'test2','test2@gmail.com','$2a$10$cEA7pOU3C.PjQA.am2grEeTi921CX1AHeKq9cHwsgG6bb.Oyex6Je','','',''),(4,1,'ayme','aymealejandra1@gmail.com','$2a$10$BTd9PtuM/GZGptiV7zuDweEhV4P6APnyH.jba9mkyt4qk1DtAkDqi','','',''),(6,1,'camila','alejandra-ayme@hotmail.com','$2a$10$gZ3AYatBs2Gp/7lc5YvjI.kTIGkUnBsqDtUElxiPufUuj/cHUYeKe','','',''),(7,1,'daportilla1','daportilla1@espe.edu.ec','$2a$10$9YetGGZh2tE/WOl5x7KgtOkY/OS/bk0s.aMPHukKVo/X.DNuh5.XW','','',''),(8,1,'marcelo','hola@espe.edu.ec','$2a$10$bOWskqaGu09mTtRzZC09Be6T8akpR6XIvNmLzwdFL9Ig4ZUEX2jUi','','',''),(9,1,'Chris','cdiza5@espe.edu.ec','$2a$10$cfAhW2PKGlyrWu.eJb4L/.JyKfBzuh1CpycvyBtKEwTCXlEzmPNnW','','',''),(10,1,'camilita','c@espe.edu.ec','$2a$10$89cHUG7GQU9E3Ea830p4jeU83NwlQrB3vRn4PAtd.sMC3HhPx/Avu','','',''),(11,1,'admin','','$2a$10$rAuZfWne.JEOVb05mpXvheZp59F8qJxA3j7oBH/ruQ4ZJP1kPolDG','Diego','Portilla','admin'),(100,1,'aaescobar2','aaescobar2@espe.edu.ec','$2a$10$ugtD/ToixTVkXrjFIsthi.fq.soHH34qwSXCZx/BBqQVlpusqKA4G','','','');
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
INSERT INTO `votaciones` VALUES (1,1,1,1,'si'),(2,1,1,2,'No'),(3,1,1,3,'No'),(4,1,1,4,'No'),(5,1,1,5,'No'),(6,1,1,6,'No'),(7,1,1,7,'No'),(8,1,1,8,'No'),(9,1,1,9,'No'),(10,1,1,10,'No'),(11,1,2,1,'No'),(12,1,2,2,'No'),(13,1,2,3,'No'),(14,1,2,4,'No'),(15,1,2,5,'No'),(16,1,2,6,'No'),(17,1,2,7,'No'),(18,1,2,8,'No'),(19,1,2,9,'No'),(20,1,2,10,'No'),(21,1,3,1,'No'),(22,1,3,2,'No'),(23,1,3,3,'No'),(24,1,3,4,'No'),(25,1,3,5,'No'),(26,1,3,6,'No'),(27,1,3,7,'No'),(28,1,3,8,'No'),(29,1,3,9,'No'),(30,1,3,10,'No'),(31,2,1,1,'No'),(32,2,1,2,'No'),(33,2,1,3,'No'),(34,2,1,4,'No'),(35,2,1,5,'No'),(36,2,1,6,'No'),(37,2,1,7,'No'),(38,2,1,8,'No'),(39,2,1,9,'No'),(40,2,1,10,'No'),(41,2,2,1,'No'),(42,2,2,2,'No'),(43,2,2,3,'No'),(44,2,2,4,'No'),(45,2,2,5,'No'),(46,2,2,6,'No'),(47,2,2,7,'No'),(48,2,2,8,'No'),(49,2,2,9,'No'),(50,2,2,10,'No'),(51,2,3,1,'No'),(52,2,3,2,'No'),(53,2,3,3,'No'),(54,2,3,4,'No'),(55,2,3,5,'No'),(56,2,3,6,'No'),(57,2,3,7,'No'),(58,2,3,8,'No'),(59,2,3,9,'No'),(60,2,3,10,'No'),(61,3,1,1,'No'),(62,3,1,2,'No'),(63,3,1,3,'No'),(64,3,1,4,'No'),(65,3,1,5,'No'),(66,3,1,6,'No'),(67,3,1,7,'No'),(68,3,1,8,'No'),(69,3,1,9,'No'),(70,3,1,10,'No'),(71,3,2,1,'No'),(72,3,2,2,'No'),(73,3,2,3,'No'),(74,3,2,4,'No'),(75,3,2,5,'No'),(76,3,2,6,'No'),(77,3,2,7,'No'),(78,3,2,8,'No'),(79,3,2,9,'No'),(80,3,2,10,'No'),(81,3,3,1,'No'),(82,3,3,2,'No'),(83,3,3,3,'No'),(84,3,3,4,'No'),(85,3,3,5,'No'),(86,3,3,6,'No'),(87,3,3,7,'No'),(88,3,3,8,'No'),(89,3,3,9,'No'),(90,3,3,10,'No'),(92,4,1,1,'No'),(93,4,1,2,'No'),(94,4,1,3,'No'),(95,4,1,4,'No'),(96,4,1,5,'No'),(97,4,1,6,'No'),(98,4,1,7,'No'),(99,4,1,8,'No'),(100,4,1,9,'No'),(101,4,1,10,'No'),(102,4,2,1,'No'),(103,4,2,2,'No'),(104,4,2,3,'No'),(105,4,2,4,'No'),(106,4,2,5,'No'),(107,4,2,6,'No'),(108,4,2,7,'No'),(109,4,2,8,'No'),(110,4,2,9,'No'),(111,4,2,10,'No'),(112,4,3,1,'No'),(113,4,3,2,'No'),(114,4,3,3,'No'),(115,4,3,4,'No'),(116,4,3,5,'No'),(117,4,3,6,'No'),(118,4,3,7,'No'),(119,4,3,8,'No'),(120,4,3,9,'No'),(121,4,3,10,'No'),(122,5,1,1,'No'),(123,5,1,2,'No'),(124,5,1,3,'No'),(125,5,1,4,'No'),(126,5,1,5,'No'),(127,5,1,6,'No'),(128,5,1,7,'No'),(129,5,1,8,'No'),(130,5,1,9,'No'),(131,5,1,10,'No'),(132,5,2,1,'No'),(133,5,2,2,'No'),(134,5,2,3,'No'),(135,5,2,4,'No'),(136,5,2,5,'No'),(137,5,2,6,'No'),(138,5,2,7,'No'),(139,5,2,8,'No'),(140,5,2,9,'No'),(141,5,2,10,'No'),(142,5,3,1,'No'),(143,5,3,2,'No'),(144,5,3,3,'No'),(145,5,3,4,'No'),(146,5,3,5,'No'),(147,5,3,6,'No'),(148,5,3,7,'No'),(149,5,3,8,'No'),(150,5,3,9,'No'),(151,5,3,10,'No'),(152,6,1,1,'No'),(153,6,1,2,'No'),(154,6,1,3,'No'),(155,6,1,4,'No'),(156,6,1,5,'No'),(157,6,1,6,'No'),(158,6,1,7,'No'),(159,6,1,8,'No'),(160,6,1,9,'No'),(161,6,1,10,'No'),(162,6,2,1,'No'),(163,6,2,2,'No'),(164,6,2,3,'No'),(165,6,2,4,'No'),(166,6,2,5,'No'),(167,6,2,6,'No'),(168,6,2,7,'No'),(169,6,2,8,'No'),(170,6,2,9,'No'),(171,6,2,10,'No'),(172,6,3,1,'No'),(173,6,3,2,'No'),(174,6,3,3,'No'),(175,6,3,4,'No'),(176,6,3,5,'No'),(177,6,3,6,'No'),(178,6,3,7,'No'),(179,6,3,8,'No'),(180,6,3,9,'No'),(181,6,3,10,'No'),(182,7,1,1,'No'),(183,7,1,2,'No'),(184,7,1,3,'No'),(185,7,1,4,'No'),(186,7,1,5,'No'),(187,7,1,6,'No'),(188,7,1,7,'No'),(189,7,1,8,'No'),(190,7,1,9,'No'),(191,7,1,10,'No'),(192,7,2,1,'No'),(193,7,2,2,'No'),(194,7,2,3,'No'),(195,7,2,4,'No'),(196,7,2,5,'No'),(197,7,2,6,'No'),(198,7,2,7,'No'),(199,7,2,8,'No'),(200,7,2,9,'No'),(201,7,2,10,'No'),(202,7,3,1,'No'),(203,7,3,2,'No'),(204,7,3,3,'No'),(205,7,3,4,'No'),(206,7,3,5,'No'),(207,7,3,6,'No'),(208,7,3,7,'No'),(209,7,3,8,'No'),(210,7,3,9,'No'),(211,7,3,10,'No');
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-27 19:09:56
