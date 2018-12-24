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

/*Table structure for table `tnotice` */

DROP TABLE IF EXISTS `tnotice`;

CREATE TABLE `tnotice` (
  `Fs_id` varchar(32) NOT NULL COMMENT '通知标识',
  `Fs_title` varchar(64) NOT NULL COMMENT '通知标题',
  `Fs_body` text COMMENT '通知内容',
  `Fs_type` varchar(2) NOT NULL COMMENT '通知类型：0-教师通知1-系统通知',
  `Ft_releasetime` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_userid` varchar(32) NOT NULL COMMENT '教师id',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0-注销 1-已发布 2：未发布',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
