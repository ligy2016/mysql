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

/* Procedure structure for procedure `comscore-stock-risk` */

/*!50003 DROP PROCEDURE IF EXISTS  `comscore-stock-risk` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `comscore-stock-risk`()
LABEL_PROC:
BEGIN
##名称
	#综合评分-股票-风控能力
	#comscore-stock-risk
##作用
	#综合评分-股票-风控能力
	#每天日结执行一次，更新当日风控分数数据。
	#不允许重复执行
##参数说明

	#变量定义
	DECLARE marketcode VARCHAR(32) DEFAULT('');
	DECLARE secacct VARCHAR(18) DEFAULT('');
	DECLARE stockcode CHAR(6) DEFAULT('');
	DECLARE stocktype VARCHAR(4) DEFAULT('');
	DECLARE currentamount INT DEFAULT(0);
	DECLARE holdamount INT DEFAULT(0);
	DECLARE avbuyprice DECIMAL(15,4) DEFAULT(0.0);
	DECLARE clientid VARCHAR(18) DEFAULT('');
	DECLARE usagecode VARCHAR(32) DEFAULT('');
	DECLARE buyprice DECIMAL(15,4) DEFAULT(0.0);
	DECLARE sellprice DECIMAL(15,4) DEFAULT(0.0);
	DECLARE days INT DEFAULT(0);
	DECLARE ratio DECIMAL(14,2) DEFAULT(0.0);
	DECLARE dbratio DECIMAL(14,2) DEFAULT(0.0);
	DECLARE score INT DEFAULT(0);
	DECLARE finish CHAR(1) DEFAULT('0');
	DECLARE cttime CHAR(19) DEFAULT('');
	DECLARE ctdate CHAR(8) DEFAULT('');
	DECLARE precttime CHAR(19) DEFAULT('');
	DECLARE prectdate CHAR(8) DEFAULT('');
	DECLARE closeprice DECIMAL(15,4) DEFAULT(0.0);
	DECLARE count INT DEFAULT(0);

	#异常处理变量定义
	DECLARE _notfound INT DEFAULT(FALSE);
	DECLARE _err INT DEFAULT(FALSE);
	DECLARE _errmsg VARCHAR(1024) DEFAULT('');

	#游标定义
	DECLARE selectcur1 CURSOR FOR
		SELECT fs_clientid, fs_usagecode, Fs_secacct, fs_mkid, fs_stocktype, fs_code, fi_ratio, fd_buyprise
		FROM tscorestockrisk;
	DECLARE cur1 CURSOR FOR
		SELECT Fs_marketcode, Fs_secacct, Fs_stockcode, Fs_stocktype, Fi_currentamount, Fi_holdamount, Fd_avbuyprice
		FROM tptstock00;


	#异常处理代码
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
	BEGIN
		SET _notfound = TRUE;
	END;
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION,SQLWARNING
	BEGIN
		GET DIAGNOSTICS CONDITION 1 _errmsg = MESSAGE_TEXT;
		SET _err = TRUE;
		SELECT _err, _errmsg;
		ROLLBACK;
	END;

	#主逻辑
	#删除前三个月的记录
	CALL prod_get_ct_time(1, cttime);
	SET  precttime = date_sub('2018-12-05 10:57:09', interval 3 month);
	SET  ctdate = LEFT(REPLACE(cttime,'-',''),8);
	SET  prectdate = LEFT(REPLACE(precttime,'-',''),8);
	DELETE FROM tscorestockrisk WHERE fs_starttime < prectdate;
	#往前更新一天数据
	OPEN selectcur1;
	sltread_loop: LOOP
		SET ratio = 0.0;
		SET score = 0;
		SET holdamount = 0;
		SET finish = '0';
		SET _notfound = FALSE;
		FETCH selectcur1 INTO clientid, usagecode, secacct, marketcode, stocktype, stockcode, dbratio, buyprice;
		IF _notfound THEN
			LEAVE sltread_loop;
		END IF;
		IF(dbratio = 100)THEN
			ITERATE sltread_loop;
		END IF;
		#获取持仓数据
		SELECT Fi_holdamount, Fd_avsellprice INTO holdamount, sellprice FROM tptstock00 WHERE Fs_secacct = secacct AND Fs_marketcode = marketcode AND Fs_stocktype = stocktype AND Fs_stockcode = stockcode;
		IF(holdamount = 0)THEN
			SET finish = '1';
		END IF;
		SELECT Fd_closeprice INTO closeprice FROM tcmstockcode00 WHERE Fs_marketcode = marketcode AND Fs_stocktype = stocktype AND Fs_stockcode = stockcode;

		IF(finish = '1')THEN
			IF(buyprice != 0.0)THEN
				SET ratio = format(1 - (sellprice / buyprice), 2);
			END IF;
		ELSE
			IF(buyprice != 0.0)THEN
				SET ratio = format(1 - (closeprice / buyprice), 2);
			END IF;
		END IF;

		IF(ratio > dbratio/100)THEN
			IF(dbratio = 5)THEN
				SET score = 5;
				SET dbratio = 10;
			ELSEIF(dbratio = 10)THEN
				SET score = 10;
				SET dbratio = 20;
			ELSEIF(dbratio = 20)THEN
				SET score = 30;
				SET dbratio = 30;
			ELSEIF(dbratio = 30)THEN
				SET score = 50;
				SET dbratio = 50;
			ELSEIF(dbratio = 50)THEN
				SET score = 100;
				SET dbratio = 100;
			END IF;
		END IF;

		IF(finish = '1')THEN
			UPDATE tscorestockrisk SET fi_score = fi_score - score, fi_ratio = 100
				WHERE fs_clientid = clientid AND fs_usagecode = usagecode AND fs_mkid = marketcode AND fs_stocktype = stocktype AND fs_code = stockcode;
		ELSE
			UPDATE tscorestockrisk SET fi_score = fi_score - score, fi_ratio = dbratio
				WHERE fs_clientid = clientid AND fs_usagecode = usagecode AND fs_mkid = marketcode AND fs_stocktype = stocktype AND fs_code = stockcode;		
		END IF;
	END LOOP;
	CLOSE selectcur1;

	OPEN cur1;
	read_loop: LOOP
		#初始化参数
		SET score = 0;
		SET ratio = 0.0;
		SET dbratio = 5;
		SET _notfound = FALSE;
		#获取一条数据
		FETCH cur1 INTO marketcode, secacct, stockcode, stocktype, currentamount, holdamount, avbuyprice;
		IF _notfound THEN
			LEAVE read_loop;
		END IF;
		IF(holdamount > currentamount)THEN#昨少今多
			#查询用户比赛信息
			SELECT t1.Fs_clientid, t1.Fs_usagecode INTO clientid, usagecode FROM tcusecacct t1 WHERE Fs_secacct = secacct;
			SELECT COUNT(1) INTO count FROM tscorestockrisk 
				WHERE fs_clientid = clientid AND fs_usagecode = usagecode AND fs_mkid = marketcode AND fs_stocktype = stocktype AND fs_code = stockcode;
			IF(count > 0)THEN
				ITERATE read_loop;
			END IF;
			SELECT Fd_closeprice INTO closeprice FROM tcmstockcode00 WHERE Fs_marketcode = marketcode AND Fs_stocktype = stocktype AND Fs_stockcode = stockcode;
			IF(avbuyprice != 0.0)THEN
				SET ratio = format(1 - (closeprice / avbuyprice), 2);
			END IF;
			IF(ratio > 0.05)THEN
				SET score = 5;
				SET dbratio = 10;
			END IF;
			INSERT INTO tscorestockrisk VALUES(clientid, usagecode, secacct, marketcode, stocktype, stockcode, 1, ctdate, avbuyprice, holdamount, dbratio, -score, '0');
		END IF;
	END LOOP;
	CLOSE cur1;

	COMMIT;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
