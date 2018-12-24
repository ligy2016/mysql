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

/*Table structure for table `ttpublicreport` */

CREATE TABLE `ttpublicreport` (
  `Fs_id` varchar(32) NOT NULL COMMENT '标示',
  `Fs_title` varchar(32) NOT NULL COMMENT '标题',
  `Fs_type` varchar(32) NOT NULL COMMENT '文档分类:0 行业报告 1：公司报告 2：指标案例',
  `Fs_industryid` varchar(32) NOT NULL COMMENT '所属行业',
  `Fs_suffix` varchar(32) NOT NULL COMMENT '文档类型:Pdf,img,doc',
  `Fs_status` varchar(32) NOT NULL COMMENT '状态:0:注销 1：正常',
  `Fs_founder` varchar(32) NOT NULL COMMENT '创建人id',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公共报告表(经典公司报告，经典行业报告，经典指标案例)';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
