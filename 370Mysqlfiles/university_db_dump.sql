-- MySQL dump 10.13  Distrib 8.0.30
--
-- Host: localhost    Database: university
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Class` (
  `code` varchar(10) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class`
--

LOCK TABLES `Class` WRITE;
/*!40000 ALTER TABLE `Class` DISABLE KEYS */;
INSERT INTO `Class` VALUES ('CSC305','Intro Graphics'),('CSC330','Programming Languages'),('CSC360','Operating Systems'),('CSC370','Databases');
/*!40000 ALTER TABLE `Class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EnrolledIn`
--

DROP TABLE IF EXISTS `EnrolledIn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `EnrolledIn` (
  `student` int NOT NULL,
  `class` varchar(10) NOT NULL,
  `semester` int NOT NULL,
  PRIMARY KEY (`student`,`class`,`semester`),
  KEY `fk_enrolledin_class` (`class`),
  CONSTRAINT `fk_enrolledin_class` FOREIGN KEY (`class`) REFERENCES `Class` (`code`),
  CONSTRAINT `fk_enrolledin_student` FOREIGN KEY (`student`) REFERENCES `Student` (`v_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EnrolledIn`
--

LOCK TABLES `EnrolledIn` WRITE;
/*!40000 ALTER TABLE `EnrolledIn` DISABLE KEYS */;
INSERT INTO `EnrolledIn` VALUES (777888,'CSC305',202201),(666777,'CSC330',202109),(222333,'CSC360',202201),(333444,'CSC360',202201),(222333,'CSC370',202109),(333444,'CSC370',202109),(666777,'CSC370',202109),(777888,'CSC370',202201);
/*!40000 ALTER TABLE `EnrolledIn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Instructor`
--

DROP TABLE IF EXISTS `Instructor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Instructor` (
  `v_number` int NOT NULL,
  `specialisation` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`v_number`),
  CONSTRAINT `fk_instructor_person` FOREIGN KEY (`v_number`) REFERENCES `Person` (`v_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Instructor`
--

LOCK TABLES `Instructor` WRITE;
/*!40000 ALTER TABLE `Instructor` DISABLE KEYS */;
INSERT INTO `Instructor` VALUES (0,'Ingenting'),(444555,'Databases'),(555666,'Computer Vision');
/*!40000 ALTER TABLE `Instructor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Person`
--

DROP TABLE IF EXISTS `Person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Person` (
  `v_number` int NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`v_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Person`
--

LOCK TABLES `Person` WRITE;
/*!40000 ALTER TABLE `Person` DISABLE KEYS */;
INSERT INTO `Person` VALUES (0,'Joey'),(111222,'Bob'),(222333,'Alice'),(333444,'Bob'),(444555,'Carol'),(555666,'Dave'),(666777,'Eve'),(777888,'Farisha'),(888999,'Gaven');
/*!40000 ALTER TABLE `Person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `v_number` int NOT NULL,
  `major` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`v_number`),
  CONSTRAINT `fk_student_person` FOREIGN KEY (`v_number`) REFERENCES `Person` (`v_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (222333,'CSC'),(333444,'CSC'),(666777,'MECH'),(777888,'SENG');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teaches`
--

DROP TABLE IF EXISTS `Teaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Teaches` (
  `instructor` int NOT NULL,
  `class` varchar(10) NOT NULL,
  `semester` int NOT NULL,
  PRIMARY KEY (`instructor`,`class`,`semester`),
  KEY `fk_teaches_class` (`class`),
  CONSTRAINT `fk_teaches_class` FOREIGN KEY (`class`) REFERENCES `Class` (`code`),
  CONSTRAINT `fk_teaches_instructor` FOREIGN KEY (`instructor`) REFERENCES `Instructor` (`v_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teaches`
--

LOCK TABLES `Teaches` WRITE;
/*!40000 ALTER TABLE `Teaches` DISABLE KEYS */;
INSERT INTO `Teaches` VALUES (555666,'CSC305',202201),(555666,'CSC330',202109),(444555,'CSC360',202201),(444555,'CSC370',202109),(444555,'CSC370',202201);
/*!40000 ALTER TABLE `Teaches` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-17 15:00:02
