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

/*Table structure for table `tcuoptinvriskctl00` */

CREATE TABLE `tcuoptinvriskctl00` (
  `Fs_clientid` char(18) NOT NULL,
  `Fs_branchno` char(5) NOT NULL,
  `Fs_clientname` varchar(128) NOT NULL,
  `Fs_papertype` char(1) NOT NULL,
  `Fs_organflag` char(1) NOT NULL,
  `Fs_optlevel` char(1) NOT NULL,
  `Fs_paperanswer` varchar(2000) NOT NULL,
  `Fi_paperscore` int(11) NOT NULL,
  `Fs_remark` varchar(2000) DEFAULT NULL,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fi_firstlevelscore` int(11) NOT NULL,
  `Fi_secondlevelscore` int(11) NOT NULL,
  `Fi_thirdlevelscore` int(11) NOT NULL,
  `Fs_regdate` char(8) DEFAULT NULL,
  `Fs_crdtexistsflag` char(1) NOT NULL,
  `Fs_spiffirstexchdate` char(8) DEFAULT NULL,
  `Fd_marketvalue` decimal(18,2) NOT NULL,
  `Fd_bailbalance` decimal(18,2) NOT NULL,
  `Fs_simulatetradeflag` char(1) NOT NULL,
  `Fs_riskbegindate` char(8) NOT NULL,
  `Fs_riskenddate` char(8) NOT NULL,
  `Fd_purapplyquota` decimal(18,2) NOT NULL,
  `Fd_totalasset` decimal(18,2) NOT NULL,
  `Fd_avgmarketvalue` decimal(18,2) NOT NULL,
  `Fd_avgmarketvaluesh` decimal(18,2) NOT NULL,
  `Fd_avgmarketvaluesz` decimal(18,2) NOT NULL,
  PRIMARY KEY (`Fs_clientid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
