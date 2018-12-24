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
USE `feps`;

/* Procedure structure for procedure `prod_股票持仓及资金调整` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_股票持仓及资金调整`(marketcode VARCHAR(32),stock_code CHAR(6),TYPE CHAR(1),
		amt CHAR(15),price1 CHAR(15), secacct  VARCHAR(18), fundacct VARCHAR(18),holdamount INT ,OUT ret INT)
LABEL_PROC:
BEGIN
	DECLARE changebal  DECIMAL(18,2) ;
	DECLARE avalbal_2  DECIMAL(18,2) ;
	DECLARE avalbal_3  DECIMAL(18,2) ;
	DECLARE changeamt INT ;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION SET ret = 3;
	DECLARE EXIT  HANDLER FOR NOT FOUND	SET ret = 2;
	SET ret =0;
	SET @res1 = '0';
	SET @res2 = '0';
	SET @acno = '0';
	SET changebal = holdamount * price1;#分红
	SET changeamt = holdamount * (1+amt);
	
	
		SELECT a.fi_sub2fuacct,a.fs_fuacct INTO @sub2fuacct,@fund_account FROM tcusub2fuacct a, tcusecacct b  
			WHERE b.Fs_secacct = secacct AND b.fs_fuacct = a.fs_fuacct AND a.Fs_currency = 'CNY';
	IF (TYPE = 0 OR TYPE =4) THEN #0送转 4转增 ：一股变多股，资金不用调整
		UPDATE tptstock00 SET Fi_enableamount = Fi_enableamount +changeamt, Fi_holdamount = Fi_holdamount+changeamt,Fi_lockamount = Fi_lockamount+changeamt,
									Fi_frozenamount = Fi_frozenamount+changeamt,Fi_exefroenbleamt = Fi_exefroenbleamt+changeamt,Fi_todayisexp = 1,Fd_costprice = Fd_costbalance/Fi_holdamount  
			WHERE Fs_marketcode = marketcode AND Fs_stockcode = stock_code AND Fi_todayisexp = 0 AND fs_secacct = secacct;
	ELSEIF (TYPE = 1 ) THEN # 分红，数量不用调整
		
		UPDATE tcasub2balance a,tcasub3balance b    
			SET a.Fd_TotalBal = a.Fd_TotalBal + changebal,a.Fd_AvalBal = a.Fd_AvalBal + changebal, 
				a.Fd_OutBal = a.Fd_OutBal + changebal,b.Fd_Balance = b.Fd_Balance + changebal
			WHERE a.fi_sub2fuacct = @sub2fuacct  AND a.fs_fuacct = @fund_account AND 
					a.fs_fuacct = b.fs_fuacct AND a.fi_sub2fuacct = b.fi_sub2fuacct AND b.fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		IF(@res1 != '0' OR @res2 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			#ROLLBACK;
			SET ret = 4; 
			LEAVE LABEL_PROC;
		END IF;
		UPDATE tptstock00 SET Fd_costbalance = Fd_costbalance - Fi_holdamount*price1 ,Fi_todayisexi = 1,Fd_costprice = Fd_costbalance/Fi_holdamount ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			WHERE Fs_marketcode = marketcode AND Fs_stockcode = stock_code AND Fi_todayisexi = 0 AND fs_secacct = secacct;
	ELSEIF (TYPE = 2) THEN
		
		UPDATE tcasub2balance a,tcasub3balance b    
			SET a.Fd_TotalBal = a.Fd_TotalBal + changebal,a.Fd_AvalBal = a.Fd_AvalBal + changebal, 
				a.Fd_OutBal = a.Fd_OutBal + changebal,b.Fd_Balance = b.Fd_Balance + changebal
			WHERE a.fi_sub2fuacct = @sub2fuacct  AND a.fs_fuacct = @fund_account AND 
					a.fs_fuacct = b.fs_fuacct AND a.fi_sub2fuacct = b.fi_sub2fuacct AND b.fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		IF(@res1 != '0' OR @res2 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			#ROLLBACK;
			SET ret = 4; 
			LEAVE LABEL_PROC;
		END IF;
 
		UPDATE tptstock00 SET Fd_costbalance = Fd_costbalance - Fi_holdamount*price1 ,Fd_costprice = Fd_costbalance/Fi_holdamount ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			WHERE Fs_marketcode = marketcode AND Fs_stockcode = stock_code AND Fi_todayisexi = 0 AND fs_secacct = secacct; 
		UPDATE tptstock00 SET Fi_todayisexi = 1, Fi_enableamount = Fi_enableamount+changeamt, Fi_holdamount = Fi_holdamount+changeamt,Fi_lockamount = Fi_lockamount+changeamt,
									Fi_frozenamount = Fi_frozenamount+changeamt,Fi_exefroenbleamt = Fi_exefroenbleamt+changeamt,Fi_todayisexp = 1,Fd_costprice = Fd_costbalance/Fi_holdamount  
			WHERE Fs_marketcode = marketcode AND Fs_stockcode = stock_code AND Fi_todayisexp = 0 AND fs_secacct = secacct;
	ELSEIF (TYPE = 3) THEN #配股,客户要掏钱！
	SET changebal = holdamount* amt * price1;#此处为配股总额
			SELECT a.Fd_AvalBal ,b.Fd_Balance  INTO avalbal_2,avalbal_3 FROM tcasub2balance a  ,tcasub3balance b    
			WHERE a.fi_sub2fuacct = @sub2fuacct  AND a.fs_fuacct = @fund_account AND 
					a.fs_fuacct = b.fs_fuacct AND a.fi_sub2fuacct = b.fi_sub2fuacct AND b.fi_sub3fuacct = 1;
		IF (avalbal_2< changebal OR avalbal_3 <changebal) THEN
				SET ret = 5;#金额不足
				LEAVE LABEL_PROC;
		END IF;
 
		UPDATE tcasub2balance a,tcasub3balance b    
			SET a.Fd_TotalBal = a.Fd_TotalBal - changebal,a.Fd_AvalBal = a.Fd_AvalBal - changebal, 
				a.Fd_OutBal = a.Fd_OutBal - changebal,b.Fd_Balance = b.Fd_Balance - changebal
			WHERE a.fi_sub2fuacct = @sub2fuacct  AND a.fs_fuacct = @fund_account AND 
					a.fs_fuacct = b.fs_fuacct AND a.fi_sub2fuacct = b.fi_sub2fuacct AND b.fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,@fund_account,@sub2fuacct,1,'TAA','PAY',0,changebal,'持仓单','');
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,@fund_account,@sub2fuacct,1,'TAA','PAY',0,changebal,'持仓单','');
		IF(@res1 != '0' OR @res2 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			#ROLLBACK;
			SET ret = 4; 
			LEAVE LABEL_PROC;
		END IF;
		UPDATE tptstock00 SET Fd_costbalance = Fd_costbalance + changebal ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			WHERE Fs_marketcode = marketcode AND Fs_stockcode = stock_code AND Fi_todayisexi = 0 AND fs_secacct = secacct; 
		
		UPDATE tptstock00 SET Fi_todayisexi = 1, Fi_enableamount = Fi_enableamount+changeamt, Fi_holdamount = Fi_holdamount+changeamt,Fi_lockamount = Fi_lockamount+changeamt,
				Fi_frozenamount = Fi_frozenamount+changeamt,Fi_exefroenbleamt = Fi_exefroenbleamt+changeamt,Fi_todayisexp = 1,Fd_costprice = Fd_costbalance/Fi_holdamount  
			WHERE Fs_marketcode = marketcode AND Fs_stockcode = stock_code AND Fi_todayisexp = 0 AND fs_secacct = secacct;
	END IF;
	
#	commit;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
