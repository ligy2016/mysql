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

/*Table structure for table `tstatistics` */

DROP TABLE IF EXISTS `tstatistics`;

CREATE TABLE `tstatistics` (
  `Fs_raceid` varchar(18) NOT NULL,
  `fs_seacct` varchar(18) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `Ft_date` date NOT NULL,
  `fd_preasset` decimal(32,4) NOT NULL COMMENT '前一个交易日资产值',
  `fd_hisweekprofit` decimal(32,4) NOT NULL,
  `fd_weekprofit` decimal(32,4) NOT NULL,
  `fd_hismonthprofit` decimal(32,4) NOT NULL,
  `fd_monthprofit` decimal(32,4) NOT NULL,
  `fd_todaymarketvalue` decimal(32,4) NOT NULL,
  `fd_todaybal` decimal(32,4) NOT NULL,
  `fd_todayprofit` decimal(32,4) NOT NULL,
  `fd_hisweekamount` decimal(32,4) NOT NULL,
  `fd_weekamount` decimal(32,4) NOT NULL,
  `fd_hismonthamount` decimal(32,4) NOT NULL,
  `fd_monthamount` decimal(32,4) NOT NULL,
  `fd_todayamount` decimal(32,4) NOT NULL,
  `fd_totalamount` decimal(32,4) NOT NULL,
  `fi_hisweekfreq` int(11) NOT NULL,
  `fi_weekfreq` int(11) NOT NULL,
  `fi_hismonthfreq` int(11) NOT NULL,
  `fi_monthfreq` int(11) NOT NULL,
  `fi_todayfreq` int(11) NOT NULL,
  PRIMARY KEY (`Fs_raceid`,`fs_seacct`),
  UNIQUE KEY `idx_fuacct` (`fs_fuacct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
