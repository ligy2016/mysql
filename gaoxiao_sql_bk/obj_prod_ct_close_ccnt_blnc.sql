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

/* Procedure structure for procedure `prod_ct_close_ccnt_blnc` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_ct_close_ccnt_blnc` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_ct_close_ccnt_blnc`(IN `fuaccttype` int,IN `settdate` char(8))
LABEL_PROC:
BEGIN
	##名称
		#prod_ct_close_ccnt_blnc
	##作用
		#柜台结资金
		#按照资金类型结资金（建议：感觉一个资金类型一套资金表或者一个柜台一套资金表合理一些）
	##参数说明
		#IN `fuaccttype` int,IN `settdate` char(8)
		#fuaccttype：资金类型
		#settdate：清算日期
	##主体

##结2级账户历史
	#更新期末数据
	UPDATE tcasub2balance SET Fd_CloseBal = Fd_TotalBal,
														Fd_CloseAvalBal = Fd_AvalBal,
														Fd_CloseOutBal = Fd_OutBal
												WHERE fs_fuacct IN (SELECT fs_fuacct FROM tcufuacct WHERE Fi_fuaccttype = fuaccttype);
	#插入历史
	#余额
	INSERT INTO tcahissub2balance 
		SELECT t1.*,settdate FROM tcasub2balance t1, tcufuacct t2 WHERE t1.fs_fuacct = t2.fs_fuacct AND t2.Fi_fuaccttype = fuaccttype;
	#明细
	INSERT INTO tcahissub2aclist
		SELECT t1.*,settdate FROM tcasub2aclist t1, tcufuacct t2 WHERE t1.fs_fuacct = t2.fs_fuacct AND t2.Fi_fuaccttype = fuaccttype;
	#删除明细
	DELETE t1 from tcasub2aclist t1, tcufuacct t2 WHERE t1.fs_fuacct = t2.fs_fuacct AND t2.Fi_fuaccttype = fuaccttype;
	#更新期初数据
	UPDATE tcasub2balance SET Fd_OutBal = Fd_AvalBal, 
														Fd_OpenBal = Fd_CloseBal, 
														Fd_OpenAvalBal = Fd_CloseAvalBal,
														Fd_OpenOutBal = Fd_OpenAvalBal
												WHERE fs_fuacct IN (SELECT fs_fuacct FROM tcufuacct WHERE Fi_fuaccttype = fuaccttype);
	
##结3级账历史
	#更新期末数据
	UPDATE tcasub3balance SET Fd_CloseBal = Fd_Balance
												WHERE fs_fuacct IN (SELECT fs_fuacct FROM tcufuacct WHERE Fi_fuaccttype = fuaccttype);
	#插入历史
	#余额
	INSERT INTO tcahissub3balance 
		SELECT t1.*,settdate FROM tcasub3balance t1, tcufuacct t2 WHERE t1.fs_fuacct = t2.fs_fuacct AND t2.Fi_fuaccttype = fuaccttype;
	#明细
	INSERT INTO tcahissub3aclist
		SELECT t1.*,settdate FROM tcasub3aclist t1, tcufuacct t2 WHERE t1.fs_fuacct = t2.fs_fuacct AND t2.Fi_fuaccttype = fuaccttype;	
	#删除明细
	DELETE t1 from tcasub3aclist t1, tcufuacct t2 WHERE t1.fs_fuacct = t2.fs_fuacct AND t2.Fi_fuaccttype = fuaccttype;
	#更新期初数据
	UPDATE tcasub3balance SET Fd_OpenBal = Fd_CloseBal
												WHERE fs_fuacct IN (SELECT fs_fuacct FROM tcufuacct WHERE Fi_fuaccttype = fuaccttype);

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
