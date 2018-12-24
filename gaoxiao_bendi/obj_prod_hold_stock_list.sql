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

/* Procedure structure for procedure `prod_hold_stock_list` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_hold_stock_list` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_hold_stock_list`(marketcode  char(64))
BEGIN
IF(marketcode = '27' OR marketcode = '31') THEN
		select Fs_mkdate into @mkdate from tmkstatus where Fs_marketcode = marketcode;
    SELECT DISTINCT  Fs_optioncode FROM tptoption00  where Fs_marketcode = marketcode and Fs_mkdate != @mkdate;
ELSEIF(marketcode = '0' OR marketcode = '1') THEN
		select Fs_mkdate into @mkdate from tmkstatus where Fs_marketcode = marketcode;
    SELECT DISTINCT Fs_stockcode FROM tptstock00  where Fs_marketcode = marketcode and Fs_mkdate != @mkdate;
END IF;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
