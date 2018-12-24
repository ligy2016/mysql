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

/* Procedure structure for procedure `prod_ct_close_table_2_his` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_ct_close_table_2_his` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_ct_close_table_2_his`(IN `table_name` varchar(512), IN `table_name_his` varchar(512), IN `mkdate` char(8), IN `delflag` int)
BEGIN
##名称
	#prod_ct_close_table_2_his
##作用
	#表转历史表
##参数说明
	#IN `table_name` varchar(512), IN `table_name_his` varchar(512), IN `delflag` int
	#table_name：原始表
	#table_name_his：历史表

##主体
	#拼接sql语句
	SET @prod_ct_close_table_2_his_sqlstr = CONCAT("INSERT INTO ", table_name_his, " SELECT *, '", mkdate, "' FROM ", table_name,' WHERE 1=1');
	#执行
	PREPARE stmt FROM @prod_ct_close_table_2_his_sqlstr;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

	IF(delflag = 1) THEN
		#清空原始表
		SET @prod_ct_close_table_2_his_sqlstrd = CONCAT("DELETE FROM ", table_name, ' WHERE 1=1');
		#执行
		PREPARE stmtd FROM @prod_ct_close_table_2_his_sqlstrd;
		EXECUTE stmtd;
		DEALLOCATE PREPARE stmtd;
	END IF;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
