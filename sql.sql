/*
SQLyog Ultimate v11.25 (64 bit)
MySQL - 5.7.40-log : Database - bank-system
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`bank-system` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `bank-system`;

/*Table structure for table `administrator` */

DROP TABLE IF EXISTS `administrator`;

CREATE TABLE `administrator` (
  `administrator_id` int(11) NOT NULL AUTO_INCREMENT,
  `administrator_name` varchar(255) NOT NULL,
  `administrator_password` varchar(255) NOT NULL,
  PRIMARY KEY (`administrator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `administrator` */

insert  into `administrator`(`administrator_id`,`administrator_name`,`administrator_password`) values (1,'wzw','123456');

/*Table structure for table `announcements` */

DROP TABLE IF EXISTS `announcements`;

CREATE TABLE `announcements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `author` varchar(100) DEFAULT NULL,
  `published_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `announcements` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `user_name` char(80) NOT NULL COMMENT '用户名',
  `pass_word` char(80) NOT NULL COMMENT '用户密码',
  `balance` double DEFAULT '0' COMMENT '用户余额',
  `phone_number` char(80) DEFAULT '0' COMMENT '用户手机号',
  `is_deleted` tinyint(3) NOT NULL DEFAULT '0',
  `file_url` varchar(256) COMMENT '用户头像地址',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`user_id`,`user_name`,`pass_word`,`balance`,`phone_number`,`is_deleted`) values (1,'wzw','e10adc3949ba59abbe56e057f20f883e',100,'123',0),(2,'www','e10adc3949ba59abbe56e057f20f883e',300,'18870334744',0),(3,'bobo','e10adc3949ba59abbe56e057f20f883e',100,'11111111111',0),(4,'tgp','e10adc3949ba59abbe56e057f20f883e',100000000000100,'13870653271',0);

/*Table structure for table `user_transaction` */

DROP TABLE IF EXISTS `user_transaction`;

CREATE TABLE `user_transaction` (
  `transaction_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_operation` varchar(255) DEFAULT NULL,
  `operation_time` datetime DEFAULT NULL,
  `operation_amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_transaction` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
