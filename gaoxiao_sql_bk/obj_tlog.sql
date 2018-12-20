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

/*Table structure for table `tlog` */

DROP TABLE IF EXISTS `tlog`;

CREATE TABLE `tlog` (
  `Fs_id` varchar(32) NOT NULL COMMENT '日志标识',
  `Fs_type` varchar(32) NOT NULL COMMENT '日志类型：1：学生登录，2：教师登录',
  `Fs_relid` varchar(32) NOT NULL COMMENT '登陆账号',
  `Fs_name` varchar(32) NOT NULL COMMENT '姓名',
  `Fs_nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `Fs_tel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `Fd_loginime` timestamp NULL DEFAULT NULL COMMENT '登陆时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
