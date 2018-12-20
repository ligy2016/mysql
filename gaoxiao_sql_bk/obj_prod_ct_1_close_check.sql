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

/* Procedure structure for procedure `prod_ct_1_close_check` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_ct_1_close_check` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_ct_1_close_check`(OUT `res` int)
LABEL_PROC:
BEGIN
	##名称
		#prod_ct_1_close_check
	##作用
		#柜台1对账
	##参数说明
		#OUT `res` int
		#res：（0成功，1失败)
	##主体
	DECLARE num1 int DEFAULT(0);
	DECLARE num2 int DEFAULT(0);
	SET res = 0;

	#1子帐和等于总账
	SELECT count(*) INTO num1 FROM 
		(SELECT sum(t2.Fd_TotalBal) totalBal, sum(t3.Fd_Balance)*2 subBal, t3.fs_fuacct fuacct FROM tcufuacct t1, tcasub2balance t2, tcasub3balance t3 
			WHERE t1.Fi_fuaccttype = 1 AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct GROUP BY t3.fs_fuacct) b1 
		WHERE b1.totalBal != b1.subBal;
	#2冻结子账户为0
	SELECT count(*) INTO num2 FROM tcufuacct t1, tcasub2balance t2, tcasub3balance t3 
		WHERE t1.Fi_fuaccttype = 1 AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct AND t3.fi_sub3fuacct = 2 AND t3.Fd_Balance != 0;
		
	IF(num1 != 0 or num2 != 0)THEN
		SET res = 1;
		LEAVE LABEL_PROC;
	END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
