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

/* Procedure structure for procedure `prod_fee_updata_blnc` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_fee_updata_blnc` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_fee_updata_blnc`(out res char(1),
	type char(1),
	traceid varchar(32),
	feegoods varchar(2),
	entrust_bs varchar(2),
	entrust_balance DECIMAL(16,4),
	business_balance DECIMAL(16,4),
	fund_account  varchar(32),
	sub2fuacct varchar(32),
	entrust_no varchar(32),
	business_no varchar(32),
	inout cms DECIMAL(16,4),
	inout tsf DECIMAL(16,4),
	inout std DECIMAL(16,4))
LABEL_PROC:
begin
##名称
	#prod_fee_updata_blnc
##作用
	#费用计算
##参数说明
	#res：返回值（'0'：成功, '1'：失败）
	#type：'0':委托冻结，'1':成交或撤单(一次性结算)，'2':只查询费用不记账
	#traceid：赛事id
	#feegoods：收费商品：1.A股，2.债券，3.基金，4.沪B股，5.深B股
	#entrust_bs：买卖方向
	#entrust_balance：委托金额
	#business_balance：成交金额
	#fund_account：资产账号
	#sub2fuacct：2级资产账号
	#entrust_no：委托编号
	#business_no：成交编号
	#cms：佣金(手续费)  (entrust_balance大于等于10000时返回费用，小于时返回最低费用)
	#tsf：过户费
	#std：印花税
	
	DECLARE stamptax DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tradefee DECIMAL(16,4) DEFAULT(0.0);
	DECLARE transactionfee DECIMAL(16,4) DEFAULT(0.0);
	DECLARE stamptaxfloor DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tradefeefloor DECIMAL(16,4) DEFAULT(0.0);
	DECLARE transactionfeefloor DECIMAL(16,4) DEFAULT(0.0);
	DECLARE cms1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE tsf1 DECIMAL(16,4) DEFAULT(0.0);
	DECLARE std1 DECIMAL(16,4) DEFAULT(0.0);
	select Fd_stamptax,Fd_tradefee,Fd_transactionfee,Fd_stamptaxfloor,Fd_tradefeefloor,Fd_transactionfeefloor 
			into stamptax,tradefee,transactionfee,stamptaxfloor,tradefeefloor,transactionfeefloor 
			from ttracefee where Fs_traceid = traceid and Fs_feegoods = feegoods 
			and Fs_buyorsell = entrust_bs and Fs_status = 1;
	set res = '0';		
	SET @res1 = '0';
	SET @res2 = '0';
	SET @res3 = '0';
	SET @res4 = '0';
	SET @res5 = '0';
	SET @res6 = '0';
	SET @acno = '0';
	
	if (type = '0')then#委托冻结
		if (entrust_balance >= 10000) then
			SET cms = entrust_balance * tradefee; #佣金(手续费)
		else
			SET cms = tradefeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET tsf = entrust_balance * transactionfee; #过户费
		else
			SET tsf = transactionfeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET std = entrust_balance * stamptax; #印花税
		else
			SET std = stamptaxfloor;
		end if;
		
		if(entrust_bs = '1')then
			if(cms != 0)then
			CALL prod_update_ccnt_blnc(@res1,'0','2',cms,fund_account,sub2fuacct,2);#2及 冻结
			CALL prod_update_ccnt_blnc(@res2,'2','0',cms,fund_account,sub2fuacct,2);#3及 冻结转入
			CALL prod_update_ccnt_blnc(@res3,'1','1',cms,fund_account,sub2fuacct,1);#3及 可用转出
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,sub2fuacct,2,'CMS','FRZ',2,cms,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,sub2fuacct,1,'CMS','FRZ',0,cms,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,sub2fuacct,2,'CMS','FRZ',1,cms,'委托单',entrust_no);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
			end if;
			
			if(tsf != 0)then
			CALL prod_update_ccnt_blnc(@res1,'0','2',tsf,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','0',tsf,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','1',tsf,fund_account,sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,sub2fuacct,2,'TSF','FRZ',2,tsf,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,sub2fuacct,1,'TSF','FRZ',0,tsf,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,sub2fuacct,2,'TSF','FRZ',1,tsf,'委托单',entrust_no);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
			end if;
			
			if(std != 0)then
			CALL prod_update_ccnt_blnc(@res1,'0','2',std,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','0',std,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','1',std,fund_account,sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,sub2fuacct,2,'STD','FRZ',2,std,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,sub2fuacct,1,'STD','FRZ',0,std,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,sub2fuacct,2,'STD','FRZ',1,std,'委托单',entrust_no);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
			end if;
		end if;
	end if;
	
	if (type = '1')then#成交或撤单(一次性结算)
		if (entrust_balance >= 10000) then
			SET cms = entrust_balance * tradefee; #佣金(手续费)
		else
			SET cms = tradefeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET tsf = entrust_balance * transactionfee; #过户费
		else
			SET tsf = transactionfeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET std = entrust_balance * stamptax; #印花税
		else
			SET std = stamptaxfloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET cms1 = business_balance * tradefee; #佣金(手续费)
		else
			SET cms1 = tradefeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET tsf1 = business_balance * transactionfee; #过户费
		else
			SET tsf1 = transactionfeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET std1 = business_balance * stamptax; #印花税
		else
			SET std1 = stamptaxfloor;
		end if;
		
		if(entrust_bs = '1')then
			if(cms != 0)then
			CALL prod_update_ccnt_blnc(@res1,'0','3',cms,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','1',cms,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','0',cms,fund_account,sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,sub2fuacct,2,'CMS','UFZ',2,cms,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,sub2fuacct,1,'CMS','UFZ',1,cms,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,sub2fuacct,2,'CMS','UFZ',0,cms,'委托单',entrust_no);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
			end if;
			
			if(tsf != 0)then
			CALL prod_update_ccnt_blnc(@res1,'0','3',tsf,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','1',tsf,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','0',tsf,fund_account,sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,sub2fuacct,2,'TSF','UFZ',2,tsf,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,sub2fuacct,1,'TSF','UFZ',1,tsf,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,sub2fuacct,2,'TSF','UFZ',0,tsf,'委托单',entrust_no);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
			end if;
			
			if(std != 0)then
			CALL prod_update_ccnt_blnc(@res1,'0','3',std,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res2,'2','1',std,fund_account,sub2fuacct,2);
			CALL prod_update_ccnt_blnc(@res3,'1','0',std,fund_account,sub2fuacct,1);
			CALL prod_insert_ccnt_list(@res4,@acno,'0',1,fund_account,sub2fuacct,2,'STD','UFZ',2,std,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res5,@acno,'1',1,fund_account,sub2fuacct,1,'STD','UFZ',1,std,'委托单',entrust_no);
			CALL prod_insert_ccnt_list(@res6,@acno,'2',1,fund_account,sub2fuacct,2,'STD','UFZ',0,std,'委托单',entrust_no);
			IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
			end if;
		end if;
		
		if (business_balance != 0) then
		
		if(cms1 != 0)then
		CALL prod_update_ccnt_blnc(@res1,'0','1',cms1,fund_account,sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',cms1,fund_account,sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,sub2fuacct,2,'CMS','PAY',0,cms1,'成交单',business_no);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,fund_account,sub2fuacct,1,'CMS','PAY',0,cms1,'成交单',business_no);
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
		end if;
		
		if(tsf1 != 0)then
		CALL prod_update_ccnt_blnc(@res1,'0','1',tsf1,fund_account,sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',tsf1,fund_account,sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,sub2fuacct,2,'TSF','PAY',0,tsf1,'成交单',business_no);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,fund_account,sub2fuacct,1,'TSF','PAY',0,tsf1,'成交单',business_no);
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
		end if;
		
		if(std1 != 0)then
		CALL prod_update_ccnt_blnc(@res1,'0','1',std1,fund_account,sub2fuacct,2);
		CALL prod_update_ccnt_blnc(@res2,'1','1',std1,fund_account,sub2fuacct,1);
		CALL prod_insert_ccnt_list(@res3,@acno,'0',1,fund_account,sub2fuacct,2,'STD','PAY',0,std1,'成交单',business_no);
		CALL prod_insert_ccnt_list(@res4,@acno,'1',1,fund_account,sub2fuacct,1,'STD','PAY',0,std1,'成交单',business_no);
		IF(@res1 != '0' OR @res2 != '0' OR @res3 != '0' OR @res4 != '0' OR @res5 != '0' OR @res6 != '0')THEN
				SET res = '1';
				LEAVE LABEL_PROC;
			end if;
		end if;

		end if;

		UPDATE ttsstkbusisec00 set Fd_occurmoney = Fd_occurmoney + cms1 + tsf1 + std1 ,Fd_exchangefare1 = std1 ,Fd_exchangefare2 = tsf1 ,Fd_standardfare0 = cms1 
				where  Fi_businessecno = business_no;
		
	end if;
	
	if(type = '2')then
		if (entrust_balance >= 10000) then
			SET cms = business_balance * tradefee; #佣金(手续费)
		else
			SET cms = tradefeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET tsf = business_balance * transactionfee; #过户费
		else
			SET tsf = transactionfeefloor;
		end if;
		
		if (entrust_balance >= 10000) then
			SET std = business_balance * stamptax; #印花税
		else
			SET std = stamptaxfloor;
		end if;
	end if;
	
	#commit;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
