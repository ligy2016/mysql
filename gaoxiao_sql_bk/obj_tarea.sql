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

/*Table structure for table `tarea` */

DROP TABLE IF EXISTS `tarea`;

CREATE TABLE `tarea` (
  `Fs_id` varchar(32) NOT NULL COMMENT '区域表id',
  `Fs_name` varchar(32) NOT NULL COMMENT '区域名称',
  `Fs_status` varchar(32) NOT NULL COMMENT '状态:1-正常0-停用',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='区域表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
