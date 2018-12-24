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

/*Table structure for table `ttradeamtstatistics` */

CREATE TABLE `ttradeamtstatistics` (
  `Fs_clientid` varchar(18) NOT NULL COMMENT '客户id',
  `Fs_name` varchar(32) NOT NULL COMMENT '客户姓名',
  `fs_fuacct` varchar(32) NOT NULL COMMENT '客户资产账号',
  `Fs_raceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_racename` varchar(32) NOT NULL COMMENT '竞赛名称',
  `Fs_dailytradeamount` varchar(32) DEFAULT NULL COMMENT '	当日交易金额',
  `Fs_weeklytradeamount` varchar(32) DEFAULT NULL COMMENT '本周交易金额',
  `Fs_monthlytradeamount` varchar(32) DEFAULT NULL COMMENT '近一个月交易金额',
  `Fs_totaltradeamount` varchar(32) DEFAULT NULL COMMENT '总交易金额',
  PRIMARY KEY (`Fs_clientid`,`fs_fuacct`,`Fs_raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易金额统计';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
