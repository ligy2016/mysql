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

/*Table structure for table `thistorystudent` */

DROP TABLE IF EXISTS `thistorystudent`;

CREATE TABLE `thistorystudent` (
  `Fs_id` varchar(32) NOT NULL COMMENT '学生标示',
  `Fs_code` varchar(32) NOT NULL COMMENT '学生账号',
  `Fs_clientid` varchar(32) NOT NULL COMMENT '学生客户账号',
  `Fs_pwd` varchar(64) NOT NULL COMMENT '学生账号密码',
  `Fs_name` varchar(32) DEFAULT NULL COMMENT '学生姓名',
  `Fs_sex` varchar(2) DEFAULT NULL COMMENT '性别:0-男1-女',
  `Fs_nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `Fs_studentno` varchar(32) DEFAULT NULL COMMENT '学号',
  `Fs_remarks` varchar(32) DEFAULT NULL COMMENT '备注',
  `Fs_serialnumber` varchar(32) DEFAULT NULL COMMENT '身份证号',
  `Fs_tel` varchar(32) DEFAULT NULL COMMENT '联系电话',
  `Fd_registertime` timestamp NULL DEFAULT NULL COMMENT '注册时间',
  `Fs_summary` text COMMENT '简介',
  `Fs_founder` varchar(32) DEFAULT NULL COMMENT '录入人',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0-停用1-正常2-冻结',
  `Fs_allowpost` varchar(2) NOT NULL COMMENT '是否允许发帖 0-不允许 1：允许',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生历史数据表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
