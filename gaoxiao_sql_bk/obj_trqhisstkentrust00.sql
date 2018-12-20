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

/*Table structure for table `trqhisstkentrust00` */

DROP TABLE IF EXISTS `trqhisstkentrust00`;

CREATE TABLE `trqhisstkentrust00` (
  `Fi_entrustno` int(11) NOT NULL,
  `Ft_entrusttime` datetime NOT NULL,
  `Fs_opbranchno` char(5) NOT NULL,
  `Fs_opentrustway` char(1) NOT NULL,
  `Fs_opstation` varchar(255) NOT NULL,
  `Fs_branchno` char(5) NOT NULL,
  `Fs_clientid` char(18) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fi_entrustamount` int(11) NOT NULL,
  `Fd_optentrustprice` decimal(14,4) NOT NULL,
  `Fs_entrustbs` char(1) NOT NULL,
  `Fs_entrustprop` varchar(3) NOT NULL,
  `Fs_registersureflag` char(1) DEFAULT NULL,
  `Fs_meetingseq` varchar(10) DEFAULT NULL,
  `Fs_orderid` varchar(10) DEFAULT NULL,
  `Fs_origorderid` varchar(10) DEFAULT '0',
  `Fi_requestno` int(11) DEFAULT NULL,
  `Ft_requesttime` datetime NOT NULL,
  `Fs_TrnDate` char(8) NOT NULL,
  PRIMARY KEY (`Fi_entrustno`,`Fs_TrnDate`),
  KEY `idx_trqhisstkentrust00_1` (`Fs_branchno`) USING BTREE,
  KEY `idx_trqhisstkentrust00_2` (`Fs_clientid`) USING BTREE,
  KEY `idx_trqhisstkentrust00_3` (`Fs_marketcode`,`Fs_stockcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
