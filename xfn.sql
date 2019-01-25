SET NAMES UTF8;
DROP DATABASE IF EXISTS xiaofeiniu;
CREATE DATABASE xiaofeiniu CHARSET=UTF8;
USE xiaofeiniu;

#管理员信息表
CREATE TABLE xfn_admin(
  aid INT PRIMARY KEY AUTO_INCREMENT COMMENT "管理员账号",
  aname VARCHAR(32) UNIQUE COMMENT "管理员用户名",
  apwd VARCHAR(64) COMMENT "管理员密码"
);
INSERT INTO xfn_admin VALUES
(NULL,'admin',PASSWORD('123456')),
(NULL,'boss',PASSWORD('999999'));

#项目全局设置
CREATE TABLE xfn_settings(
  sid INT PRIMARY KEY AUTO_INCREMENT COMMENT "编号",
  appName VARCHAR(32) COMMENT "应用/店家名称",
  apiUrl VARCHAR(64) COMMENT "数据API子系统",
  adminUrl VARCHAR(64) COMMENT "管理后台子系统",
  appUrl VARCHAR(64) COMMENT "顾客App子系统",
  icp VARCHAR(64) COMMENT "系统备案号",
  copyright VARCHAR(128) COMMENT "系统版权声明"
);
INSERT INTO xfn_settings VALUES
(NULL,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备 18016421号-1','©2018 版权所有 小肥牛餐饮管理有限公司');

#桌台信息表
CREATE TABLE xfn_table(
  tid INT PRIMARY KEY AUTO_INCREMENT COMMENT "桌台编号",
  tname VARCHAR(64) COMMENT "桌台昵称",
  type VARCHAR(16) COMMENT "桌台类型",
  status INT COMMENT "桌台状态"
);
INSERT INTO xfn_table VALUES 
(NULL,'福满堂','6-8人桌',1),
(NULL,'金镶玉','4人桌',2),
(NULL,'寿齐天','10人桌',3),
(NULL,'全家福','2人桌',0);

#桌台预定表
CREATE TABLE xnf_reservation(
  rid INT PRIMARY KEY AUTO_INCREMENT,
  contactName VARCHAR(64),
  phone VARCHAR(16),
  contactTime BIGINT,
  dinnerTime BIGINT,
  tableId INT,
  FOREIGN KEY (tableId) REFERENCES xfn_table(tid)
);
INSERT INTO xnf_reservation VALUES 
(NULL,'丁丁','13501234567',1548404840843,1548410400000,1),
(NULL,'当当','13501234567',1548474840843,1548410500000,3),
(NULL,'豆豆','13501234567',1548412408437,1548410600000,2),
(NULL,'丫丫','13501234567',1548408240843,1548410700000,4);

#菜品分类表
CREATE TABLE xfn_category(
  cid INT PRIMARY KEY AUTO_INCREMENT,
  cname VARCHAR(32)
);
INSERT INTO xfn_category VALUES
(NULL,'肉类'),
(NULL,'丸滑类'),
(NULL,'海鲜河鲜类'),
(NULL,'蔬菜豆制品类'),
(NULL,'菌菇类');

#菜品信息表
CREATE TABLE xfn_dish(
  did INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(32),
  img_url VARCHAR(128),
  price DECIMAL(6,2),
  detail VARCHAR(128),
  categoryId INT,
  FOREIGN KEY (categoryid) REFERENCES xfn_category(cid)
);
INSERT INTO xfn_dish VALUES
(100000,'草鱼片','CE7I9470.jpg',35,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用。',1),
(NULL,'酥肉','HGS_4760.jpg',45,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮3分钟左右即可食用。',1),
(NULL,'现炸酥肉(非清真)','HGS_4760-1.jpg',32,'选用冷鲜五花肉，加上鸡蛋，淀粉等原料炸制，色泽黄亮，酥软醇香，肥而不腻。锅开后再煮1分钟左右即可食用，也可直接食用',1),
(NULL,'猪脑花','zhunao.jpg',27,'选用大型厂家冷鲜猪脑经过清洗，过水、撕膜而成。肉质细腻，锅开后再煮8分钟左右即可食用。',1),
(NULL,'脆皮肠','CE7I9017.jpg',25,'锅开后再煮3分钟左右即可食用。',1),
(NULL,'午餐肉','wucanrou.jpg',18,'锅开后再煮2分钟左右即可食用。',1),
(NULL,'牛仔骨','1-CE7I5290.jpg',78,'选用新西兰羔羊肉的前胸和肩胛为原料，在国内经过分割、压制成型，肥瘦均匀。锅开后涮30秒左右即可食用。',1),
(NULL,'千层毛肚','CE7I8900_1.jpg',62,'选自牛的草肚，加入葱、姜、五香料一起煮熟后切片而成。五香味浓、耙软化渣。锅开后再煮3分钟左右即可食用。',1),
(NULL,'捞派脆脆毛肚','cuicuimaodu.jpg',55,'选自牛的草肚，采用流水清洗、撕片等工艺，加入各种调味料腌制而成。口感脆嫩，锅开后再采用“七上八下”的方法涮15秒即可食用。',1);

#订单表
CREATE TABLE xfn_order(
  oid INT PRIMARY KEY AUTO_INCREMENT,
  startTime BIGINT,
  endTime BIGINT,
  customerCount INT,
  tableId INT,
  FOREIGN KEY (tableId) REFERENCES xfn_table(tid)
);
INSERT INTO xfn_order VALUES
(NULL,1548410700000,15484107090000,3,1);

#订单详情表
CREATE TABLE xfn_detail(
  did INT PRIMARY KEY AUTO_INCREMENT,
  dishId INT COMMENT "菜品编号",
  dishCount INT COMMENT "份数",
  customerName VARCHAR(64) COMMENT "顾客名",
  orderId INT COMMENT "订单编号",
  FOREIGN KEY (dishId) REFERENCES xfn_dish(did),
  FOREIGN KEY (orderId) REFERENCES xfn_order(oid)
);
INSERT INTO xfn_detail VALUES
(NULL,100001,2,"dingding",1);
