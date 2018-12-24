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

/*Table structure for table `ttsstkentrustsec00` */

DROP TABLE IF EXISTS `ttsstkentrustsec00`;

CREATE TABLE `ttsstkentrustsec00` (
  `Fi_entrustsecno` int(11) NOT NULL,
  `Fi_requestno` int(11) NOT NULL AUTO_INCREMENT,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fs_entrustbs` char(1) NOT NULL,
  `Fd_optentrustprice` decimal(14,4) NOT NULL,
  `Fi_entrustamount` int(11) NOT NULL,
  `Fd_businessprice` decimal(15,4) NOT NULL,
  `Fi_businessamount` int(11) NOT NULL,
  `Fs_entruststatus` char(1) NOT NULL,
  `Fs_entrustprop` varchar(3) NOT NULL,
  `Fs_cancelinfo` varchar(32) DEFAULT NULL,
  `Fi_withdrawamount` int(11) NOT NULL,
  `Fs_meetingseq` varchar(10) DEFAULT NULL,
  `Fs_orderid` varchar(10) DEFAULT NULL,
  `Fs_origorderid` varchar(10) DEFAULT NULL,
  `Ft_Entrustseccrttime` datetime NOT NULL,
  `Ft_Entrustsecupdtime` datetime NOT NULL,
  `Fs_OrderResean` varchar(10000) DEFAULT NULL,
  `Fs_EnforceSell` varchar(1) NOT NULL DEFAULT '0',
  `Fs_TaddN` varchar(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`Fi_entrustsecno`),
  UNIQUE KEY `idx_ttsstkentrustsec00_1` (`Fi_requestno`) USING BTREE,
  KEY `idx_ttsstkentrustsec00_2` (`Fs_marketcode`,`Fs_stockcode`) USING BTREE,
  KEY `idx_ttsstkentrustsec00_3` (`Fs_secacct`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
