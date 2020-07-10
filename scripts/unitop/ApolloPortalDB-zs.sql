/*
Navicat MySQL Data Transfer

Source Server         : job备库
Source Server Version : 80012
Source Host           : 10.1.7.10:3306
Source Database       : ApolloPortalDB

Target Server Type    : MYSQL
Target Server Version : 80012
File Encoding         : 65001

Date: 2020-07-10 15:12:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for App
-- ----------------------------
DROP TABLE IF EXISTS `App`;
CREATE TABLE `App` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_Name` (`Name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用表';

-- ----------------------------
-- Records of App
-- ----------------------------
INSERT INTO `App` VALUES ('1', 'jobplatform', 'Job调度平台', 'UT01602', 'IT架构部', '0002551', 'caizhaoquan@uni-top.com', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-10 14:43:26');
INSERT INTO `App` VALUES ('4', 'unitopsso', '统一登陆系统', 'UT01602', 'IT架构部', '0002551', 'caizhaoquan@uni-top.com', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `App` VALUES ('5', '10000001', '雅典娜承包区算费', 'UT01602', 'IT架构部', '0002551', 'caizhaoquan@uni-top.com', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `App` VALUES ('6', '10000002', 'Demo应用', 'UT01602', 'IT架构部', '0002551', 'caizhaoquan@uni-top.com', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `App` VALUES ('7', '100003173', '配置中心管理', 'UT01602', 'IT架构部', '0002551', 'caizhaoquan@uni-top.com', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');

-- ----------------------------
-- Table structure for AppNamespace
-- ----------------------------
DROP TABLE IF EXISTS `AppNamespace`;
CREATE TABLE `AppNamespace` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `Name` varchar(32) NOT NULL DEFAULT '' COMMENT 'namespace名字，注意，需要全局唯一',
  `AppId` varchar(32) NOT NULL DEFAULT '' COMMENT 'app id',
  `Format` varchar(32) NOT NULL DEFAULT 'properties' COMMENT 'namespace的format类型',
  `IsPublic` bit(1) NOT NULL DEFAULT b'0' COMMENT 'namespace是否为公共',
  `Comment` varchar(64) NOT NULL DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_AppId` (`AppId`),
  KEY `Name_AppId` (`Name`,`AppId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用namespace定义';

-- ----------------------------
-- Records of AppNamespace
-- ----------------------------
INSERT INTO `AppNamespace` VALUES ('1', 'application', 'jobplatform', 'properties', '\0', 'default app namespace', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `AppNamespace` VALUES ('4', 'application', 'unitopsso', 'properties', '\0', 'default app namespace', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `AppNamespace` VALUES ('5', 'application', '10000001', 'properties', '\0', 'default app namespace', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `AppNamespace` VALUES ('6', 'jobPrivate', 'jobplatform', 'properties', '\0', 'Job私有配置', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `AppNamespace` VALUES ('7', 'application', '10000002', 'properties', '\0', 'default app namespace', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `AppNamespace` VALUES ('8', 'application', '100003173', 'properties', '\0', 'default app namespace', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `AppNamespace` VALUES ('9', 'redis', '100003173', 'properties', '\0', 'Redis配置', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `AppNamespace` VALUES ('10', 'redis', 'jobplatform', 'properties', '\0', '', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:47', '蔡昭全(0002551)', '2019-10-14 11:14:47');
INSERT INTO `AppNamespace` VALUES ('11', 'redis', 'unitopsso', 'properties', '\0', '', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');

-- ----------------------------
-- Table structure for Authorities
-- ----------------------------
DROP TABLE IF EXISTS `Authorities`;
CREATE TABLE `Authorities` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(50) NOT NULL,
  `Authority` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of Authorities
-- ----------------------------
INSERT INTO `Authorities` VALUES ('1', 'apollo', 'ROLE_user');

-- ----------------------------
-- Table structure for Consumer
-- ----------------------------
DROP TABLE IF EXISTS `Consumer`;
CREATE TABLE `Consumer` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Name` varchar(500) NOT NULL DEFAULT 'default' COMMENT '应用名',
  `OrgId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '部门Id',
  `OrgName` varchar(64) NOT NULL DEFAULT 'default' COMMENT '部门名字',
  `OwnerName` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerName',
  `OwnerEmail` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'ownerEmail',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='开放API消费者';

-- ----------------------------
-- Records of Consumer
-- ----------------------------

-- ----------------------------
-- Table structure for ConsumerAudit
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerAudit`;
CREATE TABLE `ConsumerAudit` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `Uri` varchar(1024) NOT NULL DEFAULT '' COMMENT '访问的Uri',
  `Method` varchar(16) NOT NULL DEFAULT '' COMMENT '访问的Method',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_ConsumerId` (`ConsumerId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='consumer审计表';

-- ----------------------------
-- Records of ConsumerAudit
-- ----------------------------

-- ----------------------------
-- Table structure for ConsumerRole
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerRole`;
CREATE TABLE `ConsumerRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'Consumer Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_ConsumerId_RoleId` (`ConsumerId`,`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='consumer和role的绑定表';

-- ----------------------------
-- Records of ConsumerRole
-- ----------------------------

-- ----------------------------
-- Table structure for ConsumerToken
-- ----------------------------
DROP TABLE IF EXISTS `ConsumerToken`;
CREATE TABLE `ConsumerToken` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `ConsumerId` int(11) unsigned DEFAULT NULL COMMENT 'ConsumerId',
  `Token` varchar(128) NOT NULL DEFAULT '' COMMENT 'token',
  `Expires` datetime NOT NULL DEFAULT '2099-01-01 00:00:00' COMMENT 'token失效时间',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  UNIQUE KEY `IX_Token` (`Token`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='consumer token表';

-- ----------------------------
-- Records of ConsumerToken
-- ----------------------------

-- ----------------------------
-- Table structure for Favorite
-- ----------------------------
DROP TABLE IF EXISTS `Favorite`;
CREATE TABLE `Favorite` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `UserId` varchar(32) NOT NULL DEFAULT 'default' COMMENT '收藏的用户',
  `AppId` varchar(500) NOT NULL DEFAULT 'default' COMMENT 'AppID',
  `Position` int(32) NOT NULL DEFAULT '10000' COMMENT '收藏顺序',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `AppId` (`AppId`(191)),
  KEY `IX_UserId` (`UserId`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='应用收藏表';

-- ----------------------------
-- Records of Favorite
-- ----------------------------
INSERT INTO `Favorite` VALUES ('23', '0024835', 'jobplatform', '10000', '', '0024835', '2019-10-09 17:01:01', '0024835', '2019-10-09 17:07:40');

-- ----------------------------
-- Table structure for Permission
-- ----------------------------
DROP TABLE IF EXISTS `Permission`;
CREATE TABLE `Permission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `PermissionType` varchar(32) NOT NULL DEFAULT '' COMMENT '权限类型',
  `TargetId` varchar(256) NOT NULL DEFAULT '' COMMENT '权限对象类型',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_TargetId_PermissionType` (`TargetId`(191),`PermissionType`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='permission表';

-- ----------------------------
-- Records of Permission
-- ----------------------------
INSERT INTO `Permission` VALUES ('1', 'CreateCluster', 'jobplatform', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `Permission` VALUES ('2', 'CreateNamespace', 'jobplatform', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `Permission` VALUES ('3', 'AssignRole', 'jobplatform', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `Permission` VALUES ('4', 'ModifyNamespace', 'jobplatform+application', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Permission` VALUES ('5', 'ReleaseNamespace', 'jobplatform+application', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Permission` VALUES ('6', 'LookUpNamespace', 'jobplatform+application+DEV', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Permission` VALUES ('7', 'ModifyNamespace', 'jobplatform+application+DEV', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Permission` VALUES ('8', 'ReleaseNamespace', 'jobplatform+application+DEV', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Permission` VALUES ('9', 'LookUpNamespace', 'jobplatform+application', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Permission` VALUES ('27', 'CreateCluster', 'unitopsso', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('28', 'CreateNamespace', 'unitopsso', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('29', 'AssignRole', 'unitopsso', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('30', 'LookUpNamespace', 'unitopsso+application', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('31', 'ModifyNamespace', 'unitopsso+application', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('32', 'ReleaseNamespace', 'unitopsso+application', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('33', 'LookUpNamespace', 'unitopsso+application+DEV', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('34', 'ModifyNamespace', 'unitopsso+application+DEV', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('35', 'ReleaseNamespace', 'unitopsso+application+DEV', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Permission` VALUES ('36', 'CreateCluster', '10000001', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('37', 'CreateNamespace', '10000001', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('38', 'AssignRole', '10000001', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('39', 'LookUpNamespace', '10000001+application', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('40', 'ModifyNamespace', '10000001+application', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('41', 'ReleaseNamespace', '10000001+application', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('42', 'LookUpNamespace', '10000001+application+DEV', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('43', 'ModifyNamespace', '10000001+application+DEV', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('44', 'ReleaseNamespace', '10000001+application+DEV', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Permission` VALUES ('45', 'CreateApplication', 'SystemRole', '\0', 'apollo', '2019-10-10 12:52:05', 'apollo', '2019-10-10 12:52:05');
INSERT INTO `Permission` VALUES ('46', 'ModifyNamespace', 'jobplatform+jobPrivate', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `Permission` VALUES ('47', 'ReleaseNamespace', 'jobplatform+jobPrivate', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `Permission` VALUES ('48', 'LookUpNamespace', 'jobplatform+jobPrivate+DEV', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Permission` VALUES ('49', 'ModifyNamespace', 'jobplatform+jobPrivate+DEV', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Permission` VALUES ('50', 'ReleaseNamespace', 'jobplatform+jobPrivate+DEV', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Permission` VALUES ('51', 'LookUpNamespace', 'jobplatform+jobPrivate', '', '0002551', '2019-10-09 16:40:14', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `Permission` VALUES ('52', 'AssignRole', '10000002', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('53', 'CreateCluster', '10000002', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('54', 'CreateNamespace', '10000002', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('55', 'ManageAppMaster', '10000002', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('56', 'LookUpNamespace', '10000002+application', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('57', 'ModifyNamespace', '10000002+application', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('58', 'ReleaseNamespace', '10000002+application', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('59', 'LookUpNamespace', '10000002+application+DEV', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('60', 'ModifyNamespace', '10000002+application+DEV', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('61', 'ReleaseNamespace', '10000002+application+DEV', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Permission` VALUES ('62', 'LookUpNamespace', 'jobplatform+application+PRO', '\0', '0002551', '2019-10-11 08:57:46', '0002551', '2019-10-11 08:57:46');
INSERT INTO `Permission` VALUES ('63', 'ModifyNamespace', 'jobplatform+application+PRO', '\0', '0002551', '2019-10-11 08:57:46', '0002551', '2019-10-11 08:57:46');
INSERT INTO `Permission` VALUES ('64', 'ReleaseNamespace', 'jobplatform+application+PRO', '\0', '0002551', '2019-10-11 08:57:47', '0002551', '2019-10-11 08:57:47');
INSERT INTO `Permission` VALUES ('65', 'LookUpNamespace', 'jobplatform+jobPrivate+PRO', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `Permission` VALUES ('66', 'ModifyNamespace', 'jobplatform+jobPrivate+PRO', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `Permission` VALUES ('67', 'ReleaseNamespace', 'jobplatform+jobPrivate+PRO', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `Permission` VALUES ('68', 'LookUpNamespace', '10000002+application+PRO', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `Permission` VALUES ('69', 'ModifyNamespace', '10000002+application+PRO', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `Permission` VALUES ('70', 'ReleaseNamespace', '10000002+application+PRO', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `Permission` VALUES ('71', 'CreateNamespace', '100003173', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('72', 'CreateCluster', '100003173', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('73', 'AssignRole', '100003173', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('74', 'ManageAppMaster', '100003173', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('75', 'LookUpNamespace', '100003173+application', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('76', 'ModifyNamespace', '100003173+application', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('77', 'ReleaseNamespace', '100003173+application', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('78', 'LookUpNamespace', '100003173+application+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('79', 'ModifyNamespace', '100003173+application+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('80', 'ReleaseNamespace', '100003173+application+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('81', 'LookUpNamespace', '100003173+application+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('82', 'ModifyNamespace', '100003173+application+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('83', 'ReleaseNamespace', '100003173+application+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Permission` VALUES ('84', 'LookUpNamespace', '100003173+redis', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('85', 'ModifyNamespace', '100003173+redis', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('86', 'ReleaseNamespace', '100003173+redis', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('87', 'LookUpNamespace', '100003173+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('88', 'ModifyNamespace', '100003173+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('89', 'ReleaseNamespace', '100003173+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('90', 'LookUpNamespace', '100003173+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('91', 'ModifyNamespace', '100003173+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('92', 'ReleaseNamespace', '100003173+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Permission` VALUES ('93', 'LookUpNamespace', 'jobplatform+redis', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('94', 'ModifyNamespace', 'jobplatform+redis', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('95', 'ReleaseNamespace', 'jobplatform+redis', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('96', 'LookUpNamespace', 'jobplatform+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('97', 'ModifyNamespace', 'jobplatform+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('98', 'ReleaseNamespace', 'jobplatform+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('99', 'LookUpNamespace', 'jobplatform+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('100', 'ModifyNamespace', 'jobplatform+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('101', 'ReleaseNamespace', 'jobplatform+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Permission` VALUES ('102', 'LookUpNamespace', 'unitopsso+redis', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('103', 'ModifyNamespace', 'unitopsso+redis', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('104', 'ReleaseNamespace', 'unitopsso+redis', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('105', 'LookUpNamespace', 'unitopsso+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('106', 'ModifyNamespace', 'unitopsso+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('107', 'ReleaseNamespace', 'unitopsso+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('108', 'LookUpNamespace', 'unitopsso+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('109', 'ModifyNamespace', 'unitopsso+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('110', 'ReleaseNamespace', 'unitopsso+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Permission` VALUES ('111', 'LookUpNamespace', 'unitopsso+application+PRO', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:57', '蔡昭全(0002551)', '2020-07-10 14:59:57');
INSERT INTO `Permission` VALUES ('112', 'ModifyNamespace', 'unitopsso+application+PRO', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:57', '蔡昭全(0002551)', '2020-07-10 14:59:57');
INSERT INTO `Permission` VALUES ('113', 'ReleaseNamespace', 'unitopsso+application+PRO', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:58', '蔡昭全(0002551)', '2020-07-10 14:59:58');

-- ----------------------------
-- Table structure for Role
-- ----------------------------
DROP TABLE IF EXISTS `Role`;
CREATE TABLE `Role` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleName` varchar(256) NOT NULL DEFAULT '' COMMENT 'Role name',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_RoleName` (`RoleName`(191)),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';

-- ----------------------------
-- Records of Role
-- ----------------------------
INSERT INTO `Role` VALUES ('1', 'Master+jobplatform', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `Role` VALUES ('2', 'ModifyNamespace+jobplatform+application', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Role` VALUES ('3', 'ReleaseNamespace+jobplatform+application', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Role` VALUES ('4', 'LookUpNamespace+jobplatform+application+DEV', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Role` VALUES ('5', 'ModifyNamespace+jobplatform+application+DEV', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Role` VALUES ('6', 'ReleaseNamespace+jobplatform+application+DEV', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Role` VALUES ('7', 'LookUpNamespace+jobplatform+application', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `Role` VALUES ('20', 'Master+unitopsso', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('21', 'LookUpNamespace+unitopsso+application', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('22', 'ModifyNamespace+unitopsso+application', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('23', 'ReleaseNamespace+unitopsso+application', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('24', 'LookUpNamespace+unitopsso+application+DEV', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('25', 'ModifyNamespace+unitopsso+application+DEV', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('26', 'ReleaseNamespace+unitopsso+application+DEV', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `Role` VALUES ('27', 'Master+10000001', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('28', 'LookUpNamespace+10000001+application', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('29', 'ModifyNamespace+10000001+application', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('30', 'ReleaseNamespace+10000001+application', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('31', 'LookUpNamespace+10000001+application+DEV', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('32', 'ModifyNamespace+10000001+application+DEV', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('33', 'ReleaseNamespace+10000001+application+DEV', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `Role` VALUES ('34', 'CreateApplication+SystemRole', '\0', 'apollo', '2019-10-10 12:52:05', 'apollo', '2019-10-10 12:52:05');
INSERT INTO `Role` VALUES ('35', 'ModifyNamespace+jobplatform+jobPrivate', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `Role` VALUES ('36', 'ReleaseNamespace+jobplatform+jobPrivate', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `Role` VALUES ('37', 'LookUpNamespace+jobplatform+jobPrivate+DEV', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Role` VALUES ('38', 'ModifyNamespace+jobplatform+jobPrivate+DEV', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Role` VALUES ('39', 'ReleaseNamespace+jobplatform+jobPrivate+DEV', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Role` VALUES ('40', 'LookUpNamespace+jobplatform+jobPrivate', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `Role` VALUES ('41', 'Master+10000002', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('42', 'ManageAppMaster+10000002', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('43', 'LookUpNamespace+10000002+application', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('44', 'ModifyNamespace+10000002+application', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('45', 'ReleaseNamespace+10000002+application', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('46', 'LookUpNamespace+10000002+application+DEV', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('47', 'ModifyNamespace+10000002+application+DEV', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('48', 'ReleaseNamespace+10000002+application+DEV', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `Role` VALUES ('49', 'LookUpNamespace+jobplatform+application+PRO', '\0', '0002551', '2019-10-11 08:57:46', '0002551', '2019-10-11 08:57:46');
INSERT INTO `Role` VALUES ('50', 'ModifyNamespace+jobplatform+application+PRO', '\0', '0002551', '2019-10-11 08:57:46', '0002551', '2019-10-11 08:57:46');
INSERT INTO `Role` VALUES ('51', 'ReleaseNamespace+jobplatform+application+PRO', '\0', '0002551', '2019-10-11 08:57:47', '0002551', '2019-10-11 08:57:47');
INSERT INTO `Role` VALUES ('52', 'LookUpNamespace+jobplatform+jobPrivate+PRO', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `Role` VALUES ('53', 'ModifyNamespace+jobplatform+jobPrivate+PRO', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `Role` VALUES ('54', 'ReleaseNamespace+jobplatform+jobPrivate+PRO', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `Role` VALUES ('55', 'LookUpNamespace+10000002+application+PRO', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `Role` VALUES ('56', 'ModifyNamespace+10000002+application+PRO', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `Role` VALUES ('57', 'ReleaseNamespace+10000002+application+PRO', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `Role` VALUES ('58', 'Master+100003173', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('59', 'ManageAppMaster+100003173', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('60', 'LookUpNamespace+100003173+application', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('61', 'ModifyNamespace+100003173+application', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('62', 'ReleaseNamespace+100003173+application', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('63', 'LookUpNamespace+100003173+application+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('64', 'ModifyNamespace+100003173+application+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('65', 'ReleaseNamespace+100003173+application+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('66', 'LookUpNamespace+100003173+application+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('67', 'ModifyNamespace+100003173+application+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('68', 'ReleaseNamespace+100003173+application+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `Role` VALUES ('69', 'LookUpNamespace+100003173+redis', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('70', 'ModifyNamespace+100003173+redis', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('71', 'ReleaseNamespace+100003173+redis', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('72', 'LookUpNamespace+100003173+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('73', 'ModifyNamespace+100003173+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('74', 'ReleaseNamespace+100003173+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('75', 'LookUpNamespace+100003173+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('76', 'ModifyNamespace+100003173+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('77', 'ReleaseNamespace+100003173+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `Role` VALUES ('78', 'LookUpNamespace+jobplatform+redis', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('79', 'ModifyNamespace+jobplatform+redis', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('80', 'ReleaseNamespace+jobplatform+redis', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('81', 'LookUpNamespace+jobplatform+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('82', 'ModifyNamespace+jobplatform+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('83', 'ReleaseNamespace+jobplatform+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('84', 'LookUpNamespace+jobplatform+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('85', 'ModifyNamespace+jobplatform+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('86', 'ReleaseNamespace+jobplatform+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `Role` VALUES ('87', 'LookUpNamespace+unitopsso+redis', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('88', 'ModifyNamespace+unitopsso+redis', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('89', 'ReleaseNamespace+unitopsso+redis', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('90', 'LookUpNamespace+unitopsso+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('91', 'ModifyNamespace+unitopsso+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('92', 'ReleaseNamespace+unitopsso+redis+DEV', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('93', 'LookUpNamespace+unitopsso+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('94', 'ModifyNamespace+unitopsso+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('95', 'ReleaseNamespace+unitopsso+redis+PRO', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `Role` VALUES ('96', 'LookUpNamespace+unitopsso+application+PRO', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:57', '蔡昭全(0002551)', '2020-07-10 14:59:57');
INSERT INTO `Role` VALUES ('97', 'ModifyNamespace+unitopsso+application+PRO', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:57', '蔡昭全(0002551)', '2020-07-10 14:59:57');
INSERT INTO `Role` VALUES ('98', 'ReleaseNamespace+unitopsso+application+PRO', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:58', '蔡昭全(0002551)', '2020-07-10 14:59:58');

-- ----------------------------
-- Table structure for RolePermission
-- ----------------------------
DROP TABLE IF EXISTS `RolePermission`;
CREATE TABLE `RolePermission` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `PermissionId` int(10) unsigned DEFAULT NULL COMMENT 'Permission Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_PermissionId` (`PermissionId`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色和权限的绑定表';

-- ----------------------------
-- Records of RolePermission
-- ----------------------------
INSERT INTO `RolePermission` VALUES ('1', '1', '1', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `RolePermission` VALUES ('2', '1', '2', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `RolePermission` VALUES ('3', '1', '3', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `RolePermission` VALUES ('4', '2', '4', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `RolePermission` VALUES ('5', '3', '5', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `RolePermission` VALUES ('6', '4', '6', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `RolePermission` VALUES ('7', '5', '7', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `RolePermission` VALUES ('8', '6', '8', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `RolePermission` VALUES ('25', '20', '27', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('26', '20', '28', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('27', '20', '29', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('28', '21', '30', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('29', '22', '31', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('30', '23', '32', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('31', '24', '33', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('32', '25', '34', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('33', '26', '35', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `RolePermission` VALUES ('34', '27', '36', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('35', '27', '37', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('36', '27', '38', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('37', '28', '39', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('38', '29', '40', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('39', '30', '41', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('40', '31', '42', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('41', '32', '43', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('42', '33', '44', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `RolePermission` VALUES ('43', '34', '45', '\0', 'apollo', '2019-10-10 12:52:05', 'apollo', '2019-10-10 12:52:05');
INSERT INTO `RolePermission` VALUES ('44', '7', '9', '\0', 'apollo', '2019-10-10 14:07:23', '', '2019-10-10 14:07:28');
INSERT INTO `RolePermission` VALUES ('45', '35', '46', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `RolePermission` VALUES ('46', '36', '47', '', '0002551', '2019-10-10 14:28:47', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `RolePermission` VALUES ('47', '37', '48', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `RolePermission` VALUES ('48', '38', '49', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `RolePermission` VALUES ('49', '39', '50', '\0', '0002551', '2019-10-10 14:28:48', '0002551', '2019-10-10 14:28:48');
INSERT INTO `RolePermission` VALUES ('50', '40', '51', '', 'apollo', '2019-10-10 14:34:53', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `RolePermission` VALUES ('51', '41', '52', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('52', '41', '53', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('53', '41', '54', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('54', '42', '55', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('55', '43', '56', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('56', '44', '57', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('57', '45', '58', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('58', '46', '59', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('59', '47', '60', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('60', '48', '61', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `RolePermission` VALUES ('61', '49', '62', '\0', '0002551', '2019-10-11 08:57:46', '0002551', '2019-10-11 08:57:46');
INSERT INTO `RolePermission` VALUES ('62', '50', '63', '\0', '0002551', '2019-10-11 08:57:46', '0002551', '2019-10-11 08:57:46');
INSERT INTO `RolePermission` VALUES ('63', '51', '64', '\0', '0002551', '2019-10-11 08:57:47', '0002551', '2019-10-11 08:57:47');
INSERT INTO `RolePermission` VALUES ('64', '52', '65', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `RolePermission` VALUES ('65', '53', '66', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `RolePermission` VALUES ('66', '54', '67', '\0', '0002551', '2019-10-11 08:59:04', '0002551', '2019-10-11 08:59:04');
INSERT INTO `RolePermission` VALUES ('67', '55', '68', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `RolePermission` VALUES ('68', '56', '69', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `RolePermission` VALUES ('69', '57', '70', '\0', '0002551', '2019-10-11 15:54:14', '0002551', '2019-10-11 15:54:14');
INSERT INTO `RolePermission` VALUES ('70', '58', '71', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('71', '58', '72', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('72', '58', '73', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('73', '59', '74', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('74', '60', '75', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('75', '61', '76', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('76', '62', '77', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('77', '63', '78', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('78', '64', '79', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('79', '65', '80', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('80', '66', '81', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('81', '67', '82', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('82', '68', '83', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `RolePermission` VALUES ('83', '69', '84', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('84', '70', '85', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('85', '71', '86', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('86', '72', '87', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('87', '73', '88', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('88', '74', '89', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('89', '75', '90', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('90', '76', '91', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('91', '77', '92', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `RolePermission` VALUES ('92', '78', '93', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('93', '79', '94', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('94', '80', '95', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('95', '81', '96', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('96', '82', '97', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('97', '83', '98', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('98', '84', '99', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('99', '85', '100', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('100', '86', '101', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `RolePermission` VALUES ('101', '87', '102', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('102', '88', '103', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('103', '89', '104', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('104', '90', '105', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('105', '91', '106', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('106', '92', '107', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('107', '93', '108', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('108', '94', '109', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('109', '95', '110', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `RolePermission` VALUES ('110', '96', '111', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:57', '蔡昭全(0002551)', '2020-07-10 14:59:57');
INSERT INTO `RolePermission` VALUES ('111', '97', '112', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:58', '蔡昭全(0002551)', '2020-07-10 14:59:58');
INSERT INTO `RolePermission` VALUES ('112', '98', '113', '\0', '蔡昭全(0002551)', '2020-07-10 14:59:58', '蔡昭全(0002551)', '2020-07-10 14:59:58');

-- ----------------------------
-- Table structure for ServerConfig
-- ----------------------------
DROP TABLE IF EXISTS `ServerConfig`;
CREATE TABLE `ServerConfig` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Key` varchar(64) NOT NULL DEFAULT 'default' COMMENT '配置项Key',
  `Value` varchar(2048) NOT NULL DEFAULT 'default' COMMENT '配置项值',
  `Comment` varchar(1024) DEFAULT '' COMMENT '注释',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) NOT NULL DEFAULT 'default' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_Key` (`Key`),
  KEY `DataChange_LastTime` (`DataChange_LastTime`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置服务自身配置';

-- ----------------------------
-- Records of ServerConfig
-- ----------------------------
INSERT INTO `ServerConfig` VALUES ('1', 'apollo.portal.envs', 'dev,pro', '可支持的环境列表', '\0', 'default', '2019-10-09 14:05:47', '', '2019-10-11 08:53:51');
INSERT INTO `ServerConfig` VALUES ('2', 'organizations', '[{\"orgId\":\"TEST1\",\"orgName\":\"样例部门1\"},{\"orgId\":\"TEST2\",\"orgName\":\"样例部门2\"}]', '部门列表', '\0', 'default', '2019-10-09 14:05:47', '', '2019-10-09 14:05:47');
INSERT INTO `ServerConfig` VALUES ('3', 'superAdmin', 'apollo,0002551', 'Portal超级管理员', '\0', 'default', '2019-10-09 14:05:47', '', '2019-10-09 15:10:59');
INSERT INTO `ServerConfig` VALUES ('4', 'api.readTimeout', '10000', 'http接口read timeout', '\0', 'default', '2019-10-09 14:05:47', '', '2019-10-09 14:05:47');
INSERT INTO `ServerConfig` VALUES ('5', 'consumer.token.salt', 'someSalt', 'consumer token salt', '\0', 'default', '2019-10-09 14:05:47', '', '2019-10-09 14:05:47');
INSERT INTO `ServerConfig` VALUES ('6', 'admin.createPrivateNamespace.switch', 'true', '是否允许项目管理员创建私有namespace', '\0', 'default', '2019-10-09 14:05:47', '', '2019-10-09 14:05:47');
INSERT INTO `ServerConfig` VALUES ('12', 'configView.memberOnly.envs', 'pro', '只对项目成员显示配置信息的环境列表，多个env以英文逗号分隔', '\0', 'default', '2019-10-10 12:43:23', '', '2019-10-10 12:43:23');
INSERT INTO `ServerConfig` VALUES ('13', 'role.create-application.enabled', 'true', '会限制只有超级管理员和拥有创建应用权限的帐号可以创建项目', '\0', '0002551', '2019-10-10 13:03:07', '0002551', '2019-10-10 13:03:07');
INSERT INTO `ServerConfig` VALUES ('14', 'role.manage-app-master.enabled', 'true', '会限制只有超级管理员和拥有管理员分配权限的帐号可以修改项目管理员', '\0', '0002551', '2019-10-10 13:03:07', '0002551', '2019-10-10 13:03:07');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of UnitopUsers
-- ----------------------------
INSERT INTO `UnitopUsers` VALUES ('1', '0002551', '蔡昭全', null, 'UT01602', '架构管理部', 'POSITION_NAME_07243', null);
INSERT INTO `UnitopUsers` VALUES ('2', '0024835', '周潮', 'zhouchao@uni-top.com', 'UT01602', 'IT架构部', 'POSITION_NAME_0673', '开发工程师');
INSERT INTO `UnitopUsers` VALUES ('3', '0001631', '杨飞', 'yangfei@uni-top.com', 'UT01599', '运维管理部', 'POSITION_NAME_07241', '运维经理');
INSERT INTO `UnitopUsers` VALUES ('4', '0000424', '谢武胜', 'xiewusheng@uni-top.com', 'UT01949', '速尔业务解决部', 'POSITION_NAME_07505', '速尔信息化组经理');
INSERT INTO `UnitopUsers` VALUES ('5', '0001781', '张鹏', null, 'UT00204', '流程与IT管理中心', 'POSITION_NAME_07258', null);

-- ----------------------------
-- Table structure for UserRole
-- ----------------------------
DROP TABLE IF EXISTS `UserRole`;
CREATE TABLE `UserRole` (
  `Id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `UserId` varchar(128) DEFAULT '' COMMENT '用户身份标识',
  `RoleId` int(10) unsigned DEFAULT NULL COMMENT 'Role Id',
  `IsDeleted` bit(1) NOT NULL DEFAULT b'0' COMMENT '1: deleted, 0: normal',
  `DataChange_CreatedBy` varchar(32) DEFAULT '' COMMENT '创建人邮箱前缀',
  `DataChange_CreatedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `DataChange_LastModifiedBy` varchar(32) DEFAULT '' COMMENT '最后修改人邮箱前缀',
  `DataChange_LastTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  PRIMARY KEY (`Id`),
  KEY `IX_DataChange_LastTime` (`DataChange_LastTime`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_UserId_RoleId` (`UserId`,`RoleId`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户和role的绑定表';

-- ----------------------------
-- Records of UserRole
-- ----------------------------
INSERT INTO `UserRole` VALUES ('1', '0002551', '1', '\0', '0002551', '2019-10-09 16:40:13', '0002551', '2019-10-09 16:40:13');
INSERT INTO `UserRole` VALUES ('2', '0002551', '2', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `UserRole` VALUES ('3', '0002551', '3', '\0', '0002551', '2019-10-09 16:40:14', '0002551', '2019-10-09 16:40:14');
INSERT INTO `UserRole` VALUES ('5', '0024835', '7', '', '0002551', '2019-10-09 17:18:02', '0002551', '2019-10-10 14:04:06');
INSERT INTO `UserRole` VALUES ('13', '0002551', '20', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `UserRole` VALUES ('14', '0002551', '22', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `UserRole` VALUES ('15', '0002551', '23', '\0', '0002551', '2019-10-09 17:44:27', '0002551', '2019-10-09 17:44:27');
INSERT INTO `UserRole` VALUES ('16', '0002551', '27', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `UserRole` VALUES ('17', '0002551', '29', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `UserRole` VALUES ('18', '0002551', '30', '\0', '0002551', '2019-10-09 17:56:58', '0002551', '2019-10-09 17:56:58');
INSERT INTO `UserRole` VALUES ('19', '0024835', '34', '', '0002551', '2019-10-10 13:02:27', '0002551', '2019-10-10 14:57:33');
INSERT INTO `UserRole` VALUES ('20', '0024835', '7', '', '0002551', '2019-10-10 14:06:24', '0002551', '2019-10-10 14:08:30');
INSERT INTO `UserRole` VALUES ('21', '0024835', '7', '', '0002551', '2019-10-10 14:09:19', '0002551', '2019-10-10 14:19:15');
INSERT INTO `UserRole` VALUES ('22', '0024835', '2', '', '0002551', '2019-10-10 14:09:44', '0002551', '2019-10-10 14:18:36');
INSERT INTO `UserRole` VALUES ('23', '0024835', '1', '', '0002551', '2019-10-10 14:10:50', '0002551', '2019-10-10 14:17:42');
INSERT INTO `UserRole` VALUES ('24', '0024835', '3', '', '0024835', '2019-10-10 14:17:07', '0002551', '2019-10-10 14:18:31');
INSERT INTO `UserRole` VALUES ('25', '0024835', '7', '', '0002551', '2019-10-10 14:22:54', '0002551', '2019-10-10 14:23:28');
INSERT INTO `UserRole` VALUES ('26', '0024835', '7', '\0', '0002551', '2019-10-10 14:25:22', '0002551', '2019-10-10 14:25:22');
INSERT INTO `UserRole` VALUES ('27', '0002551', '35', '', '0002551', '2019-10-10 14:28:48', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `UserRole` VALUES ('28', '0002551', '36', '', '0002551', '2019-10-10 14:28:48', '蔡昭全(0002551)', '2019-10-14 11:21:00');
INSERT INTO `UserRole` VALUES ('29', '0024835', '40', '', '0002551', '2019-10-10 14:34:26', '0002551', '2019-10-10 14:35:23');
INSERT INTO `UserRole` VALUES ('30', '0002551', '41', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `UserRole` VALUES ('31', '0002551', '44', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `UserRole` VALUES ('32', '0002551', '45', '\0', '0002551', '2019-10-10 14:58:38', '0002551', '2019-10-10 14:58:38');
INSERT INTO `UserRole` VALUES ('33', '0024835', '2', '', '0002551', '2019-10-11 08:58:21', '0002551', '2019-10-11 08:58:45');
INSERT INTO `UserRole` VALUES ('34', '0024835', '40', '', '0002551', '2019-10-11 08:59:13', '0002551', '2019-10-11 08:59:29');
INSERT INTO `UserRole` VALUES ('35', '0024835', '43', '', '蔡昭全(0002551)', '2019-10-11 15:54:26', '蔡昭全(0002551)', '2019-10-11 16:02:45');
INSERT INTO `UserRole` VALUES ('36', '0001631', '43', '', '蔡昭全(0002551)', '2019-10-11 15:55:33', '蔡昭全(0002551)', '2019-10-11 16:02:48');
INSERT INTO `UserRole` VALUES ('37', '0000424', '43', '', '蔡昭全(0002551)', '2019-10-11 15:56:47', '蔡昭全(0002551)', '2019-10-11 16:02:47');
INSERT INTO `UserRole` VALUES ('38', '0002551', '58', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `UserRole` VALUES ('39', '蔡昭全(0002551)', '61', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `UserRole` VALUES ('40', '蔡昭全(0002551)', '62', '\0', '蔡昭全(0002551)', '2019-10-12 13:41:46', '蔡昭全(0002551)', '2019-10-12 13:41:46');
INSERT INTO `UserRole` VALUES ('41', '蔡昭全(0002551)', '70', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `UserRole` VALUES ('42', '蔡昭全(0002551)', '71', '\0', '蔡昭全(0002551)', '2019-10-12 13:42:26', '蔡昭全(0002551)', '2019-10-12 13:42:26');
INSERT INTO `UserRole` VALUES ('43', '蔡昭全(0002551)', '79', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `UserRole` VALUES ('44', '蔡昭全(0002551)', '80', '\0', '蔡昭全(0002551)', '2019-10-14 11:14:48', '蔡昭全(0002551)', '2019-10-14 11:14:48');
INSERT INTO `UserRole` VALUES ('45', '0002551', '34', '', '蔡昭全(0002551)', '2019-10-15 09:58:18', '蔡昭全(0002551)', '2019-10-15 10:28:46');
INSERT INTO `UserRole` VALUES ('46', '0002551', '60', '\0', '蔡昭全(0002551)', '2019-10-15 09:58:45', '蔡昭全(0002551)', '2019-10-15 09:58:45');
INSERT INTO `UserRole` VALUES ('47', '0001781', '46', '\0', '蔡昭全(0002551)', '2019-10-16 08:37:28', '蔡昭全(0002551)', '2019-10-16 08:37:28');
INSERT INTO `UserRole` VALUES ('48', '蔡昭全(0002551)', '88', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');
INSERT INTO `UserRole` VALUES ('49', '蔡昭全(0002551)', '89', '\0', '蔡昭全(0002551)', '2019-10-16 14:13:03', '蔡昭全(0002551)', '2019-10-16 14:13:03');

-- ----------------------------
-- Table structure for Users
-- ----------------------------
DROP TABLE IF EXISTS `Users`;
CREATE TABLE `Users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增Id',
  `Username` varchar(64) NOT NULL DEFAULT 'default' COMMENT '用户名',
  `Password` varchar(64) NOT NULL DEFAULT 'default' COMMENT '密码',
  `Email` varchar(64) NOT NULL DEFAULT 'default' COMMENT '邮箱地址',
  `Enabled` tinyint(4) DEFAULT NULL COMMENT '是否有效',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- ----------------------------
-- Records of Users
-- ----------------------------
INSERT INTO `Users` VALUES ('1', 'apollo', '$2a$10$7r20uS.BQ9uBpf3Baj3uQOZvMVvB1RN3PYoKE94gtz2.WAOuiiwXS', 'apollo@acme.com', '1');
