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

/*Table structure for table `ttracecoercion` */

CREATE TABLE `ttracecoercion` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_schoolid` varchar(32) DEFAULT NULL COMMENT '学校id',
  `Fs_schoolname` varchar(32) DEFAULT NULL COMMENT '学校名称',
  `Fs_classid` varchar(32) DEFAULT NULL COMMENT '班级id',
  `Fs_classname` varchar(32) DEFAULT NULL COMMENT '班级名称',
  `Fs_studentid` varchar(32) DEFAULT NULL COMMENT '学生id',
  `Fs_studentname` varchar(32) DEFAULT NULL COMMENT '学生名称',
  `Fs_fuacct` varchar(32) DEFAULT NULL COMMENT '学生资产账号',
  `Fs_marketcode` varchar(32) DEFAULT NULL COMMENT '市场代码',
  `Fs_stockcode` varchar(32) NOT NULL COMMENT '证券类别:0 股票1 基金T ETF基金2 债券',
  `Fs_stockname` varchar(32) NOT NULL COMMENT '证券名称',
  `Fs_num` varchar(32) DEFAULT NULL COMMENT '平仓数量',
  `Fd_price` decimal(10,0) DEFAULT NULL COMMENT '平仓价格',
  `Ft_closetime` timestamp NULL DEFAULT NULL COMMENT '平仓时间',
  `Fs_ismarketprice` varchar(50) DEFAULT NULL COMMENT '是否市价:0-否 1-是',
  `Fs_founder` varchar(50) NOT NULL COMMENT '操作人',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛强制平仓（特殊处理）';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
