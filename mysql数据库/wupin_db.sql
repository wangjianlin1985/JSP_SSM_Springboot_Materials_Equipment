/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : wupin_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-03-15 23:12:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_apply`
-- ----------------------------
DROP TABLE IF EXISTS `t_apply`;
CREATE TABLE `t_apply` (
  `applyId` int(11) NOT NULL auto_increment COMMENT '申领id',
  `productObj` int(11) NOT NULL COMMENT '物品名称',
  `supplierObj` int(11) NOT NULL COMMENT '物品供应商',
  `companyObj` int(11) NOT NULL COMMENT '行政物需点',
  `applyCount` int(11) NOT NULL COMMENT '出库数量',
  `sqr` varchar(20) NOT NULL COMMENT '申请人',
  `sqsj` varchar(20) default NULL COMMENT '申请时间',
  `applyState` varchar(20) NOT NULL COMMENT '状态',
  `shenpiren` varchar(20) NOT NULL COMMENT '审批人',
  `cksj` varchar(20) default NULL COMMENT '出库时间',
  PRIMARY KEY  (`applyId`),
  KEY `productObj` (`productObj`),
  KEY `supplierObj` (`supplierObj`),
  KEY `companyObj` (`companyObj`),
  CONSTRAINT `t_apply_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_apply_ibfk_2` FOREIGN KEY (`supplierObj`) REFERENCES `t_supplier` (`supplierId`),
  CONSTRAINT `t_apply_ibfk_3` FOREIGN KEY (`companyObj`) REFERENCES `t_company` (`companyId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_apply
-- ----------------------------
INSERT INTO `t_apply` VALUES ('1', '1', '1', '1', '10', '11', '2018-02-22 11:27:36', '已驳回', '王敏', '2018-02-28 11:28:14');
INSERT INTO `t_apply` VALUES ('2', '1', '1', '1', '12', 'EM001', '2018-03-03 19:52:10', '已确认', '马晓三', '2018-03-03 21:24:31');
INSERT INTO `t_apply` VALUES ('3', '2', '2', '2', '12', 'EM002', '2018-03-03 21:42:16', '已申请', '--', '--');
INSERT INTO `t_apply` VALUES ('4', '2', '2', '2', '3', 'EM001', '2018-03-15 22:51:30', '已申请', '--', '--');

