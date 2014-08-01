CREATE DATABASE  IF NOT EXISTS `jms` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `jms`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win32 (x86)
--
-- Host: localhost    Database: jms
-- ------------------------------------------------------
-- Server version	5.6.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `ROLE` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `user_journal_role` (`JOURNAL_ID`,`ROLE`,`USER_ID`),
  KEY `FK_AUTHORITIES_USER_idx` (`USER_ID`),
  CONSTRAINT `FK_AUTHORITIES_USER` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES (8,3,0,'ROLE_SUPER_MANAGER'),(9,4,0,'ROLE_SUPER_MANAGER'),(27,5,0,'ROLE_SUPER_MANAGER'),(28,6,0,'ROLE_SUPER_MANAGER'),(1,1,0,'ROLE_USER'),(2,2,0,'ROLE_USER'),(3,3,0,'ROLE_USER'),(4,4,0,'ROLE_USER'),(23,5,0,'ROLE_USER'),(25,6,0,'ROLE_USER'),(15,3,1,'ROLE_A-EDITOR'),(16,4,1,'ROLE_A-EDITOR'),(58,5,1,'ROLE_A-EDITOR'),(160,6,1,'ROLE_A-EDITOR'),(171,6,1,'ROLE_B-MEMBER'),(11,3,1,'ROLE_C-EDITOR'),(12,4,1,'ROLE_C-EDITOR'),(48,5,1,'ROLE_C-EDITOR'),(181,6,1,'ROLE_C-EDITOR'),(13,3,1,'ROLE_G-EDITOR'),(14,4,1,'ROLE_G-EDITOR'),(51,5,1,'ROLE_G-EDITOR'),(161,6,1,'ROLE_G-EDITOR'),(10,3,1,'ROLE_MANAGER'),(6,4,1,'ROLE_MANAGER'),(42,5,1,'ROLE_MANAGER'),(43,6,1,'ROLE_MANAGER'),(7,3,1,'ROLE_MEMBER'),(5,4,1,'ROLE_MEMBER'),(41,5,1,'ROLE_MEMBER'),(44,6,1,'ROLE_MEMBER'),(17,3,1,'ROLE_REVIEWER'),(18,4,1,'ROLE_REVIEWER'),(66,5,1,'ROLE_REVIEWER'),(64,6,1,'ROLE_REVIEWER'),(31,3,2,'ROLE_A-EDITOR'),(37,4,2,'ROLE_A-EDITOR'),(57,5,2,'ROLE_A-EDITOR'),(55,6,2,'ROLE_A-EDITOR'),(29,3,2,'ROLE_C-EDITOR'),(39,4,2,'ROLE_C-EDITOR'),(47,5,2,'ROLE_C-EDITOR'),(50,6,2,'ROLE_C-EDITOR'),(30,3,2,'ROLE_G-EDITOR'),(38,4,2,'ROLE_G-EDITOR'),(52,5,2,'ROLE_G-EDITOR'),(54,6,2,'ROLE_G-EDITOR'),(22,3,2,'ROLE_MANAGER'),(40,4,2,'ROLE_MANAGER'),(45,5,2,'ROLE_MANAGER'),(46,6,2,'ROLE_MANAGER'),(132,1,2,'ROLE_MEMBER'),(134,2,2,'ROLE_MEMBER'),(21,3,2,'ROLE_MEMBER'),(35,4,2,'ROLE_MEMBER'),(24,5,2,'ROLE_MEMBER'),(26,6,2,'ROLE_MEMBER'),(133,1,2,'ROLE_REVIEWER'),(135,2,2,'ROLE_REVIEWER'),(33,3,2,'ROLE_REVIEWER'),(34,4,2,'ROLE_REVIEWER'),(65,5,2,'ROLE_REVIEWER'),(63,6,2,'ROLE_REVIEWER');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `NAME` varchar(10) NOT NULL,
  `UPPER_CATEGORY` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=315 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'0.1',0),(2,'0.2',0),(3,'0.3',0),(4,'0.4',0),(5,'0.5',0),(6,'0.6',0),(7,'0.7',0),(8,'0.8',0),(9,'0.9',0),(10,'0.10',0),(11,'0.11',0),(12,'0.12',0),(13,'0.13',0),(14,'0.14',0),(15,'0.15',0),(16,'0.16',0),(17,'0.17',0),(18,'1.1',1),(19,'1.2',1),(20,'1.3',1),(21,'1.4',1),(22,'1.5',1),(23,'1.6',1),(24,'1.7',1),(25,'1.8',1),(26,'1.9',1),(27,'1.10',1),(28,'1.11',1),(29,'1.12',1),(30,'1.13',1),(31,'1.14',1),(32,'1.15',1),(33,'1.16',1),(34,'1.17',1),(35,'1.18',1),(36,'1.19',1),(37,'1.20',1),(38,'2.1',2),(39,'2.2',2),(40,'2.3',2),(41,'2.4',2),(42,'2.5',2),(43,'2.6',2),(44,'2.7',2),(45,'2.8',2),(46,'2.9',2),(47,'2.10',2),(48,'2.11',2),(49,'2.12',2),(50,'2.13',2),(51,'2.14',2),(52,'2.15',2),(53,'2.16',2),(54,'2.17',2),(55,'2.18',2),(56,'2.19',2),(57,'2.20',2),(58,'2.21',2),(59,'2.22',2),(60,'2.23',2),(61,'2.24',2),(62,'2.25',2),(63,'2.26',2),(64,'2.27',2),(65,'2.28',2),(66,'2.29',2),(67,'2.30',2),(68,'2.31',2),(69,'2.32',2),(70,'2.33',2),(71,'2.34',2),(72,'2.35',2),(73,'2.36',2),(74,'2.37',2),(75,'2.38',2),(76,'2.39',2),(77,'2.40',2),(78,'2.41',2),(79,'2.42',2),(80,'2.43',2),(81,'2.44',2),(82,'2.45',2),(83,'2.46',2),(84,'2.47',2),(85,'2.48',2),(86,'2.49',2),(87,'2.50',2),(88,'2.51',2),(89,'2.52',2),(90,'2.53',2),(91,'2.54',2),(92,'2.55',2),(93,'2.56',2),(94,'2.57',2),(95,'2.58',2),(96,'2.59',2),(97,'3.1',3),(98,'3.2',3),(99,'3.3',3),(100,'3.4',3),(101,'3.5',3),(102,'3.6',3),(103,'3.7',3),(104,'3.8',3),(105,'3.9',3),(106,'3.10',3),(107,'3.11',3),(108,'3.12',3),(109,'3.13',3),(110,'3.14',3),(111,'3.15',3),(112,'3.16',3),(113,'3.17',3),(114,'3.18',3),(115,'3.19',3),(116,'3.20',3),(117,'3.21',3),(118,'3.22',3),(119,'3.23',3),(120,'3.24',3),(121,'3.25',3),(122,'3.26',3),(123,'3.27',3),(124,'3.28',3),(125,'3.29',3),(126,'3.30',3),(127,'3.31',3),(128,'3.32',3),(129,'3.33',3),(130,'3.34',3),(131,'3.35',3),(132,'3.36',3),(133,'3.37',3),(134,'3.38',3),(135,'3.39',3),(136,'3.40',3),(137,'3.41',3),(138,'3.42',3),(139,'3.43',3),(140,'3.44',3),(141,'3.45',3),(142,'3.46',3),(143,'3.47',3),(144,'3.48',3),(145,'3.49',3),(146,'3.50',3),(147,'3.51',3),(148,'3.52',3),(149,'3.53',3),(150,'3.54',3),(151,'3.55',3),(152,'3.56',3),(153,'3.57',3),(154,'3.58',3),(155,'3.59',3),(156,'3.60',3),(157,'3.61',3),(158,'3.62',3),(159,'3.63',3),(160,'3.64',3),(161,'3.65',3),(162,'3.66',3),(163,'3.67',3),(164,'3.68',3),(165,'3.69',3),(166,'3.70',3),(167,'3.71',3),(168,'3.72',3),(169,'4.1',4),(170,'4.2',4),(171,'4.3',4),(172,'4.4',4),(173,'4.5',4),(174,'4.6',4),(175,'4.7',4),(176,'4.8',4),(177,'4.9',4),(178,'4.10',4),(179,'4.11',4),(180,'4.12',4),(181,'4.13',4),(182,'4.14',4),(183,'4.15',4),(184,'4.16',4),(185,'4.17',4),(186,'4.18',4),(187,'4.19',4),(188,'4.20',4),(189,'4.21',4),(190,'4.22',4),(191,'4.23',4),(192,'4.24',4),(193,'4.25',4),(194,'4.26',4),(195,'4.27',4),(196,'4.28',4),(197,'5.1',5),(198,'5.2',5),(199,'5.3',5),(200,'5.4',5),(201,'5.5',5),(202,'5.6',5),(203,'5.7',5),(204,'5.8',5),(205,'5.9',5),(206,'5.10',5),(207,'5.11',5),(208,'5.12',5),(209,'5.13',5),(210,'5.14',5),(211,'5.15',5),(212,'5.16',5),(213,'5.17',5),(214,'5.18',5),(215,'5.19',5),(216,'5.20',5),(217,'5.21',5),(218,'5.22',5),(219,'5.23',5),(220,'5.24',5),(221,'5.25',5),(222,'5.26',5),(223,'5.27',5),(224,'5.28',5),(225,'5.29',5),(226,'5.30',5),(227,'5.31',5),(228,'5.32',5),(229,'5.33',5),(230,'5.34',5),(231,'5.35',5),(232,'5.36',5),(233,'5.37',5),(234,'5.38',5),(235,'5.39',5),(236,'5.40',5),(237,'5.41',5),(238,'6.1',6),(239,'6.2',6),(240,'6.3',6),(241,'6.4',6),(242,'6.5',6),(243,'6.6',6),(244,'6.7',6),(245,'6.8',6),(246,'6.9',6),(247,'6.10',6),(248,'6.11',6),(249,'6.12',6),(250,'6.13',6),(251,'6.14',6),(252,'6.15',6),(253,'6.16',6),(254,'6.17',6),(255,'6.18',6),(256,'6.19',6),(257,'6.20',6),(258,'6.21',6),(259,'6.22',6),(260,'6.23',6),(261,'6.24',6),(262,'6.25',6),(263,'6.26',6),(264,'7.1',7),(265,'7.2',7),(266,'7.3',7),(267,'7.4',7),(268,'7.5',7),(269,'7.6',7),(270,'7.7',7),(271,'7.8',7),(272,'7.9',7),(273,'7.10',7),(274,'7.11',7),(275,'7.12',7),(276,'7.13',7),(277,'7.14',7),(278,'7.15',7),(279,'7.16',7),(280,'7.17',7),(281,'7.18',7),(282,'7.19',7),(283,'7.20',7),(284,'7.21',7),(285,'7.22',7),(286,'7.23',7),(287,'7.24',7),(288,'7.25',7),(289,'7.26',7),(290,'7.27',7),(291,'7.28',7),(292,'7.29',7),(293,'7.30',7),(294,'7.31',7),(295,'7.32',7),(296,'7.33',7),(297,'7.34',7),(298,'7.35',7),(299,'7.36',7),(300,'7.37',7),(301,'7.38',7),(302,'7.39',7),(303,'7.40',7),(304,'7.41',7),(305,'7.42',7),(306,'7.43',7),(307,'7.44',7),(308,'7.45',7),(309,'7.46',7),(310,'7.47',7),(311,'7.48',7),(312,'7.49',7),(313,'7.50',7),(314,'7.51',7);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `change_password_code`
