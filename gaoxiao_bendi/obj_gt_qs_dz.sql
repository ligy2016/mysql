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

/* Procedure structure for procedure `gt_qs_dz` */

/*!50003 DROP PROCEDURE IF EXISTS  `gt_qs_dz` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `gt_qs_dz`(IN `gt` int, OUT `res` int)
LABEL_PROC:
BEGIN

	SET res = 0;
	#对账
	IF(gt = 1)THEN
		#股票对账
		#1子帐和等于总账
		SET @num1 = 0;
		SELECT count(*) INTO @num1 FROM 
			(SELECT sum(t2.Fd_TotalBal) totalBal, sum(t3.Fd_Balance)*2 subBal, t3.fs_fuacct fuacct FROM tcufuacct t1, tcasub2balance t2, tcasub3balance t3 
				WHERE t1.Fi_fuaccttype = 1 AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct GROUP BY t3.fs_fuacct) b1 
			WHERE b1.totalBal != b1.subBal;
		#2冻结子账户为0
		SET @num2 = 0;
		SELECT count(*) INTO @num2 FROM tcufuacct t1, tcasub2balance t2, tcasub3balance t3 
			WHERE t1.Fi_fuaccttype = 1 AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct AND t3.fi_sub3fuacct = 2 AND t3.Fd_Balance != 0;

		IF(@num1 != 0 or @num2 != 0)THEN
			SET res = 1;
			LEAVE LABEL_PROC;
		END IF;

	END IF;

	IF(gt = 2)THEN
		#期权对账
		#1子帐和等于总账
		SET @num3 = 0;
		SELECT count(*) INTO @num3 FROM 
			(SELECT sum(t2.Fd_TotalBal) totalBal, sum(t3.Fd_Balance)*4 subBal, t3.fs_fuacct fuacct FROM tcufuacct t1, tcasub2balance t2, tcasub3balance t3 
				WHERE t1.Fi_fuaccttype = 2 AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct GROUP BY t3.fs_fuacct) b1 
			WHERE b1.totalBal != b1.subBal;
		#2非行权日冻结子账户为0
		SET @num4 = 0;
		SELECT Fs_mkdate, Fs_exedate, Fs_deldate 
			INTO @madate, @exedate, @deldate
			FROM tmkstatus WHERE Fs_marketcode = '27';
		IF(@madate != @exedate)THEN#行权日
			SELECT count(*) INTO @num4 FROM tcufuacct t1, tcasub2balance t2, tcasub3balance t3 
			WHERE t1.Fi_fuaccttype = 2 AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct AND t3.fi_sub3fuacct = 2 AND t3.Fd_Balance != 0;
		END IF;

		IF(@num3 != 0 or @num4 != 0)THEN
			SET res = 1;
			LEAVE LABEL_PROC;
		END IF;

	END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
