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

/* Procedure structure for procedure `prod_分红配股转增` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_分红配股转增`(marketcode VARCHAR (32),
  traceid VARCHAR (32),
  stockcode VARCHAR (32),
  fenhong DECIMAL(18,2),
  song DECIMAL (18.2),
  zhuan DECIMAL (18.2),
  pei_amt DECIMAL (18,2),
  pei_price DECIMAL (18,2),
  OUT ret INT)
LABEL_PROC :
BEGIN
  DECLARE secacct VARCHAR (18) DEFAULT('') ;
  DECLARE call_ret INT (0) ;
  DECLARE fundacct VARCHAR (18) ;
  DECLARE contest INT (0) ;
  DECLARE contestcode VARCHAR (32) DEFAULT('') ;
  DECLARE holdamount INT DEFAULT(0);
  DECLARE done INT DEFAULT(FALSE) ;
  DECLARE msg VARCHAR (512) DEFAULT('') ;
  declare LINE int default(0);
  DECLARE cur CURSOR FOR 
  SELECT 
    t1.Fs_secacct,
    t1.Fs_stockcode ,t1.fi_holdamount
  FROM
    tptstock00 t1 
  WHERE t1.fs_marketcode = marketcode 
    AND t1.Fs_stockcode = stockcode ;
    
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE ;
  DECLARE exit HANDLER FOR SQLSTATE '42S02' BEGIN 
	ROLLBACK;
	SET ret = 1 ;
	SET msg = CONCAT(
	  'prod_分红配股转增 ',
	  ' secacct ',
	  secacct
	) ;
	SET msg = CONCAT(msg, ' stockcode ', stockcode) ;
	SET msg = CONCAT(msg, ' fundacct ', fundacct) ;
	SET msg = CONCAT(msg, ' LINE ', LINE) ;
	
	INSERT INTO `feps`.`terrorlog` (`Ft_occtime`, `Fs_errlog`) 
	VALUES  (NOW(), msg) ;
	COMMIT;
	
	END  ;
  
  set ret =0;
  OPEN cur ;
  read_loop :
  LOOP
    FETCH cur INTO secacct,
    stockcode,holdamount ;
    IF done 
    THEN LEAVE read_loop ;
    END IF ;
    CALL prod_get_fuacct_usage (
      secacct,
      call_ret,
      fundacct,
      contest,
      contestcode
    ) ;
    IF (call_ret != 0) 
	    THEN SET ret = 1 ;
	    ROLLBACK ;
	    set msg = "获取Fs_usagecode失败";
	    SET msg = CONCAT(msg, 'secacct,',secacct,' fundacct ', fundacct) ;
	    	INSERT INTO `feps`.`terrorlog` (`Ft_occtime`, `Fs_errlog`) 	VALUES  (NOW(), msg) ;
		COMMIT;
	    LEAVE read_loop ;
    ELSEIF ISNULL (contestcode) 
	    THEN ITERATE read_loop ;
    END IF ;
    IF (contestcode = traceid) -- 股票持仓及资金调整
    THEN 
 	    #call `prod_股票持仓及资金调整`(marketcode ,stockcode,type ,price ,price1 , secacct  , fundacct ,holdamount  , call_ret );
 	    
 	    IF (fenhong !=0) THEN
		CALL prod_股票持仓及资金调整(marketcode ,stockcode,1 ,0 ,fenhong , secacct  , fundacct ,holdamount  , call_ret );
		SET LINE = 94;
		CALL log_exit(call_ret);
 	    END IF;
 	    IF (song !=0) THEN
		CALL prod_股票持仓及资金调整(marketcode ,stockcode,0 ,song ,0 , secacct  , fundacct ,holdamount  , call_ret );
		SET LINE = 98;
		CALL log_exit(call_ret);
 	    END IF;
 	    
	    IF (zhuan !=0) THEN
		CALL prod_股票持仓及资金调整(marketcode ,stockcode,4 ,zhuan ,0 , secacct  , fundacct ,holdamount  , call_ret );
		set LINE = 103;
		CALL log_exit(call_ret);
 	    END IF;
 	    
 	    IF (  pei_amt !=0 AND   pei_price != 0) THEN
 	    #select marketcode ,stockcode,3 ,pei_amt ,pei_price , secacct  , fundacct ,holdamount  , call_ret;
		CALL prod_股票持仓及资金调整(marketcode ,stockcode,3 ,pei_amt ,pei_price , secacct  , fundacct ,holdamount  , call_ret );
		SET LINE = 111;
		CALL log_exit(call_ret);
 	    END IF;
 
    ELSE 
	ITERATE read_loop ;
    END IF ;
  END LOOP ;
  CLOSE cur ;
  -- DROP TEMPORARY TABLE IF EXISTS tmp_tStockHoldAmt ;
  COMMIT ;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
