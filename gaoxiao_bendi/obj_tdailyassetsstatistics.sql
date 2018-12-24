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

/*Table structure for table `tdailyassetsstatistics` */

DROP TABLE IF EXISTS `tdailyassetsstatistics`;

CREATE TABLE `tdailyassetsstatistics` (
  `Fs_clientid` varchar(18) NOT NULL COMMENT '客户编号',
  `Fs_name` varchar(32) NOT NULL COMMENT '客户名称',
  `fs_fuacct` varchar(32) NOT NULL COMMENT '资产账户编号',
  `Fs_raceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_racename` varchar(32) NOT NULL COMMENT '竞赛名称',
  `Fd_totalbal` decimal(38,4) DEFAULT NULL COMMENT '总余额',
  `Fd_maketvalue` decimal(38,4) DEFAULT NULL COMMENT '市值',
  `Ft_time` date NOT NULL COMMENT '日期',
  PRIMARY KEY (`Fs_clientid`,`fs_fuacct`,`Fs_raceid`,`Ft_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日资产统计';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
