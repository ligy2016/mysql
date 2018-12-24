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

/*Table structure for table `thisgoodsmanagement` */

DROP TABLE IF EXISTS `thisgoodsmanagement`;

CREATE TABLE `thisgoodsmanagement` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_marketcode` varchar(32) NOT NULL COMMENT '市场编号',
  `Fs_stockcode` varchar(32) NOT NULL COMMENT '证券代码',
  `Fs_stocktype` varchar(32) NOT NULL COMMENT '证券类型：0 股票1 基金T ETF基金2 债券',
  `Fs_stockname` varchar(32) NOT NULL COMMENT '证券名称',
  `Ft_endtime` timestamp NULL DEFAULT NULL COMMENT '停牌时间',
  `Ft_regaintime` timestamp NULL DEFAULT NULL COMMENT '恢复时间',
  `Fs_founder` varchar(32) NOT NULL COMMENT '操作人',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛商品管理历史记录';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