--

DROP TABLE IF EXISTS `change_password_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `change_password_code` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `EMAIL` varchar(100) NOT NULL DEFAULT '',
  `MASKCODE` varchar(50) NOT NULL DEFAULT '',
  `REGISTER_DATE` date DEFAULT NULL,
  `EXPIRATION_DATE` date DEFAULT NULL,
  `EXPIRED` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_password_code`
--

LOCK TABLES `change_password_code` WRITE;
/*!40000 ALTER TABLE `change_password_code` DISABLE KEYS */;
/*!40000 ALTER TABLE `change_password_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contacts` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `FIRST_NAME` varchar(30) DEFAULT NULL,
  `LAST_NAME` varchar(20) DEFAULT NULL,
  `LOCAL_FULL_NAME` varchar(40) DEFAULT NULL,
  `DEGREE` int(2) NOT NULL DEFAULT '-1',
  `SALUTATION` int(2) NOT NULL DEFAULT '0',
  `INSTITUTION` varchar(300) NOT NULL,
  `DEPARTMENT` varchar(100) DEFAULT NULL,
  `LOCAL_INSTITUTION` varchar(70) DEFAULT NULL,
  `LOCAL_DEPARTMENT` varchar(70) DEFAULT NULL,
  `COUNTRY_CODE` char(2) NOT NULL,
  `PHONE` varchar(45) DEFAULT NULL,
  `MOBILE` varchar(45) DEFAULT NULL,
  `FAX` varchar(45) DEFAULT NULL,
  `WEBSITE` varchar(100) DEFAULT NULL,
  `POSITION` varchar(100) DEFAULT NULL,
  `ABOUT` varchar(1000) DEFAULT NULL,
  `LOCAL_JOB_TITLE` int(2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CONTACTS_USER` (`USER_ID`),
  CONSTRAINT `FK_CONTACTS_USER` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,1,'MANUSCRIPT','LINK','',0,0,'MANUSCRIPTLINK','','','','KR','','','','','','',NULL),(2,2,'MANUSCRIPT','LINK','',0,0,'MANUSCRIPTLINK','','','','KR','','','','','','',NULL),(3,3,'Youn-Hee','Han','한연희',0,0,'MANUSCRIPTLINK','','','','KR','','','','','','',1),(4,4,'Chan-Myung','Kim','김찬명',1,2,'MANUSCRIPTLINK','MANUSCRIPTLINK','MANUSCRIPTLINK','ggggd','KR','+1 518 227 8265','','','','','',3),(5,5,'Dong-Sun','Yang','양동선',2,2,'MANUSCRIPTLINK','Department of Electronic Engineering','MANUSCRIPTLINK','','KR','','','','','','',9),(6,6,'SeungIl','Hyeon','현승일',2,2,'MANUSCRIPTLINK','ee','MANUSCRIPTLINK','bbbb','KR','','','','','','fff',5);
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `ALPHA2` char(2) DEFAULT NULL,
  `NAME` varchar(64) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES ('AF','Afghanistan'),('AL','Albania'),('DZ','Algeria'),('AS','American Samoa'),('AD','Andorra'),('AO','Angola'),('AI','Anguilla'),('AQ','Antarctica'),('AR','Argentina'),('AM','Armenia'),('AW','Aruba'),('AU','Australia'),('AT','Austria'),('AZ','Azerbaijan'),('BS','Bahamas'),('BH','Bahrain'),('BD','Bangladesh'),('BB','Barbados'),('BY','Belarus'),('BE','Belgium'),('BZ','Belize'),('BJ','Benin'),('BM','Bermuda'),('BT','Bhutan'),('BO','Bolivia'),('BA','Bosnia and Herzegowina'),('BW','Botswana'),('BV','Bouvet Island'),('BR','Brazil'),('IO','British Indian Ocean Territory'),('BN','Brunei Darussalam'),('BG','Bulgaria'),('BF','Burkina Faso'),('BI','Burundi'),('KH','Cambodia'),('CM','Cameroon'),('CA','Canada'),('CV','Cape Verde'),('KY','Cayman Islands'),('CF','Central African Republic'),('TD','Chad'),('CL','Chile'),('CN','China'),('CX','Christmas Island'),('CC','Cocos (Keeling) Islands'),('CO','Colombia'),('KM','Comoros'),('CG','Congo'),('CD','Congo, the Democratic Republic of the'),('CK','Cook Islands'),('CR','Costa Rica'),('CI','Cote d\'Ivoire'),('HR','Croatia (Hrvatska)'),('CU','Cuba'),('CY','Cyprus'),('CZ','Czech Republic'),('DK','Denmark'),('DJ','Djibouti'),('DM','Dominica'),('DO','Dominican Republic'),('EC','Ecuador'),('EG','Egypt'),('SV','El Salvador'),('GQ','Equatorial Guinea'),('ER','Eritrea'),('EE','Estonia'),('ET','Ethiopia'),('FK','Falkland Islands (Malvinas)'),('FO','Faroe Islands'),('FJ','Fiji'),('FI','Finland'),('FR','France'),('GF','French Guiana'),('PF','French Polynesia'),('TF','French Southern Territories'),('GA','Gabon'),('GM','Gambia'),('GE','Georgia'),('DE','Germany'),('GH','Ghana'),('GI','Gibraltar'),('GR','Greece'),('GL','Greenland'),('GD','Grenada'),('GP','Guadeloupe'),('GU','Guam'),('GT','Guatemala'),('GN','Guinea'),('GW','Guinea-Bissau'),('GY','Guyana'),('HT','Haiti'),('HM','Heard and Mc Donald Islands'),('VA','Holy See (Vatican City State)'),('HN','Honduras'),('HK','Hong Kong'),('HU','Hungary'),('IS','Iceland'),('IN','India'),('ID','Indonesia'),('IR','Iran (Islamic Republic of)'),('IQ','Iraq'),('IE','Ireland'),('IL','Israel'),('IT','Italy'),('JM','Jamaica'),('JP','Japan'),('JO','Jordan'),('KZ','Kazakhstan'),('KE','Kenya'),('KI','Kiribati'),('KP','Korea, Democratic People\'s Republic of'),('KR','Korea, Republic of'),('KW','Kuwait'),('KG','Kyrgyzstan'),('LA','Lao People\'s Democratic Republic'),('LV','Latvia'),('LB','Lebanon'),('LS','Lesotho'),('LR','Liberia'),('LY','Libyan Arab Jamahiriya'),('LI','Liechtenstein'),('LT','Lithuania'),('LU','Luxembourg'),('MO','Macau'),('MK','Macedonia, The Former Yugoslav Republic of'),('MG','Madagascar'),('MW','Malawi'),('MY','Malaysia'),('MV','Maldives'),('ML','Mali'),('MT','Malta'),('MH','Marshall Islands'),('MQ','Martinique'),('MR','Mauritania'),('MU','Mauritius'),('YT','Mayotte'),('MX','Mexico'),('FM','Micronesia, Federated States of'),('MD','Moldova, Republic of'),('MC','Monaco'),('MN','Mongolia'),('MS','Montserrat'),('MA','Morocco'),('MZ','Mozambique'),('MM','Myanmar'),('NA','Namibia'),('NR','Nauru'),('NP','Nepal'),('NL','Netherlands'),('AN','Netherlands Antilles'),('NC','New Caledonia'),('NZ','New Zealand'),('NI','Nicaragua'),('NE','Niger'),('NG','Nigeria'),('NU','Niue'),('NF','Norfolk Island'),('MP','Northern Mariana Islands'),('NO','Norway'),('OM','Oman'),('PK','Pakistan'),('PW','Palau'),('PA','Panama'),('PG','Papua New Guinea'),('PY','Paraguay'),('PE','Peru'),('PH','Philippines'),('PN','Pitcairn'),('PL','Poland'),('PT','Portugal'),('PR','Puerto Rico'),('QA','Qatar'),('RE','Reunion'),('RO','Romania'),('RU','Russian Federation'),('RW','Rwanda'),('KN','Saint Kitts and Nevis'),('LC','Saint LUCIA'),('VC','Saint Vincent and the Grenadines'),('WS','Samoa'),('SM','San Marino'),('ST','Sao Tome and Principe'),('SA','Saudi Arabia'),('SN','Senegal'),('SC','Seychelles'),('SL','Sierra Leone'),('SG','Singapore'),('SK','Slovakia (Slovak Republic)'),('SI','Slovenia'),('SB','Solomon Islands'),('SO','Somalia'),('ZA','South Africa'),('GS','South Georgia and the South Sandwich Islands'),('ES','Spain'),('LK','Sri Lanka'),('SH','St. Helena'),('PM','St. Pierre and Miquelon'),('SD','Sudan'),('SR','Suriname'),('SJ','Svalbard and Jan Mayen Islands'),('SZ','Swaziland'),('SE','Sweden'),('CH','Switzerland'),('SY','Syrian Arab Republic'),('TW','Taiwan, Province of China'),('TJ','Tajikistan'),('TZ','Tanzania, United Republic of'),('TH','Thailand'),('TG','Togo'),('TK','Tokelau'),('TO','Tonga'),('TT','Trinidad and Tobago'),('TN','Tunisia'),('TR','Turkey'),('TM','Turkmenistan'),('TC','Turks and Caicos Islands'),('TV','Tuvalu'),('UG','Uganda'),('UA','Ukraine'),('AE','United Arab Emirates'),('GB','United Kingdom'),('US','United States'),('UM','United States Minor Outlying Islands'),('UY','Uruguay'),('UZ','Uzbekistan'),('VU','Vanuatu'),('VE','Venezuela'),('VN','Viet Nam'),('VG','Virgin Islands (British)'),('VI','Virgin Islands (U.S.)'),('WF','Wallis and Futuna Islands'),('EH','Western Sahara'),('YE','Yemen'),('ZM','Zambia'),('ZW','Zimbabwe');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `divisions`
--

DROP TABLE IF EXISTS `divisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `divisions` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `NAME` varchar(300) DEFAULT NULL,
  `SYMBOL` varchar(3) DEFAULT NULL,
  `DESCRIPTION` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_DIVISIONS1` (`JOURNAL_ID`),
  CONSTRAINT `FK_DIVISIONS1` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `divisions`
--

LOCK TABLES `divisions` WRITE;
/*!40000 ALTER TABLE `divisions` DISABLE KEYS */;
INSERT INTO `divisions` VALUES (1,1,'COMPUTER SYSTEM AND THEORY','A','Computational Theory, Algorithm Theory, Grid/Clustering Computing, Middleware, Multimedia Theory (Synchronization Indexing, Compacting), Parallel/Distributed Processing Theory, Computer System Applications. '),(2,1,'MULTIMEDIA SYSTEM AND GRAPHICS','B','Artificial Intelligence, Image Processing, Voice Processing, Natural Language Processing, Multimedia, Human Computer Interface, Pattern Recognition, Computer Graphics, Semantic Web, Web Services.'),(3,1,'COMMUNICATION SYSTEM AND SECURITY','C','Internet Computing, Network Systems and Devices, Wireless/Ad-hoc/Sensor Networks, Network Modeling and Simulation, Network Management Techniques, Telecommunications, Communication Protocols, Transmission Techniques, Communication Systems, Digital Rights Management, Security, Encryption and Cryptography, Compression and Coding. '),(4,1,'INFORMATION SYSTEM AND APPLICATION','D','Database, Software Engineering, E-commerce, Data Mining, Information Retrieval, Computer Education. ');
/*!40000 ALTER TABLE `divisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_delivery`
--

DROP TABLE IF EXISTS `email_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_delivery` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `SENDER_USER_ID` int(32) unsigned NOT NULL,
  `RECEIVER_USER_ID` int(32) unsigned DEFAULT NULL,
  `DATE` date NOT NULL,
  `TIME` time NOT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `MANUSCRIPT_ID` int(32) unsigned DEFAULT NULL,
  `MESSAGE_ID` int(32) unsigned NOT NULL,
  `IS_CC` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FK_EMAIL_DELIVERY_TO_idx` (`RECEIVER_USER_ID`),
  KEY `FK_EMAIL_DELIVERY_JOURNAL_ID_idx` (`JOURNAL_ID`),
  KEY `FK_EMAIL_DELIVERY_MANUSCRIPT_ID_idx` (`MANUSCRIPT_ID`),
  KEY `FK_EMAIL_DELIVERY_MESSAGE_ID_idx` (`MESSAGE_ID`),
  CONSTRAINT `FK_EMAIL_DELIVERY_MESSAGE_ID` FOREIGN KEY (`MESSAGE_ID`) REFERENCES `email_messages` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_EMAIL_DELIVERY_TO` FOREIGN KEY (`RECEIVER_USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1079 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_delivery`
--

LOCK TABLES `email_delivery` WRITE;
/*!40000 ALTER TABLE `email_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_messages`
--

DROP TABLE IF EXISTS `email_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_messages` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `SUBJECT` varchar(800) NOT NULL,
  `BODY` varchar(8000) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=718 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_messages`
--

LOCK TABLES `email_messages` WRITE;
/*!40000 ALTER TABLE `email_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_editors_special_issues`
--

DROP TABLE IF EXISTS `guest_editors_special_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guest_editors_special_issues` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `SPECIAL_ISSUE_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `USER_SPECIAL_ISSUES_FK2_idx` (`JOURNAL_ID`),
  KEY `USER_SPECIAL_ISSUES_FK3_idx` (`SPECIAL_ISSUE_ID`),
  KEY `USER_SPECIAL_ISSUES_FK1_idx` (`USER_ID`),
  CONSTRAINT `USER_SPECIAL_ISSUES_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `USER_SPECIAL_ISSUES_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `USER_SPECIAL_ISSUES_FK3` FOREIGN KEY (`SPECIAL_ISSUE_ID`) REFERENCES `special_issues` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_editors_special_issues`
--

LOCK TABLES `guest_editors_special_issues` WRITE;
/*!40000 ALTER TABLE `guest_editors_special_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `guest_editors_special_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_associate_editors`
--

DROP TABLE IF EXISTS `journal_associate_editors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_associate_editors` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `AUTHORITY_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JAE_UK1` (`JOURNAL_ID`,`USER_ID`,`AUTHORITY_ID`),
  KEY `A_FK1_idx` (`USER_ID`),
  KEY `A_FK2_idx` (`JOURNAL_ID`),
  KEY `A_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `A_FK1_C` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `A_FK2_C` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `A_FK3_C` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_associate_editors`
--

LOCK TABLES `journal_associate_editors` WRITE;
/*!40000 ALTER TABLE `journal_associate_editors` DISABLE KEYS */;
INSERT INTO `journal_associate_editors` VALUES (1,3,1,15),(2,4,1,16),(8,5,1,58),(3,3,2,31),(4,4,2,37),(7,5,2,57),(5,6,2,55);
/*!40000 ALTER TABLE `journal_associate_editors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_board_members`
--

DROP TABLE IF EXISTS `journal_board_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_board_members` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `AUTHORITY_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JBM_UK1` (`JOURNAL_ID`,`USER_ID`,`AUTHORITY_ID`),
  KEY `BM_FK1_idx` (`USER_ID`),
  KEY `BM_FK2_idx` (`JOURNAL_ID`),
  KEY `BM_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `BM_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BM_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BM_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_board_members`
--

LOCK TABLES `journal_board_members` WRITE;
/*!40000 ALTER TABLE `journal_board_members` DISABLE KEYS */;
INSERT INTO `journal_board_members` VALUES (9,6,1,171);
/*!40000 ALTER TABLE `journal_board_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_categories`
--

DROP TABLE IF EXISTS `journal_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_categories` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `NAME` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `JC_FK1_idx` (`JOURNAL_ID`),
  CONSTRAINT `JCT_FK1` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_categories`
--

LOCK TABLES `journal_categories` WRITE;
/*!40000 ALTER TABLE `journal_categories` DISABLE KEYS */;
INSERT INTO `journal_categories` VALUES (193,1,'0.3'),(194,1,'0.6'),(195,1,'0.8'),(196,1,'0.10'),(200,2,'0.5'),(201,2,'0.9'),(202,2,'0.11');
/*!40000 ALTER TABLE `journal_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_chief_editors`
--

DROP TABLE IF EXISTS `journal_chief_editors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_chief_editors` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `AUTHORITY_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JCE_UK1` (`USER_ID`,`JOURNAL_ID`,`AUTHORITY_ID`),
  KEY `CE_FK1_idx` (`USER_ID`),
  KEY `CE_FK2_idx` (`JOURNAL_ID`),
  KEY `CE_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `CE_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CE_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CE_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_chief_editors`
--

LOCK TABLES `journal_chief_editors` WRITE;
/*!40000 ALTER TABLE `journal_chief_editors` DISABLE KEYS */;
INSERT INTO `journal_chief_editors` VALUES (1,3,1,11),(3,3,2,29),(2,4,1,12),(4,4,2,39),(6,5,1,48),(5,5,2,47),(12,6,1,181),(8,6,2,50);
/*!40000 ALTER TABLE `journal_chief_editors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_configuration`
--

DROP TABLE IF EXISTS `journal_configuration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_configuration` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `SETUP_STEP` int(11) NOT NULL DEFAULT '-1',
  `CHANGE_AUTHOR` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CHANGE_KEYWORD` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CHANGE_DIVISION` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CHANGE_INVITED` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CHANGE_RP` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `CHANGE_ADDITIONAL_FILES` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `REVIEW_COMPLETE_COUNT` int(11) NOT NULL,
  `REVIEW_DUE_DURATION` int(11) NOT NULL,
  `ASSIGN_REMIND_DURATION` int(11) NOT NULL,
  `ASSIGN_CANCEL_DURATION` int(11) NOT NULL,
  `INVITE_REMIND_DURATION` int(11) NOT NULL,
  `INVITE_CANCEL_DURATION` int(11) NOT NULL,
  `RESUBMIT_DURATION` int(11) NOT NULL,
  `CAMERA_SUBMIT_DURATION` int(11) NOT NULL,
  `GENTLE_REMIND_REVIEWER` int(11) NOT NULL,
  `GENTLE_REMIND_RESUBMIT` int(11) NOT NULL,
  `GENTLE_REMIND_CAMERA_SUBMIT` int(11) NOT NULL,
  `REMIND_REVIEWER` int(11) NOT NULL,
  `REMIND_RESUBMIT` int(11) NOT NULL,
  `REMIND_CAMERA_SUBMIT` int(11) NOT NULL,
  `FRONT_COVER_URL` varchar(450) DEFAULT NULL,
  `CHECKLIST_URL` varchar(450) DEFAULT NULL,
  `CAMERA_TEMPLATE_URL` varchar(200) DEFAULT NULL,
  `COPYRIGHT_URL` varchar(200) DEFAULT NULL,
  `NUM_CONFIRMS` int(11) DEFAULT NULL,
  `CONFIRM1` varchar(450) DEFAULT NULL,
  `CONFIRM2` varchar(450) DEFAULT NULL,
  `CONFIRM3` varchar(450) DEFAULT NULL,
  `CONFIRM4` varchar(450) DEFAULT NULL,
  `CONFIRM5` varchar(450) DEFAULT NULL,
  `TEXT_BASIC_INFO` varchar(2000) DEFAULT NULL,
  `TEXT_COAUTHOR` varchar(2000) DEFAULT NULL,
  `TEXT_COVERLETTER` varchar(2000) DEFAULT NULL,
  `TEXT_RP` varchar(2000) DEFAULT NULL,
  `TEXT_FILES` varchar(2000) DEFAULT NULL,
  `NUM_REVIEW_ITEMS` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID1` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID2` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID3` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID4` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID5` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID6` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID7` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID8` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID9` int(11) DEFAULT NULL,
  `REVIEW_ITEM_ID10` int(11) DEFAULT NULL,
  `REVIEWER_VIEW_AUTHOR` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `REQUIRED_RUNNINGHEAD` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `REQUIRED_KEYWORD` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `REQUIRED_COVERLETTER` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `REQUIRED_RP` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `REQUIRED_ADDITIONAL_FILES` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `MANAGE_DIVISION` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `JC_FK1_idx` (`JOURNAL_ID`),
  CONSTRAINT `JC_FK1` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_configuration`
--

LOCK TABLES `journal_configuration` WRITE;
/*!40000 ALTER TABLE `journal_configuration` DISABLE KEYS */;
INSERT INTO `journal_configuration` VALUES (1,1,5,0,0,0,0,0,0,3,6,2,7,2,2,30,15,7,7,7,3,3,3,NULL,NULL,'http://www.manuscriptlink.com/journals/jips/download/template/cameraReadyTemplate','http://www.manuscriptlink.com/journals/jips/download/template/copyright',2,'Confirm that this paper has been submitted solely to this journal and is not published, in press, or submitted elsewhere.','I have prepared this paper in accordance with the journal\'s style and format requirements.',NULL,NULL,NULL,'','','','','',7,1,2,3,4,5,6,7,0,0,0,0,1,1,1,1,0,1),(2,2,-1,0,0,0,0,0,0,3,6,2,7,2,7,30,15,7,7,7,3,3,3,'http://www.manuscriptlink.com/journals/kips/download/template/frontCover','http://www.manuscriptlink.com/journals/kips/download/template/checkList','http://www.manuscriptlink.com/journals/kips/download/template/cameraReadyTemplate','http://www.manuscriptlink.com/journals/kips/download/template/copyright',2,'test111','test222',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,1,2,3,4,5,0,0,0,0,0,0,0,0,0,0,0,0);
/*!40000 ALTER TABLE `journal_configuration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_guest_editors`
--

DROP TABLE IF EXISTS `journal_guest_editors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_guest_editors` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `AUTHORITY_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JGE_UK1` (`JOURNAL_ID`,`USER_ID`,`AUTHORITY_ID`),
  KEY `GE_FK1_idx` (`USER_ID`),
  KEY `GE_FK2_idx` (`JOURNAL_ID`),
  KEY `GE_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `GE_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GE_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GE_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_guest_editors`
--

LOCK TABLES `journal_guest_editors` WRITE;
/*!40000 ALTER TABLE `journal_guest_editors` DISABLE KEYS */;
/*!40000 ALTER TABLE `journal_guest_editors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_managers`
--

DROP TABLE IF EXISTS `journal_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_managers` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `AUTHORITY_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JM_UK1` (`USER_ID`,`JOURNAL_ID`,`AUTHORITY_ID`),
  KEY `JM_FK1_idx` (`USER_ID`),
  KEY `JM_FK2_idx` (`JOURNAL_ID`),
  KEY `JM_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `JM_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JM_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JM_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_managers`
--

LOCK TABLES `journal_managers` WRITE;
/*!40000 ALTER TABLE `journal_managers` DISABLE KEYS */;
INSERT INTO `journal_managers` VALUES (2,3,1,10),(3,3,2,22),(1,4,1,6),(4,4,2,40),(5,5,1,42),(7,5,2,45),(6,6,1,43),(8,6,2,46);
/*!40000 ALTER TABLE `journal_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_members`
--

DROP TABLE IF EXISTS `journal_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_members` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `AUTHORITY_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JM_UK1_idx` (`USER_ID`,`JOURNAL_ID`,`AUTHORITY_ID`),
  KEY `FK_JOURNAL_MEMBER_JOURANLS` (`JOURNAL_ID`),
  KEY `FK_JOURNAL_MEMBER_USERS` (`USER_ID`),
  KEY `FK_JOURNAL_MEMBER_AUTHORITIES` (`AUTHORITY_ID`),
  CONSTRAINT `FK_JOURNAL_MEMBER_AUTHORITIES_C` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_JOURNAL_MEMBER_JOURANLS_C` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_JOURNAL_MEMBER_USERS_C` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_members`
--

LOCK TABLES `journal_members` WRITE;
/*!40000 ALTER TABLE `journal_members` DISABLE KEYS */;
INSERT INTO `journal_members` VALUES (21,1,2,132),(22,2,2,134),(2,3,1,7),(3,3,2,21),(1,4,1,5),(6,4,2,35),(7,5,1,41),(4,5,2,24),(8,6,1,44),(5,6,2,26);
/*!40000 ALTER TABLE `journal_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_reviewers`
--

DROP TABLE IF EXISTS `journal_reviewers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_reviewers` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `AUTHORITY_ID` int(32) unsigned NOT NULL,
  `INVITED_UP_TO_NOW` int(32) DEFAULT '0',
  `ASSIGNED_UP_TO_NOW` int(32) DEFAULT '0',
  `COMPLETED_UP_TO_NOW` int(32) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `JR_UK1_idx` (`USER_ID`,`JOURNAL_ID`,`AUTHORITY_ID`),
  KEY `JR_FK1_idx` (`USER_ID`),
  KEY `JR_FK2_idx` (`JOURNAL_ID`),
  KEY `JR_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `JR_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JR_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JR_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_reviewers`
--

LOCK TABLES `journal_reviewers` WRITE;
/*!40000 ALTER TABLE `journal_reviewers` DISABLE KEYS */;
INSERT INTO `journal_reviewers` VALUES (1,3,1,17,0,0,0),(2,4,1,18,0,0,0),(3,3,2,33,0,0,0),(4,4,2,34,0,0,0),(5,6,2,63,0,0,0),(6,6,1,64,0,0,0),(7,5,2,65,0,0,0),(8,5,1,66,0,0,0),(20,1,2,133,0,0,0),(21,2,2,135,0,0,0);
/*!40000 ALTER TABLE `journal_reviewers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_uploaded_files`
--

DROP TABLE IF EXISTS `journal_uploaded_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_uploaded_files` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `NAME` varchar(450) DEFAULT NULL,
  `DESIGNATION` varchar(450) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `TIME` time DEFAULT NULL,
  `ABSOLUTE_PATH` varchar(1000) NOT NULL,
  `ORIGINAL_NAME` varchar(450) DEFAULT NULL,
  `PATH` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `JU_FK1_idx` (`USER_ID`),
  KEY `JU_FK2_idx` (`JOURNAL_ID`),
  CONSTRAINT `JU_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JU_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_uploaded_files`
--

LOCK TABLES `journal_uploaded_files` WRITE;
/*!40000 ALTER TABLE `journal_uploaded_files` DISABLE KEYS */;
INSERT INTO `journal_uploaded_files` VALUES (103,4,2,'frontCover2319820416058817759Centroid_based_Movement_Assisted_Sensor_Deployment_Schemes.pdf','frontCover','2014-06-14','08:41:09','C:\\var\\jms\\kips\\template\\frontCover\\frontCover2319820416058817759Centroid_based_Movement_Assisted_Sensor_Deployment_Schemes.pdf','Centroid_based_Movement_Assisted_Sensor_Deployment_Schemes.pdf',NULL),(104,4,2,'checkList9051701133938541801Mobile_sensor_network_deployment_using_potential_fields.pdf','checkList','2014-06-14','08:41:17','C:\\var\\jms\\kips\\template\\checkList\\checkList9051701133938541801Mobile_sensor_network_deployment_using_potential_fields.pdf','Mobile sensor network deployment using potential fields.pdf',NULL),(127,4,2,'cameraReadyTemplate5262639317502697874Connectivity-Guaranteed_and_Obstacle-Adaptive_Deployment_Schemes_for_Mobile_Sensor_Networks.pdf','cameraReadyTemplate','2014-06-16','02:08:10','C:\\var\\jms\\kips\\template\\cameraReadyTemplate\\cameraReadyTemplate5262639317502697874Connectivity-Guaranteed_and_Obstacle-Adaptive_Deployment_Schemes_for_Mobile_Sensor_Networks.pdf','Connectivity-Guaranteed and Obstacle-Adaptive Deployment Schemes for Mobile Sensor Networks.pdf',NULL),(128,4,2,'copyright6942374655108557011Distributed_Deployment_Schemes_for_Mobile_Wireless_Sensor_Networks_to_Ensure_Multilevel_Coverage.pdf','copyright','2014-06-16','02:08:12','C:\\var\\jms\\kips\\template\\copyright\\copyright6942374655108557011Distributed_Deployment_Schemes_for_Mobile_Wireless_Sensor_Networks_to_Ensure_Multilevel_Coverage.pdf','Distributed Deployment Schemes for Mobile Wireless Sensor Networks to Ensure Multilevel Coverage.pdf',NULL),(131,4,1,'cameraReadyTemplate_4047093611907856081.pdf','cameraReadyTemplate','2014-06-20','22:49:52','C:\\var\\jms\\jips\\template\\cameraReadyTemplate\\cameraReadyTemplate_4047093611907856081.pdf','cameraReadyTemplate_4047093611907856081.pdf',NULL),(132,4,1,'copyright_7846501528512161348.pdf','copyright','2014-06-20','22:49:55','C:\\var\\jms\\jips\\template\\copyright\\copyright_7846501528512161348.pdf','copyright_7846501528512161348.pdf',NULL);
/*!40000 ALTER TABLE `journal_uploaded_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journals` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `ENABLED` tinyint(1) DEFAULT '0',
  `PAID` tinyint(1) DEFAULT '0',
  `TYPE` char(1) DEFAULT NULL,
  `CREATOR_ID` int(32) unsigned NOT NULL,
  `JOURNAL_NAME_ID` varchar(20) DEFAULT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `SHORT_TITLE` varchar(100) DEFAULT NULL,
  `HOMEPAGE` varchar(200) DEFAULT NULL,
  `ORGANIZATION` varchar(300) DEFAULT NULL,
  `LANGUAGE_CODE` char(2) DEFAULT NULL,
  `PUBLISHER_COUNTRY_CODE` char(2) DEFAULT NULL,
  `REGISTERED_DATE` date DEFAULT NULL,
  `REGISTERED_TIME` time DEFAULT NULL,
  `COVER_IMAGE_FILENAME` varchar(128) DEFAULT NULL,
  `ABOUT` varchar(1000) DEFAULT NULL,
  `ISSN` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_JOURNALS_USERS` (`CREATOR_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
INSERT INTO `journals` VALUES (1,1,1,'A',4,'jips','Journal of Information Processing System','JIPS','http://jips-k.org','KIPS','en','KR','2014-05-15','03:32:49','r-24cf1796-535d-410a-80ca-14381b860d9c.png',NULL,NULL),(2,1,1,'A',3,'kips','한국정보처리논문지','정보처리논문지','http://www.kips.or.kr/board/sub_01.asp?bid=tissue','한국정보처리학회','ko','KR','2014-05-18','02:09:12','r-8177595d-a663-46e2-9a26-18278b01f09a.jpg',NULL,NULL),(10,0,0,'C',4,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts`
--

DROP TABLE IF EXISTS `manuscripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `SUBMIT_ID` varchar(45) DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `USER_ID` int(32) unsigned NOT NULL,
  `TYPE_ID` int(11) unsigned NOT NULL DEFAULT '0',
  `TRACK_ID` int(11) unsigned NOT NULL DEFAULT '0',
  `STATUS` varchar(1) DEFAULT NULL,
  `TITLE` varchar(500) DEFAULT NULL,
  `SPECIAL_ISSUE_ID` int(10) unsigned NOT NULL DEFAULT '0',
  `INVITE` tinyint(1) DEFAULT '0',
  `COVERLETTER` varchar(4000) DEFAULT NULL,
  `DIVISION_ID` int(11) DEFAULT NULL,
  `SUBMIT_STEP` int(10) DEFAULT NULL,
  `REVISION_COUNT` int(10) unsigned DEFAULT '0',
  `RUNNINGHEAD` varchar(200) DEFAULT NULL,
  `ABSTRACT` varchar(4000) DEFAULT NULL,
  `MANAGER_USER_ID` int(32) unsigned DEFAULT NULL,
  `GE_USER_ID` int(32) unsigned DEFAULT NULL,
  `AE_USER_ID` int(32) unsigned DEFAULT NULL,
  `CHIEF_USER_ID` int(32) unsigned DEFAULT NULL,
  `AE_ASSIGN_DATE` date DEFAULT NULL,
  `AE_ASSIGN_TIME` time DEFAULT NULL,
  `CONFIRM1` tinyint(1) DEFAULT '0',
  `CONFIRM2` tinyint(1) DEFAULT '0',
  `CONFIRM3` tinyint(1) unsigned DEFAULT NULL,
  `CONFIRM4` tinyint(1) unsigned DEFAULT NULL,
  `CONFIRM5` tinyint(1) unsigned DEFAULT NULL,
  `EDITOR_STATUS` varchar(3) DEFAULT NULL,
  `CAMERA_READY_REVISION` int(10) unsigned DEFAULT '0',
  `GALLERY_PROOF_REVISION` int(10) unsigned DEFAULT '0',
  `CAMERA_READY_CONFIRM` tinyint(1) unsigned DEFAULT '0',
  `GALLERY_PROOF_CONFIRM` tinyint(1) unsigned DEFAULT '0',
  `DUE_DATE_EXTEND_REQUEST` tinyint(1) unsigned DEFAULT '0',
  `REVISION_DUE_DATE` date DEFAULT NULL,
  `REVISION_DUE_TIME` time DEFAULT NULL,
  `CAMERA_DUE_DATE` date DEFAULT NULL,
  `CAMERA_DUE_TIME` time DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `INDEX_ID` (`ID`),
  KEY `INDEX_USER_ID` (`USER_ID`),
  KEY `M_FK1_idx` (`JOURNAL_ID`),
  KEY `M_FK2_idx` (`DIVISION_ID`),
  KEY `M_FK3_idx` (`MANAGER_USER_ID`,`AE_USER_ID`,`CHIEF_USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts`
--

LOCK TABLES `manuscripts` WRITE;
/*!40000 ALTER TABLE `manuscripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_abstract`
--

DROP TABLE IF EXISTS `manuscripts_abstract`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_abstract` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `PAPER_ABSTRACT` varchar(3000) NOT NULL,
  `REVISION_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `FK_MA_UK1` (`REVISION_COUNT`,`MANUSCRIPT_ID`),
  KEY `FK_MANUSCRIPT_ABSTRACT_1` (`MANUSCRIPT_ID`),
  CONSTRAINT `FK_MANUSCRIPT_ABSTRACT_1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_abstract`
--

LOCK TABLES `manuscripts_abstract` WRITE;
/*!40000 ALTER TABLE `manuscripts_abstract` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_abstract` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_coauthors`
--

DROP TABLE IF EXISTS `manuscripts_coauthors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_coauthors` (
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `REVISION_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `AUTHOR_ORDER` int(10) unsigned NOT NULL,
  `USER_ID` int(32) unsigned NOT NULL,
  `CORRESPONDING` tinyint(1) DEFAULT '0',
  `CREATED_MEMBER` tinyint(1) DEFAULT '0',
  `TEMP_PW` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`MANUSCRIPT_ID`,`USER_ID`,`REVISION_COUNT`),
  UNIQUE KEY `MC_UK1` (`MANUSCRIPT_ID`,`REVISION_COUNT`,`USER_ID`),
  KEY `FK_COAUTHORS_2` (`USER_ID`),
  CONSTRAINT `FK_COAUTHORS_1_C` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_COAUTHORS_2_C` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_coauthors`
--

LOCK TABLES `manuscripts_coauthors` WRITE;
/*!40000 ALTER TABLE `manuscripts_coauthors` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_coauthors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_comments`
--

DROP TABLE IF EXISTS `manuscripts_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_comments` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `FROM_USER_ID` int(32) unsigned NOT NULL,
  `TO_USER_ID` int(32) unsigned NOT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `REVISION_COUNT` int(11) DEFAULT '0',
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `FROM_ROLE` varchar(100) DEFAULT NULL,
  `TO_ROLE` varchar(100) DEFAULT NULL,
  `TEXT` varchar(10000) DEFAULT NULL,
  `SCOPE_MANAGER` int(1) DEFAULT '0',
  `STATUS` varchar(3) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `TIME` time DEFAULT NULL,
  `CAMERA_READY_REVISION` int(10) unsigned DEFAULT '0',
  `GALLERY_PROOF_REVISION` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `MC_FK1_idx` (`FROM_USER_ID`),
  KEY `MC_FK2_idx` (`MANUSCRIPT_ID`),
  KEY `MC_FK3_idx` (`JOURNAL_ID`),
  KEY `MC_FK1_idx1` (`FROM_USER_ID`,`TO_USER_ID`),
  CONSTRAINT `MC_FK2` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MC_FK3` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_comments`
--

LOCK TABLES `manuscripts_comments` WRITE;
/*!40000 ALTER TABLE `manuscripts_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_coverletter`
--

DROP TABLE IF EXISTS `manuscripts_coverletter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_coverletter` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `MANUSCRIPT_ID` int(32) unsigned DEFAULT NULL,
  `REVISION_COUNT` int(11) DEFAULT '0',
  `COVERLETTER` varchar(4500) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MC_UK1_idx` (`MANUSCRIPT_ID`,`REVISION_COUNT`),
  KEY `MC_FK1_idx` (`MANUSCRIPT_ID`,`REVISION_COUNT`),
  CONSTRAINT `MC_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_coverletter`
--

LOCK TABLES `manuscripts_coverletter` WRITE;
/*!40000 ALTER TABLE `manuscripts_coverletter` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_coverletter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_event_date`
--

DROP TABLE IF EXISTS `manuscripts_event_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_event_date` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `MANUSCRIPT_ID` int(32) unsigned DEFAULT NULL,
  `STATUS` varchar(1) DEFAULT NULL,
  `EVENT_DATE` date DEFAULT NULL,
  `EVENT_TIME` time DEFAULT NULL,
  `REVISION_COUNT` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `EVENT_DATE_FK1_idx` (`MANUSCRIPT_ID`),
  CONSTRAINT `EVENT_DATE_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_event_date`
--

LOCK TABLES `manuscripts_event_date` WRITE;
/*!40000 ALTER TABLE `manuscripts_event_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_event_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_final_decision`
--

DROP TABLE IF EXISTS `manuscripts_final_decision`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_final_decision` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) unsigned NOT NULL,
  `JOURNAL_ID` int(11) unsigned NOT NULL,
  `MANUSCRIPT_ID` int(11) unsigned NOT NULL,
  `DECISION` int(11) DEFAULT NULL,
  `REVISION_COUNT` int(11) DEFAULT '0',
  `EDITOR_RECOMMEND` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MFD_UK1_idx` (`USER_ID`,`MANUSCRIPT_ID`,`REVISION_COUNT`),
  KEY `MFD_FK1_idx` (`USER_ID`),
  KEY `MFD_FK2_idx` (`JOURNAL_ID`),
  KEY `MFD_FK3_idx` (`MANUSCRIPT_ID`),
  CONSTRAINT `MFD_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MFD_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MFD_FK3` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_final_decision`
--

LOCK TABLES `manuscripts_final_decision` WRITE;
/*!40000 ALTER TABLE `manuscripts_final_decision` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_final_decision` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_keyword`
--

DROP TABLE IF EXISTS `manuscripts_keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_keyword` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `REVISION_COUNT` int(32) NOT NULL DEFAULT '0',
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `KEYWORD` varchar(70) NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `USER_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`,`REVISION_COUNT`,`MANUSCRIPT_ID`),
  UNIQUE KEY `MK_UK1` (`MANUSCRIPT_ID`,`REVISION_COUNT`,`KEYWORD`),
  KEY `KEY1` (`REVISION_COUNT`),
  KEY `KEY2` (`MANUSCRIPT_ID`),
  KEY `MK_FK1` (`USER_ID`),
  KEY `MK_FK2` (`JOURNAL_ID`),
  CONSTRAINT `MK_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MK_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MK_FK3` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_keyword`
--

LOCK TABLES `manuscripts_keyword` WRITE;
/*!40000 ALTER TABLE `manuscripts_keyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_review`
--

DROP TABLE IF EXISTS `manuscripts_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_review` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `STATUS` varchar(1) DEFAULT NULL,
  `DUE_DATE` date DEFAULT '0000-00-00',
  `DUE_TIME` time DEFAULT NULL,
  `SCORE1` int(10) unsigned DEFAULT '0',
  `SCORE2` int(10) unsigned DEFAULT '0',
  `SCORE3` int(10) unsigned DEFAULT '0',
  `SCORE4` int(10) unsigned DEFAULT '0',
  `SCORE5` int(10) unsigned DEFAULT '0',
  `SCORE6` int(10) unsigned DEFAULT '0',
  `SCORE7` int(10) unsigned DEFAULT '0',
  `SCORE8` int(10) unsigned DEFAULT '0',
  `SCORE9` int(10) unsigned DEFAULT '0',
  `SCORE10` int(10) unsigned DEFAULT '0',
  `OVERALL` int(10) unsigned DEFAULT '0',
  `CONFIRM` tinyint(1) unsigned DEFAULT '0',
  `REVISION_COUNT` int(10) unsigned DEFAULT '0',
  `INVITE_EXPIRATION_DATE` date DEFAULT NULL,
  `RE_REVIEW` int(11) DEFAULT '0',
  `FIRST_STATUS` varchar(1) DEFAULT NULL,
  `CREATED_MEMBER` tinyint(1) DEFAULT '0',
  `TEMP_PW` varchar(45) DEFAULT NULL,
  `REVIEW_ITEM_ID1` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID2` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID3` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID4` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID5` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID6` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID7` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID8` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID9` int(11) DEFAULT '-1',
  `REVIEW_ITEM_ID10` int(11) DEFAULT '-1',
  `NUMBER_OF_REVIEW_ITEMS` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MR_UK1_idx` (`MANUSCRIPT_ID`,`USER_ID`,`REVISION_COUNT`),
  KEY `INDEX_ACCOUNTID` (`USER_ID`),
  KEY `INDEX_MANUSCRIPTID` (`MANUSCRIPT_ID`),
  KEY `ID` (`ID`),
  KEY `MR_FK3_idx` (`JOURNAL_ID`),
  CONSTRAINT `MR_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MR_FK2` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MR_FK3` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review`
--

LOCK TABLES `manuscripts_review` WRITE;
/*!40000 ALTER TABLE `manuscripts_review` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_review_decline_suggest`
--

DROP TABLE IF EXISTS `manuscripts_review_decline_suggest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_review_decline_suggest` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `REVIEWER_USER_ID` int(32) unsigned NOT NULL DEFAULT '0',
  `EDITOR_USER_ID` int(32) unsigned NOT NULL DEFAULT '0',
  `REVIEW_ID` int(11) DEFAULT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL DEFAULT '0',
  `FIRST_NAME` varchar(45) DEFAULT NULL,
  `LAST_NAME` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(45) DEFAULT NULL,
  `INSTITUTION` varchar(45) DEFAULT NULL,
  `DEGREE` int(2) DEFAULT '-1',
  `SALUTATION` int(2) DEFAULT '-1',
  `COUNTRY_CODE` char(3) DEFAULT NULL,
  `DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_INSTITUTION` varchar(70) DEFAULT NULL,
  `LOCAL_FULL_NAME` varchar(40) DEFAULT NULL,
  `REASON` int(10) unsigned NOT NULL DEFAULT '0',
  `COMMENT` varchar(4500) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_1_C` (`MANUSCRIPT_ID`),
  CONSTRAINT `FK_1_RS_C` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_decline_suggest`
--

LOCK TABLES `manuscripts_review_decline_suggest` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_decline_suggest` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_review_decline_suggest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_review_event_date`
--

DROP TABLE IF EXISTS `manuscripts_review_event_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_review_event_date` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `MANUSCRIPT_ID` int(32) unsigned DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `STATUS` varchar(1) DEFAULT NULL,
  `EVENT_DATE` date DEFAULT NULL,
  `EVENT_TIME` time DEFAULT NULL,
  `REVISION_COUNT` int(11) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `RED_FK1_idx` (`MANUSCRIPT_ID`),
  KEY `RED_FK2_idx` (`USER_ID`),
  KEY `RED_FK3_idx` (`JOURNAL_ID`),
  CONSTRAINT `RED_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RED_FK2` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RED_FK3` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_event_date`
--

LOCK TABLES `manuscripts_review_event_date` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_event_date` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_review_event_date` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_review_preferences`
--

DROP TABLE IF EXISTS `manuscripts_review_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_review_preferences` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `REVISION_COUNT` int(10) unsigned DEFAULT '0',
  `FIRST_NAME` varchar(45) DEFAULT NULL,
  `LAST_NAME` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `INSTITUTION` varchar(45) DEFAULT NULL,
  `DEGREE` varchar(40) NOT NULL DEFAULT '-1',
  `SALUTATION` varchar(5) NOT NULL DEFAULT '-1',
  `COUNTRY_CODE` char(3) NOT NULL,
  `DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_INSTITUTION` varchar(70) DEFAULT NULL,
  `LOCAL_FULL_NAME` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_1_C` (`MANUSCRIPT_ID`),
  CONSTRAINT `MRP_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_preferences`
--

LOCK TABLES `manuscripts_review_preferences` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_review_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_review_request`
--

DROP TABLE IF EXISTS `manuscripts_review_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_review_request` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `QUERY` varchar(500) DEFAULT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `EDITOR_USER_ID` int(32) unsigned NOT NULL,
  `REVIEWER_USER_ID` int(32) unsigned NOT NULL,
  `REVIEW_ID` int(32) unsigned NOT NULL,
  `AVAILABLE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID`),
  KEY `MK_MRR1_idx` (`MANUSCRIPT_ID`),
  CONSTRAINT `MRR_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_request`
--

LOCK TABLES `manuscripts_review_request` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_request` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_review_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_runninghead`
--

DROP TABLE IF EXISTS `manuscripts_runninghead`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_runninghead` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `REVISION_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `RUNNINGHEAD` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MR_UK1` (`MANUSCRIPT_ID`,`REVISION_COUNT`),
  KEY `FK_MANUSCRIPT_RUNNINGHEAD_1` (`MANUSCRIPT_ID`),
  CONSTRAINT `MRH_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_runninghead`
--

LOCK TABLES `manuscripts_runninghead` WRITE;
/*!40000 ALTER TABLE `manuscripts_runninghead` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_runninghead` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_title`
--

DROP TABLE IF EXISTS `manuscripts_title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_title` (
  `ID` int(32) NOT NULL AUTO_INCREMENT,
  `TITLE` varchar(1000) NOT NULL,
  `REVISION_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `MT_UK1` (`REVISION_COUNT`,`MANUSCRIPT_ID`),
  KEY `FK_MANUSCRIPTTITLE_1` (`MANUSCRIPT_ID`) USING BTREE,
  CONSTRAINT `TITLE_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_title`
--

LOCK TABLES `manuscripts_title` WRITE;
/*!40000 ALTER TABLE `manuscripts_title` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manuscripts_uploaded_files`
--

DROP TABLE IF EXISTS `manuscripts_uploaded_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manuscripts_uploaded_files` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `USER_ID` int(32) unsigned NOT NULL,
  `NAME` varchar(500) NOT NULL,
  `DESIGNATION` varchar(45) NOT NULL,
  `DATE` date DEFAULT NULL,
  `TIME` time DEFAULT NULL,
  `ABSOLUTE_PATH` varchar(1000) NOT NULL,
  `PATH` varchar(1000) DEFAULT NULL,
  `ORIGINAL_NAME` varchar(500) DEFAULT NULL,
  `REVISION_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  `CONFIRM` tinyint(1) NOT NULL DEFAULT '0',
  `GALLERY_PROOF_REVISION` int(10) unsigned DEFAULT '0',
  `CAMERA_READY_REVISION` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FK_UPLOADEDFILES_1` (`MANUSCRIPT_ID`),
  CONSTRAINT `FK_UPLOADEDFILES_1_C` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_uploaded_files`
--

LOCK TABLES `manuscripts_uploaded_files` WRITE;
/*!40000 ALTER TABLE `manuscripts_uploaded_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `manuscripts_uploaded_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `persistent_logins`
--

DROP TABLE IF EXISTS `persistent_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `persistent_logins` (
  `username` varchar(100) NOT NULL,
  `series` varchar(64) NOT NULL,
  `token` varchar(64) NOT NULL,
  `last_used` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persistent_logins`
--

LOCK TABLES `persistent_logins` WRITE;
/*!40000 ALTER TABLE `persistent_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `persistent_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `special_issues`
--

DROP TABLE IF EXISTS `special_issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `special_issues` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `GE_USER_ID` int(32) DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned DEFAULT NULL,
  `TITLE` varchar(300) DEFAULT NULL,
  `DESCRIPTION` varchar(5000) DEFAULT NULL,
  `SUBMIT_DUE_DATE` date NOT NULL,
  `SUBMIT_DUE_TIME` time NOT NULL,
  `CREATE_DATE` date NOT NULL,
  `CREATE_TIME` time NOT NULL,
  `STATUS` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_SPECIAL_ISSUES1_idx` (`JOURNAL_ID`),
  CONSTRAINT `FK_SPECIAL_ISSUES1` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `special_issues`
--

LOCK TABLES `special_issues` WRITE;
/*!40000 ALTER TABLE `special_issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `special_issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submitted_manuscripts`
--

DROP TABLE IF EXISTS `submitted_manuscripts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `submitted_manuscripts` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `YEAR` int(10) unsigned NOT NULL,
  `MONTH` int(10) unsigned NOT NULL,
  `MANUSCRIPT_COUNT` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `SM_FK1_idx` (`JOURNAL_ID`),
  CONSTRAINT `SM_FK1` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submitted_manuscripts`
--

LOCK TABLES `submitted_manuscripts` WRITE;
/*!40000 ALTER TABLE `submitted_manuscripts` DISABLE KEYS */;
/*!40000 ALTER TABLE `submitted_manuscripts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_divisions`
--

DROP TABLE IF EXISTS `user_divisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_divisions` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USER_ID` int(32) unsigned NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `DIVISION_ID` int(32) unsigned NOT NULL,
  `ROLE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `USER_DIVISIONS_FK2_idx` (`JOURNAL_ID`),
  KEY `USER_DIVISIONS_FK3_idx` (`DIVISION_ID`),
  KEY `USER_DIVISIONS_FK1_idx` (`USER_ID`),
  CONSTRAINT `USER_DIVISIONS_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `USER_DIVISIONS_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `USER_DIVISIONS_FK3` FOREIGN KEY (`DIVISION_ID`) REFERENCES `divisions` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_divisions`
--

LOCK TABLES `user_divisions` WRITE;
/*!40000 ALTER TABLE `user_divisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_divisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_expertises`
--

DROP TABLE IF EXISTS `user_expertises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_expertises` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `EXPERTISE` varchar(70) NOT NULL,
  `USER_ID` int(32) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `USER_EXPERTISES_UNIQUE` (`EXPERTISE`,`USER_ID`),
  KEY `USER_EXPERTISES_FK1` (`USER_ID`),
  CONSTRAINT `USER_EXPERTISES_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_expertises`
--

LOCK TABLES `user_expertises` WRITE;
/*!40000 ALTER TABLE `user_expertises` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_expertises` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `ID` int(32) unsigned NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(55) NOT NULL,
  `PASSWORD` varchar(256) NOT NULL,
  `SIGNUP_DATE` date NOT NULL,
  `SIGNUP_TIME` time NOT NULL,
  `ENABLED` smallint(6) NOT NULL,
  PRIMARY KEY (`ID`,`USERNAME`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'support@manuscriptlink.com','5eec56eaff43e0c92641044bb1b792c2bed84afa09400742fd386760c061d710','2014-05-15','08:17:54',1),(2,'no-reply@manuscriptlink.com','7cf2ed9022330ca04073527a6da90a61f3fd187738a152947ee02a73784aa025','2014-05-15','08:18:24',1),(3,'yhhan@koreatech.ac.kr','8a3e15205fb79ee7998b7f495b0ed5feaf9537d4c3b144f46f25109d0a9388d6','2014-05-15','23:19:07',1),(4,'cmdrkim@gmail.com','98a9963bfba879b370c70e00f7f60d6356c8ffdb60c2696da7a06e0ac545c17b','2014-05-15','20:19:34',1),(5,'neoanimato@gmail.com','b9a7d8fadaaa8ee7e0822959df91e1357d171d0802f26bce8673557293f97281','2014-05-18','09:59:19',1),(6,'armhwa@gmail.com','1aa319d9af2730d7ed7376fc1d3b058f2f0c66bd1d660b857f8dcecc42727390','2014-05-18','10:01:35',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-07-26 17:12:20
