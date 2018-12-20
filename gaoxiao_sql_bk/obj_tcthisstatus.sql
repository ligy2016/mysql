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

/*Table structure for table `tcthisstatus` */

DROP TABLE IF EXISTS `tcthisstatus`;

CREATE TABLE `tcthisstatus` (
  `Fi_countercode` int(11) NOT NULL COMMENT '柜台号',
  `Fs_settdate` char(8) NOT NULL COMMENT '清算日期:YYYYMMDD执行清算时，根据柜台时间校对表，匹配本日期，确定当日是否已经完成过清算',
  `Fi_status` int(11) NOT NULL COMMENT '清算状态',
  `Fi_substatus` int(11) NOT NULL COMMENT '清算子状态',
  `Fi_errorno` int(11) NOT NULL COMMENT '子状态处理错误编号',
  `Fs_errorstr` varchar(512) DEFAULT NULL COMMENT '子状态处理错误信息',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛编号',
  PRIMARY KEY (`Fi_countercode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='柜台清算状态历史';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
