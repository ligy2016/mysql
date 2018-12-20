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

/* Procedure structure for procedure `prod_gen_hisdata_of_stastics` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_gen_hisdata_of_stastics` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_gen_hisdata_of_stastics`(
  contestcode VARCHAR (32),  OUT ret INT)
LABEL_PROC :
BEGIN
DECLARE secacct VARCHAR (18) DEFAULT('') ;
DECLARE maketvalue DECIMAL(32,4) DEFAULT(0);
DECLARE bal DECIMAL(32,4) DEFAULT(0);
DECLARE ooo DECIMAL(32,4) DEFAULT(0);
DECLARE lastday VARCHAR (32) DEFAULT('') ;
DECLARE asst_today DECIMAL(32,4) DEFAULT(0);
DECLARE  intialasset DECIMAL (32,4) DEFAULT(0);
DECLARE startdate VARCHAR (32) DEFAULT('') ;
DECLARE enddate VARCHAR (32) DEFAULT('') ;
DECLARE _monthofyear INT (0) ;
DECLARE _weekofyear INT (0) ;
DECLARE _monthofyear_today  INT (0) ;
DECLARE call_ret INT (0) ;
DECLARE done INT DEFAULT(FALSE) ;
DECLARE msg VARCHAR (512) DEFAULT('') ;
DECLARE LINE INT DEFAULT(0);
--   DECLARE cur CURSOR FOR 
    
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;
 DECLARE CONTINUE HANDLER FOR sqlexception   BEGIN 
	ROLLBACK;
	SET ret = 1 ;
	SET msg = CONCAT(	  'error ',	  secacct	) ;	
	INSERT INTO `feps`.`terrorlog` (`Ft_occtime`, `Fs_errlog`) 	VALUES  (NOW(), msg) ;
	COMMIT;	
	END  ; 
  SET ret = 0 ;
  
#防止多次执行  
	IF EXISTS( SELECT 1 FROM tstatisticsdate WHERE Fs_traceid =contestcode and ft_validdate = CURDATE()  LIMIT 1) THEN
		SET LINE=43;
		leave LABEL_PROC;		
	END IF;   
  
  SELECT   ft_starttime ,Ft_endtime ,Fd_intialasset INTO startdate,enddate,intialasset FROM trace 
WHERE fs_id = contestcode AND TO_DAYS(NOW()) >= TO_DAYS(ft_starttime) AND TO_DAYS(NOW()) <= TO_DAYS(ft_endtime) ;
	IF done=TRUE THEN 
	LEAVE LABEL_PROC ;
	END IF;
  
select fi_weekofyear,fi_monthofyear  into _weekofyear,   _monthofyear from  tstatisticsdate where Fs_traceid = contestcode;
  # refresh preasset
update tstatistics set fd_preasset   = fd_preasset + fd_todayprofit where 1=1;
   
IF  _weekofyear != WEEKOFYEAR(CURDATE())  THEN # new week 
  	UPDATE  tstatistics SET fd_hisweekprofit = 0 ,fd_hisweekamount =0 ,fi_hisweekfreq =0  WHERE  Fs_raceid = contestcode;
  	UPDATE tstatisticsdate SET fi_weekofyear = WEEKOFYEAR(CURDATE())  WHERE Fs_traceid = contestcode;
ELSE
		UPDATE  tstatistics SET fd_hisweekprofit = fd_hisweekprofit + fd_todayprofit  ,fd_hisweekamount = fd_hisweekamount + fd_todayamount, fi_hisweekfreq = fi_hisweekfreq + fi_todayfreq 
		WHERE Fs_raceid = contestcode;
END IF;
  
IF   DATE_FORMAT(CURDATE(),'%m')  !=  _monthofyear THEN # new month
		UPDATE  tstatistics SET fd_hismonthprofit = 0 ,fd_hismonthamount =0 ,fi_hismonthfreq =0     WHERE  Fs_raceid = contestcode;
		UPDATE tstatisticsdate SET fi_monthofyear = DATE_FORMAT(CURDATE(),'%m')  WHERE Fs_traceid = contestcode;
ELSE
		UPDATE  tstatistics SET fd_hismonthprofit = fd_hismonthprofit + fd_todayprofit ,
			fd_hismonthamount = fd_hismonthamount + fd_todayamount, 		fi_hismonthfreq = fi_hismonthfreq + fi_todayfreq 	WHERE Fs_raceid = contestcode;
		
END IF;
		
### 只能在这里刷新’今日计数‘
UPDATE tstatistics SET fd_todayprofit = 0  ,fd_todayamount = 0,fi_todayfreq = 0  	WHERE  Fs_raceid = contestcode;	
#refresh  status info  
  update tstatisticsdate set ft_validdate = CURDATE() where Fs_traceid = contestcode;
   
#new day   
UPDATE tstatistics set Ft_date = CURDATE() where 1=1;
select Ft_time  into lastday from tdailyassetsstatistics  WHERE Fs_raceid = contestcode ORDER BY Ft_time DESC limit 0,1 ;
insert into `feps`.`tdailyassetsstatistics` (
  `Fs_clientid`,
  `Fs_name`,
  `fs_fuacct`,
  `Fs_raceid`,
  `Fs_racename`,
  `Fd_totalbal`,
  `Fd_maketvalue`,
  `Ft_time`
)  select 
  `Fs_clientid`,
  `Fs_name`,
  `fs_fuacct`,
  `Fs_raceid`,
  `Fs_racename`,
  `Fd_totalbal`,
  `Fd_maketvalue`, curdate() from tdailyassetsstatistics where Fs_raceid = contestcode  and Ft_time = lastday ;
   
  commit;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
