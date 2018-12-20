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

/* Procedure structure for procedure `prod_stock_a_close` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_stock_a_close` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_stock_a_close`(marketcode varchar(32), kindcode varchar(32))
LABEL_PROC:
BEGIN
	##名称
		#prod_stock_a_close
	##作用
		#A股市场收盘
		#股票收盘只做撤单
	##参数说明
		#marketcode varchar(32), kindcode varchar(32)
		#marketcode：市场编号
		#kindcode：分类
	##主体
	DECLARE in_op_branch_no char(5) DEFAULT('');
	DECLARE in_op_entrust_way char(1) DEFAULT('');
	DECLARE in_op_station varchar(255) DEFAULT('');
	DECLARE in_branch_no char(5) DEFAULT('');
	DECLARE in_client_id char(18) DEFAULT('');
	DECLARE in_fund_account char(18) DEFAULT('');
	DECLARE in_password char(64) DEFAULT('');
	DECLARE in_password_type char(1) DEFAULT('');
	DECLARE in_user_token varchar(512) DEFAULT('');
	DECLARE in_asset_prop char(1) DEFAULT('');
	DECLARE in_exchange_type char(4) DEFAULT('');
	DECLARE in_entrust_no char(10) DEFAULT('');
	DECLARE ccount int DEFAULT(0);

	DECLARE done INT DEFAULT(FALSE);
	DECLARE cur1 CURSOR FOR
		SELECT  t1.Fs_opbranchno, t1.Fs_opentrustway, t1.Fs_opstation, t1.Fs_branchno, 
						t1.Fs_clientid, t1.fs_fuacct,  t1.Fi_entrustno 
		FROM  trqstkentrust00 t1, ttsstkentrustsec00 t2 
		WHERE t1.Fi_requestno = t2.Fi_requestno and t2.Fs_entruststatus in (2, 7) and t1.Fs_marketcode = marketcode;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	#初始化状态
	CALL prod_close_update_marketstatus(0, marketcode, kindcode, 6, 10, 0, '');
	CALL prod_close_update_marketstatus(1, marketcode, kindcode, 6, 10, 0, '');

	#获取市场对应的交易类别
	SELECT Fs_exchangetype INTO in_exchange_type FROM tmkkindcode WHERE Fs_marketcode = marketcode AND Fs_kindcode = kindcode;
	
	OPEN cur1;
	read_loop: LOOP
		FETCH cur1 INTO in_op_branch_no, in_op_entrust_way, in_op_station, in_branch_no,
										in_client_id, in_fund_account, in_entrust_no;
		IF done THEN
			LEAVE read_loop;
		END IF;
		CALL prod_szqq_333017_auto(in_op_branch_no, in_op_entrust_way, in_op_station, in_branch_no,
													in_client_id, in_fund_account, in_password, in_password_type,
													in_user_token, in_asset_prop, in_exchange_type, in_entrust_no);
	END LOOP;
	CLOSE cur1;
	
	#校验撤单是否成功
	SELECT COUNT(*) INTO ccount FROM  trqstkentrust00 t1, ttsstkentrustsec00 t2 
		WHERE t1.Fi_requestno = t2.Fi_requestno and t2.Fs_entruststatus in (2, 7) and t1.Fs_marketcode = marketcode;
	IF (ccount != 0)THEN
		ROLLBACK;
		CALL prod_close_update_marketstatus(1, marketcode, kindcode, 6, 10, -1, '撤单出现失败，请手工处理');
		LEAVE LABEL_PROC;
	END IF;
	COMMIT;
	
	CALL prod_close_update_marketstatus(0, marketcode, kindcode, 6, 99, 0, '收盘完毕');
	CALL prod_close_update_marketstatus(1, marketcode, kindcode, 6, 99, 0, '收盘完毕');

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
