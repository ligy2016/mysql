/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.6.10 : Database - gaoxiao_local
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `gaoxiao_local`;

/*Table structure for table `tcufuacct` */

DROP TABLE IF EXISTS `tcufuacct`;

CREATE TABLE `tcufuacct` (
  `fs_fuacct` varchar(18) NOT NULL,
  `Fs_clientid` varchar(18) NOT NULL,
  `Fi_fuaccttype` int(11) NOT NULL,
  `Fs_pwd` varchar(64) NOT NULL,
  `Fi_riskctl` int(11) NOT NULL,
  `Fi_usage` int(11) NOT NULL,
  `Fs_usagecode` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`fs_fuacct`),
  UNIQUE KEY `idx_tcufuacct_1` (`Fs_clientid`,`Fi_fuaccttype`,`Fi_usage`,`Fs_usagecode`) USING BTREE,
  KEY `idx_tcufuacct` (`Fs_clientid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
