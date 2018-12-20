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

/*Table structure for table `tptoption00` */

DROP TABLE IF EXISTS `tptoption00`;

CREATE TABLE `tptoption00` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_optioncode` char(8) NOT NULL,
  `Fs_optholdtype` char(1) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_optcontractid` varchar(32) NOT NULL,
  `Fs_optionname` varchar(32) NOT NULL,
  `Fs_optiontype` char(1) NOT NULL,
  `Fi_currentamount` int(11) NOT NULL,
  `Fi_holdamount` int(11) NOT NULL,
  `Fi_enableamount` int(11) NOT NULL,
  `Fd_optcombusedamount` decimal(18,2) NOT NULL,
  `Fi_realopenamount` int(11) NOT NULL,
  `Fi_realdropamount` int(11) NOT NULL,
  `Fi_entrustdropamount` int(11) NOT NULL,
  `Fd_lastprice` decimal(19,3) NOT NULL,
  `Fd_optlastprice` decimal(15,4) NOT NULL,
  `Fd_optcostprice` decimal(18,6) NOT NULL,
  `Fd_exerciseprice` decimal(18,6) NOT NULL,
  `Fd_marketvalue` decimal(18,2) NOT NULL,
  `Fd_costbalance` decimal(18,2) NOT NULL,
  `Fd_incomebalance` decimal(18,2) NOT NULL,
  `Fd_exerciseincome` decimal(18,2) NOT NULL,
  `Fd_exerciseprofitratio` decimal(17,8) NOT NULL,
  `Fd_dutyusedbail` decimal(18,2) NOT NULL,
  `Fd_realholdmargin` decimal(18,2) NOT NULL,
  `Fd_staticholdmargin` decimal(18,2) NOT NULL,
  `Fs_exercisedate` char(8) NOT NULL,
  `Fi_amountperhand` int(11) NOT NULL,
  `Fd_sttlmntprice` decimal(15,4) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  PRIMARY KEY (`Fs_marketcode`,`Fs_secacct`,`Fs_optioncode`,`Fs_optholdtype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
