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

/*Table structure for table `tstudentpaper` */

DROP TABLE IF EXISTS `tstudentpaper`;

CREATE TABLE `tstudentpaper` (
  `Fs_id` varchar(32) NOT NULL COMMENT '学生试卷标示',
  `Fs_paperid` varchar(32) NOT NULL COMMENT '试卷id',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_score` varchar(32) NOT NULL COMMENT '分数',
  `Fs_consumetime` varchar(32) NOT NULL COMMENT '耗时',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0：未完成 1：已完成 2：注销',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生试卷表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
