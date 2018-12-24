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

/*Table structure for table `ttsoptexedeliver00` */

CREATE TABLE `ttsoptexedeliver00` (
  `Fi_exedeliverno` int(11) NOT NULL AUTO_INCREMENT,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_optioncode` char(8) NOT NULL,
  `Fs_exedelivertype` char(1) NOT NULL,
  `Fi_sourceno` int(11) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_optcontractid` varchar(32) NOT NULL,
  `Fs_optionname` varchar(32) NOT NULL,
  `Fs_optiontype` char(1) NOT NULL,
  `Fd_exerciseprice` decimal(18,6) NOT NULL,
  `Fi_exerciseamount` int(11) NOT NULL,
  `Fd_exefrozenbalance` decimal(18,2) NOT NULL,
  `Fi_clearamount` int(11) NOT NULL,
  `Fi_settleamount` int(11) NOT NULL,
  `Fd_optcashamount` decimal(18,2) NOT NULL,
  `Fd_clearbalance` decimal(18,2) NOT NULL,
  `Fd_optcashbalance` decimal(18,2) NOT NULL,
  `Fs_realstatus` char(1) NOT NULL,
  `Ft_exedelivercrttime` datetime NOT NULL,
  `Ft_exedeliverupdtime` datetime NOT NULL,
  PRIMARY KEY (`Fi_exedeliverno`),
  KEY `idx_ttsoptexedeliver00_1` (`Fs_exedelivertype`,`Fi_sourceno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
