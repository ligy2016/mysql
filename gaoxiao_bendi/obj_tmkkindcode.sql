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

/*Table structure for table `tmkkindcode` */

DROP TABLE IF EXISTS `tmkkindcode`;

CREATE TABLE `tmkkindcode` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_kindcode` varchar(32) NOT NULL,
  `Fs_kindname` varchar(128) NOT NULL,
  `Fs_exchangetype` char(4) NOT NULL,
  `Fi_fuaccttype` int(11) NOT NULL,
  `Fs_webmarketcode` varchar(2) NOT NULL COMMENT '市场类型：1：沪深证券(A股)2：基金3：债券4：沪B股5：深B股6：融资融券7：港股8：金融期货9: 商品期货10：期权11：外汇',
  PRIMARY KEY (`Fs_marketcode`,`Fs_kindcode`),
  UNIQUE KEY `idx_tmkkindcode_1` (`Fs_exchangetype`,`Fi_fuaccttype`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
