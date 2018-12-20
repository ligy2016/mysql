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

/* Procedure structure for procedure `prod_szqq_888888` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_szqq_888888` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_szqq_888888`(entrustsecno varchar(11),
optbusinessprice char(15),
businessamount char(11),
entruststatus char(1))
LABEL_PROC:
BEGIN
	DECLARE cms DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tsf DECIMAL(16,4) DEFAULT(0.0);
	DECLARE std DECIMAL(16,4) DEFAULT(0.0);
	DECLARE cms1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE cms2 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tsf1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE std1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE preamtpre DECIMAL(16,4) DEFAULT(0.0);
	DECLARE preamt DECIMAL(16,4) DEFAULT(0.0);
#判断是否正在撤单
	SELECT Fs_entruststatus,Fs_marketcode,Fs_TaddN INTO @lockentruststatus, @marketcode,@taddn #新加t+0标志 
			FROM ttsstkentrustsec00 WHERE Fi_entrustsecno = entrustsecno FOR UPDATE;
	IF(@lockentruststatus != '2')THEN
		IF(@lockentruststatus != '7')THEN
			SELECT 'error_no', @lockentruststatus , concat(@lockentruststatus,' 委托状态不对' ) as info;
			ROLLBACK;
			LEAVE LABEL_PROC;
		END IF;
	END IF;

	CALL prod_mk_get_time(@marketcode, @time);
	SET @init_date = LEFT(REPLACE(@time,'-',''),8);
	SET @entrust_time = RIGHT(@time,8);

	#修改委托单状态
	SELECT COUNT(*) INTO @count FROM ttsstkentrustsec00
		WHERE Fi_entrustsecno = entrustsecno;
	IF(@count <= 0)THEN
		SELECT 'error_no', '-99', '委托单不存在'  as info;
		LEAVE LABEL_PROC;
	END IF;
	UPDATE ttsstkentrustsec00 SET Fs_entruststatus = entruststatus,Fd_businessprice = (Fd_businessprice*Fi_businessamount +optbusinessprice*businessamount)/(Fi_businessamount+businessamount),
					Fi_businessamount = businessamount + Fi_businessamount 
		WHERE Fi_entrustsecno = entrustsecno;

	SELECT t1.Fs_entrustbs,  t1.fs_fuacct, t1.Fd_optentrustprice,t1.Fi_entrustamount,t1.Fs_secacct,t1.Fs_stockcode,t2.Fs_kindcode   
		INTO @entrust_bs,  @fund_account, @optentrustprice ,@entrustamount,@secacct,@stockcode,@kindcode 
		FROM trqstkentrust00 t1, tcmstockcode00 t2
		WHERE t1.Fi_entrustno = entrustsecno AND t1.Fs_marketcode = t2.Fs_marketcode AND t1.Fs_stockcode = t2.Fs_stockcode;

	SET preamt = optbusinessprice * businessamount ;
	SET preamtpre = @optentrustprice * businessamount;
	#计算费用
	/*SET preamtpre = @optentrustprice * businessamount;
	SET std = preamtpre * 0.001; #印花税
	if (preamtpre >= 10000) then
		SET cms = preamtpre * 0.00025; #佣金
	else
		SET cms = 2.5;
	end if;
	
	SET tsf = preamtpre *0.00002; #过户费
	
	SET preamt = optbusinessprice * businessamount ;
  SET std1 = preamt * 0.001; #印花税
	if (preamtpre >= 10000) then
		SET cms1 = preamt * 0.00025; #佣金
	else
		SET cms1 = 2.5;
	end if;
	
	SET tsf1 = preamt *0.00002; #过户费  */


	#获取成交单
	SET @businessid = 0;
	set @bsamt = 0;
	SELECT Fi_businessecno,Fi_businessamount INTO @businessid,@bsamt FROM ttsstkbusisec00 WHERE Fi_entrustsecno = entrustsecno;

	IF(@businessid = 0)THEN
		#生成成交单
		INSERT INTO ttsstkbusisec00(Fi_entrustsecno,Fs_marketcode, Fs_mkdate, Fs_secacct, Fs_stockcode, 
									Fs_stocktype, Fs_entrustbs,Fd_businessprice,Fi_businessamount,
									Fs_realstatus,Fi_businesstimes,Fs_orderid,Fs_origorderid,Ft_businesscrttime,
									Ft_businessupdtime,Fd_businessbalance,Fs_EnforceSell,Fd_occurmoney,Fd_exchangefare1,Fd_exchangefare2,Fd_standardfare0)
		SELECT  Fi_entrustsecno,Fs_marketcode,@init_date,  Fs_secacct, Fs_stockcode, 
						Fs_stocktype, Fs_entrustbs, optbusinessprice, businessamount, 
						'0', 1, Fs_orderid,Fs_origorderid,@time, @time, preamt,Fs_EnforceSell, preamt,0,0,0   
						FROM ttsstkentrustsec00 WHERE Fi_entrustsecno= entrustsecno;
		IF(ROW_COUNT() <= 0)THEN
			ROLLBACK;
			SELECT 'error_no', '-99', '生成成交单有误'  as info;
			LEAVE LABEL_PROC;
		END IF;
		SET @businessid = LAST_INSERT_ID();
	ELSE
		#更新成交单
		UPDATE ttsstkbusisec00 SET Fi_businesstimes = Fi_businesstimes + 1,
			Fi_businessamount = Fi_businessamount + businessamount,
			Fd_businessbalance = Fd_businessbalance + preamt,
			Fd_occurmoney = Fd_occurmoney + preamt,
			Fd_businessprice = Fd_businessbalance / Fi_businessamount 
			WHERE Fi_businessecno = @businessid;
		
		IF(ROW_COUNT() <= 0)THEN
			ROLLBACK;
			SELECT 'error_no', '-99', '更新成交单有误'  as info;
			LEAVE LABEL_PROC;
		END IF;
	END IF;
	
	SELECT Fd_businessprice into @businessprice from ttsstkbusisec00 where  Fi_businessecno = @businessid;
	#添加成交单明细
	INSERT INTO ttsstkbusiseclist00(Fi_businessecno, Fd_optbusinessprice, Fi_businessamount, Fs_realstatus,
																		Ft_businesscrttime, Ft_businessupdtime, Fd_businessbalance, Fi_entrustsecno,Fi_restnum,Fd_occurmoney)
		values(@businessid, optbusinessprice, businessamount, '0', 
						@time, @time, preamt, entrustsecno,@entrustamount - businessamount,preamt);
	IF(ROW_COUNT() <= 0)THEN
		ROLLBACK;
		SELECT 'error_no', '-99', '生成成交明细单有误'  as info;
		LEAVE LABEL_PROC;
	END IF;

	if(@bsamt + businessamount > @entrustamount) then
		ROLLBACK;
		SELECT 'error_no', @entrustamount-@bsamt, '成交数量超过委托数量'  as info;
		LEAVE LABEL_PROC;
	END IF;
	
	#资金变动
	SET @res1 = '0';
	SET @res2 = '0';
	SET @res3 = '0';
	SET @res4 = '0';
	SET @res5 = '0';
	SET @res6 = '0';
	SET @res7 = '0';
	SET @acno = '0';
	#select fi_sub2fuacct into @sub2fuacct from tcusub2fuacct where fs_fuacct = @fund_account and Fs_currency = 'CNY';
	select a.fi_sub2fuacct into @sub2fuacct from tcusub2fuacct a,trefsecaccttype b where a.fs_fuacct = @fund_account and a.Fs_currency = b.Fs_currency and 
					b.Fs_marketcode = @marketcode and b.Fs_kindcode = @kindcode;
	SELECT Fs_usagecode into @usagecode from tcufuacct where fs_fuacct = @fund_account and Fi_usage = 1;
	#select fi_sub3fuacct into @sub3fuacct from tcusub3fuacct where fs_fuacct = fund_account and fi_sub2fuacct = @sub2fuacct and Fi_sub3fuaccttype = 2;
	#select fi_sub3fuacct into @sub3fuacct1 from tcusub3fuacct where fs_fuacct = fund_account and fi_sub2fuacct = @sub2fuacct and Fi_sub3fuaccttype = 1;
	if (@kindcode = '1' or @kindcode = '2')THEN
				set @feegoods = '1';
			ELSEIF(@kindcode = '3')THEN
				set @feegoods = '4';
			ELSEIF(@kindcode = '4')THEN
				set @feegoods = '5';
			ELSEIF(@kindcode = '5' or @kindcode = '6')THEN
				set @feegoods = '2';
			ELSEIF(@kindcode = '7' or @kindcode = '8')THEN
				set @feegoods = '3';
			end if;
	call prod_fee_updata_blnc(@res1,'2',@usagecode,@feegoods,@entrust_bs,@optentrustprice * @entrustamount,@businessprice * businessamount,@fund_account,@sub2fuacct,entrustsecno,@businessid,cms,tsf,std);
			IF(@res1 != '0' )THEN
				SELECT 'error_no', '-99', '资金操作失败1'  as info;
				ROLLBACK;
				LEAVE LABEL_PROC;
			end if;
	if(@optentrustprice * @entrustamount >= 10000)THEN
		set cms2 = cms + std + tsf;
	ELSE
		set cms2 = (cms + std + tsf)*businessamount/@entrustamount;
	end if;
	
	if (@entrust_bs = '2') then
		/*if(@marketcode = '0')THEN
			set cms2 = cms1 + std1 + tsf1;
		ELSE
			set cms2 = cms1 + std1;
		end if;*/
		CALL prod_update_ccnt_blnc(@res1,'0','0',preamt,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',preamt,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,@fund_account,@sub2fuacct,2,'TAA','INC',1,preamt,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,@fund_account,@sub2fuacct,1,'TAA','INC',1,preamt,'成交单',@businessid);
		select Fi_holdamount ,Fd_costbalance into @holdamount,@costbalance from tptstock00 where Fs_marketcode = @marketcode and Fs_secacct = @secacct and Fs_stockcode = @stockcode;
		if ((@holdamount - businessamount) = 0 ) then
			set @cost = 0;
		else
			set @cost = (@costbalance - businessamount * optbusinessprice + cms2) / (@holdamount - businessamount);
		end if;

		if (@cost = 0 ) then
			set @profitratio = 0;
		else
			set @profitratio = (@holdamount*optbusinessprice - @costbalance)/@cost*(@holdamount - businessamount);
		end if;
		
		update tptstock00 set Fd_avsellprice = (Fd_avsellprice*Fi_realsellamount + businessamount * optbusinessprice) / (Fi_realsellamount + businessamount),
								Fi_holdamount = Fi_holdamount - businessamount ,Fi_entrustsellamount = Fi_entrustsellamount - businessamount ,
								Fi_realsellamount = Fi_realsellamount + businessamount,
								Fd_costbalance = Fd_costbalance - businessamount * optbusinessprice + cms2, Fd_costprice = @cost,Fd_marketvalue = Fi_holdamount*optbusinessprice,Fd_incomebalance = Fd_marketvalue - Fd_costbalance,
								Fd_profitratio = @profitratio      
			where Fs_marketcode = @marketcode and Fs_secacct = @secacct and Fs_stockcode = @stockcode;
	elseif (@entrust_bs = '1') then
		/*if(@marketcode = '0')THEN
			set cms2 = cms1  + tsf1;
		ELSE
			set cms2 = cms1 ;
		end if;*/
		CALL prod_update_ccnt_blnc(@res1,'0','3',preamtpre-preamt,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',preamtpre-preamt,@fund_account,@sub2fuacct,1);
		CALL prod_update_ccnt_blnc(@res3,'0','4',preamt,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res4,'2','1',preamtpre,@fund_account,@sub2fuacct,2);
		CALL prod_insert_ccnt_list(@res5,@acno,'0',1,@fund_account,@sub2fuacct,2,'TAA','PAY',0,preamt,'成交单',@businessid);
		if (preamtpre-preamt != 0) then
			CALL prod_insert_ccnt_list(@res6,@acno,'1',1,@fund_account,@sub2fuacct,1,'TAA','INC',1,preamtpre-preamt,'成交单',@businessid);
		end if;
		CALL prod_insert_ccnt_list(@res7,@acno,'2',1,@fund_account,@sub2fuacct,2,'TAA','PAY',0,preamtpre,'成交单',@businessid);
		insert into tptstock00(
									Fs_marketcode,
									Fs_secacct,
									Fs_stockcode,
									Fs_stocktype,
									Fs_stockname,
									Fi_currentamount,
									Fi_holdamount,
									Fi_enableamount,
									Fi_realbuyamount,
									Fi_realsellamount,
									Fi_uncomebuyamount,
									Fi_uncomesellamount,
									Fi_entrustsellamount,
									Fd_lastprice,
									Fd_costprice,
									Fd_keepcostprice,
									Fd_incomebalance,
									Fs_handflag,
									Fd_marketvalue,
									Fd_avbuyprice,
									Fd_avincomebalance,
									Fd_costbalance,
									Fs_delistflag,
									Fs_delistdate,
									Fd_parvalue,
									Fd_incomebalancenofare,
									Fi_frozenamount,
									Fd_profitratio,
									Fs_mkdate,
									Fi_lockamount,
									Fi_realbuylockamount,
									Fi_exefroenbleamt,
									Fi_exefrobuyamt,
									Fd_avsellprice)
				select @marketcode,@secacct,@stockcode,Fs_stocktype,Fs_stockname,0,businessamount,0,businessamount,0,0,0,0,optbusinessprice,
						(businessamount*optbusinessprice + cms2)/businessamount,optbusinessprice,0,'',businessamount*optbusinessprice,optbusinessprice,0,businessamount*optbusinessprice + cms2,Fs_delistflag,Fs_delistdate,
						Fd_parvalue,0,0,0,@init_date,0,businessamount,0,0,0      
					from tcmstockcode00 
					where Fs_marketcode = @marketcode and  Fs_stockcode = @stockcode  
				ON DUPLICATE KEY UPDATE 
					Fd_avbuyprice = (Fd_avbuyprice*Fi_realbuyamount + businessamount * optbusinessprice) / (Fi_realbuyamount + businessamount),
					Fi_holdamount = Fi_holdamount + businessamount , Fi_realbuyamount = Fi_realbuyamount + businessamount,Fi_realbuylockamount = Fi_realbuylockamount + businessamount,
					 Fd_costbalance = Fd_costbalance + businessamount * optbusinessprice +cms2, Fd_costprice = Fd_costbalance/Fi_holdamount,
					Fd_marketvalue = Fi_holdamount*optbusinessprice,Fd_incomebalance = Fd_marketvalue - Fd_costbalance,Fd_profitratio = IFNULL(Fd_incomebalance/(Fd_costprice*Fi_holdamount),0);
		if(@taddn = 0) THEN #新加t+0
			update tptstock00 set Fi_realbuyamount = Fi_realbuyamount-businessamount,Fi_enableamount = Fi_enableamount + businessamount 
													where Fs_marketcode = @marketcode and  Fs_stockcode = @stockcode and Fs_secacct = @secacct;
		end if;

	end if;
	IF(@res1 != '0' OR @res2 != '0'  OR @res3 != '0'  OR @res4 != '0' OR @res5 != '0' OR @res6 != '0' OR @res7 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败2'  as info;
		#select @res1,@res2,@res3,@res4,@res5,@res6, preamtpre, preamt, @fund_account;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;





	if (@entrustamount = businessamount OR @bsamt+businessamount = @entrustamount ) then
			call prod_fee_updata_blnc(@res1,'1',@usagecode,@feegoods,@entrust_bs,@optentrustprice * @entrustamount,@businessprice * @entrustamount,@fund_account,@sub2fuacct,entrustsecno,@businessid,cms,tsf,std);
			IF(@res1 != '0' )THEN
				SELECT 'error_no', '-99', '资金操作失败3'  as info;
				ROLLBACK;
				LEAVE LABEL_PROC;
			end if;
		/*if( @bsamt != 0) THEN
				#SET preamtpre = @optentrustprice * @entrustamount;
				if ((@optentrustprice * @entrustamount) >= 10000) then
						SET cms = (@optentrustprice * @entrustamount) * 0.00025; #佣金
				else
						SET cms = 2.5;
				end if;
				#SET preamt = optbusinessprice * @entrustamount ;
				if ((@optentrustprice * @entrustamount) >= 10000) then
					SET cms1 = (@businessprice * @entrustamount) * 0.00025; #佣金
				else
					SET cms1 = 2.5;
				end if;
				
				#SET preamtpre = @optentrustprice * businessamount;
				SET std = (@optentrustprice * @entrustamount) * 0.001; #印花费
	
				SET tsf = (@optentrustprice * @entrustamount) *0.00002; #过户费
	
				#SET preamt = optbusinessprice * businessamount ;
				SET std1 = (@businessprice * @entrustamount) * 0.001; #印花税
	
				SET tsf1 = (@businessprice * @entrustamount) *0.00002; #过户费  
				
		end if;


		if(@entrust_bs = '1')then
			CALL prod_update_ccnt_blnc(@res1,'0','3',cms,@fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','1',cms,@fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','0',cms,@fund_account,@sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,@fund_account,@sub2fuacct,2,'CMS','UFZ',2,cms,'委托单',entrustsecno);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,@fund_account,@sub2fuacct,1,'CMS','UFZ',1,cms,'委托单',entrustsecno);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,@fund_account,@sub2fuacct,2,'CMS','UFZ',0,cms,'委托单',entrustsecno);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SELECT 'error_no', '-99', '资金操作失败131';
				ROLLBACK;
				LEAVE LABEL_PROC;
			end if;
		end if;

		if (@marketcode = '0' and @entrust_bs = '1') then
			CALL prod_update_ccnt_blnc(@res1,'0','3',tsf,@fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','1',tsf,@fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','0',tsf,@fund_account,@sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,@fund_account,@sub2fuacct,2,'TSF','UFZ',2,tsf,'委托单',entrustsecno);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,@fund_account,@sub2fuacct,1,'TSF','UFZ',1,tsf,'委托单',entrustsecno);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,@fund_account,@sub2fuacct,2,'TSF','UFZ',0,tsf,'委托单',entrustsecno);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
			SELECT 'error_no', '-99', '资金操作失败201';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;


		CALL prod_update_ccnt_blnc(@res1,'0','1',cms1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',cms1,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,@fund_account,@sub2fuacct,2,'CMS','PAY',0,cms1,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,@fund_account,@sub2fuacct,1,'CMS','PAY',0,cms1,'成交单',@businessid);
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' )THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
			SELECT 'error_no', '-99', '资金操作失败201';
			ROLLBACK;
		LEAVE LABEL_PROC;
		end if;

		IF(@entrust_bs = '2')THEN
			CALL prod_update_ccnt_blnc(@res1,'0','1',std1,@fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'1','1',std1,@fund_account,@sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res3,@acno,'0',1,@fund_account,@sub2fuacct,2,'STD','PAY',0,std1,'成交单',@businessid);
			CALL prod_insert_ccnt_list(@res4,@acno,'1',1,@fund_account,@sub2fuacct,1,'STD','PAY',0,std1,'成交单',@businessid);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' )THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
			SELECT 'error_no', '-99', '资金操作失败201';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;

		if (@marketcode = '0') then
			CALL prod_update_ccnt_blnc(@res1,'0','1',tsf1,@fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'1','1',tsf1,@fund_account,@sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res3,@acno,'0',1,@fund_account,@sub2fuacct,2,'TSF','PAY',0,tsf1,'成交单',@businessid);
			CALL prod_insert_ccnt_list(@res4,@acno,'1',1,@fund_account,@sub2fuacct,1,'TSF','PAY',0,tsf1,'成交单',@businessid);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' )THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
			SELECT 'error_no', '-99', '资金操作失败201';
			ROLLBACK;
		LEAVE LABEL_PROC;
		end if;*/


		/*		
		CALL prod_update_ccnt_blnc(@res1,'0','4',cms1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','1',cms,@fund_account,@sub2fuacct,2);
		#CALL prod_update_ccnt_blnc(@res3,'1','1',cms,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,@fund_account,@sub2fuacct,2,'CMS','PAY',0,cms1,'成交单',@businessid);
		#CALL prod_insert_ccnt_list(@res5,@acno,'1',1,@fund_account,@sub2fuacct,1,'CMS','FRZ',0,cms,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,@fund_account,@sub2fuacct,2,'CMS','PAY',0,cms,'成交单',@businessid);
		IF(@res1 != '0' OR @res2 != '0' OR @res4 != '0'  OR @res6 != '0')THEN
			SELECT 'error_no', '-99', '资金操作失败';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;
		
		CALL prod_update_ccnt_blnc(@res1,'0','3',cms-cms1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',cms-cms1,@fund_account,@sub2fuacct,1);
		if (cms-cms1 != 0) then
			CALL prod_insert_ccnt_list(@res3,@acno,'1',1,@fund_account,@sub2fuacct,1,'CMS','INC',1,cms-cms1,'成交单',@businessid);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;

	
	
	IF(@entrust_bs = '2')THEN
		CALL prod_update_ccnt_blnc(@res1,'0','4',std1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','1',std,@fund_account,@sub2fuacct,2);
		#CALL prod_update_ccnt_blnc(@res3,'1','1',std,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,@fund_account,@sub2fuacct,2,'STD','PAY',0,std1,'成交单',@businessid);
		#CALL prod_insert_ccnt_list(@res5,@acno,'1',1,@fund_account,@sub2fuacct,1,'STD','FRZ',0,std,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,@fund_account,@sub2fuacct,2,'STD','PAY',0,std,'成交单',@businessid);

		IF(@res1 != '0' OR @res2 != '0'  OR @res4 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败';
		ROLLBACK;
		LEAVE LABEL_PROC;
		end if;

		CALL prod_update_ccnt_blnc(@res1,'0','3',std-std1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',std-std1,@fund_account,@sub2fuacct,1);
		if (std-std1 != 0) then
			CALL prod_insert_ccnt_list(@res3,@acno,'1',1,@fund_account,@sub2fuacct,1,'STD','INC',1,std-std1,'成交单',@businessid);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;

	end if;
	
	
	if (@marketcode = '0') then
		CALL prod_update_ccnt_blnc(@res1,'0','4',tsf1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','1',tsf,@fund_account,@sub2fuacct,2);
		#CALL prod_update_ccnt_blnc(@res3,'1','1',tsf,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,@fund_account,@sub2fuacct,2,'TSF','PAY',0,tsf1,'成交单',@businessid);
		#CALL prod_insert_ccnt_list(@res5,@acno,'1',1,@fund_account,@sub2fuacct,1,'TSF','FRZ',0,tsf,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,@fund_account,@sub2fuacct,2,'TSF','PAY',0,tsf,'成交单',@businessid);
		IF(@res1 != '0' OR @res2 != '0'  OR @res4 != '0'  OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败';
		ROLLBACK;
		LEAVE LABEL_PROC;
		end if;
		
		CALL prod_update_ccnt_blnc(@res1,'0','3',tsf-tsf1,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',tsf-tsf1,@fund_account,@sub2fuacct,1);
		if (tsf-tsf1 != 0) then
			CALL prod_insert_ccnt_list(@res3,@acno,'1',1,@fund_account,@sub2fuacct,1,'TSF','INC',1,tsf-tsf1,'成交单',@businessid);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' )THEN
			SELECT 'error_no', '-99', '资金操作失败';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;

	end if;*/
	
	end if;

	/*if (@entrust_bs = '2') then
		CALL prod_update_ccnt_blnc(@res1,'0','0',preamt,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',preamt,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,@fund_account,@sub2fuacct,2,'TAA','INC',1,preamt,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,@fund_account,@sub2fuacct,1,'TAA','INC',1,preamt,'成交单',@businessid);
		select Fi_holdamount ,Fd_costbalance into @holdamount,@costbalance from tptstock00 where Fs_marketcode = @marketcode and Fs_secacct = @secacct and Fs_stockcode = @stockcode;
		if ((@holdamount - businessamount) = 0 ) then
			set @cost = 0;
		else
			set @cost = (@costbalance - businessamount * optbusinessprice + cms) / (@holdamount - businessamount);
		end if;
		update tptstock00 set Fi_holdamount = Fi_holdamount - businessamount ,Fi_entrustsellamount = Fi_entrustsellamount - businessamount ,
								Fi_realsellamount = Fi_realsellamount + businessamount,Fd_lastprice = optbusinessprice, 
								Fd_costbalance = Fd_costbalance - businessamount * optbusinessprice + cms, Fd_costprice = @cost,Fd_incomebalance = Fd_marketvalue - Fd_costbalance 
			where Fs_marketcode = @marketcode and Fs_secacct = @secacct and Fs_stockcode = @stockcode;
	elseif (@entrust_bs = '1') then
		CALL prod_update_ccnt_blnc(@res1,'0','3',preamtpre-preamt,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',preamtpre-preamt,@fund_account,@sub2fuacct,1);
		CALL prod_update_ccnt_blnc(@res3,'0','4',preamt,@fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res4,'2','1',preamtpre,@fund_account,@sub2fuacct,2);
		CALL prod_insert_ccnt_list(@res5,@acno,'0',1,@fund_account,@sub2fuacct,2,'TAA','PAY',0,preamt,'成交单',@businessid);
		if (preamtpre-preamt != 0) then
			CALL prod_insert_ccnt_list(@res6,@acno,'1',1,@fund_account,@sub2fuacct,1,'TAA','INC',1,preamtpre-preamt,'成交单',@businessid);
		end if;
		CALL prod_insert_ccnt_list(@res7,@acno,'2',1,@fund_account,@sub2fuacct,2,'TAA','PAY',0,preamtpre,'成交单',@businessid);
		insert into tptstock00(
									Fs_marketcode,
									Fs_secacct,
									Fs_stockcode,
									Fs_stocktype,
									Fs_stockname,
									Fi_currentamount,
									Fi_holdamount,
									Fi_enableamount,
									Fi_realbuyamount,
									Fi_realsellamount,
									Fi_uncomebuyamount,
									Fi_uncomesellamount,
									Fi_entrustsellamount,
									Fd_lastprice,
									Fd_costprice,
									Fd_keepcostprice,
									Fd_incomebalance,
									Fs_handflag,
									Fd_marketvalue,
									Fd_avbuyprice,
									Fd_avincomebalance,
									Fd_costbalance,
									Fs_delistflag,
									Fs_delistdate,
									Fd_parvalue,
									Fd_incomebalancenofare,
									Fi_frozenamount,
									Fd_profitratio,
									Fs_mkdate,
									Fi_lockamount,
									Fi_realbuylockamount,
									Fi_exefroenbleamt,
									Fi_exefrobuyamt)
				select @marketcode,@secacct,@stockcode,Fs_stocktype,Fs_stockname,0,businessamount,0,businessamount,0,0,0,0,optbusinessprice,
						(businessamount*optbusinessprice + cms)/businessamount,optbusinessprice,0,'',businessamount*optbusinessprice,optbusinessprice,0,businessamount*optbusinessprice + cms,Fs_delistflag,Fs_delistdate,
						Fd_parvalue,0,0,0,@init_date,0,businessamount,0,0     
					from tcmstockcode00 
					where Fs_marketcode = @marketcode and  Fs_stockcode = @stockcode  
				ON DUPLICATE KEY UPDATE 
					Fd_avbuyprice = (Fd_avbuyprice*Fi_holdamount + businessamount * optbusinessprice) / (Fi_holdamount + businessamount),
					Fi_holdamount = Fi_holdamount + businessamount , Fi_realbuyamount = Fi_realbuyamount + businessamount,Fi_realbuylockamount = Fi_realbuylockamount + businessamount,
					Fd_lastprice = optbusinessprice, Fd_costbalance = Fd_costbalance + businessamount * optbusinessprice +cms, Fd_costprice = Fd_costbalance/Fi_holdamount,
					Fd_incomebalance = Fd_marketvalue - Fd_costbalance;

	end if;
	IF(@res1 != '0' OR @res2 != '0'  OR @res3 != '0'  OR @res4 != '0' OR @res5 != '0' OR @res6 != '0' OR @res7 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败';
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;*/
	UPDATE Tstatistics set fi_todayfreq = fi_todayfreq + 1,fi_monthfreq = fi_monthfreq + 1,fi_weekfreq = fi_weekfreq + 1,fd_todayamount = fd_todayamount + preamt,
													fd_weekamount = fd_weekamount + preamt,fd_monthamount = fd_monthamount + preamt,fd_totalamount = fd_totalamount +  preamt 
				where fs_seacct = @secacct;
	COMMIT;

	#SELECT 0;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
