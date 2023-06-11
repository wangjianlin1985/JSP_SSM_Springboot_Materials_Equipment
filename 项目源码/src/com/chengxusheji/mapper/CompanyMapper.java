package com.chengxusheji.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.chengxusheji.po.Company;

public interface CompanyMapper {
	/*添加公司物需点信息*/
	public void addCompany(Company company) throws Exception;

	/*按照查询条件分页查询公司物需点记录*/
	public ArrayList<Company> queryCompany(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有公司物需点记录*/
	public ArrayList<Company> queryCompanyList(@Param("where") String where) throws Exception;

	/*按照查询条件的公司物需点记录数*/
	public int queryCompanyCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条公司物需点记录*/
	public Company getCompany(int companyId) throws Exception;

	/*更新公司物需点记录*/
	public void updateCompany(Company company) throws Exception;

	/*删除公司物需点记录*/
	public void deleteCompany(int companyId) throws Exception;

}
