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

/* Procedure structure for procedure `unit_test_creat_user` */

DELIMITER $$

/*!50003 CREATE DEFINER=`qlqqmn`@`%` PROCEDURE `unit_test_creat_user`(testclientid INT)
BEGIN
DECLARE id VARCHAR(18);
DECLARE sec_qq VARCHAR(18);
DECLARE fund_qq VARCHAR(18);
DECLARE sec_gp VARCHAR(18);
DECLARE fund_gp VARCHAR(18);
SET id = CONCAT ('test_',testclientid);
SET sec_qq = CONCAT ('test_qq_',testclientid);
SET sec_gp = CONCAT ('test_gp_',testclientid);
SET fund_qq = CONCAT ('test_qq_',testclientid);
SET fund_gp = CONCAT ('test_gp_',testclientid);
INSERT INTO tcusecacct VALUES (sec_qq, id,4,fund_qq,sec_gp,0,'');
INSERT INTO tcusecacct VALUES (sec_gp, id,2,fund_gp,sec_qq,0,'');
INSERT INTO tcasub2balance VALUES (fund_qq, 1,1000000,1000000,0,0,0,0,0,0,0,'test',1000000,0);
INSERT INTO tcasub2balance VALUES (fund_gp, 1,1000000,1000000,0,0,0,0,0,0,0,'test',1000000,0);
INSERT INTO tcasub3balance VALUES( fund_qq,1,1,1000000,1000000,1000000,'test');
INSERT INTO tcasub3balance VALUES( fund_qq,1,2,0,0,0,'test');
INSERT INTO tcasub3balance VALUES( fund_qq,1,3,0,0,0,'test');
INSERT INTO tcasub3balance VALUES( fund_qq,1,4,0,0,0,'test');
INSERT INTO tcasub3balance VALUES( fund_gp,1,1,1000000,1000000,1000000,'test');
INSERT INTO tcasub3balance VALUES( fund_gp,1,2,0,0,0,'test');
INSERT INTO tcasub3balance VALUES( fund_gp,1,3,0,0,0,'test');
INSERT INTO tcasub3balance VALUES( fund_gp,1,4,0,0,0,'test');
COMMIT;
#委托下单`prod_szqq_338011`(IN `op_branch_no` CHAR(5),IN `op_entrust_way` CHAR(1),IN `op_station` VARCHAR(255),IN `branch_no` CHAR(5),IN `client_id` CHAR(18),IN `fund_account` CHAR(18),IN `password` CHAR(15),IN `password_type` CHAR(1),IN `user_token` VARCHAR(512),IN `asset_prop` CHAR(1),IN `exchange_type` CHAR(4),IN `option_account` CHAR(13),IN `option_code` CHAR(8),IN `entrust_amount` CHAR(11),IN `opt_entrust_price` CHAR(11),IN `entrust_bs` CHAR(1),IN `entrust_oc` CHAR(1),IN `covered_flag` CHAR(1),IN `entrust_prop` CHAR(3),IN `batch_no` CHAR(8))
#SELECT * FROM trqoptentrust00 WHERE Fs_secacct = sec_qq ;
#成交：`prod_szqq_500007`(IN `entrustsecno` char(11),IN `optbusinessprice` char(15),IN `businessamount` char(11),IN `entruststatus` char(1))
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
