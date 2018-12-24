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

/*Table structure for table `tpthisstock00` */

CREATE TABLE `tpthisstock00` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fs_stockname` varchar(32) NOT NULL,
  `Fi_currentamount` int(11) NOT NULL,
  `Fi_holdamount` int(11) NOT NULL,
  `Fi_enableamount` int(11) NOT NULL,
  `Fi_realbuyamount` int(11) NOT NULL,
  `Fi_realsellamount` int(11) NOT NULL,
  `Fi_uncomebuyamount` int(11) NOT NULL,
  `Fi_uncomesellamount` int(11) NOT NULL,
  `Fi_entrustsellamount` int(11) NOT NULL,
  `Fd_lastprice` decimal(19,4) NOT NULL,
  `Fd_costprice` decimal(14,3) NOT NULL,
  `Fd_keepcostprice` decimal(14,3) NOT NULL,
  `Fd_incomebalance` decimal(18,2) NOT NULL,
  `Fs_handflag` char(1) DEFAULT NULL,
  `Fd_marketvalue` decimal(18,2) NOT NULL,
  `Fd_avbuyprice` decimal(15,4) NOT NULL,
  `Fd_avincomebalance` decimal(18,2) NOT NULL,
  `Fd_costbalance` decimal(18,2) NOT NULL,
  `Fs_delistflag` char(1) NOT NULL,
  `Fs_delistdate` char(8) DEFAULT NULL,
  `Fd_parvalue` decimal(15,4) NOT NULL,
  `Fd_incomebalancenofare` decimal(18,2) NOT NULL,
  `Fi_frozenamount` int(11) NOT NULL,
  `Fd_profitratio` decimal(18,2) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  `Fi_lockamount` int(11) NOT NULL,
  `Fi_realbuylockamount` int(11) NOT NULL,
  `Fi_exefroenbleamt` int(11) NOT NULL,
  `Fi_exefrobuyamt` int(11) NOT NULL,
  `Fi_todayisexp` int(11) NOT NULL,
  `Fi_todayisexi` int(11) NOT NULL,
  `Fs_TrnDate` char(8) NOT NULL,
  PRIMARY KEY (`Fs_marketcode`,`Fs_secacct`,`Fs_stockcode`,`Fs_TrnDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
