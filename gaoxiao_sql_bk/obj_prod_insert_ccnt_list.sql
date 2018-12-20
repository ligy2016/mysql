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

/* Procedure structure for procedure `prod_insert_ccnt_list` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_insert_ccnt_list` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_insert_ccnt_list`(OUT `res` char(1), INOUT `acno` int, IN `type1` char(1), IN `ctid` int, IN `fuacct` varchar(18), IN `sub2fuacct` int, IN `sub3fuacct` int,IN `amttype` varchar(3), IN `amtocctype` varchar(8), IN `dric` int, IN `amt` decimal(38,4), IN `trdtype` varchar(32), IN `trdorderno` varchar(32))
BEGIN
	#此过程不处理充值和提现
	#res：返回值（'0'：成功 '1'：失败）
	#type1：账户类型（'0'：2级账户, '1'：可用交易资金子账户, '2'：冻结交易资金子账户, '3'：冻结保证金子账户(仅期权有效), '4'：实际占用保证金子账户(仅期权有效)）

	SET res = '0';
	#获取柜台时间
	CALL prod_get_ct_time(ctid, @time);

	IF(type1 = '0') THEN
		INSERT INTO tcasub2aclist(fs_fuacct, fi_sub2fuacct, 
														Fs_amttype, Fs_amtocctype, Fi_dric, 
														Fd_amt, Fs_trdtype, Fs_trdorderno, 
														Ft_regtime, Ft_updtime, Fi_status, Fs_correctdtl)
			VALUES(fuacct, sub2fuacct, 
						 amttype, amtocctype, dric, 
						 amt, trdtype, trdorderno, 
						 @time, @time, 1, NULL);
		SET acno = LAST_INSERT_ID();
		IF(ROW_COUNT() <= 0)THEN
			#ROLLBACK;
			SET res = '1';
		END IF;
	ELSEIF(type1 = '1' OR type1 = '2' OR type1 = '3' OR type1 = '4') THEN
		# 获取subno
		SELECT IFNULL(MAX(Fi_subno)+1, 1) INTO @subno FROM tcasub3aclist WHERE Fi_acno = acno FOR UPDATE;
		INSERT INTO tcasub3aclist(Fi_acno, Fi_subno, fs_fuacct, 
														fi_sub2fuacct, fi_sub3fuacct, Fi_dric, 
														Fd_amt, Fi_status)
			VALUES(acno, @subno, fuacct, 
						 sub2fuacct, sub3fuacct, dric, 
						 amt, 1);
		IF(ROW_COUNT() <= 0)THEN
			#ROLLBACK;
			SET res = '1';
		END IF;
	ELSE
		SET res = '1';
	END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
