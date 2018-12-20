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

/* Procedure structure for procedure `prod_ct_1_close` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_ct_1_close` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_ct_1_close`(IN `src` int)
LABEL_PROC:
BEGIN
##名称
	#prod_ct_1_close
##作用
	#柜台1收盘
##参数说明
	#IN `src` int
	#src：执行来源（0手工调账，1定时任务）定时认为每天只能执行一次。

##主体
	DECLARE mainstatus int DEFAULT(-1);
	DECLARE substatus int DEFAULT(-1);
	DECLARE errorno int DEFAULT(-1);
	DECLARE res int DEFAULT(0);
	DECLARE settdate char(8) DEFAULT(0);

	SELECT Fs_settdate INTO settdate FROM tctstatus WHERE Fi_countercode = 1;

	#1检查柜台状态是否允许收盘
	SELECT fi_status, fi_substatus, fi_errorno
		INTO mainstatus, substatus, errorno
		FROM tctstatus
		WHERE Fi_countercode = 1;
	IF(src = 1)THEN
		IF(mainstatus != 6 OR substatus != 0)THEN
			ROLLBACK;
			CALL prod_ct_close_update_stat(1, 1, -99, -99, -1, '当前柜台状态不允许自动收盘');
			LEAVE LABEL_PROC;
		END IF;
	END IF;

	#2检查所管市场是否全部收盘
	SELECT fi_substatus INTO substatus FROM tctstatus WHERE Fi_countercode = 1;
	IF(substatus <= 10)THEN
		CALL prod_ct_close_update_stat(0, 1, 6, 10, -99, '-99');
		CALL prod_ct_close_update_stat(1, 1, -99, -99, 0, '');
		SELECT fi_status, fi_substatus, fi_errorno
				INTO mainstatus, substatus, errorno
				FROM tmkstatus
				WHERE fs_marketcode = '0' AND fs_kindcode = '1';
		IF(mainstatus != 6 OR substatus != 99) then
			ROLLBACK;
			CALL prod_ct_close_update_stat(1, 1, -99, -99, -1, '上海A股市场未收盘完毕，此柜台不能开始清算');
			LEAVE LABEL_PROC;
		END IF;
		SELECT fi_status, fi_substatus, fi_errorno
				INTO mainstatus, substatus, errorno
				FROM tmkstatus
				WHERE fs_marketcode = '1' AND fs_kindcode = '2';
		IF(mainstatus != 6 OR substatus != 99) then
			ROLLBACK;
			CALL prod_ct_close_update_stat(1, 1, -99, -99, -1, '深圳A股市场未收盘完毕，此柜台不能开始清算');
			LEAVE LABEL_PROC;
		END IF;
	END IF;

	#3对账
	SELECT fi_substatus INTO substatus FROM tctstatus WHERE Fi_countercode = 1;
	IF(substatus <= 20)THEN
		CALL prod_ct_close_update_stat(0, 1, 6, 20, -99, '-99');
		CALL prod_ct_close_update_stat(1, 1, -99, -99, 0, '');
		CALL prod_ct_1_close_check(res);
		IF(res != 0)THEN
			ROLLBACK;
			CALL prod_ct_close_update_stat(1, 1, -99, -99, -1, '对账失败');
			LEAVE LABEL_PROC;
		END IF;
		COMMIT;
	END IF;

	#4结单据
	SELECT fi_substatus INTO substatus FROM tctstatus WHERE Fi_countercode = 1;
	IF(substatus <= 30)THEN
		CALL prod_ct_close_update_stat(0, 1, 6, 30, -99, '-99');
		CALL prod_ct_close_update_stat(1, 1, -99, -99, 0, '');
		CALL prod_ct_1_close_bill(settdate);
	COMMIT;
	END IF;


	#5结资金
	SELECT fi_substatus INTO substatus FROM tctstatus WHERE Fi_countercode = 1;
	IF(substatus <= 40)THEN
		CALL prod_ct_close_update_stat(0, 1, 6, 40, -99, '-99');
		CALL prod_ct_close_update_stat(1, 1, -99, -99, 0, '');
		CALL prod_ct_close_ccnt_blnc(1,settdate);
		COMMIT;
	END IF;

	#6结柜台状态
	CALL prod_ct_close_update_stat(0, 1, 6, 99, -99, '-99');
	CALL prod_ct_close_update_stat(1, 1, -99, -99, 0, '清算完毕');
	INSERT INTO tcthisstatus SELECT * FROM tctstatus WHERE Fi_countercode = 1;
	COMMIT;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
