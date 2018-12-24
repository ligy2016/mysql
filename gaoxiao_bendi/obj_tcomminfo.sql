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

/*Table structure for table `tcomminfo` */

DROP TABLE IF EXISTS `tcomminfo`;

CREATE TABLE `tcomminfo` (
  `Fs_clientid` varchar(32) NOT NULL COMMENT '学生客户账号',
  `Fs_marketcode` varchar(32) NOT NULL COMMENT '商品市场代码',
  `Fs_commcode` varchar(32) NOT NULL COMMENT '商品代码',
  `Ft_addtime` datetime NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`Fs_clientid`,`Fs_marketcode`,`Fs_commcode`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='自选股';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
