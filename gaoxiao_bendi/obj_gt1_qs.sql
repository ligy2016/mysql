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

/* Procedure structure for procedure `gt1_qs` */

/*!50003 DROP PROCEDURE IF EXISTS  `gt1_qs` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `gt1_qs`(IN `src` int)
LABEL_PROC:
BEGIN
#柜台1清算
#柜台1主要管理股票

#1检查所管市场是否全部收盘
#获取当前状态
SELECT fi_status, fi_substatus, fi_errorno 
	INTO @status, @substatus, @errorno
	FROM tctstatus
	WHERE Fi_countercode = 1;

IF(src = 1)THEN
	IF(@status != 6 OR @substatus != 0)THEN
		LEAVE LABEL_PROC;
	END IF;
END IF;
#1检查所管市场是否全部收盘
SELECT fi_substatus INTO @substatus FROM tctstatus WHERE Fi_countercode = 1;
IF(@substatus <= 10)THEN
	CALL prod_c_update_ctstatus(0, 1, 6, 10, 0, '');
	CALL prod_c_update_ctstatus(1, 1, 6, 10, 0, '');
	SELECT fi_status, fi_substatus, fi_errorno
			INTO @status, @substatus, @errorno
			FROM tmkstatus
			WHERE fs_marketcode = '0';
	if (@status != 6 OR @substatus != 99) then
		ROLLBACK;
		CALL prod_c_update_ctstatus(1, 1, 6, 10, -1, '市场未收盘完毕，此柜台不能开始清算');
		LEAVE LABEL_PROC;
	END IF;
	SELECT fi_status, fi_substatus, fi_errorno
			INTO @status, @substatus, @errorno
			FROM tmkstatus
			WHERE fs_marketcode = '1';
	if (@status != 6 OR @substatus != 99) then
		ROLLBACK;
		CALL prod_c_update_ctstatus(1, 1, 6, 10, -1, '市场未收盘完毕，此柜台不能开始清算');
		LEAVE LABEL_PROC;
	END IF;
END IF;

#1+对账
SELECT fi_substatus INTO @substatus FROM tctstatus WHERE Fi_countercode = 1;
IF(@substatus <= 11)THEN
	CALL prod_c_update_ctstatus(0, 1, 6, 11, 0, '');
	CALL prod_c_update_ctstatus(1, 1, 6, 11, 0, '');

	CALL gt_qs_dz(1, @res);
	IF(@res != 0)THEN
		ROLLBACK;
		CALL prod_c_update_ctstatus(1, 1, 6, 11, -1, '对账失败');
		LEAVE LABEL_PROC;		
	END IF;

	commit;
end if;

#2结单据
SELECT fi_substatus INTO @substatus FROM tctstatus WHERE Fi_countercode = 1;
IF(@substatus <= 20)THEN
	CALL prod_c_update_ctstatus(0, 1, 6, 20, 0, '');
	CALL prod_c_update_ctstatus(1, 1, 6, 20, 0, '');

 CALL gt_qs_jdj('0');
 CALL gt_qs_jdj('1');

	commit;
end if;


#4结对应资金类型余额
SELECT fi_substatus INTO @substatus FROM tctstatus WHERE Fi_countercode = 1;
IF(@substatus <= 40)THEN
	CALL prod_c_update_ctstatus(0, 1, 6, 40, 0, '');
	CALL prod_c_update_ctstatus(1, 1, 6, 40, 0, '');
	SELECT Fs_settdate into @settdate from tctstatus where Fi_countercode = 1;
	CALL gt_qs_jzj(1,@settdate);
	commit;
end if;
	CALL prod_c_update_ctstatus(0, 1, 6, 99, 0, '清算完毕');
	CALL prod_c_update_ctstatus(1, 1, 6, 99, 0, '清算完毕');

#结柜台状态
INSERT INTO tcthisstatus SELECT * FROM tctstatus WHERE Fi_countercode = 1;
COMMIT;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
