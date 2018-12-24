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

/*Table structure for table `tcuuserinfo` */

DROP TABLE IF EXISTS `tcuuserinfo`;

CREATE TABLE `tcuuserinfo` (
  `Fs_clientid` varchar(18) NOT NULL,
  `Fs_branchno` varchar(32) NOT NULL,
  `Fs_clientname` varchar(128) DEFAULT NULL,
  `Fs_certtype` char(2) DEFAULT NULL,
  `Fs_certno` varchar(32) DEFAULT NULL,
  `Fs_Tel` varchar(32) DEFAULT NULL,
  `Fs_Address` varchar(128) DEFAULT NULL,
  `Fs_Createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`Fs_clientid`),
  UNIQUE KEY `idx_tcuuserinfo_1` (`Fs_certtype`,`Fs_certno`) USING BTREE,
  UNIQUE KEY `idx_tcuuserinfo_2` (`Fs_Tel`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
