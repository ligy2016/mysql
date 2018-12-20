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

/*Table structure for table `tstudentdirary` */

DROP TABLE IF EXISTS `tstudentdirary`;

CREATE TABLE `tstudentdirary` (
  `Fs_id` varchar(32) NOT NULL COMMENT '通知标示',
  `Fs_studentid` varchar(32) NOT NULL COMMENT '学生id',
  `Fs_title` varchar(32) NOT NULL COMMENT '日志标题',
  `Fs_log` text NOT NULL COMMENT '日志内容',
  `Fs_type` varchar(2) NOT NULL COMMENT '日志类型：1：沪深证券(A股)2：基金3：债券4：沪B股5：深B股6：融资融券7：港股8：金融期货9: 商品期货10：期权11：外汇',
  `Fs_forward` varchar(2) NOT NULL COMMENT '是否转发：0:未转发1：已转发',
  `Fi_forwardcount` int(11) DEFAULT NULL COMMENT '转发数量',
  `Ft_releasetime` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0-注销 1-正常',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='日志(话题)表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
