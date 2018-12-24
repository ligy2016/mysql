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

/* Procedure structure for procedure `prod_szqq_111111` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_szqq_111111`(marketcode varchar(32),
stock_code char(6),
type char(1),
price char(15),price1 char(15))
LABEL_PROC:
begin
	DECLARE secacct varchar(18) DEFAULT('');
	DECLARE costbalance  decimal(18,2) ;
	DECLARE holdamount  int(0);
	DECLARE changebal  decimal(18,2) ;
	DECLARE done INT DEFAULT(FALSE);
	DECLARE cur1 CURSOR FOR
		SELECT  Fs_secacct,Fd_costbalance,Fi_holdamount
			FROM  tptstock00 
			WHERE Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexi = 0 and Fi_holdamount != 0;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	SET @res1 = '0';
	SET @res2 = '0';
	SET @acno = '0';
	if (type = 0) then
		update tptstock00 set Fi_enableamount = Fi_enableamount*(1+price), Fi_holdamount = Fi_holdamount*(1+price),Fi_lockamount = Fi_lockamount*(1+price),
									Fi_frozenamount = Fi_frozenamount*(1+price),Fi_exefroenbleamt = Fi_exefroenbleamt*(1+price),Fi_todayisexp = 1,Fd_costprice = Fd_costbalance/Fi_holdamount  
			where Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexp = 0;
	elseif (type = 1) then
		OPEN cur1;
		read_loop: LOOP
		FETCH cur1 INTO secacct,costbalance, holdamount;
		IF done THEN
			LEAVE read_loop;
		END IF;

		set changebal = holdamount * price1;

		select a.fi_sub2fuacct,a.fs_fuacct into @sub2fuacct,@fund_account from tcusub2fuacct a, tcusecacct b  
			where b.Fs_secacct = secacct and b.fs_fuacct = a.fs_fuacct and a.Fs_currency = 'CNY';
		
		update tcasub2balance a,tcasub3balance b    
			set a.Fd_TotalBal = a.Fd_TotalBal + changebal,a.Fd_AvalBal = a.Fd_AvalBal + changebal, 
				a.Fd_OutBal = a.Fd_OutBal + changebal,b.Fd_Balance = b.Fd_Balance + changebal
			where a.fi_sub2fuacct = @sub2fuacct  and a.fs_fuacct = @fund_account and 
					a.fs_fuacct = b.fs_fuacct and a.fi_sub2fuacct = b.fi_sub2fuacct and b.fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		IF(@res1 != '0' OR @res2 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			ROLLBACK;
			CLOSE cur1;
			LEAVE LABEL_PROC;
		end if;
		END LOOP;
		CLOSE cur1;

		#update tptstock00 set Fd_costbalance = Fd_costbalance*(1 - price) ,Fi_todayisexi = 1,Fd_costprice = Fd_costbalance/Fi_holdamount ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			#where Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexi = 0;
    #ly MODIFY
		update tptstock00 set Fd_costbalance = Fd_costbalance - Fi_holdamount*price1 ,Fi_todayisexi = 1,Fd_costprice = Fd_costbalance/Fi_holdamount ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			where Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexi = 0;
	elseif (type = 2) then
		OPEN cur1;
		read_loop: LOOP
		FETCH cur1 INTO secacct,costbalance, holdamount;
		IF done THEN
			LEAVE read_loop;
		END IF;

		set changebal = holdamount * price1;

		select a.fi_sub2fuacct,a.fs_fuacct into @sub2fuacct,@fund_account from tcusub2fuacct a, tcusecacct b  
			where b.Fs_secacct = secacct and b.fs_fuacct = a.fs_fuacct and a.Fs_currency = 'CNY';
		
		update tcasub2balance a,tcasub3balance b    
			set a.Fd_TotalBal = a.Fd_TotalBal + changebal,a.Fd_AvalBal = a.Fd_AvalBal + changebal, 
				a.Fd_OutBal = a.Fd_OutBal + changebal,b.Fd_Balance = b.Fd_Balance + changebal
			where a.fi_sub2fuacct = @sub2fuacct  and a.fs_fuacct = @fund_account and 
					a.fs_fuacct = b.fs_fuacct and a.fi_sub2fuacct = b.fi_sub2fuacct and b.fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,@fund_account,@sub2fuacct,1,'CX','INC',1,changebal,'持仓单','');
		IF(@res1 != '0' OR @res2 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			ROLLBACK;
			CLOSE cur1;
			LEAVE LABEL_PROC;
		end if;
		END LOOP;
		CLOSE cur1;

		#update tptstock00 set Fd_costbalance = Fd_costbalance*(1 - price) ,Fi_todayisexi = 1,Fd_costprice = Fd_costbalance/Fi_holdamount ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			#where Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexi = 0;
    #ly MODIFY
		update tptstock00 set Fd_costbalance = Fd_costbalance - Fi_holdamount*price1 ,Fd_costprice = Fd_costbalance/Fi_holdamount ,Fd_incomebalance = Fd_marketvalue - Fd_costbalance   
			where Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexi = 0;

		update tptstock00 set Fi_todayisexi = 1, Fi_enableamount = Fi_enableamount*(1+price), Fi_holdamount = Fi_holdamount*(1+price),Fi_lockamount = Fi_lockamount*(1+price),
									Fi_frozenamount = Fi_frozenamount*(1+price),Fi_exefroenbleamt = Fi_exefroenbleamt*(1+price),Fi_todayisexp = 1,Fd_costprice = Fd_costbalance/Fi_holdamount  
			where Fs_marketcode = marketcode and Fs_stockcode = stock_code and Fi_todayisexp = 0;

	end if;
	
	commit;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
