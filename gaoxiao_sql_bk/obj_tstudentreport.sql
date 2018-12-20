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

/*Table structure for table `tstudentreport` */

DROP TABLE IF EXISTS `tstudentreport`;

CREATE TABLE `tstudentreport` (
  `Fs_id` varchar(32) NOT NULL COMMENT '行业报告标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_industryid` varchar(32) DEFAULT NULL COMMENT '行业id',
  `Fs_traceid` varchar(32) DEFAULT NULL COMMENT '赛事id',
  `Fs_type` varchar(2) NOT NULL COMMENT '类型:1：行业报告 2：公司报告3: 赛事投资报告',
  `Fs_title` varchar(32) NOT NULL COMMENT '标题',
  `Fs_content` text NOT NULL COMMENT '内容',
  `Fs_forward` varchar(2) NOT NULL COMMENT '是否转发',
  `Ft_releasetime` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0-注销 1-正常',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生报告(公司报告，行业报告)';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
