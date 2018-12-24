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

/*Table structure for table `tmkstatus` */

DROP TABLE IF EXISTS `tmkstatus`;

CREATE TABLE `tmkstatus` (
  `Fs_marketcode` varchar(32) NOT NULL,
  `Fs_pretrddate` char(8) NOT NULL,
  `Fs_mkdate` char(8) NOT NULL,
  `Fs_nexttrddate` char(8) NOT NULL,
  `Fs_exedate` char(8) NOT NULL,
  `Fs_deldate` char(8) NOT NULL,
  `Fi_status` int(11) NOT NULL,
  `Fi_substatus` int(11) NOT NULL,
  `Fi_errorno` int(11) NOT NULL,
  `Fs_errorstr` varchar(512) DEFAULT NULL,
  `Fs_isvacation` varchar(2) DEFAULT NULL COMMENT '是否为节假日: 1：节假日，！1：工作日',
  PRIMARY KEY (`Fs_marketcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
