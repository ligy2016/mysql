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

/* Procedure structure for procedure `prod_szqq_500017` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_szqq_500017` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_szqq_500017`(marketcode char(32) ,marktime char(32))
BEGIN
	update tmktimefix set ft_marktime = str_to_date(marktime,'%Y-%m-%d %H:%i:%s'),ft_systime = NOW() WHERE fs_marketcode = marketcode;
	if (ROW_COUNT() <= 0) THEN
		INSERT INTO tmktimefix VALUES (marketcode,str_to_date(marktime,'%Y-%m-%d %H:%i:%s'),NOW());
	end if;
	commit;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
