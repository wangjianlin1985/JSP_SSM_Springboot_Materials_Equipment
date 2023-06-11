package com.chengxusheji.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.chengxusheji.po.XzAdmin;

public interface XzAdminMapper {
	/*添加行政管理信息*/
	public void addXzAdmin(XzAdmin xzAdmin) throws Exception;

	/*按照查询条件分页查询行政管理记录*/
	public ArrayList<XzAdmin> queryXzAdmin(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有行政管理记录*/
	public ArrayList<XzAdmin> queryXzAdminList(@Param("where") String where) throws Exception;

	/*按照查询条件的行政管理记录数*/
	public int queryXzAdminCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条行政管理记录*/
	public XzAdmin getXzAdmin(String xzUserName) throws Exception;

	/*更新行政管理记录*/
	public void updateXzAdmin(XzAdmin xzAdmin) throws Exception;

	/*删除行政管理记录*/
	public void deleteXzAdmin(String xzUserName) throws Exception;

}
