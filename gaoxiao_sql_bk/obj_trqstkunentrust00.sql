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

/*Table structure for table `trqstkunentrust00` */

CREATE TABLE `trqstkunentrust00` (
  `Fi_entrustno` int(11) NOT NULL AUTO_INCREMENT,
  `Ft_unentrusttime` datetime NOT NULL,
  `Fs_opbranchno` char(5) NOT NULL,
  `Fs_opentrustway` char(1) NOT NULL,
  `Fs_opstation` varchar(255) NOT NULL,
  `Fs_branchno` char(5) NOT NULL,
  `Fs_clientid` char(18) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fi_Orgentrustno` int(11) NOT NULL,
  `Fi_Orgreportno` int(11) NOT NULL,
  `Ft_requesttime` datetime NOT NULL,
  PRIMARY KEY (`Fi_entrustno`),
  KEY `idx_trqstkunentrust00_1` (`Fs_branchno`) USING BTREE,
  KEY `idx_trqstkunentrust00_2` (`Fi_Orgentrustno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
