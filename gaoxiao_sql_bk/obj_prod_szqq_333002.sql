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

/* Procedure structure for procedure `prod_szqq_333002` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_szqq_333002`(op_branch_no	varchar(5),
op_entrust_way	char(1),
op_station	varchar(255),
branch_no	varchar(5),
client_id	varchar(18),
fund_account	varchar(18),
password	varchar(15),
password_type	char(1),
user_token	varchar(512),
exchange_type	varchar(4),
stock_account	varchar(18),
stock_code	varchar(6),
entrust_amount	varchar(10),
entrust_price	varchar(20),
entrust_bs	char(1),
entrust_prop	varchar(3),
batch_no	varchar(8),
meeting_seq	varchar(10),orderresean   varchar(10000),enforcesell   varchar(1),usagecode varchar(32))
LABEL_PROC:
BEGIN
	DECLARE o_init_date char(8) DEFAULT('');
	DECLARE o_entrust_no char(10) DEFAULT('');
	DECLARE o_report_no char(8) DEFAULT('');
	DECLARE o_batch_no char(8) DEFAULT('');
	DECLARE o_entrust_time char(8) DEFAULT('');
	DECLARE o_entrust_balance DECIMAL(16,4) DEFAULT(0.0);
	DECLARE secacct varchar(18) DEFAULT('');
	DECLARE marketcode varchar(32) DEFAULT('');
	DECLARE stocktype varchar(4) DEFAULT('');
	DECLARE requesttime datetime;
	DECLARE cms DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tsf DECIMAL(16,4) DEFAULT(0.0);
	DECLARE std DECIMAL(16,4) DEFAULT(0.0);
	
  if (stock_account != '') then
		SELECT a.Fs_secacct, b.Fs_marketcode 
			INTO secacct, marketcode  
			FROM tcusecacct a,trefsecaccttype b 
			WHERE a.Fs_clientid = client_id AND a.fs_fuacct = fund_account AND a.Fs_secacct = stock_account 
						and a.Fi_secaccttype = b.Fi_secaccttype;
	ELSE
		if (exchange_type = '1' OR exchange_type = '3' OR exchange_type = '5' OR exchange_type = '7') then
			SELECT a.Fs_secacct, Fs_marketcode 
				INTO secacct, marketcode  
				FROM tcusecacct a,trefsecaccttype b 
				WHERE a.Fs_clientid = client_id AND a.fs_fuacct = fund_account AND b.Fs_marketcode = '0' 
							and a.Fi_secaccttype = b.Fi_secaccttype and a.Fi_usage = 1 and a.Fs_usagecode = usagecode and b.Fs_kindcode = exchange_type;
		ELSEIF(exchange_type = '2' OR exchange_type = '4' OR exchange_type = '6' OR exchange_type = '8') then
			SELECT a.Fs_secacct, Fs_marketcode 
				INTO secacct, marketcode  
				FROM tcusecacct a,trefsecaccttype b 
				WHERE a.Fs_clientid = client_id AND a.fs_fuacct = fund_account AND Fs_marketcode = '1' 
							and a.Fi_secaccttype = b.Fi_secaccttype and a.Fi_usage = 1 and a.Fs_usagecode = usagecode and b.Fs_kindcode = exchange_type;
		end if;
	end if;
	IF(secacct = '')THEN
			SELECT 'error_no', '-99' AS flag, '证券账户不存在' as info;
			ROLLBACK;
			LEAVE LABEL_PROC;
		END IF;

#判断是否开市
	SELECT fi_status INTO @mkstatus FROM tmkstatus WHERE fs_marketcode = marketcode;
	IF(@mkstatus != 0)THEN
		SELECT 'error_no', '-99' AS flag, '当前市场状态不允许交易'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	CALL prod_mk_get_time(marketcode, @entrust_time);
	SET o_init_date = LEFT(REPLACE(@entrust_time,'-',''),8);
	SET o_entrust_time = RIGHT(@entrust_time,8);
	#柜台时间 1表示股票
	CALL prod_get_ct_time(1,@ct_time); 
	
	SELECT Fs_stocktype ,Fd_upprice,Fd_downprice ,Fs_stkcodestatus 
		INTO stocktype,@upprice,@downprice ,@stkcodestatus
		FROM tcmstockcode00 
		WHERE Fs_marketcode = marketcode and Fs_stockcode = stock_code;
	IF(stocktype = '')THEN
		SELECT 'error_no', '-99' AS flag, '股票不存在'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;
	IF(@stkcodestatus = 1)THEN #新加停牌判断
		SELECT 'error_no', '-99' AS flag, '股票已停牌'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	IF(entrust_price > @upprice OR entrust_price < @downprice) THEN
		SELECT 'error_no', '-99' AS flag, '委托价格必须在涨停价和跌停价之间'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	SELECT MOD(entrust_amount, 100) into @yushu;
	
	if (entrust_bs = '1') then
	if(@yushu != 0 or entrust_amount = 0)THEN
		SELECT 'error_no', '-99' AS flag, '股票委托数量必须为100的倍数'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;
	end if;

	if (entrust_bs = '2') then
	 set @enableamount = 0;
		SELECT Fi_enableamount into @enableamount 
			from tptstock00 
			where Fs_marketcode = marketcode and Fs_secacct = secacct and Fs_stockcode = stock_code;
		if (@enableamount < entrust_amount) THEN
			SELECT 'error_no', '-99' AS flag, '股票持仓当日可卖数量不足'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
		end if;

		if (entrust_amount%100 !=0 and entrust_amount%100 != @enableamount%100) THEN
			SELECT 'error_no', '-99' AS flag, '委卖数量零股不允许拆分'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
		end if;
	end if;

	if(entrust_amount <= 0)THEN
		SELECT 'error_no', '-99' AS flag, '股票委托数量不能为负数'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	SELECT count(1) into @cont from tcufuacct a,tgoodsmanagement b where a.fs_fuacct = fund_account and a.Fi_usage = 1 and a.Fs_usagecode = b.Fs_traceid and b.Fs_marketcode = marketcode
												and b.Fs_stockcode = stock_code;#新加停牌判断
	if(@cont != 0)THEN
		SELECT 'error_no', '-99' AS flag, '股票在竞赛中已停牌'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;

	SELECT count(1) into @cont from tcufuacct a,trace b where a.fs_fuacct = fund_account and a.Fi_usage = 1 and a.Fs_usagecode = b.Fs_id and b.Fs_status = 1 
															and b.Fs_isnoontransaction = '0';#新加中午交易判断
	if (@cont != 0 and o_entrust_time > '11:30:00' and o_entrust_time < '13:00:00' )THEN
		SELECT 'error_no', '-99' AS flag, '中午不允许交易'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;

	SELECT count(1) into @cont from tmkstatus where Fs_marketcode = marketcode and Fs_isvacation = 1;
	SELECT count(1) into @ct from tcufuacct a,trace b where a.fs_fuacct = fund_account and a.Fi_usage = 1 and a.Fs_usagecode = b.Fs_id and b.Fs_status = 1 
															and b.Fs_isvacationtransation = '0';#新加节假日交易判断
	if (@cont != 0 and @ct !=0)THEN
		SELECT 'error_no', '-99' AS flag, '节假日不允许交易'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;

#3.1.1、委托申请单
	INSERT INTO trqstkentrust00(Ft_entrusttime, Fs_opbranchno, Fs_opentrustway, Fs_opstation, Fs_branchno, Fs_clientid, fs_fuacct, Fs_secacct, 
								Fs_marketcode, Fs_stockcode, Fs_stocktype, Fi_entrustamount, Fd_optentrustprice, Fs_entrustbs,Fs_entrustprop,
								Fs_registersureflag,Fs_meetingseq,Ft_requesttime)
								VALUES(@ct_time, op_branch_no, op_entrust_way, op_station, branch_no, client_id, fund_account, secacct, 
								marketcode, stock_code, stocktype, entrust_amount, entrust_price,entrust_bs, entrust_prop,
								'',meeting_seq,@entrust_time);
	IF(ROW_COUNT() <= 0)THEN
		SELECT 'error_no', '-99' AS flag, '新增报单失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

#取委托编号
  SET o_entrust_no = LAST_INSERT_ID();
	
	if(exchange_type != '7' AND exchange_type != '8' and exchange_type != '3' and exchange_type != '4')then
	SELECT count(1) into @cont from tcufuacct a,ttarceT0 b where a.fs_fuacct = fund_account and a.Fi_usage = 1 and a.Fs_usagecode = b.Fs_traceid and b.Fs_marketcode = marketcode
												and b.Fs_stockcode = stock_code;#新加t+0判断
	ELSE
		set @cont = 1;
	end if;
#3.1.1、委托单据
	INSERT INTO ttsstkentrustsec00(Fi_entrustsecno,Fs_marketcode,Fs_mkdate,Fs_secacct,Fs_stockcode,Fs_stocktype,Fs_entrustbs,
									Fd_optentrustprice,	Fi_entrustamount,Fd_businessprice,Fi_businessamount,Fs_entruststatus,Fs_entrustprop,
									Fi_withdrawamount,Fs_meetingseq,Ft_Entrustseccrttime,Ft_Entrustsecupdtime,Fs_OrderResean,Fs_EnforceSell) 
								VALUES(o_entrust_no,marketcode, o_init_date, secacct, stock_code, stocktype, entrust_bs,  
									entrust_price,entrust_amount,0.0,0,'2',entrust_prop,
									0,meeting_seq,@entrust_time, @entrust_time,orderresean,enforcesell);
	if (@cont != 0) THEN #新加t+0判断
		UPDATE ttsstkentrustsec00 set Fs_TaddN = 0 where Fi_entrustsecno = o_entrust_no;
	end if;
	IF(ROW_COUNT() <= 0)THEN
		SELECT 'error_no', '-99' AS flag, '新增委托单失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;
#取申请编号
	SET o_report_no = LAST_INSERT_ID();

	UPDATE trqstkentrust00 SET Fi_requestno = o_report_no, Ft_requesttime = @entrust_time WHERE Fi_entrustno = o_entrust_no;
	IF(ROW_COUNT() <= 0)THEN
		SELECT 'error_no', '-99' AS flag, '更新报单申请编号失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	SET o_batch_no = batch_no;
	SET o_entrust_balance = entrust_price * entrust_amount;

  #计算费用
	/*SET std = o_entrust_balance * 0.001; #印花税
	if (o_entrust_balance >= 10000) then
		SET cms = o_entrust_balance * 0.00025; #佣金
	else
		SET cms = 2.5;
	end if;
	
	SET tsf = o_entrust_balance *0.00002; #过户费*/

  #冻结资金
	SET @res1 = '0';
	SET @res2 = '0';
	SET @res3 = '0';
	SET @res4 = '0';
	SET @res5 = '0';
	SET @res6 = '0';
	SET @acno = '0';
	select a.fi_sub2fuacct into @sub2fuacct from tcusub2fuacct a,trefsecaccttype b where a.fs_fuacct = fund_account and a.Fs_currency = b.Fs_currency and 
					b.Fs_marketcode = marketcode and b.Fs_kindcode = exchange_type;
	#SELECT Fs_usagecode into @usagecode from tcufuacct where fs_fuacct = fund_account and Fi_usage = 1;

	if (exchange_type = '1' or exchange_type = '2')THEN
		set @feegoods = '1';
	ELSEIF(exchange_type = '3')THEN
		set @feegoods = '4';
	ELSEIF(exchange_type = '4')THEN
		set @feegoods = '5';
	ELSEIF(exchange_type = '5' or exchange_type = '6')THEN
		set @feegoods = '2';
	ELSEIF(exchange_type = '7' or exchange_type = '8')THEN
		set @feegoods = '3';
	ELSE
		SELECT 'error_no', '-99' AS flag, 'exchange_type参数不对'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;
	call prod_fee_updata_blnc(@res1,'0',usagecode,@feegoods,entrust_bs,o_entrust_balance,0,fund_account,@sub2fuacct,o_entrust_no,'',cms,tsf,std);
	IF(@res1 != '0' )THEN
		SELECT 'error_no', '-99' AS flag, '资金操作失败' as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;
	#select fi_sub3fuacct into @sub3fuacct from tcusub3fuacct where fs_fuacct = fund_account and fi_sub2fuacct = @sub2fuacct and Fi_sub3fuaccttype = 2;
	#select fi_sub3fuacct into @sub3fuacct1 from tcusub3fuacct where fs_fuacct = fund_account and fi_sub2fuacct = @sub2fuacct and Fi_sub3fuaccttype = 1;
	/*if(entrust_bs = '1')then
	CALL prod_update_ccnt_blnc(@res1,'0','2',cms,fund_account,@sub2fuacct,2);#2及 冻结
	CALL prod_update_ccnt_blnc(@res2,'2','0',cms,fund_account,@sub2fuacct,2);#3及 冻结转入
	CALL prod_update_ccnt_blnc(@res3,'1','1',cms,fund_account,@sub2fuacct,1);#3及 可用转出
	CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'CMS','FRZ',2,cms,'委托单',o_entrust_no);
	CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'CMS','FRZ',0,cms,'委托单',o_entrust_no);
	CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'CMS','FRZ',1,cms,'委托单',o_entrust_no);
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败';
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;
	end if;*/
	
	/*IF(entrust_bs = '2')THEN #卖方特有的费用
		CALL prod_update_ccnt_blnc(@res1,'0','2',std,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','0',std,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res3,'1','1',std,fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'STD','FRZ',2,std,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'STD','FRZ',0,std,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'STD','FRZ',1,std,'委托单',o_entrust_no);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败';
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;*/
	
	/*if (marketcode = '0' and entrust_bs = '1') then #上海市场特有费用
		CALL prod_update_ccnt_blnc(@res1,'0','2',tsf,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','0',tsf,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res3,'1','1',tsf,fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'TSF','FRZ',2,tsf,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'TSF','FRZ',0,tsf,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'TSF','FRZ',1,tsf,'委托单',o_entrust_no);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败';
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;*/

	if (entrust_bs = '2') then
		/*CALL prod_update_ccnt_blnc(@res1,'0','2',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',o_entrust_balance,fund_account,@sub2fuacct,1);
		CALL prod_update_ccnt_blnc(@res3,'2','0',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,@sub2fuacct,2,'TAA','FRZ',2,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'TAA','FRZ',0,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'2',1,fund_account,@sub2fuacct,2,'TAA','FRZ',1,o_entrust_balance,'委托单',o_entrust_no);*/
		

		update tptstock00 set Fi_enableamount = Fi_enableamount - entrust_amount ,Fi_entrustsellamount = Fi_entrustsellamount + entrust_amount 
				where Fs_marketcode = marketcode and Fs_secacct = secacct and Fs_stockcode = stock_code;
	elseif (entrust_bs = '1') then
		CALL prod_update_ccnt_blnc(@res1,'0','2',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',o_entrust_balance,fund_account,@sub2fuacct,1);
		CALL prod_update_ccnt_blnc(@res3,'2','0',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'TAA','FRZ',2,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'TAA','FRZ',0,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'TAA','FRZ',1,o_entrust_balance,'委托单',o_entrust_no);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99' AS flag, '资金操作失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;

	COMMIT;

	SELECT o_init_date, o_entrust_no AS info,o_batch_no, o_report_no,'' , o_entrust_time , 0 AS flag;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
