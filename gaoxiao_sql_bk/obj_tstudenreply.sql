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

/*Table structure for table `tstudenreply` */

CREATE TABLE `tstudenreply` (
  `Fs_id` varchar(32) NOT NULL COMMENT '回复标示',
  `Fs_messageid` varchar(32) NOT NULL COMMENT '留言编号',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_reply` text NOT NULL COMMENT '回复内容',
  `Ft_repludate` timestamp NULL DEFAULT NULL COMMENT '回复日期',
  `Fs_type` varchar(2) NOT NULL COMMENT '回复类型:0-留言回复 1-日志回复 2-学生报告',
  `Fs_parentid` varchar(32) DEFAULT NULL COMMENT '父级id',
  `Fi_sort` int(11) DEFAULT NULL COMMENT '序号',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:1-正常0-取消',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生回复表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
