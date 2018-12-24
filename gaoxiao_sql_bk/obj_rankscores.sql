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

/*Table structure for table `rankscores` */

CREATE TABLE `rankscores` (
  `fs_clientid` varchar(32) NOT NULL COMMENT '客户账号',
  `fs_raceid` varchar(32) NOT NULL COMMENT '竞赛id',
  `fd_selectstockscore` decimal(18,3) DEFAULT NULL COMMENT '选股水平平均分',
  `fd_sellscore` decimal(18,3) DEFAULT NULL COMMENT '出场水平平均分',
  `fd_profitscore` decimal(18,3) DEFAULT NULL COMMENT '盈利能力平均分',
  `fd_riskscore` decimal(18,3) DEFAULT NULL COMMENT '风控能力平均分',
  `fd_overalscore` decimal(18,3) DEFAULT NULL COMMENT '综合评分平均分',
  PRIMARY KEY (`fs_clientid`,`fs_raceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
