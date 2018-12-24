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

/*Table structure for table `tcasub3aclist` */

DROP TABLE IF EXISTS `tcasub3aclist`;

CREATE TABLE `tcasub3aclist` (
  `Fi_acno` int(11) NOT NULL,
  `Fi_subno` int(11) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `fi_sub2fuacct` int(11) NOT NULL,
  `fi_sub3fuacct` int(11) NOT NULL,
  `Fi_dric` int(11) NOT NULL,
  `Fd_amt` decimal(38,4) NOT NULL,
  `Fi_status` int(11) NOT NULL,
  PRIMARY KEY (`Fi_acno`,`Fi_subno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
