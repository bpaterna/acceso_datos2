-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: florabotanica
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.24.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `jardines`
--

DROP TABLE IF EXISTS `jardines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jardines` (
  `id_jardin` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_jardin`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jardines`
--

LOCK TABLES `jardines` WRITE;
/*!40000 ALTER TABLE `jardines` DISABLE KEYS */;
INSERT INTO `jardines` VALUES (1,'Apolo'),(2,'Atenea'),(3,'Iris');
/*!40000 ALTER TABLE `jardines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jardines_plantas`
--

DROP TABLE IF EXISTS `jardines_plantas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jardines_plantas` (
  `id_jardin` int NOT NULL,
  `id_planta` int NOT NULL,
  `cantidad` int DEFAULT NULL,
  PRIMARY KEY (`id_jardin`,`id_planta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jardines_plantas`
--

LOCK TABLES `jardines_plantas` WRITE;
/*!40000 ALTER TABLE `jardines_plantas` DISABLE KEYS */;
INSERT INTO `jardines_plantas` VALUES (1,1,3),(1,2,5);
/*!40000 ALTER TABLE `jardines_plantas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plantas`
--

DROP TABLE IF EXISTS `plantas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantas` (
  `id_planta` int NOT NULL AUTO_INCREMENT,
  `nombre_comun` varchar(255) NOT NULL,
  `nombre_cientifico` varchar(255) NOT NULL,
  `stock` int DEFAULT NULL,
  `precio` double DEFAULT NULL,
  PRIMARY KEY (`id_planta`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantas`
--

LOCK TABLES `plantas` WRITE;
/*!40000 ALTER TABLE `plantas` DISABLE KEYS */;
INSERT INTO `plantas` VALUES (1,'Aloe Arborescens','Aloe barbadensis miller',20,5.8),(3,'Helecho de Boston','Nephrolepis exaltata',16,8.6),(4,'Bambú de la suerte','Dracaena sanderiana',8,15.6),(5,'Girasol','Helianthus annuus',17,4.6),(8,'Palmera','Arecaceae',0,50.5);
/*!40000 ALTER TABLE `plantas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-05 18:00:10
