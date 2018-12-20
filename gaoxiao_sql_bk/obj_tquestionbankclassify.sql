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

/*Table structure for table `tquestionbankclassify` */

DROP TABLE IF EXISTS `tquestionbankclassify`;

CREATE TABLE `tquestionbankclassify` (
  `Fs_id` varchar(32) NOT NULL COMMENT '题库标示',
  `Fs_code` varchar(32) NOT NULL COMMENT '类型编号',
  `Fs_name` varchar(32) NOT NULL COMMENT '类型名称',
  `Fs_parentid` varchar(32) DEFAULT NULL COMMENT '父id',
  `Fs_status` varchar(32) NOT NULL COMMENT '状态：0:注销 1：正常',
  `Fs_founder` varchar(32) NOT NULL COMMENT '创建人',
  `Fs_createtime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='题库分类表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
