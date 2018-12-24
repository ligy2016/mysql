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

/* Procedure structure for procedure `ygtest` */

/*!50003 DROP PROCEDURE IF EXISTS  `ygtest` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ygtest`()
BEGIN	
	#定义异常条件
	DECLARE _err CHAR(1) DEFAULT("0");
	DECLARE _errmsg VARCHAR(1024) DEFAULT("");
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION,SQLWARNING,NOT FOUND 
		BEGIN
			/*GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT, @p3 = MYSQL_ERRNO, @p4 = CONSTRAINT_CATALOG, @p5 = CONSTRAINT_SCHEMA,
				@p6 = CONSTRAINT_NAME, @p7 = CATALOG_NAME, @p8 = SCHEMA_NAME, @p9 = TABLE_NAME, @p10 = COLUMN_NAME, @p11 = CURSOR_NAME;
			SELECT @p1,@p2,@p3,@p4,@p5,@p6,@p7,@p8,@p9,@p10,@p11;*/
			GET DIAGNOSTICS CONDITION 1 _errmsg = MESSAGE_TEXT;
			SET _err = '1';
			ROLLBACK;
		END;

	SELECT fs_clientid, fs_usagecode, sum(fi_score)/sum(fd_nums) FROM tscorestockrisk GROUP BY fs_clientid, fs_usagecode;

	
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
