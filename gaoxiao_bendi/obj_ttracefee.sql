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

/*Table structure for table `ttracefee` */

DROP TABLE IF EXISTS `ttracefee`;

CREATE TABLE `ttracefee` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_traceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `Fs_defaultfee` varchar(2) NOT NULL COMMENT '是否是默认费用:0:否 1：是',
  `Fs_feegoods` varchar(2) DEFAULT NULL COMMENT '收费商品:1.A股2.债券3.基金4.沪B股5.深B股',
  `Fs_buyorsell` varchar(2) DEFAULT NULL COMMENT '买卖方向',
  `Fd_stamptax` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT '印花税率',
  `Fd_tradefee` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT '手续费率',
  `Fd_transactionfee` decimal(18,3) NOT NULL DEFAULT '0.000' COMMENT '过户费率',
  `Fd_stamptaxfloor` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '印花税最低收费',
  `Fd_tradefeefloor` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '手续费最低收费',
  `Fd_transactionfeefloor` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '过户费率最低收费',
  `Fi_tradingunits` int(11) DEFAULT NULL COMMENT '交易单位',
  `Fs_status` varchar(2) NOT NULL COMMENT '状态:1-正常0-停用',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_founder` varchar(64) NOT NULL COMMENT '录入人员',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='比赛费率表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
