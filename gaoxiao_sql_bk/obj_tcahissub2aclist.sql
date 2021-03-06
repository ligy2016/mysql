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

/*Table structure for table `tcahissub2aclist` */

CREATE TABLE `tcahissub2aclist` (
  `Fi_acno` int(11) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `fi_sub2fuacct` int(11) NOT NULL,
  `Fs_amttype` char(3) NOT NULL,
  `Fs_amtocctype` char(3) NOT NULL,
  `Fi_dric` int(11) NOT NULL,
  `Fd_amt` decimal(38,4) NOT NULL,
  `Fs_trdtype` varchar(32) DEFAULT NULL,
  `Fs_trdorderno` varchar(32) DEFAULT NULL,
  `Ft_regtime` datetime NOT NULL,
  `Ft_updtime` datetime NOT NULL,
  `Fi_status` int(11) NOT NULL,
  `Fs_correctdtl` varchar(1024) DEFAULT NULL,
  `Fs_settdate` char(8) NOT NULL,
  PRIMARY KEY (`Fs_settdate`,`Fi_acno`),
  KEY `idx_tcahissub2aclist_1` (`fs_fuacct`,`fi_sub2fuacct`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
