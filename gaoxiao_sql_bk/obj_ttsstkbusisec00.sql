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

/*Table structure for table `ttsstkbusisec00` */

CREATE TABLE `ttsstkbusisec00` (
  `Fi_businessecno` int(11) NOT NULL AUTO_INCREMENT,
  `Fi_entrustsecno` int(11) NOT NULL,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_stockcode` char(6) NOT NULL,
  `Fs_stocktype` varchar(4) NOT NULL,
  `Fs_entrustbs` char(1) NOT NULL,
  `Fd_businessprice` decimal(15,4) NOT NULL,
  `Fi_businessamount` int(11) NOT NULL,
  `Fs_realstatus` char(1) NOT NULL,
  `Fi_businesstimes` int(11) NOT NULL,
  `Fs_orderid` varchar(10) DEFAULT NULL,
  `Fs_origorderid` varchar(10) DEFAULT NULL,
  `Ft_businesscrttime` datetime NOT NULL,
  `Ft_businessupdtime` datetime NOT NULL,
  `Fd_businessbalance` decimal(18,2) NOT NULL,
  `Fs_EnforceSell` varchar(1) NOT NULL,
  `Fd_occurmoney` decimal(18,2) NOT NULL COMMENT '发生额:发生额就是所有的金额，包括成交金额和费用',
  `Fd_exchangefare1` decimal(18,2) NOT NULL COMMENT '一级印花税',
  `Fd_exchangefare2` decimal(18,2) NOT NULL COMMENT '一级过户费',
  `Fd_standardfare0` decimal(18,2) NOT NULL COMMENT '佣金',
  PRIMARY KEY (`Fi_businessecno`),
  KEY `idx_ttsstkbusisec00_1` (`Fs_marketcode`) USING BTREE,
  KEY `idx_ttsstkbusisec00_2` (`Fs_marketcode`,`Fs_stockcode`) USING BTREE,
  KEY `idx_ttsstkbusisec00_3` (`Fs_secacct`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100066 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
