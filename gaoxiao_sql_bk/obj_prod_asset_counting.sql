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

/* Procedure structure for procedure `prod_asset_counting` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_asset_counting` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_asset_counting`(
  contestcode VARCHAR (32),  OUT ret INT)
LABEL_PROC :
BEGIN
DECLARE markettype VARCHAR (32) DEFAULT('') ;
DECLARE tablename VARCHAR (32) DEFAULT('') ;
DECLARE secacct VARCHAR (18) DEFAULT('') ;
DECLARE maketvalue DECIMAL(32,4) DEFAULT(0);
DECLARE bal DECIMAL(32,4) DEFAULT(0);
-- DECLARE ooo DECIMAL(32,4) DEFAULT(0);  
DECLARE asst_today DECIMAL(32,4) DEFAULT(0);
DECLARE call_ret INT (0) ;
DECLARE done INT DEFAULT(FALSE) ;
DECLARE msg VARCHAR (512) DEFAULT('') ;
DECLARE LINE INT DEFAULT(0);
DECLARE tmpcnt INT DEFAULT(0);
DECLARE  intialasset DECIMAL (32,4) DEFAULT(0);
DECLARE cur CURSOR FOR   SELECT * FROM asset_view; 
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;
DECLARE EXIT HANDLER FOR SQLEXCEPTION  SET done = TRUE ;
BEGIN 
	ROLLBACK;
	SET ret = 1 ;
	SET msg = CONCAT(	  '[error]  ',	  'prod_每日资产统计 '	,contestcode,'  ',LINE) ;	
	INSERT INTO `feps`.`terrorlog` (`Ft_occtime`, `Fs_errlog`) 	VALUES  (NOW(), msg) ;
	COMMIT;	
	END  ; 
	
	  SET ret = 0 ;
	
	#今天开始的新比赛！
	IF EXISTS( SELECT 1 FROM tstatisticsdate WHERE Fs_traceid =contestcode LIMIT 1) THEN
		SET LINE=39;
	ELSE
		-- 不存在则初始化统计数据
		    CALL prod_new_stastics(contestcode,call_ret);
		    SET LINE=43;
		    CALL log_exit(call_ret);
	END IF;   
	
	  SELECT COUNT(*) INTO  tmpcnt FROM tstatisticsdate WHERE Fs_traceid = contestcode AND TO_DAYS(ft_validdate )=TO_DAYS( CURDATE());
	  IF tmpcnt != 1 THEN  
		SET ret =1;#竞赛历史数据未初始化！ 
		LEAVE  LABEL_PROC;
	  END IF;
    SELECT Fd_intialasset INTO  intialasset FROM trace WHERE fs_id = contestcode ;
	DROP VIEW IF EXISTS asset_view;       
	SELECT  Fs_markettype INTO markettype FROM trace WHERE fs_id = contestcode ;
	IF markettype = '10'THEN 
		SET tablename = 'tptoption00';
	ELSE 
		SET tablename = 'tptstock00';
	END IF;
    SET @sqlstr = "CREATE VIEW asset_view as "; 
    SET @sqlstr = CONCAT(@sqlstr , "	SELECT     t2.Fs_secacct, IFNULL(SUM(t1.fd_marketvalue ),0) ,AVG(t3.fd_Totalbal ) FROM  (tcusecacct t2  LEFT JOIN ", tablename," ");     
    SET @sqlstr = CONCAT(@sqlstr , "  t1     ON t1.Fs_secacct = t2.Fs_secacct  AND t1.Fi_holdamount >0 )  JOIN   tcasub2balance t3 ON t3.fs_fuacct = t2.fs_fuacct 
							WHERE  t2.fs_usagecode = '",contestcode ,"'  GROUP BY t2.Fs_secacct  WITH ROLLUP ");    						
    PREPARE stmt FROM @sqlstr;      EXECUTE stmt;    
    DEALLOCATE PREPARE stmt;      
  OPEN cur ;
  read_loop :
  LOOP
    FETCH cur INTO secacct,maketvalue,bal;
    IF done     THEN LEAVE read_loop ;    END IF ;
	-- refresh
	UPDATE  `gaoxiao_local`.`tstatistics` 
	SET fd_todaybal = bal,
		fd_todaymarketvalue = maketvalue ,
		fd_todayprofit = bal+maketvalue-fd_preasset,
		fd_weekprofit = fd_hisweekprofit + bal+maketvalue-fd_preasset, 
		fd_monthprofit= fd_hismonthprofit + bal+maketvalue-fd_preasset
	WHERE  Fs_raceid = contestcode AND fs_seacct =  secacct ;
	
  END LOOP ;
  CLOSE cur ;
  COMMIT ;
	UPDATE tracestatistics  t1, tstatistics t2 
	SET t1.Fs_dailyreturn = t2.fd_todayprofit, 
		t1.Fs_weeklyreturn = t2.fd_weekprofit,
		t1.Fs_monthlyreturn = t2.fd_monthprofit,
		t1.Fs_totalreturn = t2.fd_todaybal  + t2.fd_todaymarketvalue - intialasset 
	WHERE t1.fs_fuacct = t2.fs_fuacct;
	UPDATE tdailyassetsstatistics  t1, tstatistics t2 
	SET t1.Fd_totalbal = t2. fd_todaybal, 
		t1.Fd_maketvalue = t2.fd_todaymarketvalue #
	WHERE t1.fs_fuacct = t2.fs_fuacct AND TO_DAYS(t1.Ft_time) = TO_DAYS(NOW());
	  
	  
	  COMMIT;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
