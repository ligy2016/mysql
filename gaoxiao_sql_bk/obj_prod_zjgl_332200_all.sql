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

/* Procedure structure for procedure `prod_zjgl_332200_all` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_zjgl_332200_all`(studentid  Varchar(32),
	usagecode Varchar(32),
	money_type varchar(3),
	transfer_direction char(1),
	occur_balance varchar(20),
	founder varchar(32))
LABEL_PROC:
begin
##名称
	#prod_zjgl_332200_all
##作用
	#竞赛所有账户增减资金
##参数说明
	#studentid 学生账号
	#usagecode 竞赛编号
	#money_type 金额类型
	#transfer_direction 资金增减类型  1加 2减
	#occur_balance 资金金额
	#founder 操作人
#返回参数
	
##主体
	DECLARE fuacct VARCHAR(18) DEFAULT('');
	DECLARE done INT DEFAULT(FALSE);
	DECLARE i int DEFAULT(0);
	DECLARE cur1 CURSOR FOR select t2.fs_fuacct from  tstudent t1 ,tcufuacct t2 where t1.Fs_code = studentid and t1.Fs_clientid = t2.Fs_clientid 
					and t1.Fs_status = 1 and t2.Fi_usage = 1 and t2.Fs_usagecode = usagecode ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	
	OPEN cur1;
	read_loop:LOOP
	FETCH cur1 INTO fuacct;
	IF done THEN
		LEAVE read_loop;
	END IF;
	set @res = '0';
	call prod_zjgl_332200(@res,fuacct,money_type,transfer_direction,occur_balance,founder);
	if(@res = 1) then
		SELECT 'error_no', '-99', concat('资产账号',fuacct,'资金不足或当前市场状态不允许转账') AS info;
		CLOSE cur1;
		#ROLLBACK;
		LEAVE LABEL_PROC;
	end if;
	
	END LOOP;
	CLOSE cur1;
	#commit;

end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
