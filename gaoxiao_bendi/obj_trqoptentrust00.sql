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

/*Table structure for table `trqoptentrust00` */

DROP TABLE IF EXISTS `trqoptentrust00`;

CREATE TABLE `trqoptentrust00` (
  `Fi_entrustno` int(11) NOT NULL AUTO_INCREMENT,
  `Ft_entrusttime` datetime NOT NULL,
  `Fs_opbranchno` char(5) NOT NULL,
  `Fs_opentrustway` char(1) NOT NULL,
  `Fs_opstation` varchar(255) NOT NULL,
  `Fs_branchno` char(5) NOT NULL,
  `Fs_clientid` char(18) NOT NULL,
  `fs_fuacct` varchar(18) NOT NULL,
  `Fs_assetprop` char(1) NOT NULL,
  `Fs_secacct` varchar(18) NOT NULL,
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_optioncode` char(8) NOT NULL,
  `Fi_entrustamount` int(11) NOT NULL,
  `Fd_optentrustprice` decimal(14,4) NOT NULL,
  `Fs_entrustbs` char(1) NOT NULL,
  `Fs_entrustoc` char(1) NOT NULL,
  `Fs_coveredflag` char(1) NOT NULL,
  `Fs_entrustprop` varchar(3) NOT NULL,
  `Fs_entrustsrc` char(1) NOT NULL,
  `Fi_requestno` int(11) DEFAULT NULL,
  `Ft_requesttime` datetime NOT NULL,
  PRIMARY KEY (`Fi_entrustno`),
  KEY `idx_trqoptentrust00_1` (`Fi_requestno`) USING BTREE,
  KEY `idx_trqoptentrust00_2` (`Fs_branchno`) USING BTREE,
  KEY `idx_trqoptentrust00_3` (`Fs_clientid`) USING BTREE,
  KEY `idx_trqoptentrust00_4` (`Fs_marketcode`,`Fs_optioncode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
