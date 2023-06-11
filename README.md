# JSP_SSM_Springboot_Materials_Equipment
JSP基于SSM公司物资设备采购入库申领出库库存管理网站可升级SpringBoot毕业源码案例设计
## 程序开发环境：myEclipse/Eclipse/Idea都可以 + mysql数据库
## 前台技术框架： Bootstrap  后台架构框架: SSM
系统一共分3个身份： 员工，行政部人员和超级管理员
员工：可以在网站前台查询公司无需点信息，查询供应商列表，查询部门信息，查询物资信息，查询采购入库记录和物资设备申领出库记录！员工注册登录后可以申领物资设备出库使用，管理员或者行政部人员通过确认通过了申领审核后，对应的物资库存减少！员工可以只查询自己的物资申领记录！

行政部人员：登录后可以添加管理职工信息，添加管理物资信息及物资库存查询，登记物资采购记录，物资采购后对应物资的库存增加，管理审核员工的物资申领申请及修改个人信息

超级管理员：登录后可以添加和管理公司物需点仓库信息，物需点就相当于仓库，可以添加管理职工信息，供应商信息，部门信息，物资信息，也可以管理采购记录，审核员工的物资设备申领出库申请信息，还可以管理行政部人员信息，超级管理员的功能权限最多！
## 实体ER属性：
公司物需点: 物需点id,公司名称,所在城市,物需点电话,物需点地址,B方对接人,对接人联系方式,录入时间,录入人

职工: 员工号,登录密码,姓名,性别,出生日期,员工照片,所在分公司,所属部门,联系方式,工位号,员工备注

供应商: 供应商id,供应商名称,所在城市,A方对接人,对接人联系方式,录入时间,录入人

部门: 部门id,部门名称,部门职责

物资: 物品id,物品名称,物品供应商,行政物需点,物品图片,物品价格,物品数量,物品描述,录入时间

物资采购: 采购id,物品名称,物品供应商,行政物需点,入库数量,入库时间,状态,操作人

物资申领: 申领id,物品名称,物品供应商,行政物需点,出库数量,申请人,申请时间,状态,审批人,出库时间

行政管理: 用户名,登录密码,所在分公司,姓名,性别,出生日期,联系方式,备注信息
