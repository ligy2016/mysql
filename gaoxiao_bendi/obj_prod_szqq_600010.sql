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

/* Procedure structure for procedure `prod_szqq_600010` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_szqq_600010` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_szqq_600010`(IN `marketcode`  char(32),IN `stockcode` char(8),IN `lastprice` decimal(19,4))
BEGIN
	SELECT COUNT(*) INTO @stockcount FROM tcmoptiontag00
		WHERE Fs_stockcode = stockcode;

	IF(@stockcount > 0) THEN
		UPDATE tcmoptiontag00 SET Fd_lastprice = lastprice WHERE Fs_stockcode = stockcode and Fs_marketcode = marketcode;
    COMMIT;
	END IF;

	SELECT COUNT(*) INTO @count FROM tptstock00
		WHERE Fs_stockcode = stockcode and fs_marketcode  = marketcode;

	IF(@count > 0) THEN
		UPDATE tptstock00 SET Fd_lastprice = lastprice,
		  Fd_marketvalue = lastprice*Fi_holdamount,
			Fd_incomebalance = Fd_marketvalue - Fd_costbalance
		 WHERE Fs_stockcode = stockcode and fs_marketcode  = marketcode ;
	  COMMIT;
		SELECT 0;
	ELSE
		SELECT 1;
	END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
