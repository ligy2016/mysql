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

/* Procedure structure for procedure `prod_zjgl_332200` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_zjgl_332200` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_zjgl_332200`(inout client_id varchar(18),
fund_account varchar(18),
money_type varchar(3),
transfer_direction char(1),
occur_balance varchar(20),
founder varchar(32))
LABEL_PROC:
BEGIN

/*
client_id varchar(18),#客户编号
fund_account varchar(18),#资产账号
money_type varchar(3),#金额类型
transfer_direction char(1),#资金增减类型  1加 2减
occur_balance varchar(20),#资金金额
founder varchar(32)#操作人*/
	set @balance = 0;
	set @abalbal = 0;
	set @outbal = 0;
	SET @res1 = '0';
	SET @res2 = '0';
	set @acno = '0';
	set @bankcard = '';
	set @sub2fuacct = '';
	#判断是否闭市
	SELECT fi_status INTO @mkstatus FROM tmkstatus WHERE fs_marketcode = '0';
	SELECT fi_status INTO @mkstatus1 FROM tmkstatus WHERE fs_marketcode = '1';
	IF(@mkstatus != 0 and @mkstatus1 != 0  )THEN
		SELECT 'error_no', '-99', '当前市场状态不允许转账' AS info;
		#ROLLBACK;
		set client_id = '1';
		LEAVE LABEL_PROC;
	END IF;

	
	/*if (money_type = '0') THEN
		set money_type = 'CNY';
	elseif (money_type = '1') THEN
		set money_type = 'USD';
	elseif (money_type = '2') THEN
		set money_type = 'HKD';
	end if;*/
	/*
	select c.Fd_Balance,a.Fs_bankcard into @balance,@bankcard 
		from tcufuabindbc a, tcubankcard b, tcabankcardbalance c  
		where a.Fs_bankcard = b.Fs_bankcard and a.fs_fuacct = fund_account 
			and b.Fs_clientid = client_id and b.Fs_currency = money_type 
			and c.Fs_bankcard = a.Fs_bankcard FOR UPDATE;
	if (@bankcard = '') then
		ROLLBACK;
		#SELECT -51;
		SELECT 'error_no', '-99', '无此账户';
		LEAVE LABEL_PROC;
	end if;
	*/
	select a.Fd_AvalBal,a.Fd_OutBal,a.fi_sub2fuacct into @abalbal,@outbal,@sub2fuacct  
		from tcasub2balance a, tcusub2fuacct b 
		where a.fs_fuacct = b.fs_fuacct and a.fi_sub2fuacct = b.fi_sub2fuacct 
			and b.Fs_currency = money_type and a.fs_fuacct = fund_account FOR UPDATE;
	if (@sub2fuacct = '') then
		#ROLLBACK;
		set client_id = '1';
		SELECT 'error_no', '-99', '资产账号不存在' AS info;
		LEAVE LABEL_PROC;
	end if;		
	
	if (transfer_direction = '1') then
		/*if (occur_balance > @balance) then
			ROLLBACK;
			#SELECT -57;
			SELECT 'error_no', '-99', '资金不足';
			LEAVE LABEL_PROC;
		end if;
		*/
		/*update tcabankcardbalance set Fd_Balance =  Fd_Balance - occur_balance 
			where Fs_bankcard = @bankcard;*/
			
		UPDATE tcasub2balance SET Fd_TotalBal = Fd_TotalBal + occur_balance, Fd_AvalBal = Fd_AvalBal + occur_balance, Fd_OutBal = Fd_OutBal + occur_balance ,
															Fd_TotalRecharge = Fd_TotalRecharge + occur_balance 
				WHERE fs_fuacct = fund_account AND fi_sub2fuacct = @sub2fuacct;
		update tcasub3balance set Fd_Balance = Fd_Balance + occur_balance 
				where fs_fuacct = fund_account AND fi_sub2fuacct = @sub2fuacct and fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,fund_account,@sub2fuacct,2,'BDW','INC',1,occur_balance,'银转证','');
		update tcasub2aclist set Fs_founder = founder where Fi_acno = @acno;
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,fund_account,@sub2fuacct,1,'BDW','INC',1,occur_balance,'银转证','');
		
	elseif (transfer_direction = '2') then
		#set @min = min(@abalbal,@outbal);
		SELECT LEAST(@abalbal,@outbal) into @min ;
		if (occur_balance > @min) then
			#ROLLBACK;
			#SELECT -57;
			set client_id = '1';
			SELECT 'error_no', '-99', '资金不足' AS info;
			LEAVE LABEL_PROC;
		end if;
		
	/*	update tcabankcardbalance set Fd_Balance =  Fd_Balance + occur_balance 
			where Fs_bankcard = @bankcard; */
			
		UPDATE tcasub2balance SET Fd_TotalBal = Fd_TotalBal - occur_balance, Fd_AvalBal = Fd_AvalBal - occur_balance, Fd_OutBal = Fd_OutBal - occur_balance ,
															Fd_TotalReflect = Fd_TotalReflect + occur_balance 
				WHERE fs_fuacct = fund_account AND fi_sub2fuacct = @sub2fuacct;
		update tcasub3balance set Fd_Balance = Fd_Balance - occur_balance 
				where fs_fuacct = fund_account AND fi_sub2fuacct = @sub2fuacct and fi_sub3fuacct = 1;
		CALL prod_insert_ccnt_list(@res1,@acno,'0',1,fund_account,@sub2fuacct,2,'BDW','PAY',0,occur_balance,'证转银','');
		update tcasub2aclist set Fs_founder = founder where Fi_acno = @acno;
		CALL prod_insert_ccnt_list(@res2,@acno,'1',1,fund_account,@sub2fuacct,1,'BDW','PAY',0,occur_balance,'证转银','');	
		
	end if;
	if (@res1 != '0' OR @res2 != '0') then
		#ROLLBACK;
		#SELECT -57;
		set client_id = '1';
		SELECT 'error_no', '-99', '资金不足' AS info;
		LEAVE LABEL_PROC;
	end if;	
	
	/*if(client_id = '1')THEN
		#commit;
	end if;*/
	/*select @acno;*/
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
