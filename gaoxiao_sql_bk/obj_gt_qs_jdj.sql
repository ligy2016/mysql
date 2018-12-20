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

/* Procedure structure for procedure `gt_qs_jdj` */

/*!50003 DROP PROCEDURE IF EXISTS  `gt_qs_jdj` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `gt_qs_jdj`(marketcode varchar(32))
LABEL_PROC:
begin
	#结业务数据

	#获取当前状态
	/*SELECT fi_status, fi_substatus, fi_errorno ,Fs_mkdate
		INTO @status, @substatus, @errorno,@jyrq 
		FROM tmkstatus
		WHERE fs_marketcode = marketcode;
	IF(@substatus < 13000 OR @substatus > 13200 )THEN
			CALL prod_c_update_marketstatus(1, marketcode, 99, 99, -1, '当前状态不能继续日结');
			LEAVE LABEL_PROC;
		END IF;*/
	#1.结委托
	#IF(@substatus <= 13101)THEN
		#报单
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 13101, 99, '');
		CALL prod_c_table_his('trqstkentrust00', 'trqhisstkentrust00', '1',marketcode);
		#COMMIT;
	#END IF;
	#IF(@substatus <= 13102)THEN
		#撤单
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 13102, 99, '');
		CALL prod_c_table_his('trqstkunentrust00', 'trqhisstkunentrust00', '1',marketcode);
		#COMMIT;
	#END IF;
	#IF(@substatus <= 13103)THEN
		#委托单
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 13103, 99, '');
		CALL prod_c_table_his('ttsstkentrustsec00', 'ttshisstkentrustsec00', '1',marketcode);
		#COMMIT;
	#END IF;
	#IF(@substatus <= 13105)THEN
		#成交明细
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 13105, 99, '');
		#CALL prod_c_table_his('ttsstkbusiseclist00', 'ttshisstkbusiseclist00', '1',marketcode);
		INSERT INTO ttshisstkbusiseclist00 SELECT a.* ,@jyrq from ttsstkbusiseclist00 a,ttsstkbusisec00 b where a.Fi_businessecno = b.Fi_businessecno and b.Fs_marketcode = marketcode ;
		DELETE  a from ttsstkbusiseclist00 a,ttsstkbusisec00 b where a.Fi_businessecno = b.Fi_businessecno and b.Fs_marketcode = marketcode ;
		#COMMIT;
	#END IF;
	#IF(@substatus <= 13104)THEN
		#成交单
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 13104, 99, '');
		#CALL prod_c_table_his('ttsstkbusisec00', 'ttshisstkbusisec00', '1',marketcode);
		INSERT INTO ttshisstkbusisec00 SELECT * ,@jyrq,0,0,0,0,0,0,0,0,0,0,0 from ttsstkbusisec00 where Fs_marketcode = marketcode;
		DELETE FROM ttsstkbusisec00 where Fs_marketcode = marketcode;
		UPDATE ttshisstkbusisec00 a, tcasub2aclist b 
				SET a.Fd_exchangefare1 = b.Fd_amt 
				where a.Fi_businessecno = b.Fs_trdorderno and Fs_trdtype = '成交单' and Fs_amtocctype = 'PAY' and Fs_amttype = 'STD' and  a.Fs_marketcode = marketcode; 
		UPDATE ttshisstkbusisec00 a, tcasub2aclist b 
				SET a.Fd_exchangefare2 = b.Fd_amt 
				where a.Fi_businessecno = b.Fs_trdorderno and Fs_trdtype = '成交单' and Fs_amtocctype = 'PAY' and Fs_amttype = 'TSF' and  a.Fs_marketcode = marketcode; 
		UPDATE ttshisstkbusisec00 a, tcasub2aclist b 
				SET a.Fd_exchangefare5 = b.Fd_amt 
				where a.Fi_businessecno = b.Fs_trdorderno and Fs_trdtype = '成交单' and Fs_amtocctype = 'PAY' and Fs_amttype = 'CMS' and  a.Fs_marketcode = marketcode; 
		UPDATE 	ttshisstkbusisec00 set Fd_exchangefare = 	Fd_exchangefare1 + Fd_exchangefare2 + Fd_exchangefare5  where Fs_marketcode = marketcode;	
		#COMMIT;
	#END IF;
	
	#2.结持仓
	#IF(@substatus <= 13200)THEN
		#结持仓
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 13200, 99, '');
		CALL prod_c_table_his('tptstock00', 'tpthisstock00', '0',marketcode);
		UPDATE tptstock00 SET Fi_currentamount = Fi_holdamount,Fi_enableamount = Fi_enableamount +Fi_realbuylockamount,Fi_exefroenbleamt = Fi_exefroenbleamt + Fi_exefrobuyamt,
								Fi_exefrobuyamt = 0,Fi_realbuyamount = 0, Fi_realsellamount = 0,Fi_realbuylockamount = 0,Fi_todayisexi = 0,Fi_todayisexp = 0 
					WHERE 1 = 1 and Fs_marketcode = marketcode;
		DELETE FROM tptstock00 WHERE Fi_holdamount = 0 and Fs_marketcode = marketcode;
		#COMMIT;
	#END IF;

		#CALL prod_c_update_marketstatus(0, marketcode, 14, 19999, 99, '');
		#CALL prod_c_update_marketstatus(1, marketcode, 14, 19999, 2, '盘后日结完毕');
		#SELECT "日结完毕";
		#CALL prod_c_update_marketstatus(0, marketcode, 14, 14200, 99, '');

	#3.结市场状态表
	INSERT INTO tmkhisstatus SELECT * FROM tmkstatus where Fs_marketcode = marketcode;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
