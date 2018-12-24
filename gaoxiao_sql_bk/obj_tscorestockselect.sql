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

/*Table structure for table `tscorestockselect` */

CREATE TABLE `tscorestockselect` (
  `fs_clientid` varchar(18) NOT NULL COMMENT '用户id',
  `fs_usagecode` varchar(32) NOT NULL COMMENT '比赛编号',
  `fs_mkid` varchar(32) NOT NULL COMMENT '市场编号',
  `fs_stocktype` varchar(4) NOT NULL COMMENT '商品分类',
  `fs_code` char(6) NOT NULL COMMENT '商品编号',
  `fi_times` int(11) NOT NULL COMMENT '第几次',
  `fs_starttime` char(8) NOT NULL COMMENT '开始时间',
  `fd_buyprise` decimal(15,4) NOT NULL COMMENT '买入价格',
  `fi_days` int(11) NOT NULL COMMENT '第几个结算日',
  `fi_score` int(11) NOT NULL COMMENT '得分',
  `fs_finish` char(1) NOT NULL COMMENT '是否完结',
  PRIMARY KEY (`fs_clientid`,`fs_usagecode`,`fs_mkid`,`fs_stocktype`,`fs_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
