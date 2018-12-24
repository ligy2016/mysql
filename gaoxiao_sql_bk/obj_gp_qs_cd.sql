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

/* Procedure structure for procedure `gp_qs_cd` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `gp_qs_cd`(marketcode varchar(32))
LABEL_PROC:
begin
	#变量定义
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

	DECLARE done INT DEFAULT(FALSE);
	DECLARE cur1 CURSOR FOR
		SELECT  t1.Fs_opbranchno, t1.Fs_opentrustway, t1.Fs_opstation, t1.Fs_branchno, 
						t1.Fs_clientid, t1.fs_fuacct,  t1.Fi_entrustno 
		FROM  trqstkentrust00 t1, ttsstkentrustsec00 t2 
		WHERE t1.Fi_requestno = t2.Fi_requestno and t2.Fs_entruststatus in (2, 7) and t1.Fs_marketcode = marketcode;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	#初始化状态
	CALL prod_c_update_marketstatus(0, marketcode, 6, 10, 0, '');
	CALL prod_c_update_marketstatus(1, marketcode, 6, 10, 0, '');

#1)业务处理
#1.1)撤单
	OPEN cur1;
	read_loop: LOOP
		FETCH cur1 INTO in_op_branch_no, in_op_entrust_way, in_op_station, in_branch_no,
										in_client_id, in_fund_account, in_entrust_no;
		IF done THEN
			LEAVE read_loop;
		END IF;
		CALL prod_szqq_333017_auto(in_op_branch_no, in_op_entrust_way, in_op_station, in_branch_no,
													in_client_id, in_fund_account, in_password, in_password_type,
													in_user_token, in_asset_prop, marketcode+1, in_entrust_no);
	END LOOP;
	CLOSE cur1;
	#校验撤单是否成功
	SELECT COUNT(*) INTO @count FROM  trqstkentrust00 t1, ttsstkentrustsec00 t2 
		WHERE t1.Fi_requestno = t2.Fi_requestno and t2.Fs_entruststatus in (2, 7) and t1.Fs_marketcode = marketcode;
	IF (@count != 0)THEN
		ROLLBACK;
		CALL prod_c_update_marketstatus(1, marketcode, 6, 10, -1, '撤单不成功');
		LEAVE LABEL_PROC;
	END IF;
	commit;

	CALL prod_c_update_marketstatus(0, marketcode, 6, 99, 0, '收盘完毕');
  CALL prod_c_update_marketstatus(1, marketcode, 6, 99, 0, '收盘完毕');

end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
