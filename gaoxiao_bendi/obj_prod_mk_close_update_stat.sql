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

/* Procedure structure for procedure `prod_mk_close_update_stat` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_mk_close_update_stat` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_mk_close_update_stat`(IN `type` int,IN `marketcode` varchar(32), IN `kindcode` varchar(32),IN `status` int,IN `substatus` int,IN `errorno` int,IN `errorstr` varchar(32))
BEGIN
	##名称
		#prod_mk_close_update_stat
	##作用
		#更新市场状态
	##参数说明
		#IN `type` int,IN `marketcode` varchar(32), IN `kindcode` varchar(32),IN `status` int,IN `substatus` int,IN `errorno` int,IN `errorstr` varchar(32)
		#type：（0更新状态，1更新错误信息)
	IF (type = 0)THEN
		UPDATE tmkstatus 
		SET fi_status = status, fi_substatus = substatus
		WHERE fs_marketcode = marketcode AND Fs_kindcode = kindcode;
	ELSE
		UPDATE tmkstatus 
		SET fi_errorno = errorno, fs_errorstr = errorstr
		WHERE fs_marketcode = marketcode AND Fs_kindcode = kindcode;
	END IF;

	COMMIT;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
