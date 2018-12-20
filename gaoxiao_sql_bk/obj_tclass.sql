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

/*Table structure for table `tclass` */

DROP TABLE IF EXISTS `tclass`;

CREATE TABLE `tclass` (
  `Fs_id` varchar(32) NOT NULL COMMENT '班级标示',
  `Fs_name` varchar(32) NOT NULL COMMENT '班级名称',
  `Fs_professionalid` varchar(32) NOT NULL COMMENT '专业标示',
  `Fs_departmentid` varchar(32) NOT NULL COMMENT '学系标示',
  `Fs_schoolid` varchar(32) NOT NULL COMMENT '学校标示',
  `Fs_provinceid` varchar(32) NOT NULL COMMENT '省份',
  `Fs_areaid` varchar(32) NOT NULL COMMENT '区域标示',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:1-正常0-停用',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_collegeid` varchar(32) NOT NULL COMMENT '学院ID',
  `Fs_creuserid` varchar(32) NOT NULL COMMENT '创建人ID',
  `Fs_creusername` varchar(64) NOT NULL COMMENT '创建人姓名',
  `Fs_schoolname` varchar(64) NOT NULL COMMENT '学校名称',
  `Fs_collegename` varchar(64) NOT NULL COMMENT '学院名称',
  `Fs_departmentname` varchar(64) NOT NULL,
  `Fs_professionalname` varchar(64) NOT NULL,
  `Fs_provincename` varchar(64) NOT NULL,
  `Fs_areaname` varchar(64) NOT NULL,
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='班级表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
