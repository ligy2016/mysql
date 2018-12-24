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

/* Procedure structure for procedure `comscore-stock-userscore` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `comscore-stock-userscore`()
LABEL_PROC:
BEGIN
##
   #创建统计个人各个指标分数表
	 #comscore-stock-userscore
#



INSERT INTO rankscores
	SELECT tem.clientid,tem.raceid,avg(ifnull( cast(tem.selectscore AS SIGNED ), 0 )) AS selectstockscore,avg(ifnull( cast(tem.sellscore AS SIGNED ), 0 )) AS sellscore,
avg(ifnull( cast(tem.profitscore AS SIGNED ), 0 )) AS profitscore,avg(ifnull( cast(tem.riskscore AS SIGNED ), 0 )) AS riskscore,
(avg(ifnull( cast(tem.selectscore AS SIGNED ), 0 ))*0.15+avg(ifnull( cast(tem.sellscore AS SIGNED ), 0 ))*0.15+avg(ifnull( cast(tem.profitscore AS SIGNED ), 0 ))*0.55+avg(ifnull( cast(tem.riskscore AS SIGNED ), 0 ))*0.15)AS overalscore
 FROM 
(
SELECT a.fs_clientid AS clientid,a.fs_usagecode AS raceid,a.fi_score AS selectscore,b.fi_score AS sellscore,c.fi_ratio AS profitscore,d.fi_score AS riskscore 
FROM tscorestockselect a
LEFT  JOIN tscorestocksell b ON a.fs_clientid = b.fs_clientid AND  a.fs_usagecode  = b.fs_usagecode 
LEFT JOIN  tscorestockprofit c ON a.fs_clientid = c.fs_clientid AND  a.fs_usagecode  = c.fs_usagecode 
LEFT JOIN  tscorestockrisk d ON a.fs_clientid = d.fs_clientid AND  a.fs_usagecode  = d.fs_usagecode 
) tem GROUP BY tem.clientid,tem.raceid;

COMMIT;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