-- ----------------------------
-- Table structure for `t_company`
-- ----------------------------
DROP TABLE IF EXISTS `t_company`;
CREATE TABLE `t_company` (
  `companyId` int(11) NOT NULL auto_increment COMMENT '物需点id',
  `companyName` varchar(20) NOT NULL COMMENT '公司名称',
  `city` varchar(20) NOT NULL COMMENT '所在城市',
  `telephone` varchar(20) NOT NULL COMMENT '物需点电话',
  `address` varchar(20) NOT NULL COMMENT '物需点地址',
  `bPerson` varchar(20) NOT NULL COMMENT 'B方对接人',
  `djrlxfs` varchar(20) NOT NULL COMMENT '对接人联系方式',
  `luruTime` varchar(20) default NULL COMMENT '录入时间',
  `luruRen` varchar(20) NOT NULL COMMENT '录入人',
  PRIMARY KEY  (`companyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_company
-- ----------------------------
INSERT INTO `t_company` VALUES ('1', '分公司1', '四川成都', '028-82939342', '成都红星路13号', '11', '22', '2018-02-28 11:22:53', '33');
INSERT INTO `t_company` VALUES ('2', '分公司2', '四川德阳', '028-83940834', '德阳市马宇路', '王强', '13084308343', '2018-03-03 20:03:44', '李明明');

-- ----------------------------
-- Table structure for `t_department`
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `departmentId` int(11) NOT NULL auto_increment COMMENT '部门id',
  `departmentName` varchar(20) NOT NULL COMMENT '部门名称',
  `departmentDesc` varchar(800) NOT NULL COMMENT '部门职责',
  PRIMARY KEY  (`departmentId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('1', '行政部', '管理员行政事务');
INSERT INTO `t_department` VALUES ('2', '财务部', '管理财务信息');

-- ----------------------------
-- Table structure for `t_employee`
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `employeeNo` varchar(20) NOT NULL COMMENT 'employeeNo',
  `password` varchar(20) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(4) NOT NULL COMMENT '性别',
  `bornDate` varchar(20) default NULL COMMENT '出生日期',
  `employeePhoto` varchar(60) NOT NULL COMMENT '员工照片',
  `companyObj` int(11) NOT NULL COMMENT '所在分公司',
  `departmentObj` int(11) NOT NULL COMMENT '所属部门',
  `telephone` varchar(20) NOT NULL COMMENT '联系方式',
  `gwh` varchar(20) NOT NULL COMMENT '工位号',
  `employeeMemo` varchar(800) default NULL COMMENT '员工备注',
  PRIMARY KEY  (`employeeNo`),
  KEY `companyObj` (`companyObj`),
  KEY `departmentObj` (`departmentObj`),
  CONSTRAINT `t_employee_ibfk_1` FOREIGN KEY (`companyObj`) REFERENCES `t_company` (`companyId`),
  CONSTRAINT `t_employee_ibfk_2` FOREIGN KEY (`departmentObj`) REFERENCES `t_department` (`departmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO `t_employee` VALUES ('EM001', '123', '双鱼林', '男', '2018-02-07', 'upload/85c3f09b-53b5-4f8d-82d5-2a18712cd053.jpg', '1', '1', '13594938343', '11', 'test');
INSERT INTO `t_employee` VALUES ('EM002', '123', '夏晓娇', '女', '2018-03-01', 'upload/1408cd5f-b38a-4a48-81c1-dd4b9d7b3b5e.jpg', '2', '1', '13598340835', '22', 'test');

-- ----------------------------
-- Table structure for `t_product`
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `productId` int(11) NOT NULL auto_increment COMMENT '物品id',
  `productName` varchar(20) NOT NULL COMMENT '物品名称',
  `supplierObj` int(11) NOT NULL COMMENT '物品供应商',
  `companyObj` int(11) NOT NULL COMMENT '行政物需点',
  `productPhoto` varchar(60) NOT NULL COMMENT '物品图片',
  `productPrice` float NOT NULL COMMENT '物品价格',
  `productCount` int(11) NOT NULL COMMENT '物品数量',
  `productDesc` varchar(5000) NOT NULL COMMENT '物品描述',
  `luruTime` varchar(20) default NULL COMMENT '录入时间',
  PRIMARY KEY  (`productId`),
  KEY `supplierObj` (`supplierObj`),
  KEY `companyObj` (`companyObj`),
  CONSTRAINT `t_product_ibfk_1` FOREIGN KEY (`supplierObj`) REFERENCES `t_supplier` (`supplierId`),
  CONSTRAINT `t_product_ibfk_2` FOREIGN KEY (`companyObj`) REFERENCES `t_company` (`companyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '华谊家用万用表', '1', '1', 'upload/aadbd826-3cb0-4dd4-b725-7fde76418582.jpg', '68.5', '58', '<p><span style=\"font-size: 24px; font-family: 楷体, 楷体_GB2312, SimKai;\">MS8231是一款创新型智能全自动万用表，不需做任何换挡动作，产品芯片自动完成切换档位，自动识别交流电压/直流电压/蜂鸣通断/电阻，实轻松实现傻瓜一键测量，产品小巧、便携，使用极其简单，对于初学者、家居及电工师傅，是款理想的万用表。</span></p>', '2018-02-28 11:26:01');
INSERT INTO `t_product` VALUES ('2', '恒温电烙铁', '2', '2', 'upload/989fadb1-4005-4bb6-afc5-e441d652b368.jpg', '92.5', '110', '<ul class=\"attributes-list list-paddingleft-2\" style=\"list-style-type: none;\"><li><p>品牌:&nbsp;Casarte/卡萨帝</p></li><li><p>颜色分类:&nbsp;【卡萨帝936标配全套】 卡萨帝936【A套装】 卡萨帝936【B套装】 卡萨帝936【C套装】 卡萨帝936【D套装】 卡萨帝936【拆与焊】旋钮版 卡萨帝936【拆与焊】数显版 卡萨帝936【16件套秒杀装】 【固耐斯936标配】原厂出货 【固耐斯936促销套装】原厂出货</p></li><li><p>原配烙铁头:&nbsp;1.2mm圆尖头</p></li><li><p>原配发热芯:&nbsp;直插式陶瓷发热芯</p></li><li><p>变压器:&nbsp;加大铜铝变压器</p></li><li><p>智能恒温:&nbsp;200~480℃</p></li><li><p>适用于:&nbsp;焊接，焊锡，烙画等</p></li></ul><p><br/></p>', '2018-03-03 20:07:50');

-- ----------------------------
-- Table structure for `t_purchase`
-- ----------------------------
DROP TABLE IF EXISTS `t_purchase`;
CREATE TABLE `t_purchase` (
  `purchaseId` int(11) NOT NULL auto_increment COMMENT '采购id',
  `productObj` int(11) NOT NULL COMMENT '物品名称',
  `supplierObj` int(11) NOT NULL COMMENT '物品供应商',
  `companyObj` int(11) NOT NULL COMMENT '行政物需点',
  `purchaseCount` int(11) NOT NULL COMMENT '入库数量',
  `purchaseTime` varchar(20) default NULL COMMENT '入库时间',
  `purchaseState` varchar(20) NOT NULL COMMENT '状态',
  `czr` varchar(20) NOT NULL COMMENT '操作人',
  PRIMARY KEY  (`purchaseId`),
  KEY `productObj` (`productObj`),
  KEY `supplierObj` (`supplierObj`),
  KEY `companyObj` (`companyObj`),
  CONSTRAINT `t_purchase_ibfk_1` FOREIGN KEY (`productObj`) REFERENCES `t_product` (`productId`),
  CONSTRAINT `t_purchase_ibfk_2` FOREIGN KEY (`supplierObj`) REFERENCES `t_supplier` (`supplierId`),
  CONSTRAINT `t_purchase_ibfk_3` FOREIGN KEY (`companyObj`) REFERENCES `t_company` (`companyId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_purchase
-- ----------------------------
INSERT INTO `t_purchase` VALUES ('1', '1', '1', '1', '11', '2018-02-07 11:26:16', '已入库', 'bb');
INSERT INTO `t_purchase` VALUES ('2', '2', '2', '2', '10', '2018-03-02 20:57:15', '已入库', '李峰');

-- ----------------------------
-- Table structure for `t_supplier`
-- ----------------------------
DROP TABLE IF EXISTS `t_supplier`;
CREATE TABLE `t_supplier` (
  `supplierId` int(11) NOT NULL auto_increment COMMENT '供应商id',
  `supplierName` varchar(20) NOT NULL COMMENT '供应商名称',
  `city` varchar(20) NOT NULL COMMENT '所在城市',
  `aPerson` varchar(20) NOT NULL COMMENT 'A方对接人',
  `djrlxfs` varchar(20) NOT NULL COMMENT '对接人联系方式',
  `luruTime` varchar(20) default NULL COMMENT '录入时间',
  `luruRen` varchar(20) NOT NULL COMMENT '录入人',
  PRIMARY KEY  (`supplierId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_supplier
-- ----------------------------
INSERT INTO `t_supplier` VALUES ('1', '供应商1', '四川成都', '对接人1', '11', '2018-02-28 11:24:53', '张斐');
INSERT INTO `t_supplier` VALUES ('2', '供应商2', '四川德阳', '李丽霞', '13984039432', '2018-03-03 20:04:50', '李倩');

-- ----------------------------
-- Table structure for `t_xzadmin`
-- ----------------------------
DROP TABLE IF EXISTS `t_xzadmin`;
CREATE TABLE `t_xzadmin` (
  `xzUserName` varchar(20) NOT NULL COMMENT 'xzUserName',
  `password` varchar(20) NOT NULL COMMENT '登录密码',
  `companyObj` int(11) NOT NULL COMMENT '所在分公司',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `sex` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `telephone` varchar(20) NOT NULL COMMENT '联系方式',
  `xzMemo` varchar(800) default NULL COMMENT '备注信息',
  PRIMARY KEY  (`xzUserName`),
  KEY `companyObj` (`companyObj`),
  CONSTRAINT `t_xzadmin_ibfk_1` FOREIGN KEY (`companyObj`) REFERENCES `t_company` (`companyId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_xzadmin
-- ----------------------------
INSERT INTO `t_xzadmin` VALUES ('xz001', '123', '1', '李翔', '男', '2018-02-13', '13498308343', '是广发');
INSERT INTO `t_xzadmin` VALUES ('xz002', '123', '2', '王忠林', '男', '2018-03-14', '13980839843', 'test');
