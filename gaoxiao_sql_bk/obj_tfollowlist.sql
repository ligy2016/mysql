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

/*Table structure for table `tfollowlist` */

CREATE TABLE `tfollowlist` (
  `Fs_id` varchar(32) NOT NULL COMMENT '关注标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生账号',
  `Fs_followgroupid` varchar(32) DEFAULT NULL COMMENT '分组编号',
  `Fs_follow_studentid` varchar(32) NOT NULL COMMENT '我关注的学生账号',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生关注表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
