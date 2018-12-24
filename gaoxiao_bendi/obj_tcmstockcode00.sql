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

/*Table structure for table `tcmstockcode00` */

DROP TABLE IF EXISTS `tcmstockcode00`;

CREATE TABLE `tcmstockcode00` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_kindcode` varchar(32) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fs_substocktype` varchar(4) DEFAULT NULL,
  `Fs_stockname` varchar(32) NOT NULL,
  `Fs_currency` varchar(4) NOT NULL,
  `Fi_buyunit` int(11) NOT NULL,
  `Fi_pricestep` int(11) NOT NULL,
  `Fi_storeunit` int(11) NOT NULL,
  `Fd_upprice` decimal(14,3) NOT NULL,
  `Fd_downprice` decimal(14,3) NOT NULL,
  `Fi_highamount` int(11) NOT NULL,
  `Fi_lowamount` int(11) NOT NULL,
  `Fd_highbalance` decimal(18,2) NOT NULL,
  `Fd_lowbalance` decimal(18,2) NOT NULL,
  `Fs_stockrealback` char(1) NOT NULL,
  `Fs_fundrealback` char(1) NOT NULL,
  `Fs_delistflag` char(1) NOT NULL,
  `Fs_delistdate` char(8) NOT NULL,
  `Fd_parvalue` decimal(15,4) NOT NULL,
  `Fs_stbtranstype` char(1) DEFAULT NULL,
  `Fs_stbtransstatus` char(1) DEFAULT NULL,
  `Fs_exdividendflag` char(1) NOT NULL,
  `Fi_marketmakeramount` int(11) NOT NULL,
  `Fs_stkcodestatus` char(1) NOT NULL,
  `Fs_stkcodectrlstr` varchar(32) DEFAULT NULL,
  `Fd_closeprice` decimal(15,4) NOT NULL,
  `Fd_openprice` decimal(15,4) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  `Fs_stocknamesimple` varchar(8) DEFAULT NULL COMMENT '中文名称拼音首字母',
  PRIMARY KEY (`Fs_marketcode`,`Fs_stockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
