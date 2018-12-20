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

/* Procedure structure for procedure `prod_szqq_333017_auto` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_szqq_333017_auto` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_szqq_333017_auto`(op_branch_no	varchar(5),
op_entrust_way	char(1),
op_station	varchar(255),
branch_no	varchar(5),
client_id	varchar(18),
fund_account	varchar(18),
password	varchar(15),
password_type	char(1),
user_token	varchar(512),
batch_flag	char(1),
exchange_type	varchar(4),
entrust_no	varchar(10))
LABEL_PROC:
BEGIN
	DECLARE o_init_date char(8) DEFAULT('');
	DECLARE o_entrust_no char(10) DEFAULT('');
	DECLARE o_entrust_no_old char(8) DEFAULT('');
	DECLARE o_report_no_old char(8) DEFAULT('');
	DECLARE o_exchange_type char(4) DEFAULT('');
	DECLARE o_option_account char(13) DEFAULT('');
	DECLARE o_stock_code char(6) DEFAULT('');
	DECLARE o_option_code char(8) DEFAULT('');
	DECLARE o_entrust_status_old char(1) DEFAULT('');
	DECLARE o_entrust_balance DECIMAL(16,4) DEFAULT(0.0);
  DECLARE o_entrust_balance1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE o_entrust_balance2 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE o_entrust_time char(8) DEFAULT('');
	DECLARE cms DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tsf DECIMAL(16,4) DEFAULT(0.0);
	DECLARE std DECIMAL(16,4) DEFAULT(0.0);
	DECLARE cms1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tsf1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE std1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE preamtpre DECIMAL(16,4) DEFAULT(0.0);
  DECLARE count DECIMAL(16,4) DEFAULT(0.0);
#判断是否正在成交
	if (exchange_type = '') THEN
		SELECT Fs_entruststatus INTO @lockentruststatus
				FROM ttsstkentrustsec00 WHERE Fi_entrustsecno = entrust_no FOR UPDATE;
	ELSE
		SELECT Fs_entruststatus INTO @lockentruststatus
				FROM ttsstkentrustsec00 WHERE Fi_entrustsecno = entrust_no and Fs_marketcode = exchange_type-1 FOR UPDATE;
	end if;
	IF(@lockentruststatus != '2')THEN
		IF(@lockentruststatus != '7')THEN
			SELECT 'error_no', '-99' AS flag, '当前状态不允许撤单'  as info;
			ROLLBACK;
			LEAVE LABEL_PROC;
		END IF;
	END IF;

	/*SELECT fi_status INTO @tmsh_status FROM tmkstatus WHERE fs_marketcode = '0';
  SELECT fi_status INTO @tmsz_status FROM tmkstatus WHERE fs_marketcode = '1';
  if(@tmsh_status = '5' or @tmsh_status = '6' or @tmsz_status = '5' or @tmsz_status = '6')THEN
  	SELECT 'error_no', '-99' AS flag, '已闭市，不允许撤单'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;*/

	SELECT t1.Fi_requestno, t1.Fs_secacct,t1.Fs_marketcode,t1.Fs_stockcode,  t1.Fs_orderid,t1.Fs_origorderid,t2.Fs_kindcode   
		INTO o_report_no_old,@secacct,@marketcode, @stockcode,  @orderid,@origorderid ,@kindcode 
		FROM trqstkentrust00 t1, tcmstockcode00 t2 
		WHERE t1.Fi_entrustno = entrust_no AND t1.Fs_marketcode = t2.Fs_marketcode AND t1.Fs_stockcode = t2.Fs_stockcode;
	IF(o_report_no_old = '')THEN
		SELECT 'error_no', '-99' AS flag, '委托报单不存在'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	CALL prod_mk_get_time(@marketcode, @mytime);
  SET o_init_date = LEFT(REPLACE(@mytime,'-',''),8);

	SET o_entrust_time = RIGHT(@entrust_time,8);
	SELECT count(1) into @cont from tcufuacct a,trace b where a.fs_fuacct = fund_account and a.Fi_usage = 1 and a.Fs_usagecode = b.Fs_id and b.Fs_status = 1 
															and date_format(b.Fs_tradetime,'%H:%i:%s') > '15:00:00';#新加赛事撤单时间判断
	if (@cont != 0 and o_entrust_time > '14:27:00'  )THEN
		SELECT 'error_no', '-99' AS flag, '超过14:27:00不允许撤单'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;

	CALL prod_get_ct_time(1,@ct_time); 

  INSERT INTO trqstkunentrust00(Ft_unentrusttime,Fs_opbranchno, Fs_opentrustway, Fs_opstation, Fs_branchno, Fs_clientid, fs_fuacct, 
								Fs_secacct,Fs_marketcode,Fi_Orgentrustno,Fi_Orgreportno,Ft_requesttime)
								VALUES(@ct_time,op_branch_no, op_entrust_way, op_station, branch_no, client_id, fund_account, 
								@secacct,@marketcode, entrust_no, o_report_no_old,@mytime);

	IF(ROW_COUNT() <= 0)THEN
		SELECT 'error_no', '-99' AS flag, '新增委托撤单失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;
	SET o_entrust_no = LAST_INSERT_ID();
	SET @businessamount = 0;
	SELECT a.Fi_entrustsecno,  a.Fs_entruststatus, a.Fi_entrustamount, a.Fd_optentrustprice,
				 a.Fs_entrustbs,  a.Fi_businessamount ,Fd_businessprice 
		INTO @entrustsecno,  o_entrust_status_old, @entrustamount, @optentrustprice,
				 @entrust_bs, @businessamount ,@businessprice 
		FROM ttsstkentrustsec00 a  WHERE a.Fi_requestno = o_report_no_old ;

	IF(o_entrust_status_old = '')THEN
		SELECT 'error_no', '-99' AS flag, '委托单不存在'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;
	if (@businessamount != 0) then
		SELECT b.Fi_businessecno into @businessid 
			from ttsstkentrustsec00 a, ttsstkbusisec00 b WHERE a.Fi_requestno = o_report_no_old and a.Fi_entrustsecno = b.Fi_entrustsecno;
	end if;
	#获取成交数据
	#SELECT Fi_businessamount INTO @businessamount FROM ttsstkbusisec00 WHERE Fi_entrustsecno = @entrustsecno;

	IF(o_entrust_status_old = '2')THEN
		UPDATE ttsstkentrustsec00 SET Fs_entruststatus = 6, Ft_Entrustsecupdtime = @mytime, Fi_withdrawamount = @entrustamount - @businessamount
			WHERE Fi_requestno = o_report_no_old;
	ELSEIF(o_entrust_status_old = '7')THEN
		UPDATE ttsstkentrustsec00 SET Fs_entruststatus = 5, Ft_Entrustsecupdtime = @mytime, Fi_withdrawamount = @entrustamount - @businessamount
			WHERE Fi_requestno = o_report_no_old;
	ELSE	
		SELECT 'error_no', '-99' AS flag, '委托单状态不允许撤单'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;

	IF(ROW_COUNT() <= 0)THEN
		SELECT 'error_no', '-99' AS flag, '更新委托单状态失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	END IF;
	
	SET o_entrust_no_old = entrust_no;
	SET o_exchange_type = exchange_type;

	#计算费用
	SET o_entrust_balance = @optentrustprice * (@entrustamount - @businessamount);
	SET o_entrust_balance1 = @optentrustprice * @entrustamount ;
	SET o_entrust_balance2 = @businessprice * @businessamount ;
	/*SET std = o_entrust_balance1 * 0.001; #印花税
	if (o_entrust_balance1 >= 10000) then
		SET cms = o_entrust_balance1 * 0.00025; #佣金
	else
		SET cms = 2.5;
	end if;
	
	SET tsf = o_entrust_balance1 *0.00002; #过户费

	SET o_entrust_balance2 = @businessprice * @businessamount ;
	SET std1 = o_entrust_balance2 * 0.001; #印花税
	if (o_entrust_balance2 >= 10000) then
		SET cms1 = o_entrust_balance2 * 0.00025; #佣金
	else
		SET cms1 = 2.5;
	end if;
	
	SET tsf1 = o_entrust_balance2 *0.00002; #过户费*/

	
	#资金变动
	SET @res1 = '0';
	SET @res2 = '0';
	SET @res3 = '0';
	SET @res4 = '0';
	SET @res5 = '0';
	SET @res6 = '0';
	#select fi_sub2fuacct into @sub2fuacct from tcusub2fuacct where fs_fuacct = fund_account and Fs_currency = 'CNY';
	select a.fi_sub2fuacct into @sub2fuacct from tcusub2fuacct a,trefsecaccttype b where a.fs_fuacct = fund_account and a.Fs_currency = b.Fs_currency and 
					b.Fs_marketcode = @marketcode and b.Fs_kindcode = @kindcode;
	SELECT Fs_usagecode into @usagecode from tcufuacct where fs_fuacct = fund_account and Fi_usage = 1;
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
	/*ELSE
		SELECT 'error_no', '-99' AS flag, 'Fs_kindcode参数不对'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;*/
	end if;
	call prod_fee_updata_blnc(@res1,'1',@usagecode,@feegoods,@entrust_bs,o_entrust_balance1,o_entrust_balance2,fund_account,@sub2fuacct,o_entrust_no,@businessid,cms,tsf,std);
	IF(@res1 != '0' )THEN
		SELECT 'error_no', '-99' AS flag, '资金操作失败'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;
	#select fi_sub3fuacct into @sub3fuacct from tcusub3fuacct where fs_fuacct = fund_account and fi_sub2fuacct = @sub2fuacct and Fi_sub3fuaccttype = 2;
	#select fi_sub3fuacct into @sub3fuacct1 from tcusub3fuacct where fs_fuacct = fund_account and fi_sub2fuacct = @sub2fuacct and Fi_sub3fuaccttype = 1;
	#if (@businessamount = 0) then
	/*if(@entrust_bs = '1')then
	CALL prod_update_ccnt_blnc(@res1,'0','3',cms,fund_account,@sub2fuacct,2);
	CALL prod_update_ccnt_blnc(@res2,'2','1',cms,fund_account,@sub2fuacct,2);
	CALL prod_update_ccnt_blnc(@res3,'1','0',cms,fund_account,@sub2fuacct,1);
	CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'CMS','UFZ',2,cms,'委托单',o_entrust_no);
	CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'CMS','UFZ',1,cms,'委托单',o_entrust_no);
	CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'CMS','UFZ',0,cms,'委托单',o_entrust_no);
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败131';
		ROLLBACK;
	LEAVE LABEL_PROC;
	end if;
	end if;*/

	/*IF(@entrust_bs = '2')THEN
		CALL prod_update_ccnt_blnc(@res1,'0','3',std,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','1',std,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res3,'1','0',std,fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'STD','UFZ',2,std,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'STD','UFZ',1,std,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'STD','UFZ',0,std,'委托单',o_entrust_no);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		SELECT 'error_no', '-99', '资金操作失败187';
		ROLLBACK;
	LEAVE LABEL_PROC;
	end if;*/
	
	/*if (@marketcode = '0' and @entrust_bs = '1') then
		CALL prod_update_ccnt_blnc(@res1,'0','3',tsf,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','1',tsf,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res3,'1','0',tsf,fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'TSF','UFZ',2,tsf,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'TSF','UFZ',1,tsf,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'TSF','UFZ',0,tsf,'委托单',o_entrust_no);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
		SELECT 'error_no', '-99', '资金操作失败201';
		ROLLBACK;
	LEAVE LABEL_PROC;
	end if;

	if (@businessamount != 0) then
	CALL prod_update_ccnt_blnc(@res1,'0','1',cms1,fund_account,@sub2fuacct,2);
	CALL prod_update_ccnt_blnc(@res2,'1','1',cms1,fund_account,@sub2fuacct,1);
	CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,@sub2fuacct,2,'CMS','PAY',0,cms1,'成交单',@businessid);
	CALL prod_insert_ccnt_list(@res4,@acno,'1',1,fund_account,@sub2fuacct,1,'CMS','PAY',0,cms1,'成交单',@businessid);
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' )THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
		SELECT 'error_no', '-99', '资金操作失败201';
		ROLLBACK;
	LEAVE LABEL_PROC;
	end if;

	IF(@entrust_bs = '2')THEN
		CALL prod_update_ccnt_blnc(@res1,'0','1',std1,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',std1,fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,@sub2fuacct,2,'STD','PAY',0,std1,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,fund_account,@sub2fuacct,1,'STD','PAY',0,std1,'成交单',@businessid);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' )THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
		SELECT 'error_no', '-99', '资金操作失败201';
		ROLLBACK;
	LEAVE LABEL_PROC;
	end if;

	if (@marketcode = '0') then
		CALL prod_update_ccnt_blnc(@res1,'0','1',tsf1,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',tsf1,fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,@sub2fuacct,2,'TSF','PAY',0,tsf1,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,fund_account,@sub2fuacct,1,'TSF','PAY',0,tsf1,'成交单',@businessid);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' )THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, tsf;
		SELECT 'error_no', '-99', '资金操作失败201';
		ROLLBACK;
	LEAVE LABEL_PROC;
	end if;

	end if;*/



	#ELSE
		/*SET preamtpre = @businessprice * @businessamount;
		
		if (preamtpre >= 10000) then
			SET cms = preamtpre * 0.00025; #佣金
		else
			SET cms = 2.5;
		end if;

		CALL prod_update_ccnt_blnc(@res1,'0','4',cms,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'2','1',cms,fund_account,@sub2fuacct,2);
		#CALL prod_update_ccnt_blnc(@res3,'1','1',cms,@fund_account,@sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'CMS','PAY',0,cms,'成交单',@businessid);
		#CALL prod_insert_ccnt_list(@res5,@acno,'1',1,@fund_account,@sub2fuacct,1,'CMS','FRZ',0,cms,'成交单',@businessid);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'CMS','PAY',0,cms,'成交单',@businessid);
		IF(@res1 != '0' OR @res2 != '0' OR @res4 != '0'  OR @res6 != '0')THEN
			SELECT 'error_no', '-99', '资金操作失败151';
			ROLLBACK;
			LEAVE LABEL_PROC;
		end if;

		SET count = @optentrustprice * @entrustamount;
		if (count >= 10000) then
			SET cms1 = count * 0.00025; #佣金
		else
			SET cms1 = 2.5;
		end if;
		if (cms1 > cms) then
			CALL prod_update_ccnt_blnc(@res1,'0','3',cms1 - cms,fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','1',cms1 - cms,fund_account,@sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','0',cms1 - cms,fund_account,@sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'CMS','UFZ',2,cms1 - cms,'委托单',o_entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'CMS','UFZ',1,cms1 - cms,'委托单',o_entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'CMS','UFZ',0,cms1 - cms,'委托单',o_entrust_no);
		end if;
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
			SELECT 'error_no', '-99', '资金操作失败171';
			ROLLBACK;
		LEAVE LABEL_PROC;
		end if;*/

	#end if;
	
	

	if (@entrust_bs = '2') then
		/*CALL prod_update_ccnt_blnc(@res1,'0','3',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',o_entrust_balance,fund_account,@sub2fuacct,1);
		CALL prod_update_ccnt_blnc(@res3,'2','1',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'TAA','UFZ',2,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'TAA','UFZ',1,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'TAA','UFZ',0,o_entrust_balance,'委托单',o_entrust_no);*/
		update tptstock00 set Fi_enableamount = Fi_enableamount + (@entrustamount - @businessamount) ,Fi_entrustsellamount = Fi_entrustsellamount - (@entrustamount - @businessamount)    
				where Fs_marketcode = @marketcode and Fs_secacct = @secacct and Fs_stockcode = @stockcode;
	elseif (@entrust_bs = '1') then
		CALL prod_update_ccnt_blnc(@res1,'0','3',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','0',o_entrust_balance,fund_account,@sub2fuacct,1);
		CALL prod_update_ccnt_blnc(@res3,'2','1',o_entrust_balance,fund_account,@sub2fuacct,2);
		CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,@sub2fuacct,2,'TAA','UFZ',2,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,@sub2fuacct,1,'TAA','UFZ',1,o_entrust_balance,'委托单',o_entrust_no);
		CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,@sub2fuacct,2,'TAA','UFZ',0,o_entrust_balance,'委托单',o_entrust_no);
	end if;
	IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
		#select @res1,@res2,@res3,@res4,@res5,@res6, o_entrust_no, fund_account, o_entrust_balance;
		SELECT 'error_no', '-99' AS flag, '资金操作失败224'  as info;
		ROLLBACK;
		LEAVE LABEL_PROC;
	end if;

	COMMIT;

	SELECT o_init_date, o_entrust_no AS info, o_entrust_no_old, 
		o_report_no_old,'',o_exchange_type, @secacct,@stockcode, 'CNY', o_entrust_status_old,@orderid,@origorderid ,0 AS flag;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
