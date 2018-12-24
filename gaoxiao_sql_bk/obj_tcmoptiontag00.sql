/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.7.20-log : Database - feps
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `feps`;

/*Table structure for table `tcmoptiontag00` */

CREATE TABLE `tcmoptiontag00` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_kindcode` varchar(32) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fs_stockname` varchar(32) NOT NULL,
  `Fd_lastprice` decimal(19,4) DEFAULT NULL,
  `Fi_amountperhand` int(11) NOT NULL,
  `Fs_underlystatus` char(1) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  PRIMARY KEY (`Fs_marketcode`,`Fs_stockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
