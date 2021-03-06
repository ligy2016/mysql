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

/*Table structure for table `tmessageupvote` */

DROP TABLE IF EXISTS `tmessageupvote`;

CREATE TABLE `tmessageupvote` (
  `Fs_id` varchar(32) NOT NULL COMMENT '留言点赞标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_upvote_studentid` varchar(32) NOT NULL COMMENT '被点赞的学生账号',
  `Fs_messageid` varchar(32) NOT NULL COMMENT '相关留言编号(留言、日志、报告、回复)',
  `Fs_type` varchar(2) NOT NULL COMMENT '举报类型:0-留言 1-日志 2-学生报告 3-回复',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生留言点赞表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
