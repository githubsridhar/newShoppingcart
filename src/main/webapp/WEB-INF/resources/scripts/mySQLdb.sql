DROP DATABASE IF EXISTS `shoppingcart`;
CREATE DATABASE  IF NOT EXISTS `shoppingcart` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `shoppingcart`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: shoppingcart
-- ------------------------------------------------------
-- Server version	5.7.18-log

--
-- Table structure for table `users`
--
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `customerId` int(11) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `Users`
--
LOCK TABLES `Users` WRITE;
INSERT INTO `Users` VALUES (1,0,1,'admin','admin');
UNLOCK TABLES;

--
-- Table structure for table `authorities`
--
DROP TABLE IF EXISTS `Authorities`;
CREATE TABLE `Authorities` (
  `authoritiesId` int(11) NOT NULL AUTO_INCREMENT,
  `authority` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`authoritiesId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
--
-- Dumping data for table `authorities`
--
LOCK TABLES `Authorities` WRITE;
INSERT INTO `Authorities` VALUES (1,'ROLE_ADMIN','admin');
UNLOCK TABLES;

--
-- Table structure for table `product`
--
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `pcondition` varchar(45) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `units` int(11) DEFAULT NULL,
  `manufacturer` varchar(45) DEFAULT NULL,
  `imageUrl` longtext,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

--
-- Table structure for table `customer`
--
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `customerId` int(11) NOT NULL AUTO_INCREMENT,
  `customerEmail` varchar(255) NOT NULL,
  `customerName` varchar(255) NOT NULL,
  `customerPhone` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `cartId` int(11) DEFAULT NULL,
  PRIMARY KEY (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


--
-- Table structure for table `billingaddress`
--
DROP TABLE IF EXISTS `billingaddress`;
CREATE TABLE `billingaddress` (
  `billingAddressId` int(11) NOT NULL AUTO_INCREMENT,
  `apartmentNumber` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `streetName` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`billingAddressId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


--
-- Table structure for table `shippingaddress`
--
DROP TABLE IF EXISTS `shippingaddress`;
CREATE TABLE `shippingaddress` (
  `shippingAddressId` int(11) NOT NULL AUTO_INCREMENT,
  `apartmentNumber` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `streetName` varchar(255) DEFAULT NULL,
  `zipCode` varchar(255) DEFAULT NULL,
  `customer_customerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`shippingAddressId`),
  KEY `FKBB1EE46BDA5054B` (`customer_customerId`),
  CONSTRAINT `FKBB1EE46BDA5054B` FOREIGN KEY (`customer_customerId`) REFERENCES `customer` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


--
-- Table structure for table `cart`
--
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `cartId` int(11) NOT NULL AUTO_INCREMENT,
  `grandTotal` double NOT NULL,
  `customerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`cartId`),
  KEY `FK1FEF40270264A` (`customerId`),
  CONSTRAINT `FK1FEF40270264A` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;


--
-- Table structure for table `cartitem`
--
DROP TABLE IF EXISTS `cartitem`;
CREATE TABLE `cartitem` (
  `cartItemId` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `totalPrice` double NOT NULL,
  `cartId` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  PRIMARY KEY (`cartItemId`),
  KEY `FK4393E732EF8C5CE` (`cartId`),
  KEY `FK4393E73E73FD6B7` (`pid`),
  CONSTRAINT `FK4393E732EF8C5CE` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`),
  CONSTRAINT `FK4393E73E73FD6B7` FOREIGN KEY (`pid`) REFERENCES `product` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;


--
-- Table structure for table `customerorder`
--
DROP TABLE IF EXISTS `customerorder`;
CREATE TABLE `customerorder` (
  `customerOrderId` int(11) NOT NULL AUTO_INCREMENT,
  `billingAddressId` int(11) DEFAULT NULL,
  `cartId` int(11) DEFAULT NULL,
  `customerId` int(11) DEFAULT NULL,
  `shippingAddressId` int(11) DEFAULT NULL,
  PRIMARY KEY (`customerOrderId`),
  KEY `FKAEF781F02EF8C5CE` (`cartId`),
  KEY `FKAEF781F0270264A` (`customerId`),
  KEY `FKAEF781F0140D5834` (`shippingAddressId`),
  KEY `FKAEF781F0B2042BA0` (`billingAddressId`),
  CONSTRAINT `FKAEF781F0140D5834` FOREIGN KEY (`shippingAddressId`) REFERENCES `shippingaddress` (`shippingAddressId`),
  CONSTRAINT `FKAEF781F0270264A` FOREIGN KEY (`customerId`) REFERENCES `customer` (`customerId`),
  CONSTRAINT `FKAEF781F02EF8C5CE` FOREIGN KEY (`cartId`) REFERENCES `cart` (`cartId`),
  CONSTRAINT `FKAEF781F0B2042BA0` FOREIGN KEY (`billingAddressId`) REFERENCES `billingaddress` (`billingAddressId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
