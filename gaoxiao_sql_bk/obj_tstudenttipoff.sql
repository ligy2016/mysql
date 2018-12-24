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

/*Table structure for table `tstudenttipoff` */

CREATE TABLE `tstudenttipoff` (
  `Fs_id` varchar(32) NOT NULL COMMENT '举报标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_report_studentid` varchar(32) NOT NULL COMMENT '被举报的学生账号',
  `Fs_messageid` varchar(32) NOT NULL COMMENT '相关留言编号(留言、日志、报告、回复)',
  `Fs_type` varchar(2) NOT NULL COMMENT '举报类型:0-留言 1-日志 2-学生报告 3-回复',
  `Fs_reason` text NOT NULL COMMENT '举报原因',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生举报表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
