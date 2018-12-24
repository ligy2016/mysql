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

/*Table structure for table `ttraceinterestpayment` */

CREATE TABLE `ttraceinterestpayment` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_marketcode` varchar(32) NOT NULL COMMENT '市场编号',
  `Fs_kindcode` varchar(32) NOT NULL COMMENT '市场子类别',
  `Fs_stockcode` varchar(32) NOT NULL COMMENT '证券代码',
  `Fd_money` decimal(18,4) NOT NULL COMMENT '付息金额(每手)',
  `Fs_founder` varchar(32) NOT NULL COMMENT '操作人',
  `Ft_createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='付息(特殊处理)';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
