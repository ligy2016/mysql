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

/*Table structure for table `tptstock00` */

DROP TABLE IF EXISTS `tptstock00`;

CREATE TABLE `tptstock00` (
  `Fs_marketcode` varchar(32) NOT NULL COMMENT '市场代码',
  `Fs_secacct` varchar(32) NOT NULL COMMENT '证券账户：期权市场即是衍生品合约账户',
  `Fs_stockcode` char(6) NOT NULL COMMENT '证券代码',
  `Fs_stocktype` varchar(4) NOT NULL COMMENT '证券类别：0 股票1 基金T ETF基金2 债券',
  `Fs_stockname` varchar(32) NOT NULL COMMENT '证券名称',
  `Fi_currentamount` int(11) NOT NULL COMMENT '当前数量：昨结持仓数量',
  `Fi_holdamount` int(11) NOT NULL COMMENT '持有数量：当前持仓总数',
  `Fi_enableamount` int(11) NOT NULL COMMENT '可用数量',
  `Fi_realbuyamount` int(11) NOT NULL COMMENT '回报买入数量',
  `Fi_realsellamount` int(11) NOT NULL COMMENT '回报卖出数量',
  `Fi_uncomebuyamount` int(11) NOT NULL COMMENT '未回买入数量',
  `Fi_uncomesellamount` int(11) NOT NULL COMMENT '未回卖出数量',
  `Fi_entrustsellamount` int(11) NOT NULL COMMENT '委托卖出数量',
  `Fd_lastprice` decimal(19,4) NOT NULL COMMENT '最新价：该账户持仓的最后一笔成交价',
  `Fd_costprice` decimal(14,3) NOT NULL COMMENT '成本价',
  `Fd_keepcostprice` decimal(14,3) NOT NULL COMMENT '保本价',
  `Fd_incomebalance` decimal(18,2) NOT NULL COMMENT '盈亏金额',
  `Fs_handflag` char(1) DEFAULT NULL COMMENT '手标志',
  `Fd_marketvalue` decimal(18,2) NOT NULL COMMENT '证券市值',
  `Fd_avbuyprice` decimal(15,4) NOT NULL COMMENT '买入均价',
  `Fd_avsellprice` decimal(15,4) NOT NULL COMMENT '卖出均价',
  `Fd_avincomebalance` decimal(18,2) NOT NULL COMMENT '实现盈亏',
  `Fd_costbalance` decimal(18,2) NOT NULL COMMENT '持仓成本：动态计算的持仓成本，盈亏计算在内',
  `Fs_delistflag` char(1) NOT NULL COMMENT '退市标志：0.正常1.退市',
  `Fs_delistdate` char(8) DEFAULT NULL COMMENT '退市日期',
  `Fd_parvalue` decimal(15,4) NOT NULL COMMENT '面值',
  `Fd_incomebalancenofare` decimal(18,2) NOT NULL COMMENT '无费用盈亏',
  `Fi_frozenamount` int(11) NOT NULL COMMENT '冻结数量',
  `Fd_profitratio` decimal(18,2) NOT NULL COMMENT '盈亏比例(%)',
  `Fs_mkdate` char(8) NOT NULL COMMENT '市场日期',
  `Fi_lockamount` int(11) NOT NULL COMMENT '锁定数量：已锁定数量',
  `Fi_realbuylockamount` int(11) NOT NULL COMMENT '回报买入可锁数量：当天买入可用于锁定的剩余数量',
  `Fi_exefroenbleamt` int(11) NOT NULL COMMENT '行权冻结数量-来自可用',
  `Fi_exefrobuyamt` int(11) NOT NULL COMMENT '行权冻结数量-来自买入数量',
  `Fi_todayisexp` int(11) NOT NULL DEFAULT '0' COMMENT '当日是否除权：0没有，1有一只股票理论上一天只会除一次权，发现已经除权就不需要再次除权。主要是为了防止撮合程序多次重启导致多次除权，日结是需要置为0.',
  `Fi_todayisexi` int(11) NOT NULL DEFAULT '0' COMMENT '0没有，1有',
  PRIMARY KEY (`Fs_marketcode`,`Fs_secacct`,`Fs_stockcode`,`Fs_stocktype`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='账户持仓信息表（沪深A股）';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
