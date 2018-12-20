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

/* Procedure structure for procedure `prod_ct_close_update_stat` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_ct_close_update_stat` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_ct_close_update_stat`(IN `type` int,IN `ctid` int,IN `status` int,IN `substatus` int,IN `errorno` int,IN `errorstr` varchar(512))
BEGIN#更新市场状态 type: 0(更新状态)1(更新错误)
	##名称
		#prod_ct_close_update_stat
	##作用
		#更新柜台状态
	##参数说明
		#IN `type` int,IN `ctid` int,IN `status` int,IN `substatus` int,IN `errorno` int,IN `errorstr` varchar(512)
		#type：（0更新状态，1更新错误信息)
	IF (type = 0)THEN
		UPDATE tctstatus 
		SET fi_status = status, fi_substatus = substatus
		WHERE Fi_countercode = ctid;
	ELSE
		UPDATE tctstatus 
		SET fi_errorno = errorno, fs_errorstr = errorstr
		WHERE Fi_countercode = ctid;
	END IF;

	COMMIT;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
