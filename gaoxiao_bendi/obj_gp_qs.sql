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

/* Procedure structure for procedure `gp_qs` */

/*!50003 DROP PROCEDURE IF EXISTS  `gp_qs` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `gp_qs`(IN `src` int,IN `marketcode` varchar(32))
LABEL_PROC:
BEGIN
#指定市场收盘
#marketcode 市场id
#获取当前状态
	SELECT fi_status, fi_substatus, fi_errorno 
		INTO @status, @substatus, @errorno
		FROM tmkstatus
		WHERE fs_marketcode = marketcode;

	IF(src = 1)THEN
		IF(@status != 6 OR @substatus != 0)THEN
			LEAVE LABEL_PROC;
		END IF;
	END IF;
#1撤单
CALL gp_qs_cd(marketcode);

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
