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

/* Procedure structure for procedure `prod_amount_freq_counting` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_amount_freq_counting`(  contestcode VARCHAR (32),  OUT ret INT)
LABEL_PROC :
BEGIN
  DECLARE done INT DEFAULT(FALSE) ;
  DECLARE msg VARCHAR (512) DEFAULT('') ;
  DECLARE LINE INT DEFAULT(0);
   DECLARE tmpcnt INT DEFAULT(0);
  
--     
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION  BEGIN 
	ROLLBACK;
	SET ret = 1 ;
	SET msg = CONCAT('【error】 prod_amount_freq_counting  ',	  contestcode	) ;	
	INSERT INTO `feps`.`terrorlog` (`Ft_occtime`, `Fs_errlog`) 	VALUES  (NOW(), msg) ;
	COMMIT;	
	END  ;
	 SET ret = 0 ;
	 
	
-- 	  SELECT COUNT(*) INTO  tmpcnt FROM tstatisticsdate WHERE Fs_traceid = contestcode AND TO_DAYS(ft_validdate )=TO_DAYS( CURDATE());
-- 	  
-- 	  IF tmpcnt != 1 THEN  
-- 		SET ret =1;
-- 		LEAVE  LABEL_PROC;
-- 	  END IF;
	  
	#今天开始的新比赛！没有做日初初始化
	IF EXISTS( SELECT 1 FROM tstatisticsdate WHERE Fs_traceid =contestcode LIMIT 1) THEN
		SET LINE=36;
	ELSE
		-- 不存在则初始化统计数据
		    CALL prod_new_stastics(contestcode,call_ret);
		    SET LINE=40;
		    CALL log_exit(call_ret);
	END IF;   	  
	  
update ttradenumstatistics t1,ttradeamtstatistics t2, tstatistics t3 
set t1.Fs_dailytradenum =  t3.fi_todayfreq,
	t1.Fs_weeklytradenum = t3.fi_weekfreq,
	t1.Fs_monthlytradenum = t3.fi_monthfreq ,
	t2.Fs_dailytradeamount  = t3.fd_todayamount,
	t2.Fs_weeklytradeamount = t3.fd_weekamount,
	t2.Fs_monthlytradeamount = t3.fd_monthamount,
	t2.Fs_totaltradeamount = t3.fd_totalamount
	where   t1.fs_fuacct = t3.fs_fuacct or t2.fs_fuacct = t3.fs_fuacct and t3.Fs_raceid =contestcode;
  COMMIT;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
