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

/*Table structure for table `ttsstkbusiseclist00` */

DROP TABLE IF EXISTS `ttsstkbusiseclist00`;

CREATE TABLE `ttsstkbusiseclist00` (
  `Fi_businessecno` int(11) NOT NULL,
  `Fi_businessubno` int(11) NOT NULL AUTO_INCREMENT,
  `Fd_optbusinessprice` decimal(15,4) NOT NULL,
  `Fi_businessamount` int(11) NOT NULL,
  `Fs_realstatus` char(1) NOT NULL,
  `Ft_businesscrttime` datetime NOT NULL,
  `Ft_businessupdtime` datetime NOT NULL,
  `Fd_businessbalance` decimal(18,2) NOT NULL,
  `Fi_entrustsecno` int(11) NOT NULL,
  `Fi_restnum` int(11) NOT NULL COMMENT '证券剩余数量',
  `Fd_occurmoney` decimal(10,0) NOT NULL COMMENT '发生额:发生额就是所有的金额，包括成交金额和费用',
  PRIMARY KEY (`Fi_businessecno`,`Fi_businessubno`),
  UNIQUE KEY `id_ttsstkbusiseclist00_1` (`Fi_businessubno`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
