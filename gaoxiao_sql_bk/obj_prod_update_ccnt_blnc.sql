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

/* Procedure structure for procedure `prod_update_ccnt_blnc` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_update_ccnt_blnc` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_update_ccnt_blnc`(OUT `res` char(1), IN `type1` char(1), IN `type2` char(1), IN `amount` decimal(19,3), IN `fuacct` varchar(18), IN `sub2fuacct` int, IN `sub3fuacct` int)
BEGIN
##名称
	#prod_update_ccnt_blnc
##作用
	#更新资产账户余额
	#业务引起的资金变动统一使用此过程
	#此过程不处理充值和提现
##参数说明
	#OUT `res` char(1), IN `type1` char(1), IN `type2` char(1), IN `amount` decimal(19,3), IN `fuacct` varchar(18), IN `sub2fuacct` int, IN `sub3fuacct` int
	#res：返回值（'0'：成功, '1'：失败）
	#type1：账户类型（'0'：2级账户, '1'：可用交易资金子账户, '2'：冻结交易资金子账户, '3'：冻结保证金子账户(仅期权有效), '4'：实际占用保证金子账户(仅期权有效)）
	#type2：操作类型（'0'：转入 '1'：转出 '2'：冻结 '3'：解冻 '4': 冻结后转出）

##主体	
	DECLARE TotalBal decimal(19,3) DEFAULT(0.0);
	DECLARE AvalBal decimal(19,3) DEFAULT(0.0);
	SET res = '0';

##二级账户
	IF(type1 = '0') THEN
		IF(type2 = '0') THEN
			UPDATE tcasub2balance SET Fd_TotalBal = Fd_TotalBal + amount, Fd_AvalBal = Fd_AvalBal + amount
				WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct;
		ELSEIF(type2 = '1') THEN
			SELECT Fd_TotalBal, Fd_AvalBal INTO TotalBal, AvalBal FROM tcasub2balance
				WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct FOR UPDATE;
			IF(TotalBal < amount OR AvalBal < amount) THEN
				SET res = '1';
			ELSE
				UPDATE tcasub2balance SET Fd_TotalBal = Fd_TotalBal - amount, Fd_AvalBal = Fd_AvalBal - amount
					WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct;
			END IF;
		ELSEIF(type2 = '2') THEN
			SELECT Fd_AvalBal INTO AvalBal FROM tcasub2balance 
				WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct FOR UPDATE;
			IF(AvalBal < amount) THEN
				SET res = '1';
			ELSE
				UPDATE tcasub2balance SET Fd_AvalBal = Fd_AvalBal - amount
					WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct;
			END IF;
		ELSEIF(type2 = '3') THEN
				UPDATE tcasub2balance SET Fd_AvalBal = Fd_AvalBal + amount
					WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct;
		ELSEIF(type2 = '4') THEN
			SELECT Fd_TotalBal INTO @TotalBal FROM tcasub2balance
				WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct FOR UPDATE;
			if(ABS(@TotalBal - amount) <= 0.0001) THEN
					UPDATE tcasub2balance SET Fd_TotalBal = 0.0  
						WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct;
			ELSEIF(@TotalBal < amount ) THEN
				#ROLLBACK;
					SET res = '1';
			ELSE
				UPDATE tcasub2balance SET Fd_TotalBal = Fd_TotalBal - amount 
					WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct;
			END IF;
		ELSE
			SET res = '1';
		END IF;

##三级账户
	ELSEIF(type1 = '1' OR type1 = '2' OR type1 = '3' OR type1 = '4') THEN
		IF(type2 = '0') THEN
			UPDATE tcasub3balance SET Fd_Balance = Fd_Balance + amount
				WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct AND fi_sub3fuacct = sub3fuacct;
		ELSEIF(type2 = '1') THEN
			SELECT Fd_Balance INTO TotalBal FROM tcasub3balance 
				WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct AND fi_sub3fuacct = sub3fuacct FOR UPDATE;
			IF(TotalBal < amount) THEN
				SET res = '1';
			ELSE
				UPDATE tcasub3balance SET Fd_Balance = Fd_Balance - amount
					WHERE fs_fuacct = fuacct AND fi_sub2fuacct = sub2fuacct AND fi_sub3fuacct = sub3fuacct;
			END IF;
		ELSE
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
