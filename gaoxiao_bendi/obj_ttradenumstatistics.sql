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

/*Table structure for table `ttradenumstatistics` */

DROP TABLE IF EXISTS `ttradenumstatistics`;

CREATE TABLE `ttradenumstatistics` (
  `Fs_clientid` varchar(18) NOT NULL COMMENT '客户id',
  `Fs_name` varchar(32) NOT NULL COMMENT '客户姓名',
  `fs_fuacct` varchar(32) NOT NULL COMMENT '客户资产账号',
  `Fs_raceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_racename` varchar(32) NOT NULL COMMENT '竞赛名称',
  `Fs_dailytradenum` varchar(32) DEFAULT NULL COMMENT '	当日交易次数',
  `Fs_weeklytradenum` varchar(32) DEFAULT NULL COMMENT '本周交易次数',
  `Fs_monthlytradenum` varchar(32) DEFAULT NULL COMMENT '近一个月交易次数',
  `Fs_totaltradenum` varchar(32) DEFAULT NULL COMMENT '总交易次数',
  PRIMARY KEY (`Fs_clientid`,`fs_fuacct`,`Fs_raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易次数统计';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
