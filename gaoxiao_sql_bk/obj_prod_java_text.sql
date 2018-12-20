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

/* Procedure structure for procedure `prod_java_text` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_java_text` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_java_text`()
BEGIN
	INSERT INTO `tcollege` (`Fs_id`, `Fs_name`, `Fs_schoolid`, `Fs_provinceid`, `Fs_areaid`, `Fs_status`, `Ft_createtime`, `Fs_creuserid`, `Fs_creusername`) VALUES ('12', '12', '40288195675e3b2301675f3b46d3001c', 'ql0001SiChuan', 'ql0001xn', '1', '2018-11-29 19:29:53', 'admin', '超级管理员');
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
