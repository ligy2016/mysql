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

/*Table structure for table `tedustudenttoken` */

DROP TABLE IF EXISTS `tedustudenttoken`;

CREATE TABLE `tedustudenttoken` (
  `Fs_UserId` varchar(32) NOT NULL COMMENT '用户ID',
  `Fs_Token` varchar(64) NOT NULL COMMENT '令牌',
  `Fl_Status` int(11) NOT NULL COMMENT '状态:0-无效 1-有效',
  `Ft_ApplyTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '申请时间',
  `Fs_ApplyHost` varchar(64) DEFAULT NULL COMMENT '申请主机IP',
  `Ft_CancelTime` timestamp NULL DEFAULT NULL COMMENT '注销时间',
  `Fi_CancelMode` int(11) DEFAULT NULL COMMENT '注销模式:0-自动 1-强制 当点击右上角退出时注销模式为自动，修改status为0 该字段为1，当直接关闭窗口时在第二次登录时发现该用户有令牌为有效状态时先更更为无效，该 自动为0，并重新生成新的TOKEN',
  `Fs_BusData` text COMMENT '是否允许跨域授课:登录时返回的业务数据内容',
  `Fs_Type` int(10) DEFAULT NULL COMMENT '0-学生登陆 1-教师登陆'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='授权信息记录';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
