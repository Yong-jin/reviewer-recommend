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
  KEY `FK_AUTHORITIES_USER_idx` (`USER_ID`),
  CONSTRAINT `FK_AUTHORITIES_USER` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES (1,1,0,'ROLE_USER'),(2,2,0,'ROLE_USER'),(3,3,0,'ROLE_USER'),(4,4,0,'ROLE_USER'),(5,4,1,'ROLE_MEMBER'),(6,4,1,'ROLE_MANAGER'),(7,3,1,'ROLE_MEMBER'),(8,3,0,'ROLE_SUPER_MANAGER'),(9,4,0,'ROLE_SUPER_MANAGER'),(10,3,1,'ROLE_MANAGER'),(11,3,1,'ROLE_C-EDITOR'),(12,4,1,'ROLE_C-EDITOR'),(13,3,1,'ROLE_G-EDITOR'),(14,4,1,'ROLE_G-EDITOR'),(15,3,1,'ROLE_A-EDITOR'),(16,4,1,'ROLE_A-EDITOR'),(17,3,1,'ROLE_REVIEWER'),(18,4,1,'ROLE_REVIEWER'),(21,3,2,'ROLE_MEMBER'),(22,3,2,'ROLE_MANAGER'),(23,5,0,'ROLE_USER'),(24,5,2,'ROLE_MEMBER'),(25,6,0,'ROLE_USER'),(26,6,2,'ROLE_MEMBER'),(27,5,0,'ROLE_SUPER_MANAGER'),(28,6,0,'ROLE_SUPER_MANAGER'),(29,3,2,'ROLE_C-EDITOR'),(30,3,2,'ROLE_G-EDITOR'),(31,3,2,'ROLE_A-EDITOR'),(33,3,2,'ROLE_REVIEWER'),(34,4,2,'ROLE_REVIEWER'),(35,4,2,'ROLE_MEMBER'),(37,4,2,'ROLE_A-EDITOR'),(38,4,2,'ROLE_G-EDITOR'),(39,4,2,'ROLE_C-EDITOR'),(40,4,2,'ROLE_MANAGER'),(41,5,1,'ROLE_MEMBER'),(42,5,1,'ROLE_MANAGER'),(43,6,1,'ROLE_MANAGER'),(44,6,1,'ROLE_MEMBER'),(45,5,2,'ROLE_MANAGER'),(46,6,2,'ROLE_MANAGER'),(47,5,2,'ROLE_C-EDITOR'),(48,5,1,'ROLE_C-EDITOR'),(50,6,2,'ROLE_C-EDITOR'),(51,5,1,'ROLE_G-EDITOR'),(52,5,2,'ROLE_G-EDITOR'),(54,6,2,'ROLE_G-EDITOR'),(55,6,2,'ROLE_A-EDITOR'),(57,5,2,'ROLE_A-EDITOR'),(58,5,1,'ROLE_A-EDITOR'),(63,6,2,'ROLE_REVIEWER'),(64,6,1,'ROLE_REVIEWER'),(65,5,2,'ROLE_REVIEWER'),(66,5,1,'ROLE_REVIEWER'),(132,1,2,'ROLE_MEMBER'),(133,1,2,'ROLE_REVIEWER'),(134,2,2,'ROLE_MEMBER'),(135,2,2,'ROLE_REVIEWER'),(160,6,1,'ROLE_A-EDITOR'),(161,6,1,'ROLE_G-EDITOR'),(171,6,1,'ROLE_B-MEMBER'),(181,6,1,'ROLE_C-EDITOR'),(224,78,0,'ROLE_USER'),(225,79,0,'ROLE_USER');
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `change_password_code`
--

LOCK TABLES `change_password_code` WRITE;
/*!40000 ALTER TABLE `change_password_code` DISABLE KEYS */;
INSERT INTO `change_password_code` VALUES (20,'neoanimato@gmail.com','xuKspZmSbPorMBbtHdpUdgQTLTtffN','2014-07-17','2014-07-20',1);
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
  `DEGREE` int(2) NOT NULL,
  `SALUTATION` int(2) NOT NULL,
  `INSTITUTION` varchar(70) NOT NULL,
  `DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_INSTITUTION` varchar(70) DEFAULT NULL,
  `LOCAL_DEPARTMENT` varchar(70) DEFAULT NULL,
  `COUNTRY_CODE` char(2) NOT NULL,
  `PHONE` varchar(20) DEFAULT NULL,
  `MOBILE` varchar(20) DEFAULT NULL,
  `FAX` varchar(20) DEFAULT NULL,
  `WEBSITE` varchar(100) DEFAULT NULL,
  `POSITION` varchar(100) DEFAULT NULL,
  `ABOUT` varchar(1000) DEFAULT NULL,
  `LOCAL_JOB_TITLE` int(2) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_CONTACTS_USER` (`USER_ID`),
  CONSTRAINT `FK_CONTACTS_USER` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
INSERT INTO `contacts` VALUES (1,1,'MANUSCRIPT','LINK','',0,0,'MANUSCRIPTLINK','','','','KR','','','','','','',NULL),(2,2,'MANUSCRIPT','LINK','',0,0,'MANUSCRIPTLINK','','','','KR','','','','','','',NULL),(3,3,'Youn-Hee','Han','한연희',0,0,'MANUSCRIPTLINK','','','','KR','','','','','','',1),(4,4,'Chan-Myung','Kim','김찬명',1,2,'MANUSCRIPTLINK','MANUSCRIPTLINK','MANUSCRIPTLINK','ggggd','KR','+1 518 227 8265','','','','','',3),(5,5,'Dong-Sun','Yang','양동선',2,2,'MANUSCRIPTLINK','Department of Electronic Engineering','MANUSCRIPTLINK','','KR','','','','','','',9),(6,6,'SeungIl','Hyeon','현승일',2,2,'MANUSCRIPTLINK','ee','MANUSCRIPTLINK','bbbb','KR','','','','','','fff',5),(72,78,'Joon-Min','Gil',NULL,0,0,'CU','CU',NULL,NULL,'KR',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(73,79,'dsafd','fasf',NULL,1,1,'asdf','asdf',NULL,NULL,'AN',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
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
INSERT INTO `divisions` VALUES (1,1,'COMPUTER SYSTEM AND THEORY','A','COMPUTER SYSTEM AND THEORY'),(2,1,'MULTIMEDIA SYSTEM AND GRAPHICS','B','MULTIMEDIA SYSTEM AND GRAPHICS'),(3,1,'COMMUNICATION SYSTEM AND SECURITY','C','COMMUNICATION SYSTEM AND SECURITY'),(4,1,'INFORMATION SYSTEM AND APPLICATION','D','INFORMATION SYSTEM AND APPLICATION');
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
) ENGINE=InnoDB AUTO_INCREMENT=1216 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_delivery`
--

