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

/* Procedure structure for procedure `prod_szqq_500016` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `prod_szqq_500016`(marketcode varchar(32),trddate varchar(20),
nexttrddate varchar(20),status varchar(20))
LABEL_PROC:
begin
	DECLARE sta int DEFAULT 0;
	DECLARE substa int DEFAULT 0;
	SELECT fi_status,fi_substatus into sta,substa from tmkstatus where Fs_marketcode = marketcode ;
	if (status = 0) then
		if(sta = 6 AND substa = 99 ) THEN
			UPDATE tmkstatus set Fs_mkdate = trddate,Fs_nexttrddate= nexttrddate,fi_status = status, fi_substatus = 0 where Fs_marketcode = marketcode;
		END IF;
	ELSEIF(status = 6) THEN
		if(sta = 0) THEN
			UPDATE tmkstatus SET fi_status = status, fi_substatus = 0 where Fs_marketcode = marketcode;
		END IF;
		if(sta = 5) THEN
			UPDATE tmkstatus SET fi_status = status, fi_substatus = 0 where Fs_marketcode = marketcode;
		END IF;
	ELSEIF(status = 5) THEN
		if(sta = 0) THEN
			UPDATE tmkstatus SET fi_status = status, fi_substatus = 0 where Fs_marketcode = marketcode;
		END IF;
	END IF;
  
	if(marketcode = '0' or marketcode = '1')then
		SELECT fi_status, fi_substatus into @ctsta1, @ctsubsta1 from tctstatus where Fi_countercode = 1;
		if(status = 0)then
			if(@ctsta1 = 6 AND @ctsubsta1 = 99 ) THEN
				UPDATE tctstatus SET Fs_settdate = trddate, fi_status = status, fi_substatus = 0 where Fi_countercode = 1;
			end if;
		end if;
		if(status = 6 AND @ctsta1 = 0)then
			UPDATE tctstatus SET Fs_settdate = trddate, fi_status = status, fi_substatus = 0 where Fi_countercode = 1;
		end if;
	end if;
	if(marketcode = '27' or marketcode = '31')then
		SELECT fi_status, fi_substatus into @ctsta2, @ctsubsta2 from tctstatus where Fi_countercode = 2;
		if(status = 0)then
			if(@ctsta2 = 6 AND @ctsubsta2 = 99 ) THEN
				UPDATE tctstatus SET Fs_settdate = trddate, fi_status = status, fi_substatus = 0 where Fi_countercode = 2;
			end if;
		end if;
		if(status = 6 AND @ctsta2 = 0)then
			UPDATE tctstatus SET Fs_settdate = trddate, fi_status = status, fi_substatus = 0 where Fi_countercode = 2;
		end if;
	end if;

  SELECT sta,fi_status from tmkstatus where Fs_marketcode = marketcode;
	commit;
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
