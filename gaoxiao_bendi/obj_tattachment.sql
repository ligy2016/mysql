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

/*Table structure for table `tattachment` */

DROP TABLE IF EXISTS `tattachment`;

CREATE TABLE `tattachment` (
  `Fs_id` varchar(32) NOT NULL COMMENT '通知标示',
  `Fs_relid` varchar(32) NOT NULL COMMENT '通知标示',
  `Fs_type` varchar(2) NOT NULL COMMENT '附件类型:0-学生头像1-管理员头像2-留言图像3-日志图像4-日志封面5-通知附件6-教师头像7-公司报告图片8-公司报告附件9-行业报告图片10-行业报告附件11-赛事投资报告图片12-赛事投资报告附件',
  `Fs_name` varchar(32) NOT NULL COMMENT '附件名称',
  `Fs_url` varchar(1024) NOT NULL COMMENT '地址',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
