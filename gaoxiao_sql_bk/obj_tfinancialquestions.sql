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

/*Table structure for table `tfinancialquestions` */

CREATE TABLE `tfinancialquestions` (
  `Fs_id` varchar(32) NOT NULL COMMENT '角色标示',
  `Fs_source` varchar(2) NOT NULL COMMENT '来源:0:模拟试题库 1：历年真题库',
  `Fs_content` varchar(32) NOT NULL COMMENT '题目内容',
  `Fs_type` varchar(32) NOT NULL COMMENT '题目类别:1：单选 2：多选 3：判断',
  `Fs_rightkey` varchar(32) NOT NULL COMMENT '题目正确答案',
  `Fs_answer` text NOT NULL COMMENT '答案解释',
  `Fs_ispublic` varchar(2) NOT NULL COMMENT '是否公开:0:不公开 1：公开',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:0：新增 1：已使用 2:取消',
  `Fs_founder` varchar(32) NOT NULL COMMENT '录入人',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_classifyid` varchar(32) NOT NULL COMMENT '题库分类id',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='金融试题表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
