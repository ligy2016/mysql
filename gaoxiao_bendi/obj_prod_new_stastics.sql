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

/* Procedure structure for procedure `prod_new_stastics` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_new_stastics` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_new_stastics`(
  contestcode VARCHAR (32),  OUT ret INT)
LABEL_PROC :
BEGIN
	DECLARE clientid VARCHAR (18) DEFAULT('') ;
	DECLARE secacct VARCHAR (18) DEFAULT('') ;
	DECLARE fuacct VARCHAR (18) DEFAULT('') ;
	DECLARE clientname VARCHAR (128) DEFAULT('') ;   
        DECLARE contestname VARCHAR (128) DEFAULT('') ;
	declare  intialasset decimal (32,4) default(0);
  DECLARE startdate VARCHAR (32) DEFAULT('') ;
  DECLARE enddate VARCHAR (32) DEFAULT('') ;
 
  DECLARE call_ret INT (0) ;
  DECLARE done INT DEFAULT(FALSE) ;
  DECLARE msg VARCHAR (512) DEFAULT('') ;
  DECLARE LINE INT DEFAULT(0);
  DECLARE cur CURSOR FOR 
  
  # students  info
  SELECT  DISTINCT t2.fs_clientid,       t2.fs_fuacct ,t1.Fs_clientname
  FROM    tcuuserinfo  t1 JOIN tcusecacct t2  ON t1.Fs_clientid = t2.Fs_clientid  
  WHERE  t2.fs_usagecode = contestcode  ;
    
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;
  #DECLARE CONTINUE HANDLER FOR sqlexception  ;
  DECLARE EXIT HANDLER FOR sqlexception  BEGIN 
	ROLLBACK;
	SET ret = 1 ;
	SET msg = CONCAT(	  '【error 】prod_new_stastics ',	  contestcode	,' ', LINE) ;	
	INSERT INTO  `terrorlog` (`Ft_occtime`, `Fs_errlog`) 	VALUES  (NOW(), msg) ;
	COMMIT;	
	END  ; 
  SET ret = 0 ;
  set LINE = 41;
#判断是否是今天是否是该比赛的开始日
 select   Fd_intialasset into intialasset from trace 
 where fs_id = contestcode;
-- select   ft_starttime ,Ft_endtime ,Fd_intialasset into startdate,enddate,intialasset from trace 
-- where fs_id = contestcode and TO_DAYS(NOW()) >= TO_DAYS(ft_starttime) and TO_DAYS(NOW()) <= TO_DAYS(ft_endtime) ;
-- 
-- 	if done=true then 
-- 	leave LABEL_PROC ;
-- 	end if;
  
# race info 
select   t3.fs_name  into contestname from trace t3    WHERE  t3.fs_id= contestcode  ;
OPEN cur ;
  read_loop :
  LOOP
    FETCH cur INTO clientid,        fuacct ,clientname;
    IF done     THEN LEAVE read_loop ;    END IF ;
    
     SET LINE = 60; 
    #tracestatistics
 #select clientid,   clientname,    fuacct,   contestcode,   contestname,    0,    0,    0,    0;
insert into  `tracestatistics` (  `Fs_clientid`,  `Fs_name`,  `fs_fuacct`,  `Fs_raceid`,  `Fs_racename`,  `Fs_dailyreturn`,
  `Fs_weeklyreturn`,  `Fs_monthlyreturn`,  `Fs_totalreturn`
) values  (    clientid,   clientname,    fuacct,   contestcode,   contestname,    0,    0,    0,    0  ) ;
# tdailyassetsstatistics
  SET LINE = 66;
insert into  `tdailyassetsstatistics` (
  `Fs_clientid`,
  `Fs_name`,
  `fs_fuacct`,
  `Fs_raceid`,
  `Fs_racename`,
  `Fd_totalbal`,
  `Fd_maketvalue`,
  `Ft_time`
) values  (   clientid,   clientname,    fuacct,   contestcode,   contestname, intialasset,0, curdate()  ) ;
# ttradenumstatistics 
  SET LINE = 78;
insert into  `ttradenumstatistics` (
  `Fs_clientid`,
  `Fs_name`,
  `fs_fuacct`,
  `Fs_raceid`,
  `Fs_racename`,
  `Fs_dailytradenum`,
  `Fs_weeklytradenum`,
  `Fs_monthlytradenum`,
  `Fs_totaltradenum`
) values  (   clientid,   clientname,    fuacct,   contestcode,   contestname,    0,0,0,0  ) ;
# ttradeamtstatistics
  SET LINE = 91;
insert into  `ttradeamtstatistics` (
  `Fs_clientid`,
  `Fs_name`,
  `fs_fuacct`,
  `Fs_raceid`,
  `Fs_racename`,
  `Fs_dailytradeamount`,
  `Fs_weeklytradeamount`,
  `Fs_monthlytradeamount`,
  `Fs_totaltradeamount`
)values  (    clientid,   clientname,    fuacct,   contestcode,   contestname,0,0,0,0  ) ;
 # tstatistics
   SET LINE = 104;
insert into  `tstatistics` (
  `Fs_raceid`,    `fs_fuacct`,  `Ft_date`,  `fd_preasset`,  `fd_hisweekprofit`,  `fd_weekprofit`,  `fd_hismonthprofit`,  `fd_monthprofit`,  
  `fd_todaymarketvalue`,  `fd_todaybal`,  `fd_todayprofit`,  `fd_hisweekamount`,  `fd_weekamount`,  `fd_hismonthamount`,  `fd_monthamount`,
  `fd_todayamount`,  `fi_hisweekfreq`,  `fi_weekfreq`,  `fi_hismonthfreq`,  `fi_monthfreq`,  `fi_todayfreq`
) 
values
  ( contestcode,fuacct,    CURDATE()  ,    intialasset,   0,    0,  0,    0,   0,    0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0  ) ;
 -- refresh
	
  END LOOP ;
  CLOSE cur ;
insert into  `tstatisticsdate` (  `fs_traceid`,  `ft_settledate`,  `ft_validdate`,  `fi_weekofyear`,  `fi_monthofyear`)
 values  (  contestcode,    '0',  CURDATE() , WEEKOFYEAR(CURDATE())  , DATE_FORMAT(CURDATE(),'%m')   ) ;
  COMMIT ;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
