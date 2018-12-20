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

/*Table structure for table `ttracedividend` */

DROP TABLE IF EXISTS `ttracedividend`;

CREATE TABLE `ttracedividend` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_marketcode` varchar(32) NOT NULL COMMENT '市场编号',
  `Fs_stockcode` varchar(32) NOT NULL COMMENT '证券代码',
  `Fs_stocktype` varchar(2) NOT NULL COMMENT '证券类型：0 股票1 基金T ETF基金2 债券',
  `Fs_stockname` varchar(64) NOT NULL COMMENT '证券名称',
  `Fd_vacation` decimal(18,4) DEFAULT NULL COMMENT '分红',
  `Fi_transfer` int(11) DEFAULT NULL COMMENT '送转',
  `Fi_rationedshares` int(11) DEFAULT NULL COMMENT '配股',
  `Fi_donatedcount` int(11) DEFAULT NULL COMMENT '转增数量',
  `Fd_money` decimal(18,2) DEFAULT NULL COMMENT '金额',
  `Fs_founder` varchar(50) NOT NULL COMMENT '操作人',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛分红送配（特殊处理）';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
