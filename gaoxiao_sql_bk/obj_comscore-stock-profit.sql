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

/* Procedure structure for procedure `comscore-stock-profit` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `comscore-stock-profit`()
LABEL_PROC:
BEGIN
##名称
	#综合评分-股票-盈利能力
	#comscore-stock-profit
##作用
	#综合评分-股票-盈利能力
	#每天日结执行一次，更新当日盈利分数数据。
	#不允许重复执行
##参数说明

DELETE FROM tscorestockprofit;

INSERT INTO tscorestockprofit
	SELECT t1.Fs_clientid, t1.Fs_usagecode, (SUM(t4.Fd_marketvalue)+avg(t2.Fd_TotalBal))/avg(t0.Fd_intialasset)-1 
	FROM trace t0, tcufuacct t1, tcasub2balance t2, tcusecacct t3, tptstock00 t4 
	WHERE t0.Fs_id = t1.Fs_usagecode AND t1.fs_fuacct = t2.fs_fuacct AND t1.fs_fuacct = t3.fs_fuacct AND t3.Fs_secacct = t4.Fs_secacct
	GROUP BY t1.Fs_clientid, t1.Fs_usagecode;

COMMIT;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
