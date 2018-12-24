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

/* Procedure structure for procedure `prod_insert_stockcode_copy` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_insert_stockcode_copy` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_insert_stockcode_copy`(marketcode          varchar(32),
kindcode          varchar(32),						stockcode           char(6),
						stocktype           varchar(4),
						substocktype        varchar(4),
						stockname           varchar(32),
						currency            varchar(4),
						buyunit             int,
						pricestep           int,
						storeunit           int,
						upprice             decimal(14,3),
						downprice           decimal(14,3),
						highamount          int,
						lowamount           int,
						highbalance         decimal(18,2),
						lowbalance          decimal(18,2),
						stockrealback       char(1),
						fundrealback        char(1),
						delistflag          char(1),
						delistdate          char(8),
						parvalue            decimal(15,4),
						stbtranstype        char(1),
						stbtransstatus      char(1),
						exdividendflag      char(1),
						marketmakeramount   int,
						stkcodestatus       char(1),
						stkcodectrlstr      varchar(32),
						closeprice          decimal(15,4), 
						openprice           decimal(15,4), 
						mkdate              char(8),commitFlag char(1))
BEGIN
	insert into tcmstockcode00 values(
					marketcode       ,
					kindcode       ,  
					stockcode        ,  
					stocktype        ,  
					substocktype     ,  
					stockname        ,  
					currency         ,  
					buyunit          ,  
					pricestep        ,  
					storeunit        ,  
					upprice          ,  
					downprice        ,  
					highamount       ,  
					lowamount        ,  
					highbalance      ,  
					lowbalance       ,  
					stockrealback    ,  
					fundrealback     ,  
					delistflag       ,  
					delistdate       ,  
					parvalue         ,  
					stbtranstype     ,  
					stbtransstatus   ,  
					exdividendflag   ,  
					marketmakeramount,  
					stkcodestatus    ,  
					stkcodectrlstr   ,  
					closeprice       ,  
					openprice        ,  
					mkdate)
	ON DUPLICATE KEY UPDATE    
				Fs_marketcode       =marketcode       ,
				Fs_kindcode         =kindcode         ,  
				Fs_stockcode        =stockcode        ,  
				Fs_stocktype        =stocktype        ,  
				Fs_substocktype     =substocktype     ,  
				Fs_stockname        =stockname        ,  
				Fs_currency         =currency         ,  
				Fi_buyunit          =buyunit          ,  
				Fi_pricestep        =pricestep        ,  
				Fi_storeunit        =storeunit        ,  
				Fd_upprice          =upprice          ,  
				Fd_downprice        =downprice        ,  
				Fi_highamount       =highamount       ,  
				Fi_lowamount        =lowamount        ,  
				Fd_highbalance      =highbalance      ,  
				Fd_lowbalance       =lowbalance       ,  
				Fs_stockrealback    =stockrealback    ,  
				Fs_fundrealback     =fundrealback     ,  
				Fs_delistflag       =delistflag       ,  
				Fs_delistdate       =delistdate       ,  
				Fd_parvalue         =parvalue         ,  
				Fs_stbtranstype     =stbtranstype     ,  
				Fs_stbtransstatus   =stbtransstatus   ,  
				Fs_exdividendflag   =exdividendflag   ,  
				Fi_marketmakeramount=marketmakeramount,  
				Fs_stkcodestatus    =stkcodestatus    ,  
				Fs_stkcodectrlstr   =stkcodectrlstr   ,  
				Fd_closeprice       =closeprice       ,  
				Fd_openprice        =openprice        ,  
				Fs_mkdate           =mkdate;

  IF(commitFlag = '1') THEN
		commit;
  END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
