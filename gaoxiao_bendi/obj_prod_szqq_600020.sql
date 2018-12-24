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

/* Procedure structure for procedure `prod_szqq_600020` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_szqq_600020` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_szqq_600020`(gtcode int,tradedate varchar(20))
LABEL_PROC:
begin
 # SELECT Fs_exedate,Fs_deldate INTO @tmpexedate,@tmpdeldate FROM tmkstatus WHERE Fs_marketcode = marketcode ;
  if(tradedate != "") THEN
      UPDATE tctstatus set Fs_settdate = tradedate where Fi_countercode = gtcode ;
  end if;
  
	commit;
  
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
