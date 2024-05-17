-- MariaDB dump 10.19  Distrib 10.5.22-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_bremnere
-- ------------------------------------------------------
-- Server version	10.6.17-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Amendments`
--

DROP TABLE IF EXISTS `Amendments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Amendments` (
  `amendment_id` int(11) NOT NULL AUTO_INCREMENT,
  `amendment_type` varchar(145) NOT NULL,
  `amendment_quantity` decimal(6,2) NOT NULL,
  `date_applied` date NOT NULL,
  PRIMARY KEY (`amendment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Amendments`
--

LOCK TABLES `Amendments` WRITE;
/*!40000 ALTER TABLE `Amendments` DISABLE KEYS */;
INSERT INTO `Amendments` VALUES (1,'Mulch',20.00,'2024-04-01'),(2,'Compost',10.50,'2024-04-10'),(3,'Manure',5.00,'2024-04-20');
/*!40000 ALTER TABLE `Amendments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Campgrounds`
--

DROP TABLE IF EXISTS `Campgrounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Campgrounds` (
  `campground_id` int(11) NOT NULL AUTO_INCREMENT,
  `campground_name` varchar(145) DEFAULT NULL,
  `num_campsites` int(11) DEFAULT NULL,
  PRIMARY KEY (`campground_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Campgrounds`
--

LOCK TABLES `Campgrounds` WRITE;
/*!40000 ALTER TABLE `Campgrounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `Campgrounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Employees` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(145) NOT NULL,
  `last_name` varchar(145) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  PRIMARY KEY (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Viviana','McIntyre','505-987-6543'),(2,'Noel','Freeze','505-876-5467'),(3,'Jake','Santana','505-716-8975');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GardenBedAmendments`
--

DROP TABLE IF EXISTS `GardenBedAmendments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GardenBedAmendments` (
  `garden_bed_amendments_id` int(11) NOT NULL AUTO_INCREMENT,
  `garden_bed_id` int(11) NOT NULL,
  `amendment_id` int(11) NOT NULL,
  PRIMARY KEY (`garden_bed_amendments_id`),
  KEY `garden_bed_id` (`garden_bed_id`),
  KEY `amendment_id` (`amendment_id`),
  CONSTRAINT `GardenBedAmendments_ibfk_1` FOREIGN KEY (`garden_bed_id`) REFERENCES `GardenBeds` (`garden_bed_id`) ON DELETE CASCADE,
  CONSTRAINT `GardenBedAmendments_ibfk_2` FOREIGN KEY (`amendment_id`) REFERENCES `Amendments` (`amendment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GardenBedAmendments`
--

LOCK TABLES `GardenBedAmendments` WRITE;
/*!40000 ALTER TABLE `GardenBedAmendments` DISABLE KEYS */;
INSERT INTO `GardenBedAmendments` VALUES (1,3,2),(2,3,3),(3,2,2);
/*!40000 ALTER TABLE `GardenBedAmendments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GardenBeds`
--

DROP TABLE IF EXISTS `GardenBeds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GardenBeds` (
  `garden_bed_id` int(11) NOT NULL AUTO_INCREMENT,
  `garden_bed_name` varchar(100) NOT NULL,
  `sun_level` varchar(100) NOT NULL,
  `square_feet` int(11) NOT NULL,
  `cardinal_direction` varchar(100) NOT NULL,
  PRIMARY KEY (`garden_bed_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GardenBeds`
--

LOCK TABLES `GardenBeds` WRITE;
/*!40000 ALTER TABLE `GardenBeds` DISABLE KEYS */;
INSERT INTO `GardenBeds` VALUES (1,'Plot One','Part-Sun',24,'West'),(2,'Plot Two','Shade',20,'North'),(3,'Plot Three','Sun',30,'East');
/*!40000 ALTER TABLE `GardenBeds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Harvests`
--

DROP TABLE IF EXISTS `Harvests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Harvests` (
  `harvest_id` int(11) NOT NULL AUTO_INCREMENT,
  `plant_id` int(11) NOT NULL,
  `harvest_date` date NOT NULL,
  `harvest_quantity` decimal(6,2) NOT NULL,
  PRIMARY KEY (`harvest_id`),
  KEY `plant_id` (`plant_id`),
  CONSTRAINT `Harvests_ibfk_1` FOREIGN KEY (`plant_id`) REFERENCES `Plants` (`plant_id`) ON DELETE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Harvests`
--

LOCK TABLES `Harvests` WRITE;
/*!40000 ALTER TABLE `Harvests` DISABLE KEYS */;
INSERT INTO `Harvests` VALUES (1,1,'2023-07-25',1.25),(2,2,'2023-08-10',0.20),(3,2,'2023-08-30',0.50);
/*!40000 ALTER TABLE `Harvests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Participants`
--

DROP TABLE IF EXISTS `Participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Participants` (
  `participant_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(145) NOT NULL,
  `last_name` varchar(145) NOT NULL,
  `age` int(11) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Participants`
--

LOCK TABLES `Participants` WRITE;
/*!40000 ALTER TABLE `Participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `Participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Plants`
--

DROP TABLE IF EXISTS `Plants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Plants` (
  `plant_id` int(11) NOT NULL AUTO_INCREMENT,
  `plant_name` varchar(100) NOT NULL,
  `date_planted` date NOT NULL,
  `drought_resistant` tinyint(1) NOT NULL,
  `garden_bed_id` int(11) DEFAULT NULL,
  `species_id` int(11) NOT NULL,
  PRIMARY KEY (`plant_id`),
  KEY `garden_bed_id` (`garden_bed_id`),
  KEY `species_id` (`species_id`),
  CONSTRAINT `Plants_ibfk_1` FOREIGN KEY (`garden_bed_id`) REFERENCES `GardenBeds` (`garden_bed_id`) ON DELETE CASCADE,
  CONSTRAINT `Plants_ibfk_2` FOREIGN KEY (`species_id`) REFERENCES `Species` (`species_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Plants`
--

LOCK TABLES `Plants` WRITE;
/*!40000 ALTER TABLE `Plants` DISABLE KEYS */;
INSERT INTO `Plants` VALUES (1,'Roma','2024-05-01',0,3,1),(2,'Lunchbox','2024-04-15',1,3,4),(3,'Jewel','2024-04-20',0,1,2);
/*!40000 ALTER TABLE `Plants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Programs`
--

DROP TABLE IF EXISTS `Programs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Programs` (
  `program_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(145) NOT NULL,
  `capacity` int(11) NOT NULL,
  `location` varchar(145) NOT NULL,
  `date_time` datetime NOT NULL,
  `Employee_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`program_id`),
  KEY `Employee_id` (`Employee_id`),
  CONSTRAINT `Programs_ibfk_1` FOREIGN KEY (`Employee_id`) REFERENCES `Employees` (`employee_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Programs`
--

LOCK TABLES `Programs` WRITE;
/*!40000 ALTER TABLE `Programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `Programs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Species`
--

DROP TABLE IF EXISTS `Species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Species` (
  `species_id` int(11) NOT NULL AUTO_INCREMENT,
  `species_name` varchar(100) NOT NULL,
  PRIMARY KEY (`species_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Species`
--

LOCK TABLES `Species` WRITE;
/*!40000 ALTER TABLE `Species` DISABLE KEYS */;
INSERT INTO `Species` VALUES (1,'Tomato'),(2,'Corn'),(3,'Okra'),(4,'Sweet Pepper'),(5,'Sweet Potato');
/*!40000 ALTER TABLE `Species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diagnostic`
--

DROP TABLE IF EXISTS `diagnostic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnostic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostic`
--

LOCK TABLES `diagnostic` WRITE;
/*!40000 ALTER TABLE `diagnostic` DISABLE KEYS */;
INSERT INTO `diagnostic` VALUES (1,'MySQL is working for bremnere!');
/*!40000 ALTER TABLE `diagnostic` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-16 20:30:01
