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

/*Table structure for table `tdefaulttracefee` */

DROP TABLE IF EXISTS `tdefaulttracefee`;

CREATE TABLE `tdefaulttracefee` (
  `Fs_id` varchar(32) NOT NULL COMMENT 'id',
  `Fs_feegoods` varchar(2) DEFAULT NULL COMMENT '收费商品:1.A股2.基金3.债券4.沪B股5.深B股',
  `Fs_buyorsell` varchar(2) DEFAULT NULL COMMENT '买卖方向: 1：买入 2：卖出',
  `Fd_stamptax` decimal(18,3) DEFAULT NULL COMMENT '印花税率',
  `Fd_tradefee` decimal(18,3) DEFAULT NULL COMMENT '手续费率',
  `Fd_stamptaxfloor` decimal(18,2) DEFAULT NULL COMMENT '印花税最低收费',
  `Fd_tradefeefloor` decimal(18,2) DEFAULT NULL COMMENT '手续费最低收费',
  `Fd_transactionfeefloor` decimal(18,2) DEFAULT NULL COMMENT '过户费率最低收费',
  `Fi_tradingunits` int(11) DEFAULT NULL COMMENT '交易单位',
  `Fs_status` varchar(32) NOT NULL COMMENT '状态:0-停用 1-正常',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '录入时间',
  `Fs_markettype` varchar(2) NOT NULL COMMENT '市场类型:1：沪深证券(A股)2：基金3：债券4：沪B股5：深B股6：融资融券7：港股8：金融期货9: 商品期货10：期权11：外汇',
  `Fs_founder` varchar(32) NOT NULL COMMENT '录入人员',
  `Fd_transactionfee` decimal(18,3) DEFAULT NULL COMMENT '过户费率',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='默认费率表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
