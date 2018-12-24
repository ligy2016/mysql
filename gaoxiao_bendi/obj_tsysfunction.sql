/*
SQLyog Enterprise v12.09 (64 bit)
MySQL - 5.6.10 : Database - gaoxiao_local
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `gaoxiao_local`;

/*Table structure for table `tsysfunction` */

DROP TABLE IF EXISTS `tsysfunction`;

CREATE TABLE `tsysfunction` (
  `Fs_id` varchar(32) NOT NULL COMMENT '功能标示',
  `Fi_level` int(11) NOT NULL COMMENT '功能等级',
  `Fs_name` varchar(32) NOT NULL COMMENT '功能名称',
  `Fi_order` int(11) NOT NULL COMMENT '功能排序',
  `Fs_url` varchar(1024) DEFAULT NULL COMMENT '功能链接',
  `Fs_parentid` varchar(512) DEFAULT NULL COMMENT '功能父id',
  `Fs_iconid` varchar(512) DEFAULT NULL COMMENT '功能图片id',
  `Fs_deskiconid` varchar(512) DEFAULT NULL COMMENT '功能桌面id',
  `Fs_type` varchar(32) DEFAULT NULL COMMENT '权限类型 0：标题 1:按钮',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='功能权限表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
