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

/*Table structure for table `tcmoptioncode00` */

DROP TABLE IF EXISTS `tcmoptioncode00`;

CREATE TABLE `tcmoptioncode00` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_kindcode` varchar(32) NOT NULL,
  `Fs_optioncode` char(8) NOT NULL,
  `Fs_optcontractid` varchar(32) NOT NULL,
  `Fs_optionname` varchar(32) NOT NULL,
  `Fs_optiontype` char(1) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fs_tagmarketcode` varchar(32) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_currency` varchar(4) NOT NULL,
  `Fi_amountperhand` int(11) NOT NULL,
  `Fs_optionmode` char(1) NOT NULL,
  `Fd_optcloseprice` decimal(15,4) NOT NULL,
  `Fd_closeprice` decimal(15,4) NOT NULL,
  `Fd_optupprice` decimal(18,6) NOT NULL,
  `Fd_optdownprice` decimal(18,6) NOT NULL,
  `Fd_exerciseprice` decimal(18,6) NOT NULL,
  `Fd_initperbalance` decimal(18,2) NOT NULL,
  `Fi_limithighamount` int(11) NOT NULL,
  `Fi_limitlowamount` int(11) NOT NULL,
  `Fi_mkthighamount` int(11) NOT NULL,
  `Fi_mktlowamount` int(11) NOT NULL,
  `Fs_begindate` char(8) NOT NULL,
  `Fs_enddate` char(8) NOT NULL,
  `Fs_exebegindate` char(8) NOT NULL,
  `Fs_exeenddate` char(8) NOT NULL,
  `Fs_optcodestatus` char(1) NOT NULL,
  `Fs_optupdatedstatus` char(1) NOT NULL,
  `Fi_optionversion` int(11) NOT NULL,
  `Fs_optopenstatus` char(1) NOT NULL,
  `Fs_optionflag` char(1) NOT NULL,
  `Fs_optfinalstatus` char(1) NOT NULL,
  `Fd_optpricestep` decimal(15,4) NOT NULL,
  `Fs_active` char(1) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  PRIMARY KEY (`Fs_marketcode`,`Fs_optioncode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
