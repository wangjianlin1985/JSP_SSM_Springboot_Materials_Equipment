package com.chengxusheji.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.chengxusheji.po.Apply;

public interface ApplyMapper {
	/*添加物资申领信息*/
	public void addApply(Apply apply) throws Exception;

	/*按照查询条件分页查询物资申领记录*/
	public ArrayList<Apply> queryApply(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有物资申领记录*/
	public ArrayList<Apply> queryApplyList(@Param("where") String where) throws Exception;

	/*按照查询条件的物资申领记录数*/
	public int queryApplyCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条物资申领记录*/
	public Apply getApply(int applyId) throws Exception;

	/*更新物资申领记录*/
	public void updateApply(Apply apply) throws Exception;

	/*删除物资申领记录*/
	public void deleteApply(int applyId) throws Exception;

}
