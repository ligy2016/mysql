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

/* Procedure structure for procedure `prod_stastics` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_stastics`( opt int,out ret INT)
BEGIN
	DECLARE contestid VARCHAR (32) DEFAULT('') ;
	DECLARE call_ret INT (0) ;
	DECLARE msg VARCHAR (512) DEFAULT('') ;
	DECLARE LINE INT DEFAULT(0);
	DECLARE done INT DEFAULT(FALSE) ;
	DECLARE cur CURSOR FOR  SELECT Fs_id  FROM    trace  WHERE  Fs_status='1'  and Fs_practice ='2' AND  TO_DAYS(Ft_starttime  ) <=TO_DAYS(CURDATE())   AND   TO_DAYS(Ft_endtime ) >=TO_DAYS(CURDATE()) ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;	
	DECLARE EXIT HANDLER FOR sqlexception BEGIN 
		ROLLBACK;
		SET ret = 1 ;
		SET msg = CONCAT('[error]prod_stastics  类型：',  opt,'  赛事id： ', contestid,'  ',LINE) ;	
		INSERT INTO `feps`.`terrorlog` (`Ft_occtime`, `Fs_errlog`) 	VALUES  (NOW(), msg) ;
		COMMIT;	
	END  ; 
#
set ret =0 ;   
OPEN cur ;
 read_loop :
  LOOP
	FETCH cur INTO contestid  ;
	IF done     THEN LEAVE read_loop ;    END IF ;
	IF EXISTS( SELECT 1 FROM tstatisticsdate WHERE Fs_traceid =contestid LIMIT 1) THEN
		SET LINE=1;
	ELSE
		-- 不存在则初始化统计数据
		    CALL prod_new_stastics(contestid,call_ret);
		    SET LINE=38;
		    call log_exit(call_ret);
	END IF;   
	if opt = 0 then 		#日初初始化
		SET LINE=46;
		call prod_gen_hisdata_of_stastics(contestid,call_ret);	
	elseif opt = 1 then #保证收盘后，结历史之前统计一次
		SET LINE=48;
		CALL prod_asset_counting(contestid,call_ret);	
	 end if;
		CALL log_exit(call_ret);
END LOOP ;
CLOSE cur ;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
