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

/*Table structure for table `tuserclass` */

DROP TABLE IF EXISTS `tuserclass`;

CREATE TABLE `tuserclass` (
  `Fs_userid` varchar(32) NOT NULL COMMENT '用户标示',
  `Fs_classid` varchar(32) NOT NULL COMMENT '班级标示',
  `Fs_proid` varchar(32) NOT NULL COMMENT '专业标识',
  `Fs_departid` varchar(32) NOT NULL COMMENT '学系标识',
  `Fs_collegeid` varchar(32) NOT NULL COMMENT '学院标识',
  `Fs_schoolid` varchar(32) NOT NULL COMMENT '学校标识',
  PRIMARY KEY (`Fs_userid`,`Fs_classid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户与班级关联关系表(用户管理班级表)';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
