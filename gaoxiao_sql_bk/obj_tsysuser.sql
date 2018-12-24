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

/*Table structure for table `tsysuser` */

CREATE TABLE `tsysuser` (
  `fs_id` varchar(32) NOT NULL COMMENT '用户标示',
  `fs_username` varchar(32) NOT NULL COMMENT '用户登陆名称',
  `fs_realname` varchar(32) NOT NULL COMMENT '用户真实姓名',
  `Fs_pwd` varchar(64) NOT NULL COMMENT '用户登陆密码',
  `fi_status` int(11) NOT NULL COMMENT '状态0-注销 1-正常 2-冻结',
  `Fs_tel` varchar(32) DEFAULT NULL COMMENT '用户手机号',
  `Fs_founder` varchar(32) DEFAULT NULL COMMENT '创建人id',
  `Fs_dep` varchar(32) DEFAULT NULL COMMENT '所属机构',
  `Fs_type` varchar(2) DEFAULT NULL COMMENT '账号类型:1:学校账号 2：机构账号3；超级管理员',
  `Ft_createtime` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `Fs_sex` varchar(2) DEFAULT NULL COMMENT '性别:0-男1-女',
  `Fs_serialnumber` varchar(32) DEFAULT NULL COMMENT '身份证号',
  PRIMARY KEY (`fs_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
