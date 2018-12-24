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

/* Procedure structure for procedure `prod_ct_1_close_bill` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_ct_1_close_bill` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_ct_1_close_bill`(IN `settdate` char(8))
LABEL_PROC:
begin
	##名称
		#prod_ct_1_close_bill
	##作用
		#柜台1结单据
	##参数说明
	
	##主体

	#1.结业务数据
	#委托报单
	CALL prod_ct_close_table_2_his('trqstkentrust00', 'trqhisstkentrust00', settdate, 1);
	#撤单
	CALL prod_ct_close_table_2_his('trqstkunentrust00', 'trqhisstkunentrust00', settdate, 1);
	#委托单
	CALL prod_ct_close_table_2_his('ttsstkentrustsec00', 'ttshisstkentrustsec00', settdate, 1);
	#成交明细
	CALL prod_ct_close_table_2_his('ttsstkbusiseclist00', 'ttshisstkbusiseclist00', settdate, 1);
	#成交单
	INSERT INTO ttshisstkbusisec00 SELECT * ,settdate,0,0,0,0,0,0,0,0,0,0,0 from ttsstkbusisec00;
	DELETE FROM ttsstkbusisec00 WHERE 1 = 1;
	UPDATE ttshisstkbusisec00 a, tcasub2aclist b 
			SET a.Fd_exchangefare1 = b.Fd_amt 
			WHERE a.Fi_businessecno = b.Fs_trdorderno and Fs_trdtype = '成交单' and Fs_amtocctype = 'PAY' and Fs_amttype = 'STD'; 
	UPDATE ttshisstkbusisec00 a, tcasub2aclist b 
			SET a.Fd_exchangefare2 = b.Fd_amt 
			WHERE a.Fi_businessecno = b.Fs_trdorderno and Fs_trdtype = '成交单' and Fs_amtocctype = 'PAY' and Fs_amttype = 'TSF'; 
	UPDATE ttshisstkbusisec00 a, tcasub2aclist b 
			SET a.Fd_exchangefare5 = b.Fd_amt 
			WHERE a.Fi_businessecno = b.Fs_trdorderno and Fs_trdtype = '成交单' and Fs_amtocctype = 'PAY' and Fs_amttype = 'CMS'; 
	UPDATE 	ttshisstkbusisec00 set Fd_exchangefare = 	Fd_exchangefare1 + Fd_exchangefare2 + Fd_exchangefare5;	

	#2.结持仓
	#结持仓
	CALL prod_ct_close_table_2_his('tptstock00', 'tpthisstock00', settdate, 0);
	UPDATE tptstock00 SET Fi_currentamount = Fi_holdamount,Fi_enableamount = Fi_enableamount +Fi_realbuylockamount,Fi_exefroenbleamt = Fi_exefroenbleamt + Fi_exefrobuyamt,
			Fi_exefrobuyamt = 0,Fi_realbuyamount = 0, Fi_realsellamount = 0,Fi_realbuylockamount = 0,Fi_todayisexi = 0,Fi_todayisexp = 0 
			WHERE 1 = 1;
	DELETE FROM tptstock00 WHERE Fi_holdamount = 0;

	#3.结市场状态表
	INSERT INTO tmkhisstatus SELECT * FROM tmkstatus WHERE Fs_marketcode in (0,1);

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
