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

/*Table structure for table `tnoticestudent` */

CREATE TABLE `tnoticestudent` (
  `Fs_id` varchar(32) NOT NULL COMMENT '通知标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_noticeid` varchar(32) NOT NULL COMMENT '通知id',
  `Fs_collectiontype` varchar(2) NOT NULL COMMENT '收藏类型:0-取消1-收藏',
  `Fs_readtype` varchar(2) NOT NULL COMMENT '阅读类型:0-未阅 1-已阅',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0-取消 1-正常',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生通知对应表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
