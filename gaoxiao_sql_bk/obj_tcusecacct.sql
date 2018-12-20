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
CREATE DATABASE /*!32312 IF NOT EXISTS*/`feps` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `feps`;

/*Table structure for table `tcusecacct` */

DROP TABLE IF EXISTS `tcusecacct`;

CREATE TABLE `tcusecacct` (
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_clientid` varchar(18) NOT NULL,
  `Fi_secaccttype` int(11) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `Fs_corrsecacct` varchar(18) DEFAULT NULL,
  `Fi_usage` int(11) NOT NULL,
  `Fs_usagecode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`Fs_secacct`),
  UNIQUE KEY `idx_tcusecacct_1` (`Fs_clientid`,`Fi_secaccttype`,`Fi_usage`,`Fs_usagecode`) USING BTREE,
  KEY `idx_tcusecacct_2` (`Fs_clientid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
