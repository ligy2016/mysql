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

/* Procedure structure for procedure `prod_szqq_600011` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_szqq_600011`(IN marketcode varchar(32),entrustsecno char(10))
LABEL_PROC:
BEGIN
	SET @entrustsecno_i = CAST(entrustsecno AS SIGNED);

  set @mkcode = marketcode;
	SET @tempsql = CONCAT('SELECT * FROM ttsstkentrustsec00 WHERE (Fs_entruststatus = "2" OR Fs_entruststatus = "7") ');
  SET @tempsql = CONCAT(@tempsql,' AND Fs_marketcode =  \'', @mkcode,'\'');

	IF (@entrustsecno_i != 0 )THEN
		SET @tempsql = CONCAT(@tempsql,' AND Fi_entrustsecno > ', @entrustsecno_i);
	END IF;

	SET @tempsql = CONCAT(@tempsql,' order by Fi_entrustsecno');


	#select @tempsql;
	PREPARE stmt FROM @tempsql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;


END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
