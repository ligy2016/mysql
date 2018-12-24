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

/*Table structure for table `ttraceallowedstudent` */

CREATE TABLE `ttraceallowedstudent` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_relid` varchar(32) DEFAULT NULL COMMENT '学生或班级主键',
  `Fi_type` int(11) NOT NULL COMMENT '允许类型：0-全体学生 1-指定班级 2-指定学生',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0停用 1正常',
  `Fs_founder` varchar(32) NOT NULL COMMENT '录入人员',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛允许参赛学生表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
