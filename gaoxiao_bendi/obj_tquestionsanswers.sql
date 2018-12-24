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

/*Table structure for table `tquestionsanswers` */

DROP TABLE IF EXISTS `tquestionsanswers`;

CREATE TABLE `tquestionsanswers` (
  `Fs_id` varchar(32) CHARACTER SET latin1 NOT NULL COMMENT '答案标示',
  `Fs_questionid` varchar(32) CHARACTER SET latin1 NOT NULL COMMENT '试题id',
  `Fi_code` int(32) NOT NULL COMMENT '答案编号',
  `Fs_content` varchar(32) CHARACTER SET latin1 NOT NULL COMMENT '答案内容',
  PRIMARY KEY (`Fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='试题答案表';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;