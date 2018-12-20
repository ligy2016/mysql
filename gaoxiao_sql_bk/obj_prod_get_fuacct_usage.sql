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

/* Procedure structure for procedure `prod_get_fuacct_usage` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_get_fuacct_usage` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_get_fuacct_usage`(secacct  VARCHAR(18),OUT ret INT, OUT fuacct VARCHAR(18),OUT useage INT ,OUT usagecode VARCHAR(32))
LABEL_PROC:
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION SET ret = 3;
 DECLARE EXIT  HANDLER FOR NOT FOUND	SET ret = 2;
	SET ret =0;
	SELECT IFNULL(t1.fs_fuacct,''),t1.fi_usage,t1.Fs_usagecode INTO fuacct,useage , usagecode 
	FROM tcusecacct t1 
	WHERE t1.Fs_secacct = secacct ;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
