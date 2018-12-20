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

/*Table structure for table `trace` */

DROP TABLE IF EXISTS `trace`;

CREATE TABLE `trace` (
  `Fs_id` varchar(32) NOT NULL COMMENT '竞赛标示',
  `Fs_name` varchar(32) NOT NULL COMMENT '竞赛名称',
  `Fs_markettype` varchar(32) NOT NULL COMMENT '市场类型:1：沪深证券(A股)2：基金3：债券4：沪B股5：深B股6：融资融券7：港股8：金融期货9: 商品期货10：期权11：外汇',
  `Fs_funder` varchar(32) NOT NULL COMMENT '创建人',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `Ft_enrollstart` timestamp NULL DEFAULT NULL COMMENT '报名开始时间',
  `Ft_enrollend` timestamp NULL DEFAULT NULL COMMENT '报名结束时间',
  `Ft_starttime` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `Ft_endtime` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `Fs_matchrule` text COMMENT '比赛规则',
  `Fs_tradetime` varchar(32) NOT NULL COMMENT '每日交易结束时间',
  `Fi_countlimit` int(11) NOT NULL COMMENT '参加人数限制',
  `Fi_sortcondition` int(11) NOT NULL COMMENT '参与排名条件',
  `Fd_intialasset` decimal(18,3) NOT NULL COMMENT '初始资金',
  `Fs_matchstat` varchar(2) NOT NULL COMMENT '比赛状态:1.进行中2.未开赛3.竞赛结束4.暂停5.报名中',
  `Fs_practice` varchar(2) NOT NULL COMMENT '比赛类型:1.练习2.比赛',
  `Fs_currency` varchar(8) NOT NULL COMMENT '币种:关联币种表',
  `Fs_isnoontransaction` varchar(2) NOT NULL COMMENT '中午时段是否允许交易:0-不允许交易 1-允许交易',
  `Fs_isvacationtransation` varchar(2) NOT NULL COMMENT '节假日是否允许交易:0-不允许交易 1-允许交易',
  `Fs_organizer` varchar(64) NOT NULL COMMENT '主办单位',
  `Fs_undertake` varchar(64) NOT NULL COMMENT '承办单位',
  `Fs_status` varchar(2) DEFAULT NULL COMMENT '状态:0-停用1-正常',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='竞赛（练习）表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
