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

/*Table structure for table `tcasub2balance` */

DROP TABLE IF EXISTS `tcasub2balance`;

CREATE TABLE `tcasub2balance` (
  `fs_fuacct` varchar(18) NOT NULL,
  `fi_sub2fuacct` int(11) NOT NULL,
  `Fd_TotalBal` decimal(38,4) NOT NULL,
  `Fd_capital` decimal(38,4) NOT NULL COMMENT '2018年10月29日增加 初始资金',
  `Fd_AvalBal` decimal(38,4) NOT NULL,
  `Fd_OutBal` decimal(38,4) NOT NULL,
  `Fd_OpenBal` decimal(38,4) NOT NULL,
  `Fd_CloseBal` decimal(38,4) NOT NULL,
  `Fd_OpenAvalBal` decimal(38,4) NOT NULL,
  `Fd_CloseAvalBal` decimal(38,4) NOT NULL,
  `Fd_OpenOutBal` decimal(38,4) NOT NULL,
  `Fd_CloseOutBal` decimal(38,4) NOT NULL,
  `Fs_acdate` char(8) NOT NULL,
  `Fd_TotalRecharge` decimal(38,4) NOT NULL,
  `Fd_TotalReflect` decimal(38,4) NOT NULL,
  PRIMARY KEY (`fs_fuacct`,`fi_sub2fuacct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
