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

/* Procedure structure for procedure `prod_stock_change_position` */

/*!50003 DROP PROCEDURE IF EXISTS  `prod_stock_change_position` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `prod_stock_change_position`(IN `type` int,IN `marketcode` varchar(32),IN `secacct` varchar(18),IN `stockcode` char(6),IN `stocktype` varchar(4))
BEGIN
	##名称
		#prod_stock_change_position
	##作用
		#修改股票持仓
	##参数说明
		#IN `type` int,IN `marketcode` varchar(32),IN `secacct` varchar(18),IN `stockcode` char(6),IN `stocktype` varchar(4)
		#type：（0买入成交，1卖出委托，2卖出成交，3卖出撤单)
	##主体
	IF (type = 0)THEN
		set @test = 0;
	ELSEIF(type = 1)THEN
		set @test = 0;
	ELSEIF(type = 2)THEN
		set @test = 0;
	ELSEIF(type = 3)THEN
		set @test = 0;
	END IF;

END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
