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

/*Table structure for table `ttshisoptbusisec00` */

CREATE TABLE `ttshisoptbusisec00` (
  `Fi_businessecno` int(11) NOT NULL,
  `Fi_entrustsecno` int(11) NOT NULL,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_optioncode` char(8) NOT NULL,
  `Fs_entrustbs` char(1) NOT NULL,
  `Fs_entrustoc` char(1) NOT NULL,
  `Fs_coveredflag` char(1) NOT NULL,
  `Fd_optbusinessprice` decimal(15,4) NOT NULL,
  `Fi_businessamount` int(11) NOT NULL,
  `Fs_realstatus` char(1) NOT NULL,
  `Fi_businesstimes` int(11) NOT NULL,
  `Ft_businesscrttime` datetime NOT NULL,
  `Ft_businessupdtime` datetime NOT NULL,
  `Fd_businessbalance` decimal(18,2) NOT NULL,
  `Fs_TrnDate` char(8) NOT NULL,
  `Fd_fare0` decimal(15,3) NOT NULL,
  `Fd_fare1` decimal(15,3) NOT NULL,
  `Fd_fare2` decimal(15,3) NOT NULL,
  `Fd_fare3` decimal(15,3) NOT NULL,
  `Fd_fare4` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Fs_TrnDate`,`Fi_businessecno`),
  KEY `idx_ttshisoptbusisec00_1` (`Fi_entrustsecno`) USING BTREE,
  KEY `idx_ttshisoptbusisec00_2` (`Fs_secacct`) USING BTREE,
  KEY `idx_ttshisoptbusisec00_3` (`Fs_marketcode`,`Fs_optioncode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
