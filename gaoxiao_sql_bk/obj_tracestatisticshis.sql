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

/*Table structure for table `tracestatisticshis` */

CREATE TABLE `tracestatisticshis` (
  `Fs_clientid` varchar(18) NOT NULL COMMENT '客户编号',
  `Fs_name` varchar(32) NOT NULL COMMENT '客户名称',
  `fs_fuacct` varchar(32) NOT NULL COMMENT '资产账户编号',
  `Fs_raceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_racename` varchar(32) NOT NULL COMMENT '竞赛名称',
  `Fs_dailyreturn` varchar(32) DEFAULT NULL COMMENT '日收益率',
  `Fs_weeklyreturn` varchar(32) DEFAULT NULL COMMENT '周收益率',
  `Fs_monthlyreturn` varchar(32) DEFAULT NULL COMMENT '月收益率',
  `Fs_totalreturn` varchar(32) DEFAULT NULL COMMENT '总收益率',
  `Ft_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '结算日期',
  PRIMARY KEY (`Fs_clientid`,`Fs_raceid`,`Ft_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='每日历史竞赛统计';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
