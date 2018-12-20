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

/*Table structure for table `tstudentmessage` */

DROP TABLE IF EXISTS `tstudentmessage`;

CREATE TABLE `tstudentmessage` (
  `Fs_id` varchar(32) NOT NULL COMMENT '留言标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_message` text NOT NULL COMMENT '留言内容',
  `Fs_type` varchar(2) NOT NULL COMMENT '留言类型',
  `Ft_messagedate` timestamp NULL DEFAULT NULL COMMENT '留言日期',
  `Fs_forward` varchar(2) DEFAULT NULL COMMENT '是否转发',
  `Fi_forwardcount` int(11) DEFAULT NULL COMMENT '留言转发数目',
  `Ft_releasetime` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0-注销 1-正常',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生留言表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
