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

/* Procedure structure for procedure `prod_mk_get_time` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_mk_get_time` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_mk_get_time`(IN `mkid` int, OUT `mktime` char(19))
BEGIN
##名称
	#prod_mk_get_time
##作用
	#获取市场时间
##参数说明
	#IN `mkid` int, OUT `mktime` char(19)
	#mkid：市场id
	#mktime：市场时间（格式：'2017-12-05 15:34:37's）
	
##主体
	DECLARE diff int DEFAULT(0);
	
	SELECT TIMESTAMPDIFF(SECOND, Ft_marktime, Ft_systime) 
		INTO diff  FROM tmktimefix WHERE Fs_marketcode = mkid;
	
	SELECT LEFT(DATE_SUB(now(), INTERVAL diff SECOND) ,19) 
		INTO mktime;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
