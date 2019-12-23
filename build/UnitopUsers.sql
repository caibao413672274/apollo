/*
Navicat MySQL Data Transfer

Source Server         : 测试mysql
Source Server Version : 80012
Source Host           : 10.1.5.61:3306
Source Database       : ApolloPortalDB

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2019-10-11 10:57:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for UnitopUsers
-- ----------------------------
DROP TABLE IF EXISTS `UnitopUsers`;
CREATE TABLE `UnitopUsers` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `userId` varchar(50) NOT NULL,
  `userName` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `orgNo` varchar(50) DEFAULT NULL,
  `orgName` varchar(100) DEFAULT NULL,
  `stationNo` varchar(50) DEFAULT NULL,
  `stationName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_userId` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