LOCK TABLES `email_delivery` WRITE;
/*!40000 ALTER TABLE `email_delivery` DISABLE KEYS */;
INSERT INTO `email_delivery` VALUES (1079,2,78,'2014-07-17','16:49:55',1,0,718,0),(1080,2,3,'2014-07-17','16:49:56',1,1,719,0),(1081,2,4,'2014-07-17','16:49:56',1,1,720,0),(1082,2,78,'2014-07-17','16:49:56',1,1,721,0),(1083,2,4,'2014-07-17','16:49:56',1,1,722,0),(1084,2,3,'2014-07-17','16:49:56',1,1,723,0),(1085,2,5,'2014-07-17','16:49:56',1,1,724,0),(1086,2,6,'2014-07-17','16:49:56',1,1,725,0),(1087,2,3,'2014-07-17','16:51:23',1,1,726,0),(1088,2,4,'2014-07-17','16:51:23',1,1,726,1),(1089,2,4,'2014-07-17','16:51:23',1,1,727,0),(1090,2,78,'2014-07-17','16:51:23',1,1,728,0),(1091,2,3,'2014-07-17','17:02:35',1,1,729,0),(1092,2,4,'2014-07-17','17:02:36',1,1,730,0),(1093,2,78,'2014-07-17','17:02:36',1,1,731,0),(1094,2,4,'2014-07-17','17:02:36',1,1,732,0),(1095,2,3,'2014-07-17','17:02:36',1,1,733,0),(1096,2,5,'2014-07-17','17:02:36',1,1,734,0),(1097,2,6,'2014-07-17','17:02:36',1,1,735,0),(1098,2,3,'2014-07-17','17:03:58',1,1,736,0),(1099,2,4,'2014-07-17','17:03:58',1,1,736,1),(1100,2,4,'2014-07-17','17:03:58',1,1,737,0),(1101,2,78,'2014-07-17','17:03:58',1,1,738,0),(1102,2,4,'2014-07-17','17:03:58',1,1,739,0),(1103,2,4,'2014-07-17','17:03:58',1,1,739,1),(1104,2,4,'2014-07-17','17:04:25',1,1,740,0),(1105,2,4,'2014-07-17','17:04:25',1,1,740,1),(1106,2,4,'2014-07-17','17:04:25',1,1,740,1),(1107,2,4,'2014-07-17','17:14:24',1,1,741,0),(1108,2,4,'2014-07-17','17:14:24',1,1,741,1),(1109,2,4,'2014-07-17','17:14:24',1,1,741,1),(1110,2,3,'2014-07-17','17:17:41',1,1,742,0),(1111,2,4,'2014-07-17','17:17:41',1,1,742,1),(1112,2,5,'2014-07-17','17:18:08',1,1,743,0),(1113,2,4,'2014-07-17','17:18:08',1,1,743,1),(1114,2,4,'2014-07-17','17:18:20',1,1,744,0),(1115,2,4,'2014-07-17','17:18:20',1,1,744,1),(1116,2,4,'2014-07-17','17:19:19',1,1,745,0),(1117,2,4,'2014-07-17','17:19:19',1,1,745,1),(1118,2,3,'2014-07-17','17:50:18',1,1,746,0),(1119,2,4,'2014-07-17','17:50:18',1,1,746,1),(1120,2,5,'2014-07-17','17:50:18',1,1,747,0),(1121,2,4,'2014-07-17','17:50:18',1,1,747,1),(1122,2,4,'2014-07-17','17:50:18',1,1,748,0),(1123,2,4,'2014-07-17','17:50:18',1,1,748,1),(1124,2,3,'2014-07-17','17:51:26',1,1,749,0),(1125,2,4,'2014-07-17','17:51:26',1,1,749,1),(1126,2,4,'2014-07-17','17:51:26',1,1,749,1),(1127,2,4,'2014-07-17','17:51:26',1,1,749,1),(1128,2,4,'2014-07-17','17:51:26',1,1,750,0),(1129,2,78,'2014-07-17','17:51:26',1,1,751,0),(1130,2,4,'2014-07-17','17:56:17',1,1,752,0),(1131,2,3,'2014-07-17','18:20:48',1,1,753,0),(1132,2,4,'2014-07-17','18:20:48',1,1,753,1),(1133,2,4,'2014-07-17','18:20:48',1,1,754,0),(1134,2,78,'2014-07-17','18:20:48',1,1,755,0),(1135,2,4,'2014-07-17','18:34:53',1,1,756,0),(1136,2,3,'2014-07-17','18:34:53',1,1,757,0),(1137,2,78,'2014-07-17','18:34:53',1,1,758,0),(1138,2,4,'2014-07-17','18:34:53',1,1,759,0),(1139,2,4,'2014-07-17','18:54:57',1,1,760,0),(1140,2,4,'2014-07-17','18:54:57',1,1,760,1),(1141,2,3,'2014-07-17','18:54:57',1,1,761,0),(1142,2,78,'2014-07-17','18:54:58',1,1,762,0),(1143,2,4,'2014-07-17','18:54:58',1,1,763,0),(1144,2,4,'2014-07-17','18:54:58',1,1,763,1),(1145,2,5,'2014-07-17','18:57:48',1,1,764,0),(1146,2,4,'2014-07-17','18:57:48',1,1,764,1),(1147,2,5,'2014-07-17','18:58:06',0,0,765,0),(1148,2,5,'2014-07-17','18:59:48',1,1,766,0),(1149,2,4,'2014-07-17','18:59:48',1,1,766,1),(1150,2,4,'2014-07-17','19:00:49',1,1,767,0),(1151,2,4,'2014-07-17','19:00:49',1,1,767,1),(1152,2,4,'2014-07-17','19:07:53',1,1,768,0),(1153,2,4,'2014-07-17','19:07:53',1,1,768,1),(1154,2,4,'2014-07-17','19:07:53',1,1,768,1),(1155,2,4,'2014-07-17','19:07:53',1,1,768,1),(1156,2,3,'2014-07-17','19:07:53',1,1,769,0),(1157,2,78,'2014-07-17','19:07:53',1,1,770,0),(1158,2,4,'2014-07-17','19:28:43',1,1,771,0),(1159,2,3,'2014-07-17','19:28:43',1,1,772,0),(1160,2,78,'2014-07-17','19:28:44',1,1,773,0),(1161,2,79,'2014-07-17','19:28:44',1,1,774,0),(1162,2,4,'2014-07-17','19:28:44',1,1,775,0),(1163,2,4,'2014-07-17','19:34:53',1,1,776,0),(1164,2,4,'2014-07-17','19:34:53',1,1,776,1),(1165,2,3,'2014-07-17','19:34:53',1,1,777,0),(1166,2,78,'2014-07-17','19:34:53',1,1,778,0),(1167,2,79,'2014-07-17','19:34:54',1,1,779,0),(1168,2,4,'2014-07-17','19:34:54',1,1,780,0),(1169,2,4,'2014-07-17','19:34:54',1,1,780,1),(1170,2,4,'2014-07-17','19:40:38',1,1,781,0),(1171,2,4,'2014-07-17','19:40:38',1,1,781,1),(1172,2,4,'2014-07-17','19:41:28',1,1,782,0),(1173,2,4,'2014-07-17','19:41:28',1,1,782,1),(1174,2,4,'2014-07-17','19:41:28',1,1,782,1),(1175,2,4,'2014-07-17','19:41:28',1,1,782,1),(1176,2,3,'2014-07-17','19:41:28',1,1,783,0),(1177,2,78,'2014-07-17','19:41:28',1,1,784,0),(1178,2,79,'2014-07-17','19:41:28',1,1,785,0),(1179,2,4,'2014-07-17','20:11:51',1,1,786,0),(1180,2,3,'2014-07-17','20:11:51',1,1,787,0),(1181,2,78,'2014-07-17','20:11:52',1,1,788,0),(1182,2,79,'2014-07-17','20:11:52',1,1,789,0),(1183,2,4,'2014-07-17','20:11:52',1,1,790,0),(1184,2,4,'2014-07-17','20:19:16',1,1,791,0),(1185,2,4,'2014-07-17','20:19:16',1,1,791,1),(1186,2,3,'2014-07-17','20:19:16',1,1,792,0),(1187,2,78,'2014-07-17','20:19:16',1,1,793,0),(1188,2,79,'2014-07-17','20:19:16',1,1,794,0),(1189,2,4,'2014-07-17','20:19:39',1,1,795,0),(1190,2,3,'2014-07-17','20:19:39',1,1,796,0),(1191,2,78,'2014-07-17','20:19:39',1,1,797,0),(1192,2,79,'2014-07-17','20:19:39',1,1,798,0),(1193,2,4,'2014-07-17','20:19:39',1,1,799,0),(1194,2,4,'2014-07-17','20:19:52',1,1,800,0),(1195,2,4,'2014-07-17','20:19:52',1,1,800,1),(1196,2,3,'2014-07-17','20:19:52',1,1,801,0),(1197,2,78,'2014-07-17','20:19:52',1,1,802,0),(1198,2,79,'2014-07-17','20:19:52',1,1,803,0),(1199,2,4,'2014-07-17','20:23:39',1,1,804,0),(1200,2,4,'2014-07-17','20:23:39',1,1,804,1),(1201,2,3,'2014-07-17','20:23:39',1,1,805,0),(1202,2,78,'2014-07-17','20:23:39',1,1,806,0),(1203,2,79,'2014-07-17','20:23:39',1,1,807,0),(1204,2,4,'2014-07-17','20:38:24',1,1,808,0),(1205,2,4,'2014-07-17','20:38:58',1,1,809,0),(1206,2,4,'2014-07-17','20:38:58',1,1,809,1),(1207,2,3,'2014-07-17','20:38:58',1,1,810,0),(1208,2,78,'2014-07-17','20:38:58',1,1,811,0),(1209,2,79,'2014-07-17','20:38:58',1,1,812,0),(1210,2,4,'2014-07-17','20:39:20',1,1,813,0),(1211,2,4,'2014-07-18','14:36:48',1,4,814,0),(1212,2,4,'2014-07-18','14:36:48',1,4,815,0),(1213,2,3,'2014-07-18','14:36:48',1,4,816,0),(1214,2,5,'2014-07-18','14:36:48',1,4,817,0),(1215,2,6,'2014-07-18','14:36:48',1,4,818,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=819 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_messages`
--

LOCK TABLES `email_messages` WRITE;
/*!40000 ALTER TABLE `email_messages` DISABLE KEYS */;
INSERT INTO `email_messages` VALUES (718,'Notification of your account creation at ManuscriptLink by other co-author(JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>This mail is to let you know that your account was created at the following online manuscript submission and review system of Journal of Information Processing System. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>Your account was created to submit your manuscript to Journal of Information Processing System by the following co-author.<br/><br/>Account creator (manuscript co-author): Prof. Youn-Hee Han (yhhan@koreatech.ac.kr)<br/><br/>In the online system, the account information of Prof. Joon-Min Gil is as follows:<br/><br/>Login ID (email): jmgil@cu.ac.kr<br/>Temporary password: 61f21c03<br/><br/>After login to the above system, you can change the current password in the menu \"My Profile > My Information > Password Change\".<br/> <br/>In ManuscriptLink online system,<br/><br/>* If you are an author of manuscript, you can submit your manuscript and keep a close watch over the on-going review process including the review history of past manuscripts.<br/>* If you are a journal manager of a journal, you can create and manage a new journal submission and review service, and customize your service according to the demand of editorial members and authors.  <br/>* If you are an editorial member of a journal, you can manage a review process of your journal and enhance the academic value of the journal by accepting or rejecting publication of submitted manuscripts.<br/>* If you are a reviewer of a journal, you can evaluate submitted manuscripts and submit your review results to editorial members of the journal.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(719,'Acknowledgment of a new manuscript submission (JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(720,'Acknowledgment of a new manuscript submission (JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(721,'Acknowledgment of a new manuscript submission (JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(722,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(723,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(724,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=neoanimato@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(725,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=armhwa@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(726,'Returning the submitted manuscript back (JIPS)','Dear Author,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>However, there are some problems on your manuscript and/or the related information. The details of problems are as follows:<br/><br/>some problem<br/><br/>Please correct your manuscript according to the above mentioned comments, and again submit the corrected one to the following online manuscript submission and peer-review system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>To submit the corrected manuscript in the online system, please do not open a new manuscript submission page, but just access the existing online page where you submitted the original manuscript.<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(727,'Returning the submitted manuscript back (JIPS)','Dear Author,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>However, there are some problems on your manuscript and/or the related information. The details of problems are as follows:<br/><br/>some problem<br/><br/>Please correct your manuscript according to the above mentioned comments, and again submit the corrected one to the following online manuscript submission and peer-review system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>To submit the corrected manuscript in the online system, please do not open a new manuscript submission page, but just access the existing online page where you submitted the original manuscript.<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(728,'Returning the submitted manuscript back (JIPS)','Dear Author,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>However, there are some problems on your manuscript and/or the related information. The details of problems are as follows:<br/><br/>some problem<br/><br/>Please correct your manuscript according to the above mentioned comments, and again submit the corrected one to the following online manuscript submission and peer-review system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>To submit the corrected manuscript in the online system, please do not open a new manuscript submission page, but just access the existing online page where you submitted the original manuscript.<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(729,'Acknowledgment of a new manuscript submission (JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(730,'Acknowledgment of a new manuscript submission (JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(731,'Acknowledgment of a new manuscript submission (JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(732,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(733,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(734,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=neoanimato@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(735,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=armhwa@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(736,'Confirmation of a new manuscript submission (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(737,'Confirmation of a new manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(738,'Confirmation of a new manuscript submission (14M-07-001, JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(739,'Notification of a new manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System. The submitted manuscript has been also confirmed by journal manager. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We would appreciate your efforts on the chief editor\'s process of the above manuscript submitted to Journal of Information Processing System. Please visit the following online manuscript submission & peer-review system and make progress on the manuscript\'s review process. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(740,'A new manuscript review management request (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>There is the following manuscript submitted to Journal of Information Processing System. Since you are serving as an associate editor of this journal and the subject of the submitted manuscript seems to be under of your expertise, you are entrusted with the task of the manuscript\'s review process.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>I would appreciate you if you take the review process of the above manuscript submitted to Journal of Information Processing System. Please visit the following online system and accept our request to take review process on it by selecting proper reviewers and collecting review results.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you think that the submitted manuscript is not proper to your handling of review process, you can decline this request by clicking the correspinding button provided in the online manuscript submission & peer-review system.<br/><br/>[Additional message from the chief editor]<br/>dafsdfasdfasdfasdf<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Chief Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(741,'Acceptance of the requested new manuscript review management (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Recently, you assigned an associate editor into the following manuscript submitted to Journal of Information Processing System for the review process management. He has accepted your request of the review process management.  <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>The associate editor accepting the request of review process management: Mr. Chan-Myung Kim (cmdrkim@gmail.com)<br/><br/>Best regards, <br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(742,'Review assignment and the related information (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>There is a following manuscript submitted to Journal of Information Processing System and I believe it falls within your area of expertise and you are a well-qualified scholar. So, we would like to assign you to a reviewer for it.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/><br/>We ask you to complete your review evaluation by August 28, 2014 and provide the comments to our review system. Please click the following url and complete your review.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you forgot your password, please click the link in \"Forgot your password?\" section of the page shown by the above URL and insert your email (yhhan@koreatech.ac.kr) in the shown input form.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(743,'Invitation to review a manuscript (14M-07-001, JIPS)','Dear Mr. Dong-Sun Yang,<br/><br/>There is a following manuscript submitted to Journal of Information Processing System and I believe it falls within your area of expertise. So, we would like to invite you as a reviewer for it.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/><br/>A copy of the abstract of the submission is attached to this e-mail. We request that your review be completed by within 6 weeks. If you are unable to meet this schedule or you are unable to perform the review, it would be helpful if you would suggest a colleague that could review the manuscript. <br/><br/>Please click on the following link to let us know whether or not you are able to review this manuscript<br/><br/>URL: http://www.manuscriptlink.com/journals/jips/reviewInvitation/aa782041b4884b5a8b13c55eb05b2e4f<br/><br/>I realize that our expert reviewers greatly contribute to the high standards of the journal, and I thank you for your present and/or future participation.<br/><br/>Best regards,<br/><br/>[Manuscript information]<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Abstract: This paper presents a genetic algorithmic approach to the shortest path (SP) routing problem. Variable-length chromosomes (strings) and their genes (parameters) have been used for encoding the problem. The crossover operation exchanges partial chromosomes (partial routes) at positionally independent crossing sites and the mutation operation maintains the genetic diversity of the population. The proposed algorithm can cure all the infeasible chromosomes with a simple repair function. Crossover and mutation together provide a search capability that results in improved quality of solution and enhanced rate of convergence. This paper also develops a population-sizing equation that facilitates a solution with desired quality. It is based on the gambler’s ruin model; the equation has been further enhanced and generalized, however. The equation relates the size of the population, the quality of solution, the cardinality of the alphabet, and other parameters of the proposed algorithm. Computer simulations show that the proposed algorithm exhibits a much better quality of solution (route optimality) and a much higher rate of convergence than other algorithms. The results are relatively independent of problem types (network sizes and topologies) for almost all source–destination pairs. Furthermore, simulation studies emphasize the usefulness of the population-sizing equation. The equation scales to larger networks. It is felt that it can be used for determining an adequate population size (for a desired quality of solution) in the SP routing problem.<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(744,'Review assignment and the related information (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>There is a following manuscript submitted to Journal of Information Processing System and I believe it falls within your area of expertise and you are a well-qualified scholar. So, we would like to assign you to a reviewer for it.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/><br/>We ask you to complete your review evaluation by August 28, 2014 and provide the comments to our review system. Please click the following url and complete your review.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you forgot your password, please click the link in \"Forgot your password?\" section of the page shown by the above URL and insert your email (cmdrkim@gmail.com) in the shown input form.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(745,'Thank you for reviewing a manuscript (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for completing your review for the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/><br/>Your time and effort is greatly appreciated by the journal editorial members and by the authors.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(746,'You don\'t need to review the manuscript any more (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Recently, you have been assigned to review the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/><br/>We consider that you are reviewing the manuscript, but the review process has come to end due to some reasons. So, you do not need to submit your review result to the online system.<br/><br/>Thanks for your time and I hope you will be able to review other manuscripts in the near future.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(747,'Cancellation of review request (14M-07-001, JIPS)','Dear Mr. Dong-Sun Yang,<br/><br/>Recently, you have been invited to review the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/><br/>However, we would like to cancel the reviewer invitation and assign the manuscript to other possible reviewer. <br/><br/>Thanks for your time and I hope you will be able to review other manuscripts in the near future.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(748,'A manuscript review result report (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of an associate editor (Mr. Chan-Myung Kim)\'s completion of review process for the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please login to the following online system and decide the final review result of the current review round after looking through the associate editor and reviewers\' comments. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(749,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>We have received all review comments from our reviewers on the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Overall review result: Marginal<br/><br/>The second half of this email contains important review comments and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Assuming you address the reviewers\' concerns in a satisfactory manner, you can revise the original manuscript and again submit it to the above online system. <br/><br/>When preparing it, you should write the reply letter including a list of responses to the review comments. The reply letter to the review comments should be uploaded as a separate file in addition to your revised manuscript. Acceptable formats for the reply letter include PDF (preferred) and MS Word.<br/><br/>The deadline for submission of the revised manuscript and replay letter is August 16, 2014. If you have any question regarding the revised manuscript, please contact the journal manager.<br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/>fffffffffff\n<br/><br/>- Associate Editor\'s Comments - <br/>asdfasdfasdfasdf<br/><br/><br/>- Reviewers\' Review Scores and Comments - <br/>Reviewer #1<br/><br/>Familiarity: Medium<br/>Clarity: Good<br/>Significance: Good<br/>Originality: Good<br/>Quality: Good<br/>Language: Average<br/>Relevance: Average<br/>Overall Judgement: Average<br/><br/>ddddddddddddfasdfadsf<br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(750,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>We have received all review comments from our reviewers on the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Overall review result: Marginal<br/><br/>The second half of this email contains important review comments and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Assuming you address the reviewers\' concerns in a satisfactory manner, you can revise the original manuscript and again submit it to the above online system. <br/><br/>When preparing it, you should write the reply letter including a list of responses to the review comments. The reply letter to the review comments should be uploaded as a separate file in addition to your revised manuscript. Acceptable formats for the reply letter include PDF (preferred) and MS Word.<br/><br/>The deadline for submission of the revised manuscript and replay letter is August 16, 2014. If you have any question regarding the revised manuscript, please contact the journal manager.<br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/>fffffffffff\n<br/><br/>- Associate Editor\'s Comments - <br/>asdfasdfasdfasdf<br/><br/><br/>- Reviewers\' Review Scores and Comments - <br/>Reviewer #1<br/><br/>Familiarity: Medium<br/>Clarity: Good<br/>Significance: Good<br/>Originality: Good<br/>Quality: Good<br/>Language: Average<br/>Relevance: Average<br/>Overall Judgement: Average<br/><br/>ddddddddddddfasdfadsf<br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(751,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>We have received all review comments from our reviewers on the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Overall review result: Marginal<br/><br/>The second half of this email contains important review comments and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Assuming you address the reviewers\' concerns in a satisfactory manner, you can revise the original manuscript and again submit it to the above online system. <br/><br/>When preparing it, you should write the reply letter including a list of responses to the review comments. The reply letter to the review comments should be uploaded as a separate file in addition to your revised manuscript. Acceptable formats for the reply letter include PDF (preferred) and MS Word.<br/><br/>The deadline for submission of the revised manuscript and replay letter is August 16, 2014. If you have any question regarding the revised manuscript, please contact the journal manager.<br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/>fffffffffff\n<br/><br/>- Associate Editor\'s Comments - <br/>asdfasdfasdfasdf<br/><br/><br/>- Reviewers\' Review Scores and Comments - <br/>Reviewer #1<br/><br/>Familiarity: Medium<br/>Clarity: Good<br/>Significance: Good<br/>Originality: Good<br/>Quality: Good<br/>Language: Average<br/>Relevance: Average<br/>Overall Judgement: Average<br/><br/>ddddddddddddfasdfadsf<br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(752,'Request the revision deadline extension (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>The author(s) are now preparing a revised version of the following manuscript submitted to Journal of Information Processing System. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/17/2014<br/><br/>The deadline for submission of the revised manuscript and replay letter was August 16, 2014, but the author(s) requested the deadline extension to July 31, 2014. After discussing with editorial members about this request, please let the authors know the decision on whether to accept the request through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Best regards,<br/><br/>'),(753,'Approval of your request to extend the revision deadline (14M-07-001, JIPS)','Dear Author,<br/><br/>We approve your request to extend the deadline for submission of a revised version of the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/17/2014<br/><br/>The updated deadline for submission of the revised manuscript and replay letter is confirmed to August 14, 2014. Please submit them through the following online system by the deadline.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(754,'Approval of your request to extend the revision deadline (14M-07-001, JIPS)','TO: yhhan@koreatech.ac.kr, \nCC: cmdrkim@gmail.com, \n*****위와 같은 TO, CC 구성으로 아래 메일 내용이 전달됩니다.*****\nDear Author,<br/><br/>We approve your request to extend the deadline for submission of a revised version of the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/17/2014<br/><br/>The updated deadline for submission of the revised manuscript and replay letter is confirmed to August 14, 2014. Please submit them through the following online system by the deadline.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(755,'Approval of your request to extend the revision deadline (14M-07-001, JIPS)','TO: cmdrkim@gmail.com, \nCC: \n*****위와 같은 TO, CC 구성으로 아래 메일 내용이 전달됩니다.*****\nTO: yhhan@koreatech.ac.kr, \nCC: cmdrkim@gmail.com, \n*****위와 같은 TO, CC 구성으로 아래 메일 내용이 전달됩니다.*****\nDear Author,<br/><br/>We approve your request to extend the deadline for submission of a revised version of the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Youn-Hee Han<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/17/2014<br/><br/>The updated deadline for submission of the revised manuscript and replay letter is confirmed to August 14, 2014. Please submit them through the following online system by the deadline.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(756,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(757,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(758,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(759,'Notification of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the following revised manuscript\'s submission to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(760,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(761,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(762,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(763,'Notification of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the following revised manuscript\'s submission to Journal of Information Processing System. The submitted manuscript has been also confirmed by journal manager and the previous version of submitted manuscript has been managed by you who serve as an associate editor.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We would appreciate your efforts on the associate editor\'s process of the above updated manuscript submitted to Journal of Information Processing System. Please visit the following online manuscript submission & peer-review system and make progress on the manuscript\'s review process by selecting proper reviewers.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(764,'Review assignment and the related information (14M-07-001, JIPS)','Dear Mr. Dong-Sun Yang,<br/><br/>There is a following manuscript submitted to Journal of Information Processing System and I believe it falls within your area of expertise and you are a well-qualified scholar. So, we would like to assign you to a reviewer for it.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/><br/>We ask you to complete your review evaluation by August 28, 2014 and provide the comments to our review system. Please click the following url and complete your review.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=neoanimato@gmail.com<br/><br/>If you forgot your password, please click the link in \"Forgot your password?\" section of the page shown by the above URL and insert your email (neoanimato@gmail.com) in the shown input form.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(765,'Re-new your password of ManuscriptLink','Hello, <br/><br/>We have received a request to reset the password for your account at ManuscriptLink (http://www.manuscriptlink.com).<br/>Please follow the link below to reset your password:<br/>http://www.manuscriptlink.com/changePassword?code=xuKspZmSbPorMBbtHdpUdgQTLTtffN<br/><br/><br/>'),(766,'Thank you for reviewing a manuscript (14M-07-001, JIPS)','Dear Mr. Dong-Sun Yang,<br/><br/>Thank you for completing your review for the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/><br/>Your time and effort is greatly appreciated by the journal editorial members and by the authors.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(767,'A manuscript review result report (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of an associate editor (Mr. Chan-Myung Kim)\'s completion of review process for the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please login to the following online system and decide the final review result of the current review round after looking through the associate editor and reviewers\' comments. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(768,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>We have received all review comments from our reviewers on the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Overall review result: Marginal<br/><br/>The second half of this email contains important review comments and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Assuming you address the reviewers\' concerns in a satisfactory manner, you can revise the original manuscript and again submit it to the above online system. <br/><br/>When preparing it, you should write the reply letter including a list of responses to the review comments. The reply letter to the review comments should be uploaded as a separate file in addition to your revised manuscript. Acceptable formats for the reply letter include PDF (preferred) and MS Word.<br/><br/>The deadline for submission of the revised manuscript and replay letter is August 16, 2014. If you have any question regarding the revised manuscript, please contact the journal manager.<br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/>mm decision at re1v\n<br/><br/>- Associate Editor\'s Comments - <br/>review complete at rev111<br/><br/><br/>- Reviewers\' Review Scores and Comments - <br/>Reviewer #1<br/><br/>Familiarity: Medium<br/>Clarity: Good<br/>Significance: Average<br/>Originality: Average<br/>Quality: Average<br/>Language: Average<br/>Relevance: Average<br/>Overall Judgement: Average<br/><br/>review at rev1<br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(769,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>We have received all review comments from our reviewers on the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Overall review result: Marginal<br/><br/>The second half of this email contains important review comments and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Assuming you address the reviewers\' concerns in a satisfactory manner, you can revise the original manuscript and again submit it to the above online system. <br/><br/>When preparing it, you should write the reply letter including a list of responses to the review comments. The reply letter to the review comments should be uploaded as a separate file in addition to your revised manuscript. Acceptable formats for the reply letter include PDF (preferred) and MS Word.<br/><br/>The deadline for submission of the revised manuscript and replay letter is August 16, 2014. If you have any question regarding the revised manuscript, please contact the journal manager.<br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/>mm decision at re1v\n<br/><br/>- Associate Editor\'s Comments - <br/>review complete at rev111<br/><br/><br/>- Reviewers\' Review Scores and Comments - <br/>Reviewer #1<br/><br/>Familiarity: Medium<br/>Clarity: Good<br/>Significance: Average<br/>Originality: Average<br/>Quality: Average<br/>Language: Average<br/>Relevance: Average<br/>Overall Judgement: Average<br/><br/>review at rev1<br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(770,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>We have received all review comments from our reviewers on the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Overall review result: Marginal<br/><br/>The second half of this email contains important review comments and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Assuming you address the reviewers\' concerns in a satisfactory manner, you can revise the original manuscript and again submit it to the above online system. <br/><br/>When preparing it, you should write the reply letter including a list of responses to the review comments. The reply letter to the review comments should be uploaded as a separate file in addition to your revised manuscript. Acceptable formats for the reply letter include PDF (preferred) and MS Word.<br/><br/>The deadline for submission of the revised manuscript and replay letter is August 16, 2014. If you have any question regarding the revised manuscript, please contact the journal manager.<br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/>mm decision at re1v\n<br/><br/>- Associate Editor\'s Comments - <br/>review complete at rev111<br/><br/><br/>- Reviewers\' Review Scores and Comments - <br/>Reviewer #1<br/><br/>Familiarity: Medium<br/>Clarity: Good<br/>Significance: Average<br/>Originality: Average<br/>Quality: Average<br/>Language: Average<br/>Relevance: Average<br/>Overall Judgement: Average<br/><br/>review at rev1<br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(771,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(772,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(773,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(774,'Acknowledgment of a revised manuscript submission (14M-07-001, JIPS)','Dear Dr. dsafd fasf,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>In a couple of days, a confirmation e-mail will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system:<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=coAuthorRev2@nate.com<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(775,'Notification of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the following revised manuscript\'s submission to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(776,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(777,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Youn-Hee Han,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(778,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Prof. Joon-Min Gil,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=jmgil@cu.ac.kr<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(779,'Confirmation of a revised manuscript submission (14M-07-001, JIPS)','Dear Dr. dsafd fasf,<br/><br/>Thank you for submitting a revised version of the following manuscript to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We completely confirm your submission of the above manuscript into Journal of Information Processing System. The above manuscript is accepted for review processing on the understanding that it has not been published elsewhere (or submitted to another journal). Exceptions to this rule are manuscripts containing material disclosed at conferences. You also confirm that the author(s) from various institutions agree with the contents of the submitted manuscript.<br/><br/>We will organize a fast peer-review, and if your manuscript is accepted, the manuscript will be published finally. We aim to process manuscripts quickly. You can check the peer-review process of your manuscript in the following online manuscript submission & peer-review system.<br/> <br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=coAuthorRev2@nate.com<br/><br/>If you have any question regarding your submission, please contact the journal manager while mentioning the manuscript title and ID.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(780,'Notification of a revised manuscript submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the following revised manuscript\'s submission to Journal of Information Processing System. The submitted manuscript has been also confirmed by journal manager and the previous version of submitted manuscript has been managed by you who serve as an associate editor.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>We would appreciate your efforts on the associate editor\'s process of the above updated manuscript submitted to Journal of Information Processing System. Please visit the following online manuscript submission & peer-review system and make progress on the manuscript\'s review process by selecting proper reviewers.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(781,'A manuscript review result report (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of an associate editor (Mr. Chan-Myung Kim)\'s completion of review process for the following manuscript submitted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>Please login to the following online system and decide the final review result of the current review round after looking through the associate editor and reviewers\' comments. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Associate Editor<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(782,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>Congratulations! We are pleased to inform you that we have Accepted your manuscript submitted to Journal of Information Processing System. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>The second half of this email contains important review comments that you must follow to ensure successful publication of your paper, and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>What you should do at the next step is to make your camera-ready paper for the above manuscript. When making your camera-ready paper, please take into consideration all review comments.<br/><br/>Don\'t forget that you should use the following template to make the camera-ready paper.<br/><br/>Camera-ready paper template: http://www.manuscriptlink.com/journals/jips/download/template/cameraReadyTemplate<br/><br/>The deadline for the camera-ready paper submission is August 01, 2014. We cannot guarantee to include your paper in final edition, in case of late submission of your camera-ready paper.<br/><br/>When you submit the camera-ready paper, please fill up the form of copyright transfer agreement, which you can download from the following URL, and include it.<br/><br/>Form of copyright transfer agreement: http://www.manuscriptlink.com/journals/jips/download/template/copyright<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager. <br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/><br/><br/>- Associate Editor\'s Comments - <br/>accept at revision 22222222<br/><br/><br/><br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(783,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>Congratulations! We are pleased to inform you that we have Accepted your manuscript submitted to Journal of Information Processing System. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>The second half of this email contains important review comments that you must follow to ensure successful publication of your paper, and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>What you should do at the next step is to make your camera-ready paper for the above manuscript. When making your camera-ready paper, please take into consideration all review comments.<br/><br/>Don\'t forget that you should use the following template to make the camera-ready paper.<br/><br/>Camera-ready paper template: http://www.manuscriptlink.com/journals/jips/download/template/cameraReadyTemplate<br/><br/>The deadline for the camera-ready paper submission is August 01, 2014. We cannot guarantee to include your paper in final edition, in case of late submission of your camera-ready paper.<br/><br/>When you submit the camera-ready paper, please fill up the form of copyright transfer agreement, which you can download from the following URL, and include it.<br/><br/>Form of copyright transfer agreement: http://www.manuscriptlink.com/journals/jips/download/template/copyright<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager. <br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/><br/><br/>- Associate Editor\'s Comments - <br/>accept at revision 22222222<br/><br/><br/><br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(784,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>Congratulations! We are pleased to inform you that we have Accepted your manuscript submitted to Journal of Information Processing System. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>The second half of this email contains important review comments that you must follow to ensure successful publication of your paper, and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>What you should do at the next step is to make your camera-ready paper for the above manuscript. When making your camera-ready paper, please take into consideration all review comments.<br/><br/>Don\'t forget that you should use the following template to make the camera-ready paper.<br/><br/>Camera-ready paper template: http://www.manuscriptlink.com/journals/jips/download/template/cameraReadyTemplate<br/><br/>The deadline for the camera-ready paper submission is August 01, 2014. We cannot guarantee to include your paper in final edition, in case of late submission of your camera-ready paper.<br/><br/>When you submit the camera-ready paper, please fill up the form of copyright transfer agreement, which you can download from the following URL, and include it.<br/><br/>Form of copyright transfer agreement: http://www.manuscriptlink.com/journals/jips/download/template/copyright<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager. <br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/><br/><br/>- Associate Editor\'s Comments - <br/>accept at revision 22222222<br/><br/><br/><br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(785,'Decision on your manuscript 14M-07-001 submitted to JIPS','Dear Author,<br/><br/>Congratulations! We are pleased to inform you that we have Accepted your manuscript submitted to Journal of Information Processing System. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/><br/>The second half of this email contains important review comments that you must follow to ensure successful publication of your paper, and you can also find them in the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>What you should do at the next step is to make your camera-ready paper for the above manuscript. When making your camera-ready paper, please take into consideration all review comments.<br/><br/>Don\'t forget that you should use the following template to make the camera-ready paper.<br/><br/>Camera-ready paper template: http://www.manuscriptlink.com/journals/jips/download/template/cameraReadyTemplate<br/><br/>The deadline for the camera-ready paper submission is August 01, 2014. We cannot guarantee to include your paper in final edition, in case of late submission of your camera-ready paper.<br/><br/>When you submit the camera-ready paper, please fill up the form of copyright transfer agreement, which you can download from the following URL, and include it.<br/><br/>Form of copyright transfer agreement: http://www.manuscriptlink.com/journals/jips/download/template/copyright<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager. <br/><br/>Thank you for submitting your manuscript to Journal of Information Processing System.<br/><br/>[Review Results]<br/>------------------------<br/>- Chief Editor\'s Comments -<br/><br/><br/>- Associate Editor\'s Comments - <br/>accept at revision 22222222<br/><br/><br/><br/>------------------------<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(786,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(787,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(788,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(789,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(790,'Notification of a camera-ready paper submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the camera-ready version submission of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and determine if the submitted camera-ready paper has problems to make gallery proofs of it.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(791,'Returning the camera-ready paper back (14M-07-001)','Dear Author,<br/><br/>Recently, you have submitted the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>However, we now return it back to you because it has the following problems to make gallery proofs of it.<br/><br/>[The reason to return the submitted camera-ready paper back to the author(s)]<br/>return cameraready 0<br/><br/>Please correct your camera-ready paper again and re-submit it through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the online system.  <br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(792,'Returning the camera-ready paper back (14M-07-001)','Dear Author,<br/><br/>Recently, you have submitted the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>However, we now return it back to you because it has the following problems to make gallery proofs of it.<br/><br/>[The reason to return the submitted camera-ready paper back to the author(s)]<br/>return cameraready 0<br/><br/>Please correct your camera-ready paper again and re-submit it through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the online system.  <br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(793,'Returning the camera-ready paper back (14M-07-001)','Dear Author,<br/><br/>Recently, you have submitted the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>However, we now return it back to you because it has the following problems to make gallery proofs of it.<br/><br/>[The reason to return the submitted camera-ready paper back to the author(s)]<br/>return cameraready 0<br/><br/>Please correct your camera-ready paper again and re-submit it through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the online system.  <br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(794,'Returning the camera-ready paper back (14M-07-001)','Dear Author,<br/><br/>Recently, you have submitted the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>However, we now return it back to you because it has the following problems to make gallery proofs of it.<br/><br/>[The reason to return the submitted camera-ready paper back to the author(s)]<br/>return cameraready 0<br/><br/>Please correct your camera-ready paper again and re-submit it through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the online system.  <br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/><br/>'),(795,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(796,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(797,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(798,'[Before Due Date] Gentle reminder to author(s) for the camera-ready paper submission (14M-07-001, JIPS)','Dear Author,<br/><br/>Thank you for submitting the camera-ready version of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>After looking through the submitted camera-ready paper, we will send a confirmation email to you soon if there is no problem to make gallery proofs of it. Further progress on your camera-ready paper can be checked through the following online system.  <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If you have any question regarding your camera-ready paper, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(799,'Notification of a camera-ready paper submission (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to notify you of the camera-ready version submission of the following manuscript accepted to Journal of Information Processing System.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and determine if the submitted camera-ready paper has problems to make gallery proofs of it.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(800,'Confirmation of the submitted camera-ready paper (14M-07-001, JIPS)','Dear Author,<br/><br/>This mail is to confirm you that the submitted camera-ready version of the following manuscript accepted to Journal of Information Processing System has no problem and it will be used to make the gallery proofs.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>We will contact you again when the gallery proofs of it are ready.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(801,'Confirmation of the submitted camera-ready paper (14M-07-001, JIPS)','Dear Author,<br/><br/>This mail is to confirm you that the submitted camera-ready version of the following manuscript accepted to Journal of Information Processing System has no problem and it will be used to make the gallery proofs.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>We will contact you again when the gallery proofs of it are ready.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(802,'Confirmation of the submitted camera-ready paper (14M-07-001, JIPS)','Dear Author,<br/><br/>This mail is to confirm you that the submitted camera-ready version of the following manuscript accepted to Journal of Information Processing System has no problem and it will be used to make the gallery proofs.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>We will contact you again when the gallery proofs of it are ready.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(803,'Confirmation of the submitted camera-ready paper (14M-07-001, JIPS)','Dear Author,<br/><br/>This mail is to confirm you that the submitted camera-ready version of the following manuscript accepted to Journal of Information Processing System has no problem and it will be used to make the gallery proofs.<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>We will contact you again when the gallery proofs of it are ready.<br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(804,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(805,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(806,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(807,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(808,'Request of Corrections for gallery proofs (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to let you know that some corrections to the gallery proofs of the following manuscript accepted to Journal of Information Processing System have been requested by the author(s).<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>[Author(s)\' requests to make correction to gallery proofs]<br/>dddddddddddddd<br/><br/>Please correct the current gallery proofs according to the requests and upload the corrected version to the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/><br/>'),(809,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(810,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(811,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(812,'Ready for your gallery proofs (14M-07-001, JIPS)','Dear Author,<br/><br/>We are pleased to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System are ready. <br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please login to the following online system and look though the gallery proofs of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips<br/><br/>If there are some requests to you at the gallery proofs, please let us know your addition or update based on the requests through any ways. In addition to that, you find any problems on the gallery proofs, please let us know it also. If you think that the current gallery proofs can be published as there are, please confirm it through the online system. <br/><br/>Best regards,<br/><br/>Mr. Chan-Myung Kim, Journal Manager<br/>Journal of Information Processing System<br/>Email: cmdrkim@gmail.com<br/>Homepage: http://jips-k.org<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/><br/><br/>'),(813,'Confirm gallery proofs (14M-07-001, JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>This mail is to let you know that the gallery proofs of the following manuscript accepted to Journal of Information Processing System have been finally confirmed by the author(s).<br/><br/>Manuscript ID: 14M-07-001<br/>Title: A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2<br/>Author(s): Chan-Myung Kim, Youn-Hee Han, Joon-Min Gil, dsafd fasf<br/>Corresponding Author: Joon-Min Gil<br/>Affiliation of Corresponding Author: CU<br/>Date of Manuscript Submission: 07/17/2014<br/>Date of Review Result Report: 07/16/2014<br/>Date of Camera-ready Paper Submission: 07/16/2014<br/><br/>Please make progress on publication with the current gallery proofs and change the manuscript\'s status into \"Published\" in the following online system after the successful publication of it. <br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(814,'Acknowledgment of a new manuscript submission (JIPS)','Dear Mr. Chan-Myung Kim,<br/><br/>Thank you for submitting the following manuscript to Journal of Information Processing System.<br/><br/>Title: testtttttttt<br/>Author(s): Chan-Myung Kim<br/>Corresponding Author: Chan-Myung Kim<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/18/2014<br/><br/>In a couple of days, a confirmation e-mail including the manuscript ID will be again forwarded to you when we look through your submission and confirm it. Further progress on your submission can be checked through the following online system.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>If you have any question regarding your submission, please contact the journal manager.<br/><br/>Best regards,<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(815,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: testtttttttt<br/>Author(s): Chan-Myung Kim<br/>Corresponding Author: Chan-Myung Kim<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/18/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=cmdrkim@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(816,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: testtttttttt<br/>Author(s): Chan-Myung Kim<br/>Corresponding Author: Chan-Myung Kim<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/18/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=yhhan@koreatech.ac.kr<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(817,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: testtttttttt<br/>Author(s): Chan-Myung Kim<br/>Corresponding Author: Chan-Myung Kim<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/18/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=neoanimato@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>'),(818,'Notification of a new manuscript submission (JIPS)','Dear Journal Manager,<br/><br/>This mail is to notify you of the following manuscript submission to Journal of Information Processing System.<br/><br/>Title: testtttttttt<br/>Author(s): Chan-Myung Kim<br/>Corresponding Author: Chan-Myung Kim<br/>Affiliation of Corresponding Author: MANUSCRIPTLINK<br/>Date of Manuscript Submission: 07/18/2014<br/><br/>Please visit the following online manuscript submission & peer-review system, and confirm the newly submitted manuscript after looking through the submission information.<br/><br/>* Online System URL: http://www.manuscriptlink.com/journals/jips?id=armhwa@gmail.com<br/><br/>Manager of ManuscriptLink<br/><br/>=============[Note]=============<br/>This email is only for the delivery service. <br/>Please do not reply to this mail.<br/> <br/><br/>');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
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
  KEY `A_FK1_idx` (`USER_ID`),
  KEY `A_FK2_idx` (`JOURNAL_ID`),
  KEY `A_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `A_FK1_C` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `A_FK2_C` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `A_FK3_C` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_associate_editors`
--

LOCK TABLES `journal_associate_editors` WRITE;
/*!40000 ALTER TABLE `journal_associate_editors` DISABLE KEYS */;
INSERT INTO `journal_associate_editors` VALUES (1,3,1,15),(2,4,1,16),(3,3,2,31),(4,4,2,37),(5,6,2,55),(7,5,2,57),(8,5,1,58);
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
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_categories`
--

LOCK TABLES `journal_categories` WRITE;
/*!40000 ALTER TABLE `journal_categories` DISABLE KEYS */;
INSERT INTO `journal_categories` VALUES (200,2,'0.5'),(201,2,'0.9'),(202,2,'0.11'),(213,1,'0.1');
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
  KEY `CE_FK1_idx` (`USER_ID`),
  KEY `CE_FK2_idx` (`JOURNAL_ID`),
  KEY `CE_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `CE_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CE_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CE_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_chief_editors`
--

LOCK TABLES `journal_chief_editors` WRITE;
/*!40000 ALTER TABLE `journal_chief_editors` DISABLE KEYS */;
INSERT INTO `journal_chief_editors` VALUES (1,3,1,11),(2,4,1,12),(3,3,2,29),(4,4,2,39),(5,5,2,47),(6,5,1,48),(8,6,2,50),(12,6,1,181);
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
INSERT INTO `journal_configuration` VALUES (1,1,5,1,1,0,1,1,1,3,6,2,7,2,2,30,15,7,7,7,3,3,3,'http://www.manuscriptlink.com/journals/jips/download/template/frontCover',NULL,'http://www.manuscriptlink.com/journals/jips/download/template/cameraReadyTemplate','http://www.manuscriptlink.com/journals/jips/download/template/copyright',2,'Confirm that this paper has been submitted solely to this journal and is not published, in press, or submitted elsewhere.','I have prepared this paper in accordance with the journal\'s style and format requirements.',NULL,NULL,NULL,'<span class=\"wysiwyg-color-purple\">adsfasdfasdf</span>','ttttttttttttttzzzzzzz<br>','ssdafsdfsj','rrrrrrrrrrrr','ffffffffffffffffff',7,1,2,3,4,5,6,7,0,0,0,0,1,1,1,0,1,0),(2,2,-1,0,0,0,0,0,0,3,6,2,7,2,7,30,15,7,7,7,3,3,3,'http://www.manuscriptlink.com/journals/kips/download/template/frontCover','http://www.manuscriptlink.com/journals/kips/download/template/checkList','http://www.manuscriptlink.com/journals/kips/download/template/cameraReadyTemplate','http://www.manuscriptlink.com/journals/kips/download/template/copyright',2,'test111','test222',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,1,2,3,4,5,0,0,0,0,0,0,0,0,0,0,0,0);
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
  KEY `GE_FK1_idx` (`USER_ID`),
  KEY `GE_FK2_idx` (`JOURNAL_ID`),
  KEY `GE_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `GE_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GE_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `GE_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_guest_editors`
--

LOCK TABLES `journal_guest_editors` WRITE;
/*!40000 ALTER TABLE `journal_guest_editors` DISABLE KEYS */;
INSERT INTO `journal_guest_editors` VALUES (1,3,1,13),(2,4,1,14),(3,3,2,30),(4,4,2,38),(5,5,1,51),(6,5,2,52),(8,6,2,54),(10,6,1,161);
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
  KEY `JM_FK1_idx` (`USER_ID`),
  KEY `JM_FK2_idx` (`JOURNAL_ID`),
  KEY `JM_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `JM_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JM_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JM_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_managers`
--

LOCK TABLES `journal_managers` WRITE;
/*!40000 ALTER TABLE `journal_managers` DISABLE KEYS */;
INSERT INTO `journal_managers` VALUES (1,4,1,6),(2,3,1,10),(3,3,2,22),(4,4,2,40),(5,5,1,42),(6,6,1,43),(7,5,2,45),(8,6,2,46);
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
  KEY `FK_JOURNAL_MEMBER_JOURANLS` (`JOURNAL_ID`),
  KEY `FK_JOURNAL_MEMBER_USERS` (`USER_ID`),
  KEY `FK_JOURNAL_MEMBER_AUTHORITIES` (`AUTHORITY_ID`),
  CONSTRAINT `FK_JOURNAL_MEMBER_AUTHORITIES_C` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_JOURNAL_MEMBER_JOURANLS_C` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_JOURNAL_MEMBER_USERS_C` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_members`
--

LOCK TABLES `journal_members` WRITE;
/*!40000 ALTER TABLE `journal_members` DISABLE KEYS */;
INSERT INTO `journal_members` VALUES (1,4,1,5),(2,3,1,7),(3,3,2,21),(4,5,2,24),(5,6,2,26),(6,4,2,35),(7,5,1,41),(8,6,1,44),(21,1,2,132),(22,2,2,134);
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
  KEY `JR_FK1_idx` (`USER_ID`),
  KEY `JR_FK2_idx` (`JOURNAL_ID`),
  KEY `JR_FK3_idx` (`AUTHORITY_ID`),
  CONSTRAINT `JR_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JR_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `JR_FK3` FOREIGN KEY (`AUTHORITY_ID`) REFERENCES `authorities` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
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
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_uploaded_files`
--

LOCK TABLES `journal_uploaded_files` WRITE;
/*!40000 ALTER TABLE `journal_uploaded_files` DISABLE KEYS */;
INSERT INTO `journal_uploaded_files` VALUES (103,4,2,'frontCover2319820416058817759Centroid_based_Movement_Assisted_Sensor_Deployment_Schemes.pdf','frontCover','2014-06-14','08:41:09','C:\\var\\jms\\kips\\template\\frontCover\\frontCover2319820416058817759Centroid_based_Movement_Assisted_Sensor_Deployment_Schemes.pdf','Centroid_based_Movement_Assisted_Sensor_Deployment_Schemes.pdf',NULL),(104,4,2,'checkList9051701133938541801Mobile_sensor_network_deployment_using_potential_fields.pdf','checkList','2014-06-14','08:41:17','C:\\var\\jms\\kips\\template\\checkList\\checkList9051701133938541801Mobile_sensor_network_deployment_using_potential_fields.pdf','Mobile sensor network deployment using potential fields.pdf',NULL),(127,4,2,'cameraReadyTemplate5262639317502697874Connectivity-Guaranteed_and_Obstacle-Adaptive_Deployment_Schemes_for_Mobile_Sensor_Networks.pdf','cameraReadyTemplate','2014-06-16','02:08:10','C:\\var\\jms\\kips\\template\\cameraReadyTemplate\\cameraReadyTemplate5262639317502697874Connectivity-Guaranteed_and_Obstacle-Adaptive_Deployment_Schemes_for_Mobile_Sensor_Networks.pdf','Connectivity-Guaranteed and Obstacle-Adaptive Deployment Schemes for Mobile Sensor Networks.pdf',NULL),(128,4,2,'copyright6942374655108557011Distributed_Deployment_Schemes_for_Mobile_Wireless_Sensor_Networks_to_Ensure_Multilevel_Coverage.pdf','copyright','2014-06-16','02:08:12','C:\\var\\jms\\kips\\template\\copyright\\copyright6942374655108557011Distributed_Deployment_Schemes_for_Mobile_Wireless_Sensor_Networks_to_Ensure_Multilevel_Coverage.pdf','Distributed Deployment Schemes for Mobile Wireless Sensor Networks to Ensure Multilevel Coverage.pdf',NULL),(131,4,1,'cameraReadyTemplate_4047093611907856081.pdf','cameraReadyTemplate','2014-06-20','22:49:52','C:\\var\\jms\\jips\\template\\cameraReadyTemplate\\cameraReadyTemplate_4047093611907856081.pdf','cameraReadyTemplate_4047093611907856081.pdf',NULL),(132,4,1,'copyright_7846501528512161348.pdf','copyright','2014-06-20','22:49:55','C:\\var\\jms\\jips\\template\\copyright\\copyright_7846501528512161348.pdf','copyright_7846501528512161348.pdf',NULL),(135,4,1,'frontCover_7501515949018353628.pdf','frontCover','2014-07-18','14:12:54','C:\\var\\jms\\jips\\template\\frontCover\\frontCover_7501515949018353628.pdf','frontCover_7501515949018353628.pdf',NULL);
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
  `TYPE_ID` int(11) unsigned NOT NULL,
  `TRACK_ID` int(11) unsigned NOT NULL,
  `STATUS` varchar(1) DEFAULT NULL,
  `TITLE` varchar(500) DEFAULT NULL,
  `SPECIAL_ISSUE_ID` int(10) unsigned NOT NULL DEFAULT '0',
  `INVITE` tinyint(1) DEFAULT '0',
  `COVERLETTER` varchar(4000) DEFAULT NULL,
  `DIVISION_ID` int(11) DEFAULT NULL,
  `SUBMIT_STEP` int(10) DEFAULT NULL,
  `REVISION_COUNT` int(10) unsigned DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts`
--

LOCK TABLES `manuscripts` WRITE;
/*!40000 ALTER TABLE `manuscripts` DISABLE KEYS */;
INSERT INTO `manuscripts` VALUES (1,'14M-07-001',1,4,0,0,'P','A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2',0,0,'cover letter at rev222',0,5,2,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2',' rev22 This paper presents a genetic algorithmic approach to the shortest path (SP) routing problem. Variable-length chromosomes (strings) and their genes (parameters) have been used for encoding the problem. The crossover operation exchanges partial chromosomes (partial routes) at positionally independent crossing sites and the mutation operation maintains the genetic diversity of the population. The proposed algorithm can cure all the infeasible chromosomes with a simple repair function. Crossover and mutation together provide a search capability that results in improved quality of solution and enhanced rate of convergence. This paper also develops a population-sizing equation that facilitates a solution with desired quality. It is based on the gambler’s ruin model; the equation has been further enhanced and generalized, however. The equation relates the size of the population, the quality of solution, the cardinality of the alphabet, and other parameters of the proposed algorithm. Computer simulations show that the proposed algorithm exhibits a much better quality of solution (route optimality) and a much higher rate of convergence than other algorithms. The results are relatively independent of problem types (network sizes and topologies) for almost all source–destination pairs. Furthermore, simulation studies emphasize the usefulness of the population-sizing equation. The equation scales to larger networks. It is felt that it can be used for determining an adequate population size (for a desired quality of solution) in the SP routing problem.',4,0,4,4,'2014-07-17','10:04:25',1,1,0,0,0,'T',1,1,1,1,0,'2014-08-16','08:07:53','2014-08-01','16:41:28'),(2,NULL,1,4,0,0,'B','ddddddddddddddddddddddd',0,0,'dddddddddddddddd',0,3,0,'dddddddddddddddddddddddd','dddddddddddddddddddddddddd',0,0,0,0,NULL,NULL,0,0,0,0,0,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL),(3,NULL,1,4,0,0,'B',NULL,0,0,NULL,0,0,0,NULL,NULL,0,0,0,0,NULL,NULL,0,0,0,0,0,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL),(4,NULL,1,4,0,0,'I','testtttttttt',0,0,'dddddddddddddddddddddddddddd',0,5,0,'ttttttttttttt','tttttttttttttttttttttttttttttt',0,0,0,0,NULL,NULL,1,1,0,0,0,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL);
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
  `REVISION_COUNT` int(10) unsigned NOT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MANUSCRIPT_ABSTRACT_1` (`MANUSCRIPT_ID`),
  CONSTRAINT `FK_MANUSCRIPT_ABSTRACT_1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_abstract`
--

LOCK TABLES `manuscripts_abstract` WRITE;
/*!40000 ALTER TABLE `manuscripts_abstract` DISABLE KEYS */;
INSERT INTO `manuscripts_abstract` VALUES (1,'This paper presents a genetic algorithmic approach to the shortest path (SP) routing problem. Variable-length chromosomes (strings) and their genes (parameters) have been used for encoding the problem. The crossover operation exchanges partial chromosomes (partial routes) at positionally independent crossing sites and the mutation operation maintains the genetic diversity of the population. The proposed algorithm can cure all the infeasible chromosomes with a simple repair function. Crossover and mutation together provide a search capability that results in improved quality of solution and enhanced rate of convergence. This paper also develops a population-sizing equation that facilitates a solution with desired quality. It is based on the gambler’s ruin model; the equation has been further enhanced and generalized, however. The equation relates the size of the population, the quality of solution, the cardinality of the alphabet, and other parameters of the proposed algorithm. Computer simulations show that the proposed algorithm exhibits a much better quality of solution (route optimality) and a much higher rate of convergence than other algorithms. The results are relatively independent of problem types (network sizes and topologies) for almost all source–destination pairs. Furthermore, simulation studies emphasize the usefulness of the population-sizing equation. The equation scales to larger networks. It is felt that it can be used for determining an adequate population size (for a desired quality of solution) in the SP routing problem.',0,1),(2,' rev2 This paper presents a genetic algorithmic approach to the shortest path (SP) routing problem. Variable-length chromosomes (strings) and their genes (parameters) have been used for encoding the problem. The crossover operation exchanges partial chromosomes (partial routes) at positionally independent crossing sites and the mutation operation maintains the genetic diversity of the population. The proposed algorithm can cure all the infeasible chromosomes with a simple repair function. Crossover and mutation together provide a search capability that results in improved quality of solution and enhanced rate of convergence. This paper also develops a population-sizing equation that facilitates a solution with desired quality. It is based on the gambler’s ruin model; the equation has been further enhanced and generalized, however. The equation relates the size of the population, the quality of solution, the cardinality of the alphabet, and other parameters of the proposed algorithm. Computer simulations show that the proposed algorithm exhibits a much better quality of solution (route optimality) and a much higher rate of convergence than other algorithms. The results are relatively independent of problem types (network sizes and topologies) for almost all source–destination pairs. Furthermore, simulation studies emphasize the usefulness of the population-sizing equation. The equation scales to larger networks. It is felt that it can be used for determining an adequate population size (for a desired quality of solution) in the SP routing problem.',1,1),(3,' rev22 This paper presents a genetic algorithmic approach to the shortest path (SP) routing problem. Variable-length chromosomes (strings) and their genes (parameters) have been used for encoding the problem. The crossover operation exchanges partial chromosomes (partial routes) at positionally independent crossing sites and the mutation operation maintains the genetic diversity of the population. The proposed algorithm can cure all the infeasible chromosomes with a simple repair function. Crossover and mutation together provide a search capability that results in improved quality of solution and enhanced rate of convergence. This paper also develops a population-sizing equation that facilitates a solution with desired quality. It is based on the gambler’s ruin model; the equation has been further enhanced and generalized, however. The equation relates the size of the population, the quality of solution, the cardinality of the alphabet, and other parameters of the proposed algorithm. Computer simulations show that the proposed algorithm exhibits a much better quality of solution (route optimality) and a much higher rate of convergence than other algorithms. The results are relatively independent of problem types (network sizes and topologies) for almost all source–destination pairs. Furthermore, simulation studies emphasize the usefulness of the population-sizing equation. The equation scales to larger networks. It is felt that it can be used for determining an adequate population size (for a desired quality of solution) in the SP routing problem.',2,1),(4,'dddddddddddddddddddddddddd',0,2),(5,'tttttttttttttttttttttttttttttt',0,4);
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
  `REVISION_COUNT` int(10) unsigned NOT NULL,
  `AUTHOR_ORDER` int(10) unsigned NOT NULL,
  `USER_ID` int(32) unsigned NOT NULL,
  `CORRESPONDING` tinyint(1) DEFAULT '0',
  `CREATED_MEMBER` tinyint(1) DEFAULT '0',
  `TEMP_PW` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`MANUSCRIPT_ID`,`USER_ID`,`REVISION_COUNT`),
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
INSERT INTO `manuscripts_coauthors` VALUES (1,1,2,3,0,0,NULL),(1,2,2,3,0,0,NULL),(1,1,1,4,0,0,NULL),(1,2,1,4,0,0,NULL),(1,1,3,78,1,0,NULL),(1,2,3,78,1,0,NULL),(1,2,4,79,0,0,NULL),(2,0,1,4,1,0,NULL),(3,0,1,4,1,0,NULL),(4,0,1,4,1,0,NULL);
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
  `REVISION_COUNT` int(11) DEFAULT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `FROM_ROLE` varchar(100) DEFAULT NULL,
  `TO_ROLE` varchar(100) DEFAULT NULL,
  `TEXT` varchar(4500) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_comments`
--

LOCK TABLES `manuscripts_comments` WRITE;
/*!40000 ALTER TABLE `manuscripts_comments` DISABLE KEYS */;
INSERT INTO `manuscripts_comments` VALUES (1,4,4,1,0,1,'ROLE_C-EDITOR','ROLE_A-EDITOR','dafsdfasdfasdfasdf',1,'O','2014-07-17','17:04:25',0,0),(2,4,3,1,0,1,'ROLE_REVIEWER','ROLE_MEMBER','ddddddddddddfasdfadsf',0,'R','2014-07-17','17:19:19',0,0),(3,4,4,1,0,1,'ROLE_REVIEWER','ROLE_A-EDITOR','asdfasdfasdfasdf',1,'R','2014-07-17','17:19:19',0,0),(4,4,4,1,0,1,'ROLE_A-EDITOR','ROLE_C-EDITOR','asdfasdfasdfasdf',1,'R','2014-07-17','17:50:18',0,0),(5,4,3,1,0,1,'ROLE_A-EDITOR','ROLE_MEMBER','asdfasdfasdfasdf',1,'R','2014-07-17','17:50:18',0,0),(6,4,3,1,0,1,'ROLE_C-EDITOR','ROLE_MEMBER','fffffffffff',1,'E','2014-07-17','17:51:26',0,0),(7,5,4,1,1,1,'ROLE_REVIEWER','ROLE_MEMBER','review at rev1',0,'R','2014-07-17','18:59:48',0,0),(8,5,4,1,1,1,'ROLE_REVIEWER','ROLE_A-EDITOR','review at rev1',1,'R','2014-07-17','18:59:48',0,0),(9,4,4,1,1,1,'ROLE_A-EDITOR','ROLE_C-EDITOR','review complete at rev1',1,'R','2014-07-17','19:00:49',0,0),(10,4,4,1,1,1,'ROLE_A-EDITOR','ROLE_MEMBER','review complete at rev111',1,'R','2014-07-17','19:00:49',0,0),(11,4,4,1,1,1,'ROLE_C-EDITOR','ROLE_MEMBER','mm decision at re1v',1,'E','2014-07-17','19:07:53',0,0),(12,4,4,1,2,1,'ROLE_A-EDITOR','ROLE_C-EDITOR','accept at revision 2',1,'R','2014-07-17','19:40:38',0,0),(13,4,4,1,2,1,'ROLE_A-EDITOR','ROLE_MEMBER','accept at revision 22222222',1,'R','2014-07-17','19:40:38',0,0),(14,4,4,1,2,1,'ROLE_MANAGER','ROLE_MEMBER','return cameraready 0',0,'M','2014-07-17','20:19:16',0,0),(15,4,4,1,2,1,'ROLE_MEMBER','ROLE_MANAGER','dddddddddddddd',1,'G','2014-07-17','20:38:24',0,0);
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
  `REVISION_COUNT` int(11) DEFAULT NULL,
  `COVERLETTER` varchar(4500) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `MC_FK1_idx` (`MANUSCRIPT_ID`,`REVISION_COUNT`),
  CONSTRAINT `MC_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_coverletter`
--

LOCK TABLES `manuscripts_coverletter` WRITE;
/*!40000 ALTER TABLE `manuscripts_coverletter` DISABLE KEYS */;
INSERT INTO `manuscripts_coverletter` VALUES (1,1,0,'cover letter at original'),(2,1,1,'cover letter at rev2'),(3,1,2,'cover letter at rev222'),(4,2,0,'dddddddddddddddd'),(5,4,0,'dddddddddddddddddddddddddddd');
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
  `REVISION_COUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EVENT_DATE_FK1_idx` (`MANUSCRIPT_ID`),
  CONSTRAINT `EVENT_DATE_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_event_date`
--

LOCK TABLES `manuscripts_event_date` WRITE;
/*!40000 ALTER TABLE `manuscripts_event_date` DISABLE KEYS */;
INSERT INTO `manuscripts_event_date` VALUES (1,1,'B','2014-07-17','16:44:10',0),(2,1,'I','2014-07-17','16:49:55',0),(3,1,'B','2014-07-17','16:51:23',0),(4,1,'I','2014-07-17','17:02:35',0),(5,1,'O','2014-07-17','17:03:57',0),(6,1,'O','2014-07-17','17:04:25',0),(7,1,'D','2014-07-17','17:51:26',1),(8,1,'V','2014-07-17','18:34:53',1),(9,1,'R','2014-07-17','18:54:57',1),(10,1,'D','2014-07-17','19:07:53',2),(11,1,'V','2014-07-17','19:28:43',2),(12,1,'R','2014-07-17','19:34:53',2),(13,1,'A','2014-07-17','19:41:28',2),(14,1,'M','2014-07-17','20:11:51',2),(15,1,'M','2014-07-17','20:19:39',2),(16,1,'G','2014-07-17','20:23:39',2),(17,1,'G','2014-07-17','20:38:58',2),(18,1,'P','2014-07-17','20:41:35',2),(19,2,'B','2014-07-18','02:21:55',0),(20,3,'B','2014-07-18','02:25:34',0),(21,4,'B','2014-07-18','10:35:33',0),(22,4,'I','2014-07-18','10:36:47',0);
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
  `REVISION_COUNT` int(11) DEFAULT NULL,
  `EDITOR_RECOMMEND` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `MFD_FK1_idx` (`USER_ID`),
  KEY `MFD_FK2_idx` (`JOURNAL_ID`),
  KEY `MFD_FK3_idx` (`MANUSCRIPT_ID`),
  CONSTRAINT `MFD_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MFD_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MFD_FK3` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_final_decision`
--

LOCK TABLES `manuscripts_final_decision` WRITE;
/*!40000 ALTER TABLE `manuscripts_final_decision` DISABLE KEYS */;
INSERT INTO `manuscripts_final_decision` VALUES (1,4,1,1,3,0,4),(2,4,1,1,3,1,3),(3,4,1,1,4,2,4);
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
  `REVISION_COUNT` int(32) NOT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  `KEYWORD` varchar(70) NOT NULL,
  `JOURNAL_ID` int(32) unsigned NOT NULL,
  `USER_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`,`REVISION_COUNT`,`MANUSCRIPT_ID`),
  KEY `KEY1` (`REVISION_COUNT`),
  KEY `KEY2` (`MANUSCRIPT_ID`),
  KEY `MK_FK1` (`USER_ID`),
  KEY `MK_FK2` (`JOURNAL_ID`),
  CONSTRAINT `MK_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MK_FK2` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MK_FK3` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_keyword`
--

LOCK TABLES `manuscripts_keyword` WRITE;
/*!40000 ALTER TABLE `manuscripts_keyword` DISABLE KEYS */;
INSERT INTO `manuscripts_keyword` VALUES (5,0,1,'Terms—Gambler’s ruin model',1,3),(6,0,1,'genetic algorithms',1,3),(7,0,1,'population size',1,3),(8,0,1,'shortest path routing problem',1,3),(13,1,1,'Terms—Gambler’s ruin model',1,3),(14,1,1,'genetic algorithms',1,3),(15,1,1,'population size',1,3),(16,1,1,'shortest path routing problem',1,3),(17,1,1,'rev2',1,3),(23,2,1,'Terms—Gambler’s ruin model',1,4),(24,2,1,'genetic algorithms',1,4),(25,2,1,'population size',1,4),(26,2,1,'shortest path routing problem',1,4),(27,2,1,'rev22',1,4),(29,0,2,'ddd',1,4),(30,0,4,'ddddddddd',1,4);
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
  `REVISION_COUNT` int(10) unsigned DEFAULT NULL,
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
  KEY `INDEX_ACCOUNTID` (`USER_ID`),
  KEY `INDEX_MANUSCRIPTID` (`MANUSCRIPT_ID`),
  KEY `ID` (`ID`),
  KEY `MR_FK3_idx` (`JOURNAL_ID`),
  CONSTRAINT `MR_FK1` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MR_FK2` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `MR_FK3` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review`
--

LOCK TABLES `manuscripts_review` WRITE;
/*!40000 ALTER TABLE `manuscripts_review` DISABLE KEYS */;
INSERT INTO `manuscripts_review` VALUES (1,4,1,1,'C','2014-08-28','17:18:20',3,4,4,4,4,3,3,0,0,0,3,0,0,NULL,0,NULL,0,NULL,1,2,3,4,5,6,7,0,0,0,7),(2,6,1,1,'S',NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,NULL,0,'S',0,NULL,0,0,0,0,0,0,0,0,0,0,0),(3,3,1,1,'M','2014-08-28','17:17:41',0,0,0,0,0,0,0,0,0,0,0,1,0,NULL,0,'A',0,NULL,0,0,0,0,0,0,0,0,0,0,0),(4,5,1,1,'M',NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,0,'2014-07-19',0,'I',0,NULL,0,0,0,0,0,0,0,0,0,0,0),(5,5,1,1,'C','2014-08-28','23:57:48',3,4,3,3,3,3,3,0,0,0,3,0,1,NULL,2,NULL,0,NULL,1,2,3,4,5,6,7,0,0,0,7),(6,5,1,1,'S',NULL,NULL,0,0,0,0,0,0,0,0,0,0,0,0,2,NULL,2,NULL,0,NULL,0,0,0,0,0,0,0,0,0,0,0);
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
  `DEGREE` varchar(40) DEFAULT NULL,
  `SALUTATION` varchar(5) DEFAULT NULL,
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
  `REVISION_COUNT` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `RED_FK1_idx` (`MANUSCRIPT_ID`),
  KEY `RED_FK2_idx` (`USER_ID`),
  KEY `RED_FK3_idx` (`JOURNAL_ID`),
  CONSTRAINT `RED_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RED_FK2` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RED_FK3` FOREIGN KEY (`JOURNAL_ID`) REFERENCES `journals` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_event_date`
--

LOCK TABLES `manuscripts_review_event_date` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_event_date` DISABLE KEYS */;
INSERT INTO `manuscripts_review_event_date` VALUES (1,4,1,1,'S','2014-07-17','17:14:37',0),(2,6,1,1,'S','2014-07-17','17:14:51',0),(3,3,1,1,'S','2014-07-17','17:14:57',0),(4,3,1,1,'A','2014-07-17','17:17:41',0),(5,5,1,1,'S','2014-07-17','17:18:00',0),(6,5,1,1,'I','2014-07-17','17:18:08',0),(7,4,1,1,'A','2014-07-17','17:18:20',0),(8,4,1,1,'C','2014-07-17','17:19:19',0),(9,3,1,1,'M','2014-07-17','17:50:17',0),(10,5,1,1,'M','2014-07-17','17:50:18',0),(11,5,1,1,'S','2014-07-17','18:57:41',1),(12,5,1,1,'A','2014-07-17','18:57:48',1),(13,5,1,1,'C','2014-07-17','18:59:48',1);
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
  `REVISION_COUNT` int(10) unsigned DEFAULT NULL,
  `FIRST_NAME` varchar(45) DEFAULT NULL,
  `LAST_NAME` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(45) NOT NULL,
  `INSTITUTION` varchar(45) DEFAULT NULL,
  `DEGREE` varchar(40) NOT NULL,
  `SALUTATION` varchar(5) NOT NULL,
  `COUNTRY_CODE` char(3) NOT NULL,
  `DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_DEPARTMENT` varchar(70) DEFAULT NULL,
  `LOCAL_INSTITUTION` varchar(70) DEFAULT NULL,
  `LOCAL_FULL_NAME` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_1_C` (`MANUSCRIPT_ID`),
  CONSTRAINT `MRP_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_preferences`
--

LOCK TABLES `manuscripts_review_preferences` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_preferences` DISABLE KEYS */;
INSERT INTO `manuscripts_review_preferences` VALUES (1,6,1,1,'SeungIl','Hyeon','armhwa@gmail.com','MANUSCRIPTLINK','2','2','KR',NULL,NULL,NULL,NULL),(2,0,1,1,'Reviewer','Preference','rptest@rp.net','rp','0','0','MA','rp',NULL,NULL,NULL),(3,0,1,1,'sdf','asdfas','rprev1@nate.com','asdfasdf','0','0','BR','asdfasdf',NULL,NULL,NULL),(4,6,1,2,'SeungIl','Hyeon','armhwa@gmail.com','MANUSCRIPTLINK','2','2','KR',NULL,NULL,NULL,NULL),(5,0,1,2,'Reviewer','Preference','rptest@rp.net','rp','0','0','MA','rp',NULL,NULL,NULL),(6,0,1,2,'sdf','asdfas','rprev1@nate.com','asdfasdf','0','0','BR','asdfasdf',NULL,NULL,NULL),(7,6,2,0,'SeungIl','Hyeon','armhwa@gmail.com','MANUSCRIPTLINK','2','2','KR',NULL,NULL,NULL,NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_review_request`
--

LOCK TABLES `manuscripts_review_request` WRITE;
/*!40000 ALTER TABLE `manuscripts_review_request` DISABLE KEYS */;
INSERT INTO `manuscripts_review_request` VALUES (1,'aa782041b4884b5a8b13c55eb05b2e4f',1,4,5,4,0);
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
  `REVISION_COUNT` int(10) unsigned NOT NULL,
  `RUNNINGHEAD` varchar(300) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MANUSCRIPT_RUNNINGHEAD_1` (`MANUSCRIPT_ID`),
  CONSTRAINT `MRH_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_runninghead`
--

LOCK TABLES `manuscripts_runninghead` WRITE;
/*!40000 ALTER TABLE `manuscripts_runninghead` DISABLE KEYS */;
INSERT INTO `manuscripts_runninghead` VALUES (1,1,0,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations'),(2,1,1,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2'),(3,1,2,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2'),(4,2,0,'dddddddddddddddddddddddd'),(5,4,0,'ttttttttttttt');
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
  `REVISION_COUNT` int(10) unsigned NOT NULL,
  `MANUSCRIPT_ID` int(32) unsigned NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_MANUSCRIPTTITLE_1` (`MANUSCRIPT_ID`) USING BTREE,
  CONSTRAINT `TITLE_FK1` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_title`
--

LOCK TABLES `manuscripts_title` WRITE;
/*!40000 ALTER TABLE `manuscripts_title` DISABLE KEYS */;
INSERT INTO `manuscripts_title` VALUES (1,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations',0,1),(2,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2',1,1),(3,'A Genetic Algorithm for Shortest Path Routing Problem and the Sizing of Populations rev2',2,1),(4,'ddddddddddddddddddddddd',0,2),(5,'testtttttttt',0,4);
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
  `REVISION_COUNT` int(10) unsigned NOT NULL,
  `CONFIRM` tinyint(1) NOT NULL DEFAULT '0',
  `GALLERY_PROOF_REVISION` int(10) unsigned DEFAULT '0',
  `CAMERA_READY_REVISION` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `FK_UPLOADEDFILES_1` (`MANUSCRIPT_ID`),
  CONSTRAINT `FK_UPLOADEDFILES_1_C` FOREIGN KEY (`MANUSCRIPT_ID`) REFERENCES `manuscripts` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manuscripts_uploaded_files`
--

LOCK TABLES `manuscripts_uploaded_files` WRITE;
/*!40000 ALTER TABLE `manuscripts_uploaded_files` DISABLE KEYS */;
INSERT INTO `manuscripts_uploaded_files` VALUES (1,1,3,'file901817731514032892mainDocument-1-[14M-07-001]-Original.pdf','mainDocument','2014-07-17','21:49:03','C:\\var\\jms\\jips\\2014\\14M-07-001\\0\\mainDocument\\file901817731514032892mainDocument-1-[14M-07-001]-Original.pdf',NULL,'mainDocument-1-[14M-07-001]-Original.pdf',0,1,0,0),(2,1,3,'file8454506878290807365frontCover-1-[14M-07-001]-Original.pdf','frontCover','2014-07-17','21:49:08','C:\\var\\jms\\jips\\2014\\14M-07-001\\0\\frontCover\\file8454506878290807365frontCover-1-[14M-07-001]-Original.pdf',NULL,'frontCover-1-[14M-07-001]-Original.pdf',0,1,0,0),(3,1,3,'file7146538855410027656checkList-1-[14M-07-001]-Original.pdf','checkList','2014-07-17','21:49:16','C:\\var\\jms\\jips\\2014\\14M-07-001\\0\\checkList\\file7146538855410027656checkList-1-[14M-07-001]-Original.pdf',NULL,'checkList-1-[14M-07-001]-Original.pdf',0,1,0,0),(4,1,4,'additionalReviewResults_8160793990186585902.pdf','additionalReviewResults','2014-07-17','17:19:10','C:\\var\\jms\\jips\\2014\\1\\0\\additionalReviewResults\\additionalReviewResults_8160793990186585902.pdf',NULL,'additionalReviewResults_8160793990186585902.pdf',0,1,0,0),(5,1,3,'file7145655356383276764mainDocument-1-[14M-07-001]-Revision-1.pdf','mainDocument','2014-07-17','23:30:29','C:\\var\\jms\\jips\\2014\\14M-07-001\\1\\mainDocument\\file7145655356383276764mainDocument-1-[14M-07-001]-Revision-1.pdf',NULL,'mainDocument-1-[14M-07-001]-Revision-1.pdf',1,1,0,0),(6,1,3,'frontCover_9058119285728770382.pdf','frontCover','2014-07-17','18:30:33','C:\\var\\jms\\jips\\2014\\1\\1\\frontCover\\frontCover_9058119285728770382.pdf',NULL,'frontCover_9058119285728770382.pdf',1,0,0,0),(7,1,3,'checkList_8253926662181567452.pdf','checkList','2014-07-17','18:30:41','C:\\var\\jms\\jips\\2014\\1\\1\\checkList\\checkList_8253926662181567452.pdf',NULL,'checkList_8253926662181567452.pdf',1,0,0,0),(8,1,4,'file3349719605694375560mainDocument-1-[14M-07-001]-Revision-2.pdf','mainDocument','2014-07-17','00:28:24','C:\\var\\jms\\jips\\2014\\14M-07-001\\2\\mainDocument\\file3349719605694375560mainDocument-1-[14M-07-001]-Revision-2.pdf',NULL,'mainDocument-1-[14M-07-001]-Revision-2.pdf',2,1,0,0),(9,1,4,'frontCover_4624158735680989359.pdf','frontCover','2014-07-17','19:28:28','C:\\var\\jms\\jips\\2014\\1\\2\\frontCover\\frontCover_4624158735680989359.pdf',NULL,'frontCover_4624158735680989359.pdf',2,0,0,0),(10,1,4,'checkList_8872041204250078380.pdf','checkList','2014-07-17','19:28:34','C:\\var\\jms\\jips\\2014\\1\\2\\checkList\\checkList_8872041204250078380.pdf',NULL,'checkList_8872041204250078380.pdf',2,0,0,0),(11,1,4,'file7018413384140377765cameraReadyPaper-1-[14M-07-001]-Original.pdf','cameraReadyPaper','2014-07-17','01:09:59','C:\\var\\jms\\jips\\2014\\14M-07-001\\2\\cameraReadyPaper\\file7018413384140377765cameraReadyPaper-1-[14M-07-001]-Original.pdf',NULL,'cameraReadyPaper-1-[14M-07-001]-Original.pdf',2,1,0,0),(12,1,4,'file1766916202787481227cameraReadyPaper-2-[14M-07-001]-Revision-1.pdf','cameraReadyPaper','2014-07-17','01:19:29','C:\\var\\jms\\jips\\2014\\14M-07-001\\2\\cameraReadyPaper\\file1766916202787481227cameraReadyPaper-2-[14M-07-001]-Revision-1.pdf',NULL,'cameraReadyPaper-2-[14M-07-001]-Revision-1.pdf',2,1,0,1),(13,1,4,'file3879208788852491681GalleryProof-1-[14M-07-001]-Original.pdf','galleryProof','2014-07-17','06:22:05','C:\\var\\jms\\jips\\2014\\14M-07-001\\2\\galleryProof\\file3879208788852491681GalleryProof-1-[14M-07-001]-Original.pdf',NULL,'GalleryProof-1-[14M-07-001]-Original.pdf',2,1,0,1),(14,1,4,'file8873930100266565756GalleryProofCorrection-1-[14M-07-001]-ReplyToGalleryProof-Original.pdf','galleryProofCorrectionRequest','2014-07-17','01:28:34','C:\\var\\jms\\jips\\2014\\14M-07-001\\2\\galleryProofCorrectionRequest\\file8873930100266565756GalleryProofCorrection-1-[14M-07-001]-ReplyToGalleryProof-Original.pdf',NULL,'GalleryProofCorrection-1-[14M-07-001]-ReplyToGalleryProof-Original.pdf',2,1,0,1),(15,1,4,'file7816227461983474911GalleryProof-2-[14M-07-001]-Revision-1.pdf','galleryProof','2014-07-17','01:38:51','C:\\var\\jms\\jips\\2014\\14M-07-001\\2\\galleryProof\\file7816227461983474911GalleryProof-2-[14M-07-001]-Revision-1.pdf',NULL,'GalleryProof-2-[14M-07-001]-Revision-1.pdf',2,1,1,1),(16,4,4,'mainDocument_8412335108745783021.pdf','mainDocument','2014-07-18','14:36:35','C:\\var\\jms\\jips\\2014\\4\\0\\mainDocument\\mainDocument_8412335108745783021.pdf',NULL,'mainDocument_8412335108745783021.pdf',0,0,0,0),(17,4,4,'frontCover_3315692493656170512.pdf','frontCover','2014-07-18','14:36:38','C:\\var\\jms\\jips\\2014\\4\\0\\frontCover\\frontCover_3315692493656170512.pdf',NULL,'frontCover_3315692493656170512.pdf',0,0,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submitted_manuscripts`
--

LOCK TABLES `submitted_manuscripts` WRITE;
/*!40000 ALTER TABLE `submitted_manuscripts` DISABLE KEYS */;
INSERT INTO `submitted_manuscripts` VALUES (6,1,14,7,1);
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
  `USER_ID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `EXPERTISE_FK1_idx` (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_expertises`
--

LOCK TABLES `user_expertises` WRITE;
/*!40000 ALTER TABLE `user_expertises` DISABLE KEYS */;
INSERT INTO `user_expertises` VALUES (109,'Terms—Gambler’s Ruin Model',4),(110,'Terms—Gambler’s Ruin Model',3),(111,'Terms—Gambler’s Ruin Model',78),(112,'Genetic Algorithms',4),(113,'Genetic Algorithms',3),(114,'Genetic Algorithms',78),(115,'Population Size',4),(116,'Population Size',3),(117,'Population Size',78),(118,'Shortest Path Routing Problem',4),(119,'Shortest Path Routing Problem',3),(120,'Shortest Path Routing Problem',78),(121,'Rev2',4),(122,'Rev2',3),(123,'Rev2',78),(124,'Terms—Gambler’s ruin model',5),(125,'genetic algorithms',5),(126,'population size',5),(127,'shortest path routing problem',5),(128,'rev2',5),(129,'Terms—Gambler’s Ruin Model',79),(130,'Genetic Algorithms',79),(131,'Population Size',79),(132,'Shortest Path Routing Problem',79),(133,'Rev22',4),(134,'Rev22',3),(135,'Rev22',78),(136,'Rev22',79),(137,'Ddddddddd',4);
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
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'support@manuscriptlink.com','5eec56eaff43e0c92641044bb1b792c2bed84afa09400742fd386760c061d710','2014-05-15','08:17:54',1),(2,'no-reply@manuscriptlink.com','7cf2ed9022330ca04073527a6da90a61f3fd187738a152947ee02a73784aa025','2014-05-15','08:18:24',1),(3,'yhhan@koreatech.ac.kr','8a3e15205fb79ee7998b7f495b0ed5feaf9537d4c3b144f46f25109d0a9388d6','2014-05-15','04:19:07',1),(4,'cmdrkim@gmail.com','98a9963bfba879b370c70e00f7f60d6356c8ffdb60c2696da7a06e0ac545c17b','2014-05-15','01:19:34',1),(5,'neoanimato@gmail.com','b9a7d8fadaaa8ee7e0822959df91e1357d171d0802f26bce8673557293f97281','2014-05-18','14:59:19',1),(6,'armhwa@gmail.com','1aa319d9af2730d7ed7376fc1d3b058f2f0c66bd1d660b857f8dcecc42727390','2014-05-18','10:01:35',1),(78,'jmgil@cu.ac.kr','d69420945ca9509371a918b64a180f57f000a163c5198f3699cb2f5684bdbc3b','2014-07-17','16:47:56',1),(79,'coAuthorRev2@nate.com','af61e492e93a0bb4b0971072f4d83acd600a3e909d37b8daaf1a9e7c581270b7','2014-07-17','23:28:37',1);
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

-- Dump completed on 2014-07-18 10:40:01
