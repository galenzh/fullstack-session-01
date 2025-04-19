/*
 Navicat Premium Data Transfer

 Source Server         : Mydb
 Source Server Type    : MySQL
 Source Server Version : 80200 (8.2.0)
 Source Host           : localhost:3306
 Source Schema         : pdas

 Target Server Type    : MySQL
 Target Server Version : 80200 (8.2.0)
 File Encoding         : 65001

 Date: 17/04/2025 19:48:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `phone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `isdefault` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '否' COMMENT '是否默认地址',
  `userid` bigint NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='地址';

-- ----------------------------
-- Records of address
-- ----------------------------
BEGIN;
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (1, '2025-03-22 12:42:31', '地址1', '李一', '19819881111', '是', 11);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (2, '2025-03-22 12:42:31', '地址2', '王二', '19819882222', '是', 12);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (3, '2025-03-22 12:42:31', '地址3', '张三', '19819883333', '是', 13);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (4, '2025-03-22 12:42:31', '地址4', '刘四', '19819884444', '是', 14);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (5, '2025-03-22 12:42:31', '地址5', '陈五', '19819885555', '是', 15);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (6, '2025-03-22 12:42:31', '地址6', '杨六', '19819886666', '是', 16);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (7, '2025-03-22 12:42:31', '地址7', '赵七', '19819887777', '是', 17);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (8, '2025-03-22 12:42:31', '地址8', '黄八', '19819888888', '是', 18);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (9, '2025-03-22 12:42:31', '地址9', '周九', '19819889999', '是', 19);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (10, '2025-03-22 12:42:31', '地址10', '吴十', '19819880000', '是', 20);
INSERT INTO `address` (`id`, `addtime`, `address`, `name`, `phone`, `isdefault`, `userid`) VALUES (11, '2025-04-10 21:16:40', '河北沧州', 'aaa', '15512346782', '是', 70);
COMMIT;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'kechengxinxi' COMMENT '商品表名',
  `goodid` bigint NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int DEFAULT NULL COMMENT '购买数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `discountprice` double DEFAULT NULL COMMENT '折扣价',
  `userid` bigint NOT NULL COMMENT '用户id',
  `goodtype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='购物车';

-- ----------------------------
-- Records of cart
-- ----------------------------
BEGIN;
INSERT INTO `cart` (`id`, `addtime`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `userid`, `goodtype`) VALUES (1, '2025-04-10 21:22:42', 'gaopinggongju', 9, '青少年人格倾向测评工具', 'file/gaopinggongjuTupian9.jpg', 1, 139.9, NULL, 70, NULL);
INSERT INTO `cart` (`id`, `addtime`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `userid`, `goodtype`) VALUES (2, '2025-04-16 21:36:39', 'kechengxinxi', 3, '反社会人格障碍识别与应对', 'file/kechengxinxiKechengtupian3.jpg', 1, 79.9, NULL, 70, '反社会人格障碍识别与应对');
COMMIT;

-- ----------------------------
-- Table structure for ceshibaogao
-- ----------------------------
DROP TABLE IF EXISTS `ceshibaogao`;
CREATE TABLE `ceshibaogao` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ceshixiangmu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试项目',
  `ceshishijian` datetime DEFAULT NULL COMMENT '测试时间',
  `ceshibaogao` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '测试报告',
  `ceshichengji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '测试成绩',
  `shentijinengpinggu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '身体机能评估',
  `zhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `xingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `baogaoshijian` datetime DEFAULT NULL COMMENT '报告时间',
  `zixunshizhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师账号',
  `zixunshixingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试报告';

-- ----------------------------
-- Records of ceshibaogao
-- ----------------------------
BEGIN;
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (1, '2025-03-22 12:42:31', '测试项目1', '2025-03-22 12:42:31', '', '测试成绩1', '身体机能评估1', '账号1', '姓名1', '性别1', '2025-03-22 12:42:31', '咨询师账号1', '咨询师姓名1');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (2, '2025-03-22 12:42:31', '测试项目2', '2025-03-22 12:42:31', '', '测试成绩2', '身体机能评估2', '账号2', '姓名2', '性别2', '2025-03-22 12:42:31', '咨询师账号2', '咨询师姓名2');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (3, '2025-03-22 12:42:31', '测试项目3', '2025-03-22 12:42:31', '', '测试成绩3', '身体机能评估3', '账号3', '姓名3', '性别3', '2025-03-22 12:42:31', '咨询师账号3', '咨询师姓名3');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (4, '2025-03-22 12:42:31', '测试项目4', '2025-03-22 12:42:31', '', '测试成绩4', '身体机能评估4', '账号4', '姓名4', '性别4', '2025-03-22 12:42:31', '咨询师账号4', '咨询师姓名4');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (5, '2025-03-22 12:42:31', '测试项目5', '2025-03-22 12:42:31', '', '测试成绩5', '身体机能评估5', '账号5', '姓名5', '性别5', '2025-03-22 12:42:31', '咨询师账号5', '咨询师姓名5');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (6, '2025-03-22 12:42:31', '测试项目6', '2025-03-22 12:42:31', '', '测试成绩6', '身体机能评估6', '账号6', '姓名6', '性别6', '2025-03-22 12:42:31', '咨询师账号6', '咨询师姓名6');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (7, '2025-03-22 12:42:31', '测试项目7', '2025-03-22 12:42:31', '', '测试成绩7', '身体机能评估7', '账号7', '姓名7', '性别7', '2025-03-22 12:42:31', '咨询师账号7', '咨询师姓名7');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (8, '2025-03-22 12:42:31', '测试项目8', '2025-03-22 12:42:31', '', '测试成绩8', '身体机能评估8', '账号8', '姓名8', '性别8', '2025-03-22 12:42:31', '咨询师账号8', '咨询师姓名8');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (9, '2025-03-22 12:42:31', '测试项目9', '2025-03-22 12:42:31', '', '测试成绩9', '身体机能评估9', '账号9', '姓名9', '性别9', '2025-03-22 12:42:31', '咨询师账号9', '咨询师姓名9');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (10, '2025-03-22 12:42:31', '测试项目10', '2025-03-22 12:42:31', '', '测试成绩10', '身体机能评估10', '账号10', '姓名10', '性别10', '2025-03-22 12:42:31', '咨询师账号10', '咨询师姓名10');
INSERT INTO `ceshibaogao` (`id`, `addtime`, `ceshixiangmu`, `ceshishijian`, `ceshibaogao`, `ceshichengji`, `shentijinengpinggu`, `zhanghao`, `xingming`, `xingbie`, `baogaoshijian`, `zixunshizhanghao`, `zixunshixingming`) VALUES (11, '2025-03-22 12:48:49', '1', '2025-03-22 00:00:00', 'file/1742618922702.doc', '', '1', '账号1', '姓名1', '男', '2025-03-22 12:48:11', '咨询师账号1', '咨询师姓名1');
COMMIT;

-- ----------------------------
-- Table structure for ceshipingfen
-- ----------------------------
DROP TABLE IF EXISTS `ceshipingfen`;
CREATE TABLE `ceshipingfen` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zixunshizhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师账号',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `pingfenshijian` datetime DEFAULT NULL COMMENT '评分时间',
  `zhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `shouji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `pingfen` int DEFAULT NULL COMMENT '评分',
  `ceshibaogao` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '测试报告',
  `pingfenbeizhu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '评分备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试评分';

-- ----------------------------
-- Records of ceshipingfen
-- ----------------------------
BEGIN;
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (1, '2025-04-11 20:00:00', '咨询师刘', '微信', '2025-04-11 21:00:00', '咨询师刘', '13800000001', 45, '初步检测显示存在一定回避型人格特征。', '建议持续关注社交回避行为。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (2, '2025-04-11 20:00:01', '顾问02', 'QQ', '2025-04-11 21:00:01', '咨询师2', '13800000002', 62, '测评结果接近自恋型人格特点，建议关注人际关系敏感性。', '需注意自我评价波动与过度自信。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (3, '2025-04-11 20:00:02', '顾问03', '邮箱', '2025-04-11 21:00:02', '咨询师9', '13800000003', 58, '存在依赖型人格倾向，建议加强独立意识。', '加强独立性练习。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (4, '2025-04-11 20:00:03', '顾问04', '视频通话', '2025-04-11 21:00:03', '咨询师7', '13800000004', 72, '无明显人格障碍特征，建议保持良好心理状态。', '无需干预。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (5, '2025-04-11 20:00:04', '顾问05', '电话咨询', '2025-04-11 21:00:04', '咨询师3', '13800000005', 88, '可能存在边缘型人格迹象，推荐进一步评估。', '推荐咨询边缘型相关资料。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (6, '2025-04-11 20:00:05', '顾问06', '当面交流', '2025-04-11 21:00:05', '咨询师王', '13800000006', 95, '人格特征稳定，测试得分较高，风险较低。', '状态良好。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (7, '2025-04-11 20:00:06', '顾问07', '匿名聊天室', '2025-04-11 21:00:06', '咨询师洪', '13800000007', 39, '表现出一定强迫型人格行为模式。', '可能存在轻微强迫症状。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (8, '2025-04-11 20:00:07', '顾问08', '微信群组', '2025-04-11 21:00:07', '咨询师张', '13800000008', 67, '部分测评项显示社会退缩倾向。', '观察期。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (9, '2025-04-11 20:00:08', '顾问09', '线下', '2025-04-11 21:00:08', '咨询师李', '13800000009', 79, '情绪调节能力尚可，建议定期自我检查。', '建议每月复测一次。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (10, '2025-04-11 20:00:09', '顾问10', '小程序', '2025-04-11 21:00:09', '咨询师张', '13800000010', 60, '整体心理健康状态良好，建议继续保持。', '适应能力良好。');
INSERT INTO `ceshipingfen` (`id`, `addtime`, `zixunshizhanghao`, `lianxifangshi`, `pingfenshijian`, `zhanghao`, `shouji`, `pingfen`, `ceshibaogao`, `pingfenbeizhu`) VALUES (12, '2025-04-16 10:33:03', '咨询师账号1', '198198811110', '2025-04-16 10:32:51', '账号1', '19819881111', 88, '', '不错');
COMMIT;

-- ----------------------------
-- Table structure for chat
-- ----------------------------
DROP TABLE IF EXISTS `chat`;
CREATE TABLE `chat` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `adminid` bigint DEFAULT NULL COMMENT '管理员id',
  `ask` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '提问内容',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `isreply` int DEFAULT NULL COMMENT '是否回复',
  `userid` bigint NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客服聊天';

-- ----------------------------
-- Records of chat
-- ----------------------------
BEGIN;
INSERT INTO `chat` (`id`, `addtime`, `adminid`, `ask`, `reply`, `isreply`, `userid`) VALUES (1, '2025-03-22 12:42:31', 1, '提问内容1', '回复内容1', 1, 1);
INSERT INTO `chat` (`id`, `addtime`, `adminid`, `ask`, `reply`, `isreply`, `userid`) VALUES (15, '2025-04-07 12:43:17', NULL, '你是我的人格障碍检测助手，作为我的虚拟医生，你将帮助我了解自己在心理健康方面可能存在的问题，并提供一些安慰和建议。请放心，所有的对话内容都是保密的，旨在帮助我更好地理解自己，获得改善心理健康的建议。，，你要引导客户来说出用户的症状', NULL, 0, 70);
INSERT INTO `chat` (`id`, `addtime`, `adminid`, `ask`, `reply`, `isreply`, `userid`) VALUES (16, '2025-04-07 12:43:36', 70, NULL, '当然，我会以一种温和且尊重的方式引导你分享你的感受。首先，我想让你知道，这里是一个安全的空间，你可以放心地表达任何想法和感受。\n\n让我们从一些日常体验开始聊起吧。有时候，人们可能会在日常生活中遇到一些困扰他们的情绪或行为模式。你是否觉得自己在某些方面与周围的人有所不同，或者在某些情境下感到特别困惑或挣扎？\n\n比如，你是否经常感到孤独，即使身边有人陪伴也难以缓解？或者，你是否在某些社交场合中感到特别不自在，难以与他人建立亲密或信任的关系？又或者，你是否经常对自己的价值、能力或外貌产生强烈的质疑或不满？\n\n这些都是一些可能指向人格障碍的迹象，但请记住，这些只是可能的线索，并不能直接确定你是否真的患有某种人格障碍。更重要的是，我们一起来探讨你的感受，并找到适合你的支持和帮助。\n\n如果你愿意，可以分享一些具体的例子或情境，这样我可以更好地理解你的感受，并提供更有针对性的建议。当然，如果你不愿意分享太多细节，也没关系，我们可以先从更一般的话题聊起。\n\n请记住，无论你的感受如何，你都不是一个人在面对这些挑战。我在这里，愿意倾听并为你提供支持。', 0, 70);
COMMIT;

-- ----------------------------
-- Table structure for chat_friend
-- ----------------------------
DROP TABLE IF EXISTS `chat_friend`;
CREATE TABLE `chat_friend` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint NOT NULL COMMENT '用户id',
  `fid` bigint NOT NULL COMMENT '好友id',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '图片',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `alias` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '别名',
  `type` int DEFAULT '0' COMMENT '类型(0:好友申请，1:好友，2:消息)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='好友表';

-- ----------------------------
-- Records of chat_friend
-- ----------------------------
BEGIN;
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (1, '2025-03-22 12:42:31', 1, 1, '名称1', 'file/chat_friendPicture1.jpg,file/chat_friendPicture2.jpg,file/chat_friendPicture3.jpg', '角色1', '表名1', '别名1', 1);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (2, '2025-03-22 12:42:31', 2, 2, '名称2', 'file/chat_friendPicture2.jpg,file/chat_friendPicture3.jpg,file/chat_friendPicture4.jpg', '角色2', '表名2', '别名2', 2);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (3, '2025-03-22 12:42:31', 3, 3, '名称3', 'file/chat_friendPicture3.jpg,file/chat_friendPicture4.jpg,file/chat_friendPicture5.jpg', '角色3', '表名3', '别名3', 3);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (4, '2025-03-22 12:42:31', 4, 4, '名称4', 'file/chat_friendPicture4.jpg,file/chat_friendPicture5.jpg,file/chat_friendPicture6.jpg', '角色4', '表名4', '别名4', 4);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (5, '2025-03-22 12:42:31', 5, 5, '名称5', 'file/chat_friendPicture5.jpg,file/chat_friendPicture6.jpg,file/chat_friendPicture7.jpg', '角色5', '表名5', '别名5', 5);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (6, '2025-03-22 12:42:31', 6, 6, '名称6', 'file/chat_friendPicture6.jpg,file/chat_friendPicture7.jpg,file/chat_friendPicture8.jpg', '角色6', '表名6', '别名6', 6);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (7, '2025-03-22 12:42:31', 7, 7, '名称7', 'file/chat_friendPicture7.jpg,file/chat_friendPicture8.jpg,file/chat_friendPicture9.jpg', '角色7', '表名7', '别名7', 7);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (8, '2025-03-22 12:42:31', 8, 8, '名称8', 'file/chat_friendPicture8.jpg,file/chat_friendPicture9.jpg,file/chat_friendPicture10.jpg', '角色8', '表名8', '别名8', 8);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (9, '2025-03-22 12:42:31', 9, 9, '名称9', 'file/chat_friendPicture9.jpg,file/chat_friendPicture10.jpg,file/chat_friendPicture11.jpg', '角色9', '表名9', '别名9', 9);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (10, '2025-03-22 12:42:31', 10, 10, '名称10', 'file/chat_friendPicture10.jpg,file/chat_friendPicture11.jpg,file/chat_friendPicture12.jpg', '角色10', '表名10', '别名10', 10);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (11, '2025-04-13 21:03:41', 70, 80, '咨询师账号10', 'file/zixunshiTouxiang10.jpg', NULL, 'zixunshi', NULL, 2);
INSERT INTO `chat_friend` (`id`, `addtime`, `uid`, `fid`, `name`, `picture`, `role`, `tablename`, `alias`, `type`) VALUES (12, '2025-04-13 21:03:41', 80, 70, '10', 'file/yonghuTouxiang10.jpg', NULL, 'yonghu', NULL, 2);
COMMIT;

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `uid` bigint NOT NULL COMMENT '用户id',
  `fid` bigint NOT NULL COMMENT '好友id',
  `content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '内容',
  `format` int DEFAULT NULL COMMENT '格式(1:文字，2:图片)',
  `is_read` int DEFAULT '0' COMMENT '消息已读(0:未读，1:已读)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='消息表';

-- ----------------------------
-- Records of chat_message
-- ----------------------------
BEGIN;
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (1, '2025-03-22 12:42:31', 1, 1, '内容1', 1, 1);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (2, '2025-03-22 12:42:31', 2, 2, '内容2', 2, 2);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (3, '2025-03-22 12:42:31', 3, 3, '内容3', 3, 3);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (4, '2025-03-22 12:42:31', 4, 4, '内容4', 4, 4);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (5, '2025-03-22 12:42:31', 5, 5, '内容5', 5, 5);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (6, '2025-03-22 12:42:31', 6, 6, '内容6', 6, 6);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (7, '2025-03-22 12:42:31', 7, 7, '内容7', 7, 7);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (8, '2025-03-22 12:42:31', 8, 8, '内容8', 8, 8);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (9, '2025-03-22 12:42:31', 9, 9, '内容9', 9, 9);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (10, '2025-03-22 12:42:31', 10, 10, '内容10', 10, 10);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (11, '2025-04-13 21:03:41', 70, 80, '医生您好', 1, 1);
INSERT INTO `chat_message` (`id`, `addtime`, `uid`, `fid`, `content`, `format`, `is_read`) VALUES (12, '2025-04-13 21:08:52', 80, 70, '你好呀', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for chathelper
-- ----------------------------
DROP TABLE IF EXISTS `chathelper`;
CREATE TABLE `chathelper` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ask` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '提问内容',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='聊天助手';

-- ----------------------------
-- Records of chathelper
-- ----------------------------
BEGIN;
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (1, '2025-03-22 12:42:31', '我总是觉得别人不喜欢我，是人格障碍吗？', '这种感受可能与回避型或依赖型人格有关，建议通过专业测评进一步确认。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (2, '2025-03-22 12:42:31', '人格障碍可以自愈吗？', '部分轻微人格特征可以通过自我认知和行为调整改善，严重情况建议寻求专业帮助。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (3, '2025-03-22 12:42:31', 'PDQ-4 是什么？', 'PDQ-4 是一种常用的人格障碍自评问卷，用于初步筛查人格障碍特征。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (4, '2025-03-22 12:42:31', '测评显示我有边缘型倾向，要怎么办？', '可以从情绪调节和人际关系改善入手，也建议定期接受心理咨询。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (5, '2025-03-22 12:42:31', '人格障碍和心理疾病一样吗？', '人格障碍属于心理障碍的一种类型，但和抑郁症等疾病有所不同，具有稳定的行为模式特征。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (6, '2025-03-22 12:42:31', '如何判断自己是否需要心理辅导？', '当你感到情绪困扰、人际冲突频繁、自我否定严重时，建议尝试心理咨询。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (7, '2025-03-22 12:42:31', '我是不是太敏感了？经常因小事生气。', '高敏感可能与边缘型或情绪不稳定人格相关，可以通过训练改善情绪调节。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (8, '2025-03-22 12:42:31', '测评后我很焦虑怎么办？', '这是正常反应，测评只是提示工具，焦虑可以通过呼吸训练和正念缓解。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (9, '2025-03-22 12:42:31', '我能匿名进行心理咨询吗？', '当然可以，我们支持匿名咨询，保护用户隐私。');
INSERT INTO `chathelper` (`id`, `addtime`, `ask`, `reply`) VALUES (10, '2025-03-22 12:42:31', '人格测评报告怎么看？', '报告会标注可能的人格特质倾向，建议结合专家建议做进一步解读。');
COMMIT;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '值',
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '链接',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='轮播图';

-- ----------------------------
-- Records of config
-- ----------------------------
BEGIN;
INSERT INTO `config` (`id`, `addtime`, `name`, `value`, `url`) VALUES (1, '2025-03-22 12:42:31', 'swiper1', 'file/swiperPicture1.jpg', NULL);
INSERT INTO `config` (`id`, `addtime`, `name`, `value`, `url`) VALUES (2, '2025-03-22 12:42:31', 'swiper2', 'file/swiperPicture2.jpg', NULL);
INSERT INTO `config` (`id`, `addtime`, `name`, `value`, `url`) VALUES (3, '2025-03-22 12:42:31', 'swiper3', 'file/swiperPicture3.jpg', NULL);
COMMIT;

-- ----------------------------
-- Table structure for discussgaopinggongju
-- ----------------------------
DROP TABLE IF EXISTS `discussgaopinggongju`;
CREATE TABLE `discussgaopinggongju` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint NOT NULL COMMENT '关联表id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='高评工具评论表';

-- ----------------------------
-- Records of discussgaopinggongju
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for discusskechengxinxi
-- ----------------------------
DROP TABLE IF EXISTS `discusskechengxinxi`;
CREATE TABLE `discusskechengxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint NOT NULL COMMENT '关联表id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程信息评论表';

-- ----------------------------
-- Records of discusskechengxinxi
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for discussxinlijiankangxuexi
-- ----------------------------
DROP TABLE IF EXISTS `discussxinlijiankangxuexi`;
CREATE TABLE `discussxinlijiankangxuexi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint NOT NULL COMMENT '关联表id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nickname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='心理健康学习评论表';

-- ----------------------------
-- Records of discussxinlijiankangxuexi
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for emailregistercode
-- ----------------------------
DROP TABLE IF EXISTS `emailregistercode`;
CREATE TABLE `emailregistercode` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色',
  `code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '验证码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='邮箱验证码';

-- ----------------------------
-- Records of emailregistercode
-- ----------------------------
BEGIN;
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (1, '2025-03-22 12:42:31', '邮箱1', '角色1', '验证码1');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (2, '2025-03-22 12:42:31', '邮箱2', '角色2', '验证码2');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (3, '2025-03-22 12:42:31', '邮箱3', '角色3', '验证码3');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (4, '2025-03-22 12:42:31', '邮箱4', '角色4', '验证码4');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (5, '2025-03-22 12:42:31', '邮箱5', '角色5', '验证码5');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (6, '2025-03-22 12:42:31', '邮箱6', '角色6', '验证码6');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (7, '2025-03-22 12:42:31', '邮箱7', '角色7', '验证码7');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (8, '2025-03-22 12:42:31', '邮箱8', '角色8', '验证码8');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (9, '2025-03-22 12:42:31', '邮箱9', '角色9', '验证码9');
INSERT INTO `emailregistercode` (`id`, `addtime`, `email`, `role`, `code`) VALUES (10, '2025-03-22 12:42:31', '邮箱10', '角色10', '验证码10');
COMMIT;

-- ----------------------------
-- Table structure for emotion_assessment
-- ----------------------------
DROP TABLE IF EXISTS `emotion_assessment`;
CREATE TABLE `emotion_assessment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) NOT NULL COMMENT '评估名称',
  `description` text COMMENT '评估描述',
  `time` int DEFAULT '15' COMMENT '评估时长(分钟)',
  `status` varchar(50) DEFAULT '正常' COMMENT '评估状态',
  `emotion_type` varchar(100) DEFAULT NULL COMMENT '情绪类型',
  `target_audience` varchar(200) DEFAULT NULL COMMENT '适用人群',
  `suggestion_template` text COMMENT '评估建议模板',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='情绪评估';

-- ----------------------------
-- Records of emotion_assessment
-- ----------------------------
BEGIN;
INSERT INTO `emotion_assessment` (`id`, `name`, `description`, `time`, `status`, `emotion_type`, `target_audience`, `suggestion_template`, `addtime`) VALUES (1, '抑郁症筛查量表(PHQ-9)', 'PHQ-9是一种广泛使用的抑郁症筛查工具，通过9个问题评估您过去两周的情绪状态。', 10, '正常', '抑郁', '青少年和成人', '您的PHQ-9评分为：{score}\n\n评估结果：\n{result}\n\n建议：\n{suggestions}\n\n注意：本评估仅供参考，不能替代专业医疗诊断。如果您有严重的情绪困扰，请咨询专业心理医生。', '2025-04-13 12:34:43');
INSERT INTO `emotion_assessment` (`id`, `name`, `description`, `time`, `status`, `emotion_type`, `target_audience`, `suggestion_template`, `addtime`) VALUES (2, '焦虑自评量表(GAD-7)', 'GAD-7是一种简短的焦虑症状筛查工具，用于评估最近两周内的焦虑症状频率。', 5, '正常', '焦虑', '青少年和成人', '您的GAD-7评分为：{score}\n\n评估结果：\n{result}\n\n放松建议：\n{relaxation_tips}\n\n注意：本评估仅供参考，不能替代专业医疗诊断。如果您有严重的焦虑症状，请咨询专业心理医生。', '2025-04-13 12:34:43');
COMMIT;

-- ----------------------------
-- Table structure for exampaper
-- ----------------------------
DROP TABLE IF EXISTS `exampaper`;
CREATE TABLE `exampaper` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试卷名称',
  `time` int NOT NULL COMMENT '考试时长(分钟)',
  `status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '启用' COMMENT '试卷状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='在线测试';

-- ----------------------------
-- Records of exampaper
-- ----------------------------
BEGIN;
INSERT INTO `exampaper` (`id`, `addtime`, `name`, `time`, `status`) VALUES (1, '2025-03-22 12:42:31', '心理测评', 120, '1');
INSERT INTO `exampaper` (`id`, `addtime`, `name`, `time`, `status`) VALUES (3, '2025-04-13 12:57:27', '性格测试', 30, '1');
COMMIT;

-- ----------------------------
-- Table structure for examquestion
-- ----------------------------
DROP TABLE IF EXISTS `examquestion`;
CREATE TABLE `examquestion` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `paperid` bigint NOT NULL COMMENT '试卷id（外键）',
  `papername` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试卷名称',
  `questionname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试题名称',
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '选项，json字符串',
  `score` bigint DEFAULT '0' COMMENT '分值',
  `answer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '正确答案',
  `analysis` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '答案解析',
  `type` bigint DEFAULT NULL COMMENT '试题类型',
  `sequence` bigint DEFAULT NULL COMMENT '试题排序，值越大排越前面',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='试题管理';

-- ----------------------------
-- Records of examquestion
-- ----------------------------
BEGIN;
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (5, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否经常感到情绪极端波动，时而感到高兴，时而感到非常沮丧，且没有明显的原因？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '情绪波动可能反映了情感不稳定的倾向，可能与人格障碍相关。', 1, 1);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (6, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否在与他人关系中常常感到极度不安，害怕被抛弃或被拒绝？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '这种情感不安可能是边缘型人格障碍的特征。', 1, 2);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (7, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否经常不顾后果地做事，比如在没有考虑后果的情况下进行冲动消费、酗酒或做危险的行为？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '冲动行为可能反映了反社会或边缘型人格障碍。', 1, 3);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (8, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否常常对他人的动机或行为抱有怀疑，认为他们总是试图伤害或利用你？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '这种怀疑可能与偏执型人格障碍有关。', 1, 4);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (9, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否常常感到自己比别人优越，认为别人没有资格和你平等交往？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '过度的自我优越感可能与自恋型人格障碍相关。', 1, 5);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (10, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否对自己的感受和行为缺乏自我控制，经常无法按计划行事或解决问题？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '缺乏自控可能是边缘型人格障碍或冲动型人格障碍的表现。', 1, 6);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (11, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否常常觉得与他人建立深层次关系是困难的，并且更喜欢保持与他人一定的距离？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '这种孤立感可能与回避型人格障碍相关。', 1, 7);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (12, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否经常对他人的情感反应不敏感，表现出冷漠或缺乏同理心？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '缺乏同理心是反社会人格障碍的常见特征。', 1, 8);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (13, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否容易对他人的批评产生过度反应，甚至可能表现出攻击性或敌对情绪？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '过度的情绪反应可能是边缘型人格障碍的表现。', 1, 9);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (14, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否在社交场合中常感到过于紧张，害怕被他人评价或拒绝？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '社交焦虑可能是社交恐惧症或回避型人格障碍的标志。', 1, 10);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (15, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否常常觉得自己无法体验到别人所说的幸福或满足，感到空虚或没有目标？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '空虚感可能与情感障碍或边缘型人格障碍相关。', 1, 11);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (16, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否经常在紧张和冲突的情况下表现出过度的愤怒或敌意？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '情绪失控可能与边缘型人格障碍有关。', 1, 12);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (17, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否常常以为他人可能会背叛你或对你不忠，因此表现出过度的警觉性？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '过度的警觉性可能与偏执型人格障碍相关。', 1, 13);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (18, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否感到生活中的规则和常规让你感到束缚，常常挑战现有的规则和社会规范？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '挑战规则可能与反社会人格障碍相关。', 1, 14);
INSERT INTO `examquestion` (`id`, `addtime`, `paperid`, `papername`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (19, '2025-04-07 22:16:29', 1, '人格障碍检测', '你是否经常感到自己没有明确的生活目标或方向，不知道自己未来的道路是什么？', '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '缺乏方向感可能与情感障碍或边缘型人格障碍相关。', 1, 15);
COMMIT;

-- ----------------------------
-- Table structure for examquestionbank
-- ----------------------------
DROP TABLE IF EXISTS `examquestionbank`;
CREATE TABLE `examquestionbank` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `questionname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试题名称',
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '选项，json字符串',
  `score` bigint DEFAULT '0' COMMENT '分值',
  `answer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '正确答案',
  `analysis` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '答案解析',
  `type` bigint DEFAULT NULL COMMENT '试题类型',
  `sequence` bigint DEFAULT NULL COMMENT '试题排序，值越大排越前面',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='试题库管理';

-- ----------------------------
-- Records of examquestionbank
-- ----------------------------
BEGIN;
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (1, '2025-04-11 15:08:23', '当你感到被批评时，你通常会？', '{\"A\":\"迅速反击\", \"B\":\"情绪低落\", \"C\":\"理性接受\", \"D\":\"假装无所谓\"}', 5, 'B', '情绪易受外界评价影响是回避型或边缘型人格的典型特征。', 1, 1);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (2, '2025-04-11 15:08:23', '你是否经常怀疑别人不够关心你？', '{\"A\":\"几乎没有\", \"B\":\"有时\", \"C\":\"经常\", \"D\":\"总是\"}', 5, 'C', '高度依赖他人关注是依赖型人格障碍的表现之一。', 1, 2);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (3, '2025-04-11 15:08:23', '在与人交往中，你是否倾向于控制对方的行为？', '{\"A\":\"从不\", \"B\":\"偶尔\", \"C\":\"经常\", \"D\":\"总是\"}', 5, 'C', '控制欲强可能与强迫型或自恋型人格相关。', 1, 3);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (4, '2025-04-11 15:08:23', '你是否有强烈的完美主义倾向？', '{\"A\":\"从不\", \"B\":\"偶尔\", \"C\":\"频繁\", \"D\":\"非常强烈\"}', 5, 'D', '完美主义可能是强迫型人格障碍的一种表现。', 1, 4);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (5, '2025-04-11 15:08:23', '是否常因小事情绪剧烈波动？', '{\"A\":\"几乎不会\", \"B\":\"偶尔\", \"C\":\"频繁\", \"D\":\"每天都有\"}', 5, 'C', '情绪波动剧烈是边缘型人格常见特征之一。', 1, 5);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (6, '2025-04-11 15:08:23', '当人际关系不稳定时你会？', '{\"A\":\"试图修复\", \"B\":\"主动疏远\", \"C\":\"情绪失控\", \"D\":\"无动于衷\"}', 5, 'C', '关系不稳下情绪崩溃是边缘型人格障碍的特征。', 1, 6);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (7, '2025-04-11 15:08:23', '你是否经常幻想自己拥有特殊才能或地位？', '{\"A\":\"从未有过\", \"B\":\"偶尔\", \"C\":\"频繁\", \"D\":\"总是\"}', 5, 'C', '幻想型思维可提示潜在自恋型或分裂型人格特征。', 1, 7);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (8, '2025-04-11 15:08:23', '你是否常怀疑他人在背后议论你？', '{\"A\":\"从不\", \"B\":\"偶尔\", \"C\":\"经常\", \"D\":\"一直都这样想\"}', 5, 'C', '高度猜疑可能与偏执型人格障碍相关。', 1, 8);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (9, '2025-04-11 15:08:23', '你倾向于？', '{\"A\":\"独立完成任务\", \"B\":\"依赖他人决定\", \"C\":\"反复征求意见\", \"D\":\"逃避决策\"}', 5, 'B', '严重依赖他人常见于依赖型人格。', 1, 9);
INSERT INTO `examquestionbank` (`id`, `addtime`, `questionname`, `options`, `score`, `answer`, `analysis`, `type`, `sequence`) VALUES (10, '2025-04-11 15:08:23', '你在压力大时的反应通常是？', '{\"A\":\"积极寻求帮助\", \"B\":\"否认问题\", \"C\":\"冲动行为\", \"D\":\"沉默不语\"}', 5, 'C', '冲动应对压力在边缘型人格中较为常见。', 1, 10);
COMMIT;

-- ----------------------------
-- Table structure for examrecord
-- ----------------------------
DROP TABLE IF EXISTS `examrecord`;
CREATE TABLE `examrecord` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `paperid` bigint NOT NULL COMMENT '试卷id（外键）',
  `papername` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试卷名称',
  `questionid` bigint NOT NULL COMMENT '试题id（外键）',
  `questionname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '试题名称',
  `type` bigint DEFAULT NULL COMMENT '试题类型',
  `ismark` bigint DEFAULT NULL COMMENT '是否批卷',
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '选项，json字符串',
  `score` bigint DEFAULT '0' COMMENT '分值',
  `answer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '正确答案',
  `analysis` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '答案解析',
  `myscore` bigint DEFAULT '0' COMMENT '试题得分',
  `myanswer` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '考生答案',
  `userid` bigint NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=973 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='考试记录';

-- ----------------------------
-- Records of examrecord
-- ----------------------------
BEGIN;
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (814, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10003, '当我遇到矛盾和冲突时，我倾向于：', 1, 1, '[{\"text\":\"坚持自己的立场，直到对方妥协\"},{\"text\":\"寻找双方都能接受的解决方案\"},{\"text\":\"避免冲突，保持沉默\"},{\"text\":\"顺从对方，以维持关系\"}]', 10, 'B', '选择A可能表明您有些强势；选择B反映了您善于妥协和寻求共识的能力；选择C表明您可能有回避冲突的倾向；选择D表明您重视关系胜过解决问题。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (815, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10005, '在社交场合中，我通常是：', 1, 1, '[{\"text\":\"活跃的中心人物\"},{\"text\":\"积极与他人交流互动\"},{\"text\":\"安静地观察他人\"},{\"text\":\"感到不自在，希望尽快离开\"}]', 10, 'C', '选择A表明您可能是外向型性格；选择B反映出您可能是社交型性格；选择C表明您可能偏向内向；选择D表明您可能有社交焦虑。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (816, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10002, '在面对挑战时，我通常会：', 1, 1, '[{\"text\":\"勇敢面对，迎难而上\"},{\"text\":\"先评估风险，再决定行动\"},{\"text\":\"担心自己无法应对\"},{\"text\":\"寻求他人帮助或合作\"}]', 10, 'A', '选择A表明您具有积极面对困难的态度；选择B反映了您的谨慎性格；选择C可能表明您有些缺乏自信；选择D表明您注重团队协作。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (817, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10006, '面对重大决策时，我更倾向于：', 1, 1, '[{\"text\":\"分析利弊得失，逻辑决策\"},{\"text\":\"根据自己的感受和价值观决定\"},{\"text\":\"参考他人意见后再做决定\"},{\"text\":\"推迟决定，担心做出错误选择\"}]', 10, 'B', '选择A表明您可能重视理性思考；选择B表明您可能关注情感和价值观；选择C反映出您可能依赖他人决策；选择D表明您可能有决策焦虑。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (818, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10001, '当我感到压力时，我通常会选择：', 1, 1, '[{\"text\":\"静下心来思考解决方案\"},{\"text\":\"向亲近的人倾诉\"},{\"text\":\"转移注意力，做其他事情\"},{\"text\":\"寻求专业帮助\"}]', 10, 'A', '选择A反映了您的冷静思考能力；选择B反映了您的情感依赖倾向；选择C反映了您的回避性格；选择D反映了您的社交依赖性。', 10, 'B', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (819, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10004, '当我犯错误时，我通常会：', 1, 1, '[{\"text\":\"坦然接受并承担责任\"},{\"text\":\"感到羞愧和尴尬\"},{\"text\":\"为自己辩解或找借口\"},{\"text\":\"思考如何避免再次犯同样的错误\"}]', 10, 'A', '选择A表明您具有良好的自我认知和责任感；选择B反映出您可能过于在意他人评价；选择C表明您可能有自我防御的倾向；选择D反映出您有学习和成长的意愿。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (820, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10007, '当我完成一项艰巨任务后，我通常会：', 1, 1, '[{\"text\":\"立即关注任何需要改进的地方\"},{\"text\":\"专注于所取得的成果\"},{\"text\":\"希望得到他人的认可和赞赏\"},{\"text\":\"感到自豪和满足\"}]', 10, 'D', '选择A反映出您可能追求完美；选择B表明您可能注重成果；选择C表明您可能注重外界认可；选择D反映您有良好的自我激励能力。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (821, '2025-04-17 11:05:08', '姓名10', 3, '性格测试', 10008, '当我的计划被打乱时，我通常会：', 1, 1, '[{\"text\":\"坚持原计划，尽量按原定方式进行\"},{\"text\":\"灵活调整，制定新计划\"},{\"text\":\"感到失落和沮丧\"},{\"text\":\"放弃原计划，等待时机\"}]', 10, 'B', '选择A表明您可能有控制欲和固执倾向；选择B反映出您的适应能力和灵活性；选择C表明您可能容易沮丧；选择D反映您可能有回避应对的倾向。', 0, '', 70);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (905, '2025-04-17 15:53:11', '姓名3', 3, '性格测试', 10001, '当我感到压力时，我通常会选择：', 1, 1, '[{\"text\":\"静下心来思考解决方案\"},{\"text\":\"向亲近的人倾诉\"},{\"text\":\"转移注意力，做其他事情\"},{\"text\":\"寻求专业帮助\"}]', 10, 'A', '选择A反映了您的冷静思考能力；选择B反映了您的情感依赖倾向；选择C反映了您的回避性格；选择D反映了您的社交依赖性。', 10, 'C', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (906, '2025-04-17 15:53:11', '姓名3', 3, '性格测试', 10005, '在社交场合中，我通常是：', 1, 1, '[{\"text\":\"活跃的中心人物\"},{\"text\":\"积极与他人交流互动\"},{\"text\":\"安静地观察他人\"},{\"text\":\"感到不自在，希望尽快离开\"}]', 10, 'C', '选择A表明您可能是外向型性格；选择B反映出您可能是社交型性格；选择C表明您可能偏向内向；选择D表明您可能有社交焦虑。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (907, '2025-04-17 15:53:11', '姓名3', 3, '性格测试', 10003, '当我遇到矛盾和冲突时，我倾向于：', 1, 1, '[{\"text\":\"坚持自己的立场，直到对方妥协\"},{\"text\":\"寻找双方都能接受的解决方案\"},{\"text\":\"避免冲突，保持沉默\"},{\"text\":\"顺从对方，以维持关系\"}]', 10, 'B', '选择A可能表明您有些强势；选择B反映了您善于妥协和寻求共识的能力；选择C表明您可能有回避冲突的倾向；选择D表明您重视关系胜过解决问题。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (908, '2025-04-17 15:53:12', '姓名3', 3, '性格测试', 10002, '在面对挑战时，我通常会：', 1, 1, '[{\"text\":\"勇敢面对，迎难而上\"},{\"text\":\"先评估风险，再决定行动\"},{\"text\":\"担心自己无法应对\"},{\"text\":\"寻求他人帮助或合作\"}]', 10, 'A', '选择A表明您具有积极面对困难的态度；选择B反映了您的谨慎性格；选择C可能表明您有些缺乏自信；选择D表明您注重团队协作。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (909, '2025-04-17 15:53:12', '姓名3', 3, '性格测试', 10006, '面对重大决策时，我更倾向于：', 1, 1, '[{\"text\":\"分析利弊得失，逻辑决策\"},{\"text\":\"根据自己的感受和价值观决定\"},{\"text\":\"参考他人意见后再做决定\"},{\"text\":\"推迟决定，担心做出错误选择\"}]', 10, 'B', '选择A表明您可能重视理性思考；选择B表明您可能关注情感和价值观；选择C反映出您可能依赖他人决策；选择D表明您可能有决策焦虑。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (910, '2025-04-17 15:53:12', '姓名3', 3, '性格测试', 10004, '当我犯错误时，我通常会：', 1, 1, '[{\"text\":\"坦然接受并承担责任\"},{\"text\":\"感到羞愧和尴尬\"},{\"text\":\"为自己辩解或找借口\"},{\"text\":\"思考如何避免再次犯同样的错误\"}]', 10, 'A', '选择A表明您具有良好的自我认知和责任感；选择B反映出您可能过于在意他人评价；选择C表明您可能有自我防御的倾向；选择D反映出您有学习和成长的意愿。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (911, '2025-04-17 15:53:12', '姓名3', 3, '性格测试', 10008, '当我的计划被打乱时，我通常会：', 1, 1, '[{\"text\":\"坚持原计划，尽量按原定方式进行\"},{\"text\":\"灵活调整，制定新计划\"},{\"text\":\"感到失落和沮丧\"},{\"text\":\"放弃原计划，等待时机\"}]', 10, 'B', '选择A表明您可能有控制欲和固执倾向；选择B反映出您的适应能力和灵活性；选择C表明您可能容易沮丧；选择D反映您可能有回避应对的倾向。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (912, '2025-04-17 15:53:12', '姓名3', 3, '性格测试', 10007, '当我完成一项艰巨任务后，我通常会：', 1, 1, '[{\"text\":\"立即关注任何需要改进的地方\"},{\"text\":\"专注于所取得的成果\"},{\"text\":\"希望得到他人的认可和赞赏\"},{\"text\":\"感到自豪和满足\"}]', 10, 'D', '选择A反映出您可能追求完美；选择B表明您可能注重成果；选择C表明您可能注重外界认可；选择D反映您有良好的自我激励能力。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (958, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 5, '你是否经常感到情绪极端波动，时而感到高兴，时而感到非常沮丧，且没有明显的原因？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '情绪波动可能反映了情感不稳定的倾向，可能与人格障碍相关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (959, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 6, '你是否在与他人关系中常常感到极度不安，害怕被抛弃或被拒绝？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '这种情感不安可能是边缘型人格障碍的特征。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (960, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 7, '你是否经常不顾后果地做事，比如在没有考虑后果的情况下进行冲动消费、酗酒或做危险的行为？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '冲动行为可能反映了反社会或边缘型人格障碍。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (961, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 10, '你是否对自己的感受和行为缺乏自我控制，经常无法按计划行事或解决问题？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '缺乏自控可能是边缘型人格障碍或冲动型人格障碍的表现。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (962, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 8, '你是否常常对他人的动机或行为抱有怀疑，认为他们总是试图伤害或利用你？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '这种怀疑可能与偏执型人格障碍有关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (963, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 9, '你是否常常感到自己比别人优越，认为别人没有资格和你平等交往？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '过度的自我优越感可能与自恋型人格障碍相关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (964, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 12, '你是否经常对他人的情感反应不敏感，表现出冷漠或缺乏同理心？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '缺乏同理心是反社会人格障碍的常见特征。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (965, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 11, '你是否常常觉得与他人建立深层次关系是困难的，并且更喜欢保持与他人一定的距离？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '这种孤立感可能与回避型人格障碍相关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (966, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 14, '你是否在社交场合中常感到过于紧张，害怕被他人评价或拒绝？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '社交焦虑可能是社交恐惧症或回避型人格障碍的标志。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (967, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 13, '你是否容易对他人的批评产生过度反应，甚至可能表现出攻击性或敌对情绪？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '过度的情绪反应可能是边缘型人格障碍的表现。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (968, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 15, '你是否常常觉得自己无法体验到别人所说的幸福或满足，感到空虚或没有目标？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '空虚感可能与情感障碍或边缘型人格障碍相关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (969, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 16, '你是否经常在紧张和冲突的情况下表现出过度的愤怒或敌意？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '情绪失控可能与边缘型人格障碍有关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (970, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 17, '你是否常常以为他人可能会背叛你或对你不忠，因此表现出过度的警觉性？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '过度的警觉性可能与偏执型人格障碍相关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (971, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 18, '你是否感到生活中的规则和常规让你感到束缚，常常挑战现有的规则和社会规范？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '挑战规则可能与反社会人格障碍相关。', 0, '', 71);
INSERT INTO `examrecord` (`id`, `addtime`, `username`, `paperid`, `papername`, `questionid`, `questionname`, `type`, `ismark`, `options`, `score`, `answer`, `analysis`, `myscore`, `myanswer`, `userid`) VALUES (972, '2025-04-17 15:54:59', '姓名3', 1, '心理测评', 19, '你是否经常感到自己没有明确的生活目标或方向，不知道自己未来的道路是什么？', 1, 1, '[{\"text\":\"经常这样\",\"code\":\"A\"},{\"text\":\"偶尔这样\",\"code\":\"B\"},{\"text\":\"从不这样\",\"code\":\"C\"}]', 10, 'C', '缺乏方向感可能与情感障碍或边缘型人格障碍相关。', 0, '', 71);
COMMIT;

-- ----------------------------
-- Table structure for forum
-- ----------------------------
DROP TABLE IF EXISTS `forum`;
CREATE TABLE `forum` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '帖子标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '帖子内容',
  `parentid` bigint DEFAULT NULL COMMENT '父节点id',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `isdone` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态',
  `is_top` int DEFAULT '0' COMMENT '是否置顶',
  `top_time` datetime DEFAULT NULL COMMENT '置顶时间',
  `thumbsup_number` int DEFAULT '0' COMMENT '赞',
  `crazily_number` int DEFAULT '0' COMMENT '踩',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='论坛交流';

-- ----------------------------
-- Records of forum
-- ----------------------------
BEGIN;
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (1, '2025-04-10 18:01:00', '人格障碍自我检测后的体会分享', '使用平台测评后对自己的人格有了新理解，推荐大家多尝试自测工具。', 0, 1, '匿名用户', 'file/forumAvatarurl1.jpg,file/forumAvatarurl2.jpg,file/forumAvatarurl3.jpg', '开放', 0, NULL, 12, 1);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (2, '2025-04-10 18:05:00', '话题｜心理测评报告怎么看？', '测评完成后拿到报告，有些术语不懂，希望有人解释一下。', 0, 2, '用户名2', 'file/forumAvatarurl2.jpg,file/forumAvatarurl3.jpg,file/forumAvatarurl4.jpg', '开放', 0, NULL, 15, 0);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (3, '2025-04-10 18:08:00', '心理专家答疑｜边缘型人格症状', '欢迎大家提问，今天我在此统一答复关于边缘型人格障碍的常见表现与应对。', 0, 3, '王教授', 'file/forumAvatarurl3.jpg,file/forumAvatarurl4.jpg,file/forumAvatarurl5.jpg', '开放', 1, '2025-04-10 18:10:00', 22, 0);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (4, '2025-04-10 18:13:00', '匿名互助｜自我认知支持小组组队', '如果你也刚开始探索自己人格问题，我们可以组一个匿名互助群互相支持。', 0, 4, '匿名用户', 'file/forumAvatarurl4.jpg,file/forumAvatarurl5.jpg,file/forumAvatarurl6.jpg', '开放', 0, NULL, 18, 1);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (5, '2025-04-10 18:18:00', '话题｜人格障碍会遗传吗？', '家里有成员存在类似问题，我很担心遗传影响。有人了解相关研究吗？', 0, 5, '用户名5', 'file/forumAvatarurl5.jpg,file/forumAvatarurl6.jpg,file/forumAvatarurl7.jpg', '开放', 0, NULL, 11, 2);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (6, '2025-04-10 18:22:00', '心理测评服务是否值得购买？', '看到平台有会员服务可以免费测评和咨询折扣，有朋友体验过吗？', 0, 6, '匿名用户', 'file/forumAvatarurl6.jpg,file/forumAvatarurl7.jpg,file/forumAvatarurl8.jpg', '开放', 0, NULL, 10, 1);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (7, '2025-04-10 18:27:00', '自恋型人格｜如何建立真实关系', '我总觉得别人不理解我，有人说我可能有自恋型人格，怎么办？', 0, 7, '用户名7', 'file/forumAvatarurl7.jpg,file/forumAvatarurl8.jpg,file/forumAvatarurl9.jpg', '开放', 0, NULL, 7, 1);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (8, '2025-04-10 18:33:00', '测评报告显示我有回避型人格', '对社交感到抗拒，总是想逃避冲突，有没有人一样？', 0, 8, '匿名用户', 'file/forumAvatarurl8.jpg,file/forumAvatarurl9.jpg,file/forumAvatarurl10.jpg', '开放', 0, '2025-04-16 21:35:30', 9, 0);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (9, '2025-04-10 18:38:00', '专家讲解｜人格障碍类型与区别', '今天我来讲解常见人格障碍类型：边缘型、依赖型、自恋型等如何区分。', 0, 9, '周医生', 'file/forumAvatarurl9.jpg,file/forumAvatarurl10.jpg,file/forumAvatarurl11.jpg', '开放', 1, '2025-04-10 18:39:00', 20, 0);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (10, '2025-04-10 18:43:00', '测评之后的转变｜我的自救之路', '测评让我意识到自己需要改变的一些地方，大家有什么转变经历？', 0, 10, '匿名用户', 'file/forumAvatarurl10.jpg,file/forumAvatarurl11.jpg,file/forumAvatarurl12.jpg', '开放', 1, '2025-04-10 18:43:00', 13, 1);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (11, '2025-04-10 21:01:36', NULL, '<p>有人吗</p>', 9, 70, '10', 'file/yonghuTouxiang10.jpg', NULL, 0, NULL, 0, 0);
INSERT INTO `forum` (`id`, `addtime`, `title`, `content`, `parentid`, `userid`, `username`, `avatarurl`, `isdone`, `is_top`, `top_time`, `thumbsup_number`, `crazily_number`) VALUES (12, '2025-04-10 21:27:49', '抑郁求助！', '<p>抑郁怎么办？</p>', 0, 70, '10', 'file/yonghuTouxiang10.jpg', '开放', 0, '2025-04-11 14:35:29', 0, 0);
COMMIT;

-- ----------------------------
-- Table structure for gaopinggongju
-- ----------------------------
DROP TABLE IF EXISTS `gaopinggongju`;
CREATE TABLE `gaopinggongju` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gongjumingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '工具名称',
  `tupian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `xiangqing` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '详情',
  `shiyongfangfa` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '使用方法',
  `price` double DEFAULT '0' COMMENT '价格',
  `discuss_number` int DEFAULT '0' COMMENT '评论数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='高评工具';

-- ----------------------------
-- Records of gaopinggongju
-- ----------------------------
BEGIN;
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (1, '2025-04-08 12:00:00', '人格障碍评估工具包', 'file/gaopinggongjuTupian1.jpg,file/gaopinggongjuTupian2.jpg,file/gaopinggongjuTupian3.jpg', '用于早期发现和评估人格障碍类型，支持量表评分与结果解释。', '在线填写测评问卷，自动生成评估结果', 99.9, 1);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (2, '2025-04-08 12:00:00', '心理健康全面测评仪', 'file/gaopinggongjuTupian2.jpg,file/gaopinggongjuTupian3.jpg', '全面评估心理健康状况，包括焦虑、抑郁、人格特质等。', '通过平台进行综合心理测试并出具报告', 104.9, 2);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (3, '2025-04-08 12:00:00', '边缘型人格测试套件', 'file/gaopinggongjuTupian3.jpg', '针对边缘型人格的特征量身定制的测试题与解释方案。', '选择题测试+结果匹配反馈', 109.9, 3);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (4, '2025-04-08 12:00:00', '心理测评报告解读助手', 'file/gaopinggongjuTupian4.jpg', '自动生成测评报告解读，配合咨询师使用效果更佳。', '上传测评结果，自动生成分析', 114.9, 4);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (5, '2025-04-08 12:00:00', '自我认知成长训练工具', 'file/gaopinggongjuTupian5.jpg,file/gaopinggongjuTupian6.jpg,file/gaopinggongjuTupian7.jpg', '提升自我觉察力，改善情绪管理与行为调节能力。', '每日练习与反馈，形成自我调节计划', 119.9, 5);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (6, '2025-04-08 12:00:00', '社交障碍自评与分析', 'file/gaopinggongjuTupian6.jpg,file/gaopinggongjuTupian7.jpg,file/gaopinggongjuTupian8.jpg', '识别社交中的不适行为模式，提供个性化改善建议。', '匿名填写后生成社交改善建议', 124.9, 6);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (7, '2025-04-08 12:00:00', '依赖型人格干预指南', 'file/gaopinggongjuTupian7.jpg,file/gaopinggongjuTupian8.jpg,file/gaopinggongjuTupian9.jpg', '帮助识别依赖行为，支持CBT干预配合咨询课程。', '依赖指数分析+自助训练方案下载', 129.9, 7);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (8, '2025-04-08 12:00:00', '强迫型人格识别工具', 'file/gaopinggongjuTupian8.jpg,file/gaopinggongjuTupian9.jpg,file/gaopinggongjuTupian10.jpg', '精准检测强迫型行为和思维模式，辅助行为疗法使用。', '行为情境测试+结果解读', 134.9, 8);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (9, '2025-04-08 12:00:00', '青少年人格倾向测评工具', 'file/gaopinggongjuTupian6.jpg', '适合青少年人格发展筛查，提供早期干预建议。', '青少年模式测试+图形化反馈', 139.9, 9);
INSERT INTO `gaopinggongju` (`id`, `addtime`, `gongjumingcheng`, `tupian`, `xiangqing`, `shiyongfangfa`, `price`, `discuss_number`) VALUES (10, '2025-04-08 12:00:00', '心理咨询会员专属工具箱', 'file/gaopinggongjuTupian1.jpg', '限会员使用，包含所有测评免费权限及课程购买优惠。', '登录会员账号后可一键启用所有功能', 144.9, 10);
COMMIT;

-- ----------------------------
-- Table structure for jiankangjianyi
-- ----------------------------
DROP TABLE IF EXISTS `jiankangjianyi`;
CREATE TABLE `jiankangjianyi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `biaoti` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '标题',
  `zixunshizhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师账号',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `jianyishijian` datetime DEFAULT NULL COMMENT '建议时间',
  `zhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `shouji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `jianyineirong` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '建议内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='健康建议';

-- ----------------------------
-- Records of jiankangjianyi
-- ----------------------------
BEGIN;
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (1, '2025-03-22 12:42:31', '标题1', '咨询师账号1', '联系方式1', '2025-03-22 12:42:31', '账号1', '手机1', '建议内容1');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (2, '2025-03-22 12:42:31', '标题2', '咨询师账号2', '联系方式2', '2025-03-22 12:42:31', '账号2', '手机2', '建议内容2');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (3, '2025-03-22 12:42:31', '标题3', '咨询师账号3', '联系方式3', '2025-03-22 12:42:31', '账号3', '手机3', '建议内容3');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (4, '2025-03-22 12:42:31', '标题4', '咨询师账号4', '联系方式4', '2025-03-22 12:42:31', '账号4', '手机4', '建议内容4');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (5, '2025-03-22 12:42:31', '标题5', '咨询师账号5', '联系方式5', '2025-03-22 12:42:31', '账号5', '手机5', '建议内容5');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (6, '2025-03-22 12:42:31', '标题6', '咨询师账号6', '联系方式6', '2025-03-22 12:42:31', '账号6', '手机6', '建议内容6');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (7, '2025-03-22 12:42:31', '标题7', '咨询师账号7', '联系方式7', '2025-03-22 12:42:31', '账号7', '手机7', '建议内容7');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (8, '2025-03-22 12:42:31', '标题8', '咨询师账号8', '联系方式8', '2025-03-22 12:42:31', '账号8', '手机8', '建议内容8');
INSERT INTO `jiankangjianyi` (`id`, `addtime`, `biaoti`, `zixunshizhanghao`, `lianxifangshi`, `jianyishijian`, `zhanghao`, `shouji`, `jianyineirong`) VALUES (9, '2025-03-22 12:42:31', '标题9', '咨询师账号9', '联系方式9', '2025-03-22 12:42:31', '账号9', '手机9', '建议内容9');
COMMIT;

-- ----------------------------
-- Table structure for kechengleixing
-- ----------------------------
DROP TABLE IF EXISTS `kechengleixing`;
CREATE TABLE `kechengleixing` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengleixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程类型';

-- ----------------------------
-- Records of kechengleixing
-- ----------------------------
BEGIN;
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (1, '2025-04-11 15:11:00', '人格障碍基础测评');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (2, '2025-04-11 15:12:00', '边缘型人格管理');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (3, '2025-04-11 15:13:00', '强迫型人格调节');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (4, '2025-04-11 15:14:00', '回避型人格自助');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (5, '2025-04-11 15:15:00', '自恋型人格应对');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (6, '2025-04-11 15:16:00', '依赖型人格独立训练');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (7, '2025-04-11 15:17:00', 'PDQ-4测评解读');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (8, '2025-04-11 15:18:00', 'MMPI人格测评实操');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (9, '2025-04-11 15:19:00', '心理咨询技巧入门');
INSERT INTO `kechengleixing` (`id`, `addtime`, `kechengleixing`) VALUES (10, '2025-04-11 15:20:00', '人格障碍干预与成长');
COMMIT;

-- ----------------------------
-- Table structure for kechengxinxi
-- ----------------------------
DROP TABLE IF EXISTS `kechengxinxi`;
CREATE TABLE `kechengxinxi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `kechengmingcheng` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `kechengtupian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '课程图片',
  `kechengleixing` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程类型',
  `kechengjianjie` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '课程简介',
  `kechengshipin` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '课程视频',
  `fabushijian` datetime DEFAULT NULL COMMENT '发布时间',
  `storeup_number` int DEFAULT NULL COMMENT '收藏数',
  `discuss_number` int DEFAULT NULL COMMENT '评论数',
  `clicktime` datetime DEFAULT NULL COMMENT '最近点击时间',
  `price` double DEFAULT '0' COMMENT '价格',
  `jf` int DEFAULT '-1' COMMENT '积分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程信息';

-- ----------------------------
-- Records of kechengxinxi
-- ----------------------------
BEGIN;
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (1, '2025-03-22 12:42:31', '人格障碍自我检测与评估', 'file/kechengxinxiKechengtupian1.jpg', '人格障碍基础测评', '本课程将引导学员通过自我评估来识别可能的人格障碍特征，重点介绍情感不稳定、冲动控制及人际关系问题。', '', '2025-03-22 12:42:31', 1, 1, '2025-04-15 17:46:19', 99.9, 10000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (2, '2025-03-22 12:42:31', '边缘型人格障碍与治疗方法', 'file/kechengxinxiKechengtupian2.jpg', '边缘型人格管理', '探索边缘型人格障碍的症状及其治疗方法，课程涵盖情感波动管理、冲动控制技巧及社交技巧的提升。', '', '2025-03-22 12:42:31', 2, 3, '2025-04-16 21:25:58', 109.9, 12000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (3, '2025-03-22 12:42:31', '反社会人格障碍识别与应对', 'file/kechengxinxiKechengtupian3.jpg', '强迫型人格调节', '课程专注于反社会人格障碍的识别与管理，包括认知行为疗法（CBT）在内的多种治疗方法。', '', '2025-03-22 12:42:31', 0, 2, '2025-04-16 21:36:46', 79.9, 9000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (4, '2025-03-22 12:42:31', '自恋型人格障碍的应对技巧', 'file/kechengxinxiKechengtupian1.jpg', '回避型人格自助', '本课程讲解如何识别和应对自恋型人格障碍，帮助学员更好地管理人际关系与情感需求。', '', '2025-03-22 12:42:31', 0, 0, '2025-04-13 19:37:03', 59.9, 5000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (5, '2025-03-22 12:42:31', '人格障碍与情感调节技巧', 'file/kechengxinxiKechengtupian2.jpg', '自恋型人格应对', '通过学习情感调节技巧和认知行为疗法，学员将学会有效控制情感波动，减少冲动行为。', '', '2025-03-22 12:42:31', 0, 5, '2025-04-15 17:46:03', 119.9, 13000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (6, '2025-03-22 12:42:31', '治疗人格障碍的科学方法', 'file/kechengxinxiKechengtupian6.jpg', '依赖型人格独立训练', '该课程介绍了现代治疗人格障碍的科学方法，尤其是通过心理治疗来应对人格障碍相关症状。', '', '2025-03-22 12:42:31', 0, 2, '2025-04-15 17:52:39', 89.9, 11000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (7, '2025-03-22 12:42:31', '回避型人格障碍的识别与治疗', 'file/kechengxinxiKechengtupian7.jpg', 'PDQ-4测评解读', '课程讲解回避型人格障碍的症状，帮助学员识别并采取有效的治疗方法以减轻焦虑与恐惧。', '', '2025-03-22 12:42:31', 0, 4, '2025-04-15 17:53:27', 89.9, 9500);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (8, '2025-03-22 12:42:31', '依赖型人格障碍的自我帮助策略', 'file/kechengxinxiKechengtupian8.jpg', 'MMPI人格测评实操', '本课程为依赖型人格障碍学员提供自我帮助策略，帮助他们培养独立性和自信心，减少情感依赖。', '', '2025-03-22 12:42:31', 1, 1, '2025-04-15 17:45:34', 99.9, 10000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (9, '2025-03-22 12:42:31', '反社会行为与心理治疗', 'file/kechengxinxiKechengtupian2.jpg', '心理咨询技巧入门', '该课程专门讲解如何通过心理治疗减少反社会行为，帮助学员重建社会功能并改善人际关系。', '', '2025-03-22 12:42:31', 2, 0, '2025-04-15 17:45:25', 109.9, 12000);
INSERT INTO `kechengxinxi` (`id`, `addtime`, `kechengmingcheng`, `kechengtupian`, `kechengleixing`, `kechengjianjie`, `kechengshipin`, `fabushijian`, `storeup_number`, `discuss_number`, `clicktime`, `price`, `jf`) VALUES (10, '2025-03-22 12:42:31', '人格障碍的早期识别与干预', 'file/kechengxinxiKechengtupian1.jpg', '人格障碍干预与成长', '学习如何在早期识别人格障碍症状，并采用有效的干预方法进行治疗。适合有心理健康问题的学员。', '', '2025-03-22 12:42:31', 3, 1, '2025-04-15 17:45:00', 79.9, 9000);
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `menujson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单';

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` (`id`, `addtime`, `menujson`) VALUES (1, '2025-03-22 12:42:31', '[{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-phone\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"users\",\"menu\":\"管理员\",\"menuJump\":\"列表\",\"tableName\":\"users\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"私信\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"yonghu\",\"menu\":\"用户\",\"menuJump\":\"列表\",\"tableName\":\"yonghu\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"私信\",\"预约\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\"],\"classname\":\"zixunshi\",\"menu\":\"咨询师\",\"menuJump\":\"列表\",\"tableName\":\"zixunshi\"}],\"fontClass\":\"icon-user2\",\"menu\":\"用户管理\",\"unicode\":\"&#xef98;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"appFrontIcon\":\"cuIcon-discover\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"查看评论\"],\"classname\":\"xinlijiankangxuexi\",\"menu\":\"心理健康学习\",\"menuJump\":\"列表\",\"tableName\":\"xinlijiankangxuexi\"}],\"fontClass\":\"icon-common17\",\"menu\":\"心理健康学习管理\",\"unicode\":\"&#xedfe;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"咨询师预约统计\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-keyboard\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"审核\",\"咨询师预约统计\",\"首页总数\",\"首页统计\"],\"classname\":\"zixunshiyuyue\",\"menu\":\"咨询师预约\",\"menuJump\":\"列表\",\"tableName\":\"zixunshiyuyue\"}],\"fontClass\":\"icon-common10\",\"menu\":\"咨询师预约管理\",\"unicode\":\"&#xedd1;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"组卷\",\"调查统计\"],\"appFrontIcon\":\"cuIcon-goodsnew\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"组卷\",\"调查统计\"],\"classname\":\"exampaper\",\"menu\":\"在线测试\",\"tableName\":\"exampaper\"}],\"fontClass\":\"icon-common25\",\"menu\":\"在线测试\",\"unicode\":\"&#xee09;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"打印\",\"导出\"],\"appFrontIcon\":\"cuIcon-goods\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"打印\",\"导出\"],\"classname\":\"examquestion\",\"menu\":\"试题管理\",\"menuJump\":\"列表\",\"tableName\":\"examquestion\"}],\"fontClass\":\"icon-common14\",\"menu\":\"试题管理\",\"unicode\":\"&#xedfb;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"打印\",\"导出\"],\"appFrontIcon\":\"cuIcon-time\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"打印\",\"导出\"],\"classname\":\"examquestionbank\",\"menu\":\"试题库管理\",\"menuJump\":\"列表\",\"tableName\":\"examquestionbank\"}],\"fontClass\":\"icon-common41\",\"menu\":\"试题库管理\",\"unicode\":\"&#xeede;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-goodsnew\",\"buttons\":[\"查看\"],\"classname\":\"exampaper\",\"menu\":\"在线测试\",\"menuJump\":\"12\",\"tableName\":\"exampaper\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"批卷\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\",\"批卷\"],\"classname\":\"examrecord\",\"menu\":\"考试记录\",\"tableName\":\"examrecord\"}],\"fontClass\":\"icon-common11\",\"menu\":\"考试管理\",\"unicode\":\"&#xeded;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"测试评分统计\",\"账号统计\",\"首页总数\",\"首页统计\",\"建议\"],\"appFrontIcon\":\"cuIcon-brand\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"测试评分统计\",\"首页总数\",\"首页统计\"],\"classname\":\"ceshipingfen\",\"menu\":\"测试评分\",\"menuJump\":\"列表\",\"tableName\":\"ceshipingfen\"}],\"fontClass\":\"icon-common34\",\"menu\":\"测试评分管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"jiankangjianyi\",\"menu\":\"健康建议\",\"menuJump\":\"列表\",\"tableName\":\"jiankangjianyi\"}],\"fontClass\":\"icon-common2\",\"menu\":\"健康建议管理\",\"unicode\":\"&#xeda4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"热门帖子统计\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-send\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"热门帖子统计\",\"首页总数\",\"首页统计\"],\"classname\":\"forum\",\"menu\":\"论坛交流\",\"tableName\":\"forum\"}],\"fontClass\":\"icon-common32\",\"menu\":\"论坛管理\",\"unicode\":\"&#xee66;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"回复\"],\"appFrontIcon\":\"cuIcon-newshot\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"回复\"],\"classname\":\"messages\",\"menu\":\"反馈建议\",\"menuJump\":\"列表\",\"tableName\":\"messages\"}],\"fontClass\":\"icon-common32\",\"menu\":\"反馈建议管理\",\"unicode\":\"&#xee66;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\",\"修改\"],\"classname\":\"config\",\"menu\":\"轮播图\",\"menuJump\":\"列表\",\"tableName\":\"config\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-discover\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"news\",\"menu\":\"心理资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\"}],\"fontClass\":\"icon-common46\",\"menu\":\"系统管理\",\"unicode\":\"&#xef3d;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\",\"修改\"],\"menu\":\"全部订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"}],\"menu\":\"订单管理\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-album\",\"buttons\":[\"查看\"],\"classname\":\"ceshibaogao\",\"menu\":\"测试报告\",\"menuJump\":\"列表\",\"tableName\":\"ceshibaogao\"}],\"fontClass\":\"icon-common33\",\"menu\":\"测试报告管理\",\"unicode\":\"&#xee6a;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-explore\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"chat\",\"menu\":\"客服聊天\",\"menuJump\":\"列表\",\"tableName\":\"chat\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-camera\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"chathelper\",\"menu\":\"聊天助手\",\"menuJump\":\"列表\",\"tableName\":\"chathelper\"}],\"fontClass\":\"icon-common43\",\"menu\":\"客服聊天管理\",\"unicode\":\"&#xef27;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"查看\",\"修改\",\"删除\",\"查看评论\"],\"classname\":\"kechengxinxi\",\"menu\":\"课程信息\",\"menuJump\":\"列表\",\"tableName\":\"kechengxinxi\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"appFrontIcon\":\"cuIcon-medal\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"gaopinggongju\",\"menu\":\"高评工具\",\"menuJump\":\"列表\",\"tableName\":\"gaopinggongju\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"kechengleixing\",\"menu\":\"课程类型\",\"menuJump\":\"列表\",\"tableName\":\"kechengleixing\"}],\"fontClass\":\"icon-common10\",\"menu\":\"课程信息管理\",\"unicode\":\"&#xedd1;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"xinlijiankangxuexi\",\"menu\":\"心理健康学习\",\"menuJump\":\"列表\",\"tableName\":\"xinlijiankangxuexi\"}],\"menu\":\"心理健康学习\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\",\"私信\",\"预约\"],\"classname\":\"zixunshi\",\"menu\":\"咨询师\",\"menuJump\":\"列表\",\"tableName\":\"zixunshi\"}],\"menu\":\"咨询师\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"classname\":\"exampaper\",\"fontClass\":\"icon-common43\",\"menu\":\"在线测试\",\"menuJump\":\"12\",\"tableName\":\"exampaper\",\"unicode\":\"&#xef27;\"}],\"fontClass\":\"icon-common43\",\"menu\":\"在线测试\",\"unicode\":\"&#xef27;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-send\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"forum\",\"fontClass\":\"icon-common49\",\"menu\":\"论坛交流\",\"menuJump\":\"列表\",\"tableName\":\"forum\",\"unicode\":\"&#xef79;\"}],\"fontClass\":\"icon-common49\",\"menu\":\"论坛交流\",\"unicode\":\"&#xef79;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-time\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"messages\",\"menu\":\"反馈建议\",\"menuJump\":\"列表\",\"tableName\":\"messages\"}],\"menu\":\"反馈建议\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"menu\":\"心理资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\"}],\"menu\":\"心理资讯\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-present\",\"buttons\":[\"查看\",\"查看评论\"],\"classname\":\"kechengxinxi\",\"menu\":\"课程信息\",\"menuJump\":\"列表\",\"tableName\":\"kechengxinxi\"}],\"menu\":\"课程信息管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\"],\"classname\":\"chat\",\"menu\":\"客服聊天\",\"menuJump\":\"列表\",\"tableName\":\"chat\"}],\"menu\":\"客服聊天管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-skin\",\"buttons\":[\"查看\"],\"classname\":\"gaopinggongju\",\"menu\":\"高评工具\",\"menuJump\":\"列表\",\"tableName\":\"gaopinggongju\"}],\"menu\":\"高评工具管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"users\",\"roleName\":\"管理员\",\"tableName\":\"users\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"私信\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"查看\",\"私信\"],\"classname\":\"yonghu\",\"menu\":\"用户\",\"menuJump\":\"列表\",\"tableName\":\"yonghu\"}],\"fontClass\":\"icon-user2\",\"menu\":\"用户管理\",\"unicode\":\"&#xef98;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"咨询师预约统计\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-keyboard\",\"buttons\":[\"查看\"],\"classname\":\"zixunshiyuyue\",\"menu\":\"咨询师预约\",\"menuJump\":\"列表\",\"tableName\":\"zixunshiyuyue\"}],\"fontClass\":\"icon-common10\",\"menu\":\"咨询师预约管理\",\"unicode\":\"&#xedd1;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-goodsnew\",\"buttons\":[\"查看\"],\"classname\":\"exampaper\",\"menu\":\"在线测试\",\"menuJump\":\"12\",\"tableName\":\"exampaper\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"批卷\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"classname\":\"examrecord\",\"menu\":\"考试记录\",\"tableName\":\"examrecord\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"classname\":\"examrecord\",\"menu\":\"错题本\",\"menuJump\":\"22\",\"tableName\":\"examrecord\"}],\"fontClass\":\"icon-common11\",\"menu\":\"考试管理\",\"unicode\":\"&#xeded;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"测试评分统计\",\"账号统计\",\"首页总数\",\"首页统计\",\"建议\"],\"appFrontIcon\":\"cuIcon-brand\",\"buttons\":[\"查看\"],\"classname\":\"ceshipingfen\",\"menu\":\"测试评分\",\"menuJump\":\"列表\",\"tableName\":\"ceshipingfen\"}],\"fontClass\":\"icon-common34\",\"menu\":\"测试评分管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\"],\"classname\":\"jiankangjianyi\",\"menu\":\"健康建议\",\"menuJump\":\"列表\",\"tableName\":\"jiankangjianyi\"}],\"fontClass\":\"icon-common2\",\"menu\":\"健康建议管理\",\"unicode\":\"&#xeda4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-send\",\"buttons\":[\"查看\"],\"classname\":\"forum\",\"menu\":\"我的发布\",\"menuJump\":\"14\",\"tableName\":\"forum\"}],\"fontClass\":\"icon-common32\",\"menu\":\"论坛管理\",\"unicode\":\"&#xee66;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\",\"确认收货\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\"],\"menu\":\"全部订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"}],\"menu\":\"订单管理\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-pic\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"address\",\"menu\":\"地址\",\"menuJump\":\"列表\",\"tableName\":\"address\"}],\"fontClass\":\"icon-common48\",\"menu\":\"地址管理\",\"unicode\":\"&#xef65;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-album\",\"buttons\":[\"查看\"],\"classname\":\"ceshibaogao\",\"menu\":\"测试报告\",\"menuJump\":\"列表\",\"tableName\":\"ceshibaogao\"}],\"fontClass\":\"icon-common33\",\"menu\":\"测试报告管理\",\"unicode\":\"&#xee6a;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"查看\",\"删除\"],\"classname\":\"storeup\",\"menu\":\"我的收藏\",\"menuJump\":\"1\",\"tableName\":\"storeup\"}],\"fontClass\":\"icon-common3\",\"menu\":\"我的收藏管理\",\"unicode\":\"&#xeda5;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-wenzi\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"cart\",\"menu\":\"购物车\",\"menuJump\":\"列表\",\"tableName\":\"cart\"}],\"fontClass\":\"icon-common39\",\"menu\":\"购物车管理\",\"unicode\":\"&#xeeba;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"新增\",\"查看\"],\"classname\":\"chatMessage\",\"menu\":\"消息表\",\"menuJump\":\"列表\",\"tableName\":\"chat_message\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-cardboard\",\"buttons\":[\"新增\",\"查看\"],\"classname\":\"chatFriend\",\"menu\":\"好友表\",\"menuJump\":\"列表\",\"tableName\":\"chat_friend\"}],\"fontClass\":\"icon-common45\",\"menu\":\"消息表管理\",\"unicode\":\"&#xef3b;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"xinlijiankangxuexi\",\"menu\":\"心理健康学习\",\"menuJump\":\"列表\",\"tableName\":\"xinlijiankangxuexi\"}],\"menu\":\"心理健康学习\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\",\"私信\",\"预约\"],\"classname\":\"zixunshi\",\"menu\":\"咨询师\",\"menuJump\":\"列表\",\"tableName\":\"zixunshi\"}],\"menu\":\"咨询师\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"classname\":\"exampaper\",\"fontClass\":\"icon-common43\",\"menu\":\"在线测试\",\"menuJump\":\"12\",\"tableName\":\"exampaper\",\"unicode\":\"&#xef27;\"}],\"fontClass\":\"icon-common43\",\"menu\":\"在线测试\",\"unicode\":\"&#xef27;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-send\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"forum\",\"fontClass\":\"icon-common49\",\"menu\":\"论坛交流\",\"menuJump\":\"列表\",\"tableName\":\"forum\",\"unicode\":\"&#xef79;\"}],\"fontClass\":\"icon-common49\",\"menu\":\"论坛交流\",\"unicode\":\"&#xef79;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-time\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"messages\",\"menu\":\"反馈建议\",\"menuJump\":\"列表\",\"tableName\":\"messages\"}],\"menu\":\"反馈建议\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"menu\":\"心理资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\"}],\"menu\":\"心理资讯\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-present\",\"buttons\":[\"查看\",\"查看评论\"],\"classname\":\"kechengxinxi\",\"menu\":\"课程信息\",\"menuJump\":\"列表\",\"tableName\":\"kechengxinxi\"}],\"menu\":\"课程信息管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\"],\"classname\":\"chat\",\"menu\":\"客服聊天\",\"menuJump\":\"列表\",\"tableName\":\"chat\"}],\"menu\":\"客服聊天管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-skin\",\"buttons\":[\"查看\"],\"classname\":\"gaopinggongju\",\"menu\":\"高评工具\",\"menuJump\":\"列表\",\"tableName\":\"gaopinggongju\"}],\"menu\":\"高评工具管理\"}],\"hasBackLogin\":\"否\",\"hasBackRegister\":\"否\",\"hasFrontLogin\":\"是\",\"hasFrontRegister\":\"是\",\"pathName\":\"yonghu\",\"roleName\":\"用户\",\"tableName\":\"yonghu\"},{\"backMenu\":[{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"私信\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"查看\",\"私信\"],\"classname\":\"yonghu\",\"menu\":\"用户\",\"menuJump\":\"列表\",\"tableName\":\"yonghu\"}],\"fontClass\":\"icon-user2\",\"menu\":\"用户管理\",\"unicode\":\"&#xef98;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"appFrontIcon\":\"cuIcon-discover\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"classname\":\"xinlijiankangxuexi\",\"menu\":\"心理健康学习\",\"menuJump\":\"列表\",\"tableName\":\"xinlijiankangxuexi\"}],\"fontClass\":\"icon-common17\",\"menu\":\"心理健康学习管理\",\"unicode\":\"&#xedfe;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"审核\",\"咨询师预约统计\",\"首页总数\",\"首页统计\"],\"appFrontIcon\":\"cuIcon-keyboard\",\"buttons\":[\"查看\",\"审核\",\"咨询师预约统计\",\"首页总数\",\"首页统计\"],\"classname\":\"zixunshiyuyue\",\"menu\":\"咨询师预约\",\"menuJump\":\"列表\",\"tableName\":\"zixunshiyuyue\"}],\"fontClass\":\"icon-common10\",\"menu\":\"咨询师预约管理\",\"unicode\":\"&#xedd1;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"测试评分统计\",\"账号统计\",\"首页总数\",\"首页统计\",\"建议\"],\"appFrontIcon\":\"cuIcon-brand\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"测试评分统计\",\"首页总数\",\"首页统计\",\"建议\"],\"classname\":\"ceshipingfen\",\"menu\":\"测试评分\",\"menuJump\":\"列表\",\"tableName\":\"ceshipingfen\"}],\"fontClass\":\"icon-common34\",\"menu\":\"测试评分管理\",\"unicode\":\"&#xee85;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\",\"修改\",\"删除\"],\"classname\":\"jiankangjianyi\",\"menu\":\"健康建议\",\"menuJump\":\"列表\",\"tableName\":\"jiankangjianyi\"}],\"fontClass\":\"icon-common2\",\"menu\":\"健康建议管理\",\"unicode\":\"&#xeda4;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"已取消订单\",\"menuJump\":\"已取消\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"发货\",\"物流\",\"核销\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"发货\",\"物流\",\"查看\"],\"menu\":\"已支付订单\",\"menuJump\":\"已支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\"],\"menu\":\"全部订单\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已退款订单\",\"menuJump\":\"已退款\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"物流\",\"查看\"],\"menu\":\"已完成订单\",\"menuJump\":\"已完成\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\"],\"menu\":\"未支付订单\",\"menuJump\":\"未支付\",\"tableName\":\"orders\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"导出\",\"确认收货\",\"物流\"],\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"查看\",\"物流\"],\"menu\":\"已发货订单\",\"menuJump\":\"已发货\",\"tableName\":\"orders\"}],\"menu\":\"订单管理\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"appFrontIcon\":\"cuIcon-album\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"ceshibaogao\",\"menu\":\"测试报告\",\"menuJump\":\"列表\",\"tableName\":\"ceshibaogao\"}],\"fontClass\":\"icon-common33\",\"menu\":\"测试报告管理\",\"unicode\":\"&#xee6a;\"},{\"child\":[{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"appFrontIcon\":\"cuIcon-form\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"classname\":\"kechengxinxi\",\"menu\":\"课程信息\",\"menuJump\":\"列表\",\"tableName\":\"kechengxinxi\"},{\"allButtons\":[\"新增\",\"查看\",\"修改\",\"删除\",\"查看评论\"],\"appFrontIcon\":\"cuIcon-medal\",\"buttons\":[\"新增\",\"查看\",\"修改\",\"删除\"],\"classname\":\"gaopinggongju\",\"menu\":\"高评工具\",\"menuJump\":\"列表\",\"tableName\":\"gaopinggongju\"}],\"fontClass\":\"icon-common10\",\"menu\":\"课程信息管理\",\"unicode\":\"&#xedd1;\"}],\"frontMenu\":[{\"child\":[{\"appFrontIcon\":\"cuIcon-rank\",\"buttons\":[\"查看\"],\"classname\":\"xinlijiankangxuexi\",\"menu\":\"心理健康学习\",\"menuJump\":\"列表\",\"tableName\":\"xinlijiankangxuexi\"}],\"menu\":\"心理健康学习\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-copy\",\"buttons\":[\"查看\",\"私信\",\"预约\"],\"classname\":\"zixunshi\",\"menu\":\"咨询师\",\"menuJump\":\"列表\",\"tableName\":\"zixunshi\"}],\"menu\":\"咨询师\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-news\",\"buttons\":[\"查看\"],\"classname\":\"exampaper\",\"fontClass\":\"icon-common43\",\"menu\":\"在线测试\",\"menuJump\":\"12\",\"tableName\":\"exampaper\",\"unicode\":\"&#xef27;\"}],\"fontClass\":\"icon-common43\",\"menu\":\"在线测试\",\"unicode\":\"&#xef27;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-send\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"forum\",\"fontClass\":\"icon-common49\",\"menu\":\"论坛交流\",\"menuJump\":\"列表\",\"tableName\":\"forum\",\"unicode\":\"&#xef79;\"}],\"fontClass\":\"icon-common49\",\"menu\":\"论坛交流\",\"unicode\":\"&#xef79;\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-time\",\"buttons\":[\"查看\",\"新增\"],\"classname\":\"messages\",\"menu\":\"反馈建议\",\"menuJump\":\"列表\",\"tableName\":\"messages\"}],\"menu\":\"反馈建议\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-circle\",\"buttons\":[\"查看\"],\"classname\":\"news\",\"menu\":\"心理资讯\",\"menuJump\":\"列表\",\"tableName\":\"news\"}],\"menu\":\"心理资讯\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-present\",\"buttons\":[\"查看\",\"查看评论\"],\"classname\":\"kechengxinxi\",\"menu\":\"课程信息\",\"menuJump\":\"列表\",\"tableName\":\"kechengxinxi\"}],\"menu\":\"课程信息管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-qrcode\",\"buttons\":[\"新增\",\"查看\"],\"classname\":\"chat\",\"menu\":\"客服聊天\",\"menuJump\":\"列表\",\"tableName\":\"chat\"}],\"menu\":\"客服聊天管理\"},{\"child\":[{\"appFrontIcon\":\"cuIcon-skin\",\"buttons\":[\"查看\"],\"classname\":\"gaopinggongju\",\"menu\":\"高评工具\",\"menuJump\":\"列表\",\"tableName\":\"gaopinggongju\"}],\"menu\":\"高评工具管理\"}],\"hasBackLogin\":\"是\",\"hasBackRegister\":\"是\",\"hasFrontLogin\":\"否\",\"hasFrontRegister\":\"否\",\"pathName\":\"zixunshi\",\"roleName\":\"咨询师\",\"tableName\":\"zixunshi\"}]');
COMMIT;

-- ----------------------------
-- Table structure for messages
-- ----------------------------
DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `userid` bigint NOT NULL COMMENT '留言人id',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户名',
  `avatarurl` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '留言内容',
  `cpicture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '留言图片',
  `reply` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  `rpicture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复图片',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='反馈建议';

-- ----------------------------
-- Records of messages
-- ----------------------------
BEGIN;
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (1, '2025-04-11 15:01:00', 10, '访客1', 'file/messagesAvatarurl1.jpg', '最近做了PDQ-4的人格测评，不太懂分数代表什么，能解释一下吗？', 'file/messagesCpicture1.jpg', '您好，PDQ-4主要用于筛查人格障碍风险，建议结合心理咨询进一步判断。<br><hr style=\"border-top: 1px dashed #ccc;\"><div style=\"margin-top:8px;\">10 回复: 2025/4/11 15:21:35</div><div><p><img src=\"http://localhost:8080/pdas/file/1744356093613.jpg\" alt=\"\" data-href=\"\" style=\"\"/></p></div>', 'file/messagesRpicture1.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (2, '2025-04-11 15:02:00', 20, '访客2', 'file/messagesAvatarurl2.jpg', 'MMPI测评的报告中提到了“社交回避”，这是什么意思？', 'file/messagesCpicture2.jpg', '您好，这是指个体倾向于回避社交场合，可能与回避型人格相关。建议关注。', 'file/messagesRpicture2.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (3, '2025-04-11 15:03:00', 30, '访客3', 'file/messagesAvatarurl3.jpg', '人格障碍测评后很焦虑，是不是我真的有问题了？', 'file/messagesCpicture3.jpg', '请别过度担心，测评只是初步筛查，不代表正式诊断，建议和专业人员进一步沟通。', 'file/messagesRpicture3.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (4, '2025-04-11 15:04:00', 40, '访客4', 'file/messagesAvatarurl4.jpg', '我在测试中有强迫型倾向，这会影响生活吗？', 'file/messagesCpicture4.jpg', '强迫型人格在压力下可能影响效率，但也有优势。了解自身特质是改善的第一步。', 'file/messagesRpicture4.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (5, '2025-04-11 15:05:00', 50, '访客5', 'file/messagesAvatarurl5.jpg', '我想问问有没有针对依赖型人格的自助方法？', 'file/messagesCpicture5.jpg', '当然可以，比如记录每日独立完成的事情或练习独立决策能力。', 'file/messagesRpicture5.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (6, '2025-04-11 15:06:00', 60, '访客6', 'file/messagesAvatarurl6.jpg', '测评报告显示有边缘型风险，我该怎么办？', 'file/messagesCpicture6.jpg', '您好，建议尝试情绪识别训练，并定期参加心理疏导活动。', 'file/messagesRpicture6.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (7, '2025-04-11 15:07:00', 70, '访客7', 'file/messagesAvatarurl7.jpg', '有没有免费的测评工具推荐？', 'file/messagesCpicture7.jpg', '您好，我们推荐“人格障碍自评量表”初步了解自己的特质。', 'file/messagesRpicture7.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (8, '2025-04-11 15:08:00', 80, '访客8', 'file/messagesAvatarurl8.jpg', '我朋友做了测评被建议去看心理医生，是不是很严重？', 'file/messagesCpicture8.jpg', '并不代表严重，仅说明有进一步评估的必要。及时了解才是负责任的表现。', 'file/messagesRpicture8.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (9, '2025-04-11 15:09:00', 90, '访客9', 'file/messagesAvatarurl9.jpg', '人格测评过程中有哪些注意事项？', 'file/messagesCpicture9.jpg', '确保在安静环境下、如实填写问题，并避免过度解读结果。', 'file/messagesRpicture9.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (10, '2025-04-11 15:10:00', 100, '访客10', 'file/messagesAvatarurl10.jpg', '系统里的人格测评会保存记录吗？担心隐私。', 'file/messagesCpicture10.jpg', '系统默认匿名分析，您也可选择删除历史测评数据。<br><hr style=\"border-top: 1px dashed #ccc;\"><div style=\"margin-top:8px;\">11 回复: 2025/4/13 12:45:12</div><div><p>好的</p></div>', 'file/messagesRpicture10.jpg');
INSERT INTO `messages` (`id`, `addtime`, `userid`, `username`, `avatarurl`, `content`, `cpicture`, `reply`, `rpicture`) VALUES (11, '2025-04-11 15:11:00', 110, '访客11', 'file/messagesAvatarurl1.jpg', '测试说我有情绪不稳定，真的需要就医吗？', 'file/messagesCpicture7.jpg', '建议先与专业咨询师沟通，不必马上对号入座，了解自身很重要。<br><hr style=\"border-top: 1px dashed #ccc;\"><div style=\"margin-top:8px;\">10 回复: 2025/4/11 15:20:39</div><div><p>是的</p></div><br><hr style=\"border-top: 1px dashed #ccc;\"><div style=\"margin-top:8px;\">10 回复: 2025/4/11 15:22:11</div><div><p><img src=\"http://localhost:8080/pdas/file/1744356118048.jpg\" alt=\"\" data-href=\"\" style=\"width: 103.50px;height: 151.13px;\"/></p></div>', NULL);
COMMIT;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '简介',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='心理资讯';

-- ----------------------------
-- Records of news
-- ----------------------------
BEGIN;
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (1, '2025-04-07 12:42:31', '人格障碍自我检测与评估', '本课程将引导学员通过自我评估来识别可能的人格障碍特征，重点介绍情感不稳定、冲动控制及人际关系问题。', 'file/newsPicture1.jpg', '本课程将帮助学员识别和评估自我是否有潜在人格障碍，提供有效的自我调节方法。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (2, '2025-04-07 12:42:31', '心理测评：自我诊断与调整', '本课程专注于通过心理测评工具进行自我诊断，并提供个性化的调整建议，帮助学员理解自己的人格特点。', 'file/newsPicture2.jpg', '该课程教授如何使用心理测评工具进行自我分析，并为学员提供针对性的心理调整建议。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (3, '2025-04-07 12:42:31', '人格障碍检测与心理健康管理', '了解人格障碍的不同类型及其对心理健康的影响，学习如何通过自我检测和干预来改善心理状态。', 'file/newsPicture3.jpg', '本课程介绍了人格障碍的症状和识别方法，并提供了心理健康管理的建议，帮助学员改善心理状态。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (4, '2025-04-07 12:42:31', '边缘型人格障碍及其治疗方法', '探索边缘型人格障碍的症状，学习如何通过治疗方法来有效管理情感波动与行为冲动。', 'file/newsPicture4.jpg', '学习边缘型人格障碍的症状与治疗方法，包括情感调节技巧和冲动管理技巧，帮助学员提高情绪控制能力。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (5, '2025-04-07 12:42:31', '反社会人格障碍的识别与应对', '本课程帮助学员识别反社会人格障碍的症状，并介绍应对策略和治疗方法，促进行为改善。', 'file/newsPicture5.jpg', '学习反社会人格障碍的诊断与治疗，了解如何识别反社会行为，并采取适当的干预措施。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (6, '2025-04-07 12:42:31', '自恋型人格障碍的识别与治疗', '本课程帮助学员识别和理解自恋型人格障碍的症状，学会应对和治疗自恋型人格的有效方法。', 'file/newsPicture6.jpg', '介绍自恋型人格障碍的症状和治疗方法，帮助学员有效应对与他人的关系问题。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (7, '2025-04-07 12:42:31', '回避型人格障碍的自我调节与治疗', '学习回避型人格障碍的特征，提供自我调节的方法以及如何通过心理治疗有效改善回避行为。', 'file/newsPicture7.jpg', '本课程帮助学员识别回避型人格障碍的行为特征，并提供实用的治疗和调节技巧。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (8, '2025-04-07 12:42:31', '依赖型人格障碍的诊断与治疗', '课程讲解依赖型人格障碍的症状及治疗方法，帮助学员建立健康的自我独立性和自信心。', 'file/newsPicture8.jpg', '讲解如何通过认知行为疗法（CBT）来治疗依赖型人格障碍，帮助学员增强独立性。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (9, '2025-04-07 12:42:31', '强迫型人格障碍的识别与治疗', '探索强迫型人格障碍的特征，帮助学员识别过度控制行为并提供有效的治疗方法。', 'file/newsPicture9.jpg', '本课程教授如何识别强迫型人格障碍的症状，并提供治疗策略，帮助学员改善生活质量。');
INSERT INTO `news` (`id`, `addtime`, `title`, `introduction`, `picture`, `content`) VALUES (10, '2025-04-07 12:42:31', '人格障碍的早期识别与干预', '本课程专注于早期识别人格障碍的症状，介绍有效的干预方法，帮助学员进行预防性治疗。', 'file/newsPicture10.jpg', '学习如何通过早期干预来识别和管理人格障碍，帮助学员减少心理问题的影响。');
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `total` double DEFAULT NULL COMMENT '总价',
  `discounttotal` double DEFAULT NULL COMMENT '折扣总价格',
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付类型',
  `status` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '订单状态',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '地址',
  `tel` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '电话',
  `consignee` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '收货人',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `logistics` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '物流',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户角色',
  `userid` bigint NOT NULL COMMENT '用户id',
  `orderid` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'kechengxinxi' COMMENT '商品表名',
  `goodid` bigint NOT NULL COMMENT '商品id',
  `goodname` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `buynumber` int DEFAULT NULL COMMENT '购买数量',
  `price` double DEFAULT NULL COMMENT '单价',
  `discountprice` double DEFAULT NULL COMMENT '折扣价',
  `goodtype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品类型',
  PRIMARY KEY (`id`),
  UNIQUE KEY `orderid` (`orderid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品订单';

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`id`, `addtime`, `total`, `discounttotal`, `type`, `status`, `address`, `tel`, `consignee`, `remark`, `logistics`, `role`, `userid`, `orderid`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `goodtype`) VALUES (1, '2025-04-10 21:17:03', 79.9, 79.9, '1', '已支付', '河北沧州', '15512346782', 'aaa', '请发顺丰快递', NULL, 'yonghu', 70, '20250410211703152584', 'kechengxinxi', 10, '人格障碍的早期识别与干预', 'file/kechengxinxiKechengtupian10.jpg', 1, 79.9, 79.9, '人格障碍的早期识别与干预');
INSERT INTO `orders` (`id`, `addtime`, `total`, `discounttotal`, `type`, `status`, `address`, `tel`, `consignee`, `remark`, `logistics`, `role`, `userid`, `orderid`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `goodtype`) VALUES (2, '2025-04-10 21:22:04', 139.9, 139.9, '1', '未支付', '河北沧州', '15512346782', 'aaa', '', NULL, 'yonghu', 70, '20250410212204501169', 'gaopinggongju', 9, '青少年人格倾向测评工具', 'file/gaopinggongjuTupian9.jpg', 1, 139.9, 139.9, NULL);
INSERT INTO `orders` (`id`, `addtime`, `total`, `discounttotal`, `type`, `status`, `address`, `tel`, `consignee`, `remark`, `logistics`, `role`, `userid`, `orderid`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `goodtype`) VALUES (3, '2025-04-10 21:22:57', 139.9, 139.9, '1', '已支付', '河北沧州', '15512346782', 'aaa', '尽快发货', NULL, 'yonghu', 70, '20250410212257230665', 'gaopinggongju', 9, '青少年人格倾向测评工具', 'file/gaopinggongjuTupian9.jpg', 1, 139.9, 139.9, NULL);
INSERT INTO `orders` (`id`, `addtime`, `total`, `discounttotal`, `type`, `status`, `address`, `tel`, `consignee`, `remark`, `logistics`, `role`, `userid`, `orderid`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `goodtype`) VALUES (4, '2025-04-16 21:25:40', 109.9, 109.9, '1', '已退款', '河北沧州', '15512346782', 'aaa', '', NULL, 'yonghu', 70, '20250416212540276943', 'kechengxinxi', 2, '边缘型人格障碍与治疗方法', 'file/kechengxinxiKechengtupian2.jpg', 1, 109.9, 109.9, '边缘型人格障碍与治疗方法');
INSERT INTO `orders` (`id`, `addtime`, `total`, `discounttotal`, `type`, `status`, `address`, `tel`, `consignee`, `remark`, `logistics`, `role`, `userid`, `orderid`, `tablename`, `goodid`, `goodname`, `picture`, `buynumber`, `price`, `discountprice`, `goodtype`) VALUES (5, '2025-04-16 21:36:45', 79.9, 79.9, '1', '已支付', '河北沧州', '15512346782', 'aaa', '', NULL, 'yonghu', 70, '20250416213645813303', 'kechengxinxi', 3, '反社会人格障碍识别与应对', 'file/kechengxinxiKechengtupian3.jpg', 1, 79.9, 79.9, '反社会人格障碍识别与应对');
COMMIT;

-- ----------------------------
-- Table structure for personality_test
-- ----------------------------
DROP TABLE IF EXISTS `personality_test`;
CREATE TABLE `personality_test` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) NOT NULL COMMENT '测试名称',
  `description` text COMMENT '测试描述',
  `time` int DEFAULT '30' COMMENT '测试时长(分钟)',
  `status` varchar(50) DEFAULT '正常' COMMENT '测试状态',
  `test_type` varchar(100) DEFAULT NULL COMMENT '测试类型',
  `result_template` text COMMENT '结果解析模板',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='性格测试';

-- ----------------------------
-- Records of personality_test
-- ----------------------------
BEGIN;
INSERT INTO `personality_test` (`id`, `name`, `description`, `time`, `status`, `test_type`, `result_template`, `addtime`) VALUES (1, 'MBTI性格测试', 'MBTI性格测试是一种流行的性格类型测试，可以帮助您了解自己的性格类型和倾向。', 30, '正常', 'MBTI', '您的MBTI类型是：{type}\n\n主要特点：\n{features}\n\n职业建议：\n{career_advice}\n\n个人发展建议：\n{personal_development}', '2025-04-13 12:34:43');
INSERT INTO `personality_test` (`id`, `name`, `description`, `time`, `status`, `test_type`, `result_template`, `addtime`) VALUES (2, '大五人格测试', '大五人格测试是基于五大人格特质理论的心理测试，用于评估开放性、责任心、外向性、亲和性和神经质五个方面。', 20, '正常', '大五人格', '您的大五人格测试结果如下：\n\n开放性：{openness}%\n责任心：{conscientiousness}%\n外向性：{extraversion}%\n亲和性：{agreeableness}%\n神经质：{neuroticism}%\n\n个性解析：\n{analysis}\n\n发展建议：\n{suggestions}', '2025-04-13 12:34:43');
COMMIT;

-- ----------------------------
-- Table structure for storeup
-- ----------------------------
DROP TABLE IF EXISTS `storeup`;
CREATE TABLE `storeup` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `refid` bigint DEFAULT NULL COMMENT 'refid',
  `tablename` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '表名',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `picture` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片',
  `type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '1' COMMENT '类型(1:收藏,21:赞,22:踩,31:竞拍参与,41:关注)',
  `inteltype` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '推荐类型',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `userid` bigint NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='我的收藏';

-- ----------------------------
-- Records of storeup
-- ----------------------------
BEGIN;
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (1, '2025-04-08 10:46:32', 1, 'xinlijiankangxuexi', '人格障碍自我检测指南', 'file/xinlijiankangxuexiFengmian1.jpg', '21', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (4, '2025-04-10 18:03:27', 4, 'forum', '匿名互助｜自我认知支持小组组队', '', '21', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (5, '2025-04-10 18:04:43', 5, 'forum', '话题｜人格障碍会遗传吗？', '', '21', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (6, '2025-04-13 21:03:26', 72, 'zixunshi', '咨询师账号2', 'file/zixunshiTouxiang2.jpg', '21', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (7, '2025-04-13 21:10:03', 80, 'zixunshi', '咨询师刘', 'file/zixunshiTouxiang10.jpg', '21', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (8, '2025-04-16 21:24:43', 2, 'xinlijiankangxuexi', '自我认知与心理测评入门', 'file/xinlijiankangxuexiFengmian2.jpg', '21', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (9, '2025-04-16 21:24:51', 2, 'xinlijiankangxuexi', '自我认知与心理测评入门', 'file/xinlijiankangxuexiFengmian2.jpg', '1', NULL, NULL, 70);
INSERT INTO `storeup` (`id`, `addtime`, `refid`, `tablename`, `name`, `picture`, `type`, `inteltype`, `remark`, `userid`) VALUES (10, '2025-04-17 11:12:02', 2, 'xinlijiankangxuexi', '自我认知与心理测评入门', 'file/xinlijiankangxuexiFengmian2.jpg', '21', NULL, NULL, 71);
COMMIT;

-- ----------------------------
-- Table structure for token
-- ----------------------------
DROP TABLE IF EXISTS `token`;
CREATE TABLE `token` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userid` bigint NOT NULL COMMENT '用户id',
  `username` varchar(100) NOT NULL COMMENT '用户名',
  `tablename` varchar(100) DEFAULT NULL COMMENT '表名',
  `role` varchar(100) DEFAULT NULL COMMENT '角色',
  `token` varchar(200) NOT NULL COMMENT '密码',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '新增时间',
  `expiratedtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COMMENT='token表';

-- ----------------------------
-- Records of token
-- ----------------------------
BEGIN;
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (1, 61, '账号1', 'yonghu', '用户', '6g1h0dv49v5fabxdk2jn897trwkbf7pi', '2025-03-22 12:45:51', '2025-03-22 13:45:51');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (2, 1, 'admin', 'users', '管理员', 'pop2se8fzm2rlda0pvegerkyoupsodrb', '2025-03-22 12:46:46', '2025-04-17 18:00:15');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (3, 71, '咨询师账号1', 'zixunshi', '管理员', 'aylczitxz7l5gsf2rbxfdkw385q8n02b', '2025-03-22 12:48:03', '2025-04-17 20:43:15');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (4, 70, '10', 'yonghu', '用户', 'ln3c2vqngwolof8q104sqpbc8h67h5my', '2025-04-07 12:37:50', '2025-04-17 20:43:43');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (5, 80, '咨询师账号10', 'zixunshi', '管理员', 'ral52matkh3nc4dln631y2x7jic3qmuu', '2025-04-08 21:49:51', '2025-04-16 11:32:38');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (6, 81, '11', 'zixunshi', '管理员', 'cm186py21bmum5oc0vn9iq1sfqfa8g22', '2025-04-10 21:31:16', '2025-04-15 22:24:08');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (7, 71, '11', 'yonghu', '用户', 'mhc7o9e2vmjxp1ftvwire6hky681hko2', '2025-04-11 11:26:11', '2025-04-17 18:01:31');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (8, 77, '咨询师账号7', 'zixunshi', '管理员', '1qg57huohvlex4n1ei0wg1zxs8qx0xwz', '2025-04-13 21:57:00', '2025-04-15 23:55:28');
INSERT INTO `token` (`id`, `userid`, `username`, `tablename`, `role`, `token`, `addtime`, `expiratedtime`) VALUES (9, 76, '咨询师账号6', 'zixunshi', '管理员', 'lupe2hconp88r1hbrnx7wz91197hg1f7', '2025-04-15 21:26:37', '2025-04-16 12:37:32');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `role` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '管理员' COMMENT '角色',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='管理员';

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `addtime`, `username`, `password`, `role`) VALUES (1, '2025-03-22 12:42:31', 'admin', 'admin', '管理员');
COMMIT;

-- ----------------------------
-- Table structure for xinlijiankangxuexi
-- ----------------------------
DROP TABLE IF EXISTS `xinlijiankangxuexi`;
CREATE TABLE `xinlijiankangxuexi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `biaoti` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `fengmian` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '封面',
  `fabushijian` datetime DEFAULT NULL COMMENT '发布时间',
  `zixunshizhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师账号',
  `zixunshixingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师姓名',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `neirong` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `thumbsup_number` int DEFAULT '0' COMMENT '赞',
  `crazily_number` int DEFAULT '0' COMMENT '踩',
  `storeup_number` int DEFAULT '0' COMMENT '收藏数',
  `discuss_number` int DEFAULT '0' COMMENT '评论数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='心理健康学习';

-- ----------------------------
-- Records of xinlijiankangxuexi
-- ----------------------------
BEGIN;
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (1, '2025-04-08 10:48:06', '人格障碍自我检测指南', 'file/xinlijiankangxuexiFengmian1.jpg,file/xinlijiankangxuexiFengmian2.jpg,file/xinlijiankangxuexiFengmian3.jpg', '2025-04-08 12:00:00', '心理顾问001', '心理顾问小李', '在线聊天', '本内容介绍如何通过标准化心理量表（如PDQ-4、DSM-5量表）对常见人格障碍进行初步筛查与识别。帮助你从自我评估出发，了解人格特征中的潜在风险因素，为后续咨询提供参考。', 10, 8, 5, 3);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (2, '2025-04-08 10:48:06', '自我认知与心理测评入门', 'file/xinlijiankangxuexiFengmian2.jpg,file/xinlijiankangxuexiFengmian3.jpg,file/xinlijiankangxuexiFengmian4.jpg', '2025-04-08 12:00:00', '心理顾问002', '心理顾问小赵', '邮箱咨询', '课程将介绍自我意识觉察与心理测评基础知识，帮助你通过科学手段认识内在心理状态，建立对自身性格结构的认知，探索潜在人格类型并掌握适应策略。', 11, 7, 7, 4);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (3, '2025-04-08 10:48:06', '边缘型人格障碍应对方法', 'file/xinlijiankangxuexiFengmian3.jpg,file/xinlijiankangxuexiFengmian4.jpg,file/xinlijiankangxuexiFengmian5.jpg', '2025-04-08 12:00:00', '心理顾问003', '心理顾问小王', '电话咨询', '讲解边缘型人格的核心特征（如情绪剧烈波动、恐惧被抛弃等），并提供日常情绪调节方法，如正念训练、自我价值重建与关系界限设定，适合初次了解该类型者。', 11, 9, 7, 5);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (4, '2025-04-08 10:48:06', '心理测评工具使用指南', 'file/xinlijiankangxuexiFengmian4.jpg,file/xinlijiankangxuexiFengmian5.jpg,file/xinlijiankangxuexiFengmian6.jpg', '2025-04-08 12:00:00', '心理顾问004', '心理顾问小张', '面对面', '系统介绍MMPI、EPQ、MBTI等主流测评工具的应用场景与解读技巧，并指导如何科学使用测评结果判断人格适应性，避免常见误解和标签化问题。', 8, 6, 5, 2);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (5, '2025-04-08 10:48:06', '自恋型人格的识别与自助', 'file/xinlijiankangxuexiFengmian5.jpg,file/xinlijiankangxuexiFengmian6.jpg,file/xinlijiankangxuexiFengmian7.jpg', '2025-04-08 12:00:00', '心理顾问005', '心理顾问小钱', '视频通话', '从自恋型人格的典型表现（如对他人评价高度敏感、缺乏共情等）切入，结合实际案例提供调整人际互动与增强自我接纳的实用建议。', 13, 10, 8, 6);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (6, '2025-04-08 10:48:06', '人格障碍治疗的心理技巧', 'file/xinlijiankangxuexiFengmian6.jpg,file/xinlijiankangxuexiFengmian7.jpg,file/xinlijiankangxuexiFengmian8.jpg', '2025-04-08 12:00:00', '心理顾问006', '心理顾问小周', '微信咨询', '讲解心理治疗中常用的认知行为疗法（CBT）与辩证行为疗法（DBT）在人格障碍干预中的作用，适合已确诊或处于治疗阶段的学员参考。', 14, 9, 7, 5);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (7, '2025-04-08 10:48:06', '回避型人格障碍应对建议', 'file/xinlijiankangxuexiFengmian7.jpg,file/xinlijiankangxuexiFengmian8.jpg,file/xinlijiankangxuexiFengmian9.jpg', '2025-04-08 12:00:00', '心理顾问007', '心理顾问小吴', '在线留言', '解析回避型人格在社交焦虑、自卑心理中的体现，课程提供渐进式社交练习与认知重构技巧，帮助学员突破人际障碍。', 12, 8, 6, 4);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (8, '2025-04-08 10:48:06', '依赖型人格的心理解读', 'file/xinlijiankangxuexiFengmian8.jpg,file/xinlijiankangxuexiFengmian9.jpg,file/xinlijiankangxuexiFengmian10.jpg', '2025-04-08 12:00:00', '心理顾问008', '心理顾问小郑', 'QQ交流', '深入分析依赖型人格在亲密关系中的表现与心理动因，介绍建立健康独立性的练习路径，包括自我价值感重建和情感断舍离练习。', 9, 7, 5, 3);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (9, '2025-04-08 10:48:06', '心理评估在咨询中的作用', 'file/xinlijiankangxuexiFengmian9.jpg,file/xinlijiankangxuexiFengmian10.jpg,file/xinlijiankangxuexiFengmian11.jpg', '2025-04-08 12:00:00', '心理顾问009', '心理顾问小孙', '当面预约', '通过真实咨询案例说明心理评估在问题识别、咨询方向确定及疗效追踪中的作用，让你更好理解评估结果与咨询策略的匹配关系。', 10, 9, 6, 5);
INSERT INTO `xinlijiankangxuexi` (`id`, `addtime`, `biaoti`, `fengmian`, `fabushijian`, `zixunshizhanghao`, `zixunshixingming`, `lianxifangshi`, `neirong`, `thumbsup_number`, `crazily_number`, `storeup_number`, `discuss_number`) VALUES (10, '2025-04-08 10:48:06', '人格障碍的早期识别技巧', 'file/xinlijiankangxuexiFengmian10.jpg,file/xinlijiankangxuexiFengmian11.jpg,file/xinlijiankangxuexiFengmian12.jpg', '2025-04-08 12:00:00', '心理顾问010', '心理顾问小马', '语音通话', '本内容重点介绍如何通过细致观察生活中的行为模式、思维倾向与情绪反应，识别可能的人格异常信号，为预防性干预提供参考。', 15, 12, 9, 7);
COMMIT;

-- ----------------------------
-- Table structure for yonghu
-- ----------------------------
DROP TABLE IF EXISTS `yonghu`;
CREATE TABLE `yonghu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `mima` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `xingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `nianling` int DEFAULT NULL COMMENT '年龄',
  `shouji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `jf` double DEFAULT '0' COMMENT '积分',
  `money` double DEFAULT '0' COMMENT '余额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zhanghao` (`zhanghao`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';

-- ----------------------------
-- Records of yonghu
-- ----------------------------
BEGIN;
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (61, '2025-03-22 12:42:31', '账号1', '123456', '姓名1', '男', 'file/yonghuTouxiang1.jpg', 1, '19819881111', '102020001@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (62, '2025-03-22 12:42:31', '账号2', '123456', '姓名2', '男', 'file/yonghuTouxiang2.jpg', 2, '19819881112', '102020002@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (63, '2025-03-22 12:42:31', '账号3', '123456', '姓名3', '男', 'file/yonghuTouxiang3.jpg', 3, '19819881113', '102020003@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (64, '2025-03-22 12:42:31', '账号4', '123456', '姓名4', '男', 'file/yonghuTouxiang4.jpg', 4, '19819881114', '102020004@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (65, '2025-03-22 12:42:31', '账号5', '123456', '姓名5', '男', 'file/yonghuTouxiang5.jpg', 5, '19819881115', '102020005@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (66, '2025-03-22 12:42:31', '账号6', '123456', '姓名6', '男', 'file/yonghuTouxiang6.jpg', 6, '19819881116', '102020006@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (67, '2025-03-22 12:42:31', '账号7', '123456', '姓名7', '男', 'file/yonghuTouxiang7.jpg', 7, '19819881117', '102020007@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (68, '2025-03-22 12:42:31', '账号8', '123456', '姓名8', '男', 'file/yonghuTouxiang8.jpg', 8, '19819881118', '102020008@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (69, '2025-03-22 12:42:31', '账号9', '123456', '姓名9', '男', 'file/yonghuTouxiang9.jpg', 9, '19819881119', '102020009@qq.com', 10000, 200);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (70, '2025-03-22 12:42:31', '10', '123456', '姓名10', '男', 'file/yonghuTouxiang10.jpg', 10, '198198811110', '1020200010@qq.com', 10158, 1787.3);
INSERT INTO `yonghu` (`id`, `addtime`, `zhanghao`, `mima`, `xingming`, `xingbie`, `touxiang`, `nianling`, `shouji`, `email`, `jf`, `money`) VALUES (71, '2025-03-22 12:42:31', '11', '11', '姓名3', '男', 'file/yonghuTouxiang3.jpg', 3, '19819881113', '102120003@qq.com', 10000, 200);
COMMIT;

-- ----------------------------
-- Table structure for zixunshi
-- ----------------------------
DROP TABLE IF EXISTS `zixunshi`;
CREATE TABLE `zixunshi` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `zixunshizhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师账号',
  `mima` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `zixunshixingming` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师姓名',
  `xingbie` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `touxiang` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '头像',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `zizhirenzheng` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '资质认证',
  `thumbsup_number` int DEFAULT '0' COMMENT '赞',
  `crazily_number` int DEFAULT '0' COMMENT '踩',
  `storeup_number` int DEFAULT '0' COMMENT '收藏数',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `zixunshizhanghao` (`zixunshizhanghao`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='咨询师';

-- ----------------------------
-- Records of zixunshi
-- ----------------------------
BEGIN;
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (71, '2025-03-22 12:42:31', '咨询师账号1', '123456', '咨询师姓名1', '男', 'file/zixunshiTouxiang1.jpg', '19819881111', 'file/zixunshiZizhirenzheng1.jpg', 1, 1, 1, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (72, '2025-03-22 12:42:31', '咨询师账号2', '123456', '咨询师姓名2', '男', 'file/zixunshiTouxiang2.jpg', '19819881112', 'file/zixunshiZizhirenzheng2.jpg', 3, 2, 2, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (73, '2025-03-22 12:42:31', '咨询师账号3', '123456', '咨询师姓名3', '男', 'file/zixunshiTouxiang3.jpg', '19819881113', 'file/zixunshiZizhirenzheng3.jpg', 3, 3, 3, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (74, '2025-03-22 12:42:31', '咨询师账号4', '123456', '咨询师姓名4', '男', 'file/zixunshiTouxiang4.jpg', '19819881114', 'file/zixunshiZizhirenzheng4.jpg', 4, 4, 4, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (75, '2025-03-22 12:42:31', '咨询师账号5', '123456', '咨询师姓名5', '男', 'file/zixunshiTouxiang5.jpg', '19819881115', 'file/zixunshiZizhirenzheng5.jpg', 5, 5, 5, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (76, '2025-03-22 12:42:31', '咨询师账号6', '123456', '咨询师姓名6', '男', 'file/zixunshiTouxiang6.jpg', '19819881116', 'file/zixunshiZizhirenzheng6.jpg', 6, 6, 6, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (77, '2025-03-22 12:42:31', '咨询师账号7', '123456', '咨询师姓名7', '男', 'file/zixunshiTouxiang7.jpg', '19819881117', 'file/zixunshiZizhirenzheng7.jpg', 7, 7, 7, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (78, '2025-03-22 12:42:31', '咨询师账号8', '123456', '咨询师姓名8', '男', 'file/zixunshiTouxiang8.jpg', '19819881118', 'file/zixunshiZizhirenzheng8.jpg', 8, 8, 8, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (79, '2025-03-22 12:42:31', '咨询师账号9', '123456', '咨询师姓名9', '男', 'file/zixunshiTouxiang9.jpg', '19819881119', 'file/zixunshiZizhirenzheng9.jpg', 9, 9, 9, '是', '');
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (80, '2025-03-22 12:42:31', '咨询师刘', '123456', '咨询师刘', '男', 'file/zixunshiTouxiang10.jpg', '198198811110', 'file/zixunshiZizhirenzheng10.jpg', 11, 10, 10, '是', NULL);
INSERT INTO `zixunshi` (`id`, `addtime`, `zixunshizhanghao`, `mima`, `zixunshixingming`, `xingbie`, `touxiang`, `lianxifangshi`, `zizhirenzheng`, `thumbsup_number`, `crazily_number`, `storeup_number`, `sfsh`, `shhf`) VALUES (81, '2025-03-22 12:42:31', '11', '11', '咨询师姓名1', '男', 'file/zixunshiTouxiang10.jpg', '198198811110', 'file/zixunshiZizhirenzheng10.jpg', 11, 11, 11, '是', NULL);
COMMIT;

-- ----------------------------
-- Table structure for zixunshiyuyue
-- ----------------------------
DROP TABLE IF EXISTS `zixunshiyuyue`;
CREATE TABLE `zixunshiyuyue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `addtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `yuyuebianhao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预约编号',
  `zixunshizhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '咨询师账号',
  `lianxifangshi` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '联系方式',
  `yuyueshijian` datetime DEFAULT NULL COMMENT '预约时间',
  `time_slot` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预约时间段(如09:00-10:00)',
  `duration` int DEFAULT '60' COMMENT '咨询时长(分钟)',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '待确认' COMMENT '预约状态(待确认/已确认/已完成/已取消)',
  `zhanghao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '账号',
  `shouji` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机',
  `yuyuezixunshijian` date DEFAULT NULL COMMENT '预约咨询时间',
  `yuyuebeizhu` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '预约备注',
  `sfsh` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '待审核' COMMENT '是否审核',
  `shhf` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '回复内容',
  PRIMARY KEY (`id`),
  UNIQUE KEY `yuyuebianhao` (`yuyuebianhao`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='咨询师预约';

-- ----------------------------
-- Records of zixunshiyuyue
-- ----------------------------
BEGIN;
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (1, '2025-04-11 15:01:00', 'YY202504111501001001', '咨询师李', '15500000001', '2025-04-12 09:00:00', '09:00-10:00', 60, '已确认', 'u001', '15500000001', '2025-04-12', '人格障碍测评预约', '是', '通过');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (2, '2025-04-11 15:02:00', 'YY202504111502002002', '咨询师张', '15500000002', '2025-04-12 10:00:00', '10:00-11:00', 60, '已取消', 'u002', '15500000002', '2025-04-12', 'PDQ-4结果解读预约', '否', '拒绝');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (3, '2025-04-11 15:03:00', 'YY202504111503003003', '咨询师洪', '15500000003', '2025-04-12 11:00:00', '11:00-12:00', 60, '待确认', 'u003', '15500000003', '2025-04-12', '情绪不稳倾向咨询', '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (4, '2025-04-11 15:04:00', 'YY202504111504004004', '咨询师王', '15500000004', '2025-04-12 14:00:00', '14:00-15:00', 60, '待确认', 'u004', '15500000004', '2025-04-12', '自恋型人格初筛', '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (5, '2025-04-11 15:05:00', 'YY202504111505005005', '咨询师3', '15500000005', '2025-04-12 15:00:00', '15:00-16:00', 60, '待确认', 'u005', '15500000005', '2025-04-12', '边缘型人格干预预约', '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (6, '2025-04-11 15:06:00', 'YY202504111506006006', '咨询师李', '15500000006', '2025-04-12 16:00:00', '16:00-17:00', 60, '待确认', 'u006', '15500000006', '2025-04-12', '人格测评后焦虑咨询', '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (7, '2025-04-11 15:07:00', 'YY202504111507007007', '咨询师7', '15500000007', '2025-04-12 17:00:00', '17:00-18:00', 60, '待确认', 'u007', '15500000007', '2025-04-12', '强迫型人格调节方法', '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (8, '2025-04-11 15:08:00', 'YY202504111508008008', '咨询师李', '15500000008', '2025-04-12 18:00:00', '18:00-19:00', 60, '待确认', 'u008', '15500000008', '2025-04-12', '人格障碍倾向自助预约', '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (9, '2025-04-11 15:09:00', 'YY202504111509009009', '咨询师9', '15500000009', '2025-04-12 19:00:00', '19:00-20:00', 60, '已取消', 'u009', '15500000009', '2025-04-12', '匿名人格咨询预约', '否', '拒绝');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (10, '2025-04-11 15:10:00', 'YY202504111510001010', '咨询师刘', '15500000010', '2025-04-12 20:00:00', '20:00-21:00', 60, '已确认', 'u010', '15500000010', '2025-04-12', '人格评估结果反馈预约', '是', '通过');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (11, '2025-04-11 17:51:06', 'YY202504111510001011', '咨询师刘', '15500000011', '2025-04-15 17:51:37', NULL, 60, '待确认', NULL, NULL, NULL, NULL, '待审核', NULL);
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (12, '2025-04-13 21:29:16', 'YY202504132129162047', '咨询师刘', '198198811110', '2025-04-13 21:29:06', '10:00-11:00', 60, '待确认', '11', '19819881113', '2025-04-13', '1', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (13, '2025-04-13 21:46:00', 'YY202504132146008102', '咨询师刘', '198198811110', '2025-04-13 21:45:53', '11:00-12:00', 60, '待确认', '11', '19819881113', '2025-04-13', '11', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (14, '2025-04-13 22:04:23', 'YY202504132204237714', '咨询师账号1', '19819881117', '2025-04-13 22:04:15', '14:00-15:00', 60, '已确认', '11', '19819881113', '2025-04-13', '7', '是', '通过');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (15, '2025-04-13 22:08:52', 'YY202504132208521281', '咨询师账号7', '15512345678', '2025-04-13 22:08:14', '16:00-17:00', 60, '待确认', '11', '19819881113', '2025-04-13', '考试不合格', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (16, '2025-04-13 22:42:27', 'YY202504132242279451', '咨询师账号7', '15512345678', '2025-04-13 22:42:12', '09:00-10:00', 60, '待确认', '11', '19819881113', '2025-04-13', '2', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (18, '2025-04-15 16:18:06', 'YY202504151618064878', '咨询师刘', '15512345678', '2025-04-15 16:13:05', '09:00-10:00', 60, '待确认', '11', '19819881113', '2025-04-15', '11', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (19, '2025-04-15 16:59:00', 'YY202504151659006688', '咨询师刘', '15512345678', '2025-04-15 16:57:07', '11:00-12:00', 60, '待确认', '11', '19819881113', '2025-04-15', '11', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (20, '2025-04-15 20:35:42', 'YY202504152035426094', '咨询师账号6', '19819881116', '2025-04-15 20:35:25', '11:00-12:00', 90, '待确认', '11', '19819881113', '2025-04-15', '1', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (21, '2025-04-15 20:35:58', 'YY202504152035588433', '咨询师账号6', '19819881116', '2025-04-15 20:35:50', '09:00-10:00', 60, '待确认', '11', '19819881113', '2025-04-15', '1', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (22, '2025-04-15 20:36:14', 'YY202504152036145669', '咨询师账号6', '19819881116', '2025-04-15 20:36:06', '09:00-10:00', 60, '已确认', '11', '19819881113', '2025-04-15', '1', '是', '1');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (23, '2025-04-15 20:43:08', 'YY202504152043081719', '咨询师刘', '198198811110', '2025-04-15 20:42:52', '10:00-11:00', 60, '已确认', '11', '19819881113', '2025-04-15', '1', '是', '1');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (25, '2025-04-15 21:27:30', 'YY202504152127301540', '咨询师刘', '198198811110', '2025-04-15 21:27:18', '15:00-16:00', 60, '已确认', '11', '19819881113', '2025-04-15', '1', '是', '1');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (26, '2025-04-16 21:27:56', 'YY202504162127564747', '咨询师刘', '198198811110', '2025-04-16 21:27:21', '09:00-10:00', 60, '待确认', '10', '198198811110', '2025-04-16', '心情不好', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (27, '2025-04-16 21:29:16', 'YY202504162129166677', '咨询师账号1', '19819881111', '2025-04-16 21:29:00', '15:00-16:00', 60, '待确认', '10', '198198811110', '2025-04-16', '抑郁', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (28, '2025-04-16 21:31:04', 'YY202504162131047132', '咨询师账号1', '19819881111', '2025-04-16 21:30:50', '16:00-17:00', 60, '待确认', '10', '198198811110', '2025-04-16', '123', '待审核', '');
INSERT INTO `zixunshiyuyue` (`id`, `addtime`, `yuyuebianhao`, `zixunshizhanghao`, `lianxifangshi`, `yuyueshijian`, `time_slot`, `duration`, `status`, `zhanghao`, `shouji`, `yuyuezixunshijian`, `yuyuebeizhu`, `sfsh`, `shhf`) VALUES (29, '2025-04-17 15:54:17', 'YY202504171554171855', '咨询师账号1', '19819881111', '2025-04-17 15:53:43', '14:00-15:00', 60, '待确认', '11', '19819881113', '2025-04-17', '有困扰', '待审核', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
