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

/*Table structure for table `tprofessional` */

CREATE TABLE `tprofessional` (
  `Fs_id` varchar(32) NOT NULL COMMENT '专业标示',
  `Fs_name` varchar(32) NOT NULL COMMENT '专业名称',
  `Fs_departmentid` varchar(32) NOT NULL COMMENT '学系标示',
  `Fs_collegeid` varchar(32) NOT NULL COMMENT '学院标示',
  `Fs_schoolid` varchar(32) NOT NULL COMMENT '学校标示',
  `Fs_provinceid` varchar(32) NOT NULL COMMENT '省份',
  `Fs_areaid` varchar(32) NOT NULL COMMENT '区域标示',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:1-正常0-停用',
  `Ft_createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '录入时间',
  `Fs_creuserid` varchar(32) NOT NULL COMMENT '创建人ID',
  `Fs_creusername` varchar(32) NOT NULL COMMENT '创建人姓名',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专业表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
