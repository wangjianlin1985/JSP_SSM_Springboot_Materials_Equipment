package com.chengxusheji.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chengxusheji.mapper.CompanyMapper;
import com.chengxusheji.po.Company;
@Service
public class CompanyService {

	@Resource CompanyMapper companyMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加公司物需点记录*/
    public void addCompany(Company company) throws Exception {
    	companyMapper.addCompany(company);
    }

    /*按照查询条件分页查询公司物需点记录*/
    public ArrayList<Company> queryCompany(String companyName,String city,String telephone,String bPerson,String djrlxfs,String luruTime,String luruRen,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!companyName.equals("")) where = where + " and t_company.companyName like '%" + companyName + "%'";
    	if(!city.equals("")) where = where + " and t_company.city like '%" + city + "%'";
    	if(!telephone.equals("")) where = where + " and t_company.telephone like '%" + telephone + "%'";
    	if(!bPerson.equals("")) where = where + " and t_company.bPerson like '%" + bPerson + "%'";
    	if(!djrlxfs.equals("")) where = where + " and t_company.djrlxfs like '%" + djrlxfs + "%'";
    	if(!luruTime.equals("")) where = where + " and t_company.luruTime like '%" + luruTime + "%'";
    	if(!luruRen.equals("")) where = where + " and t_company.luruRen like '%" + luruRen + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return companyMapper.queryCompany(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Company> queryCompany(String companyName,String city,String telephone,String bPerson,String djrlxfs,String luruTime,String luruRen) throws Exception  { 
     	String where = "where 1=1";
    	if(!companyName.equals("")) where = where + " and t_company.companyName like '%" + companyName + "%'";
    	if(!city.equals("")) where = where + " and t_company.city like '%" + city + "%'";
    	if(!telephone.equals("")) where = where + " and t_company.telephone like '%" + telephone + "%'";
    	if(!bPerson.equals("")) where = where + " and t_company.bPerson like '%" + bPerson + "%'";
    	if(!djrlxfs.equals("")) where = where + " and t_company.djrlxfs like '%" + djrlxfs + "%'";
    	if(!luruTime.equals("")) where = where + " and t_company.luruTime like '%" + luruTime + "%'";
    	if(!luruRen.equals("")) where = where + " and t_company.luruRen like '%" + luruRen + "%'";
    	return companyMapper.queryCompanyList(where);
    }

    /*查询所有公司物需点记录*/
    public ArrayList<Company> queryAllCompany()  throws Exception {
        return companyMapper.queryCompanyList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String companyName,String city,String telephone,String bPerson,String djrlxfs,String luruTime,String luruRen) throws Exception {
     	String where = "where 1=1";
    	if(!companyName.equals("")) where = where + " and t_company.companyName like '%" + companyName + "%'";
    	if(!city.equals("")) where = where + " and t_company.city like '%" + city + "%'";
    	if(!telephone.equals("")) where = where + " and t_company.telephone like '%" + telephone + "%'";
    	if(!bPerson.equals("")) where = where + " and t_company.bPerson like '%" + bPerson + "%'";
    	if(!djrlxfs.equals("")) where = where + " and t_company.djrlxfs like '%" + djrlxfs + "%'";
    	if(!luruTime.equals("")) where = where + " and t_company.luruTime like '%" + luruTime + "%'";
    	if(!luruRen.equals("")) where = where + " and t_company.luruRen like '%" + luruRen + "%'";
        recordNumber = companyMapper.queryCompanyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取公司物需点记录*/
    public Company getCompany(int companyId) throws Exception  {
        Company company = companyMapper.getCompany(companyId);
        return company;
    }

    /*更新公司物需点记录*/
    public void updateCompany(Company company) throws Exception {
        companyMapper.updateCompany(company);
    }

    /*删除一条公司物需点记录*/
    public void deleteCompany (int companyId) throws Exception {
        companyMapper.deleteCompany(companyId);
    }

    /*删除多条公司物需点信息*/
    public int deleteCompanys (String companyIds) throws Exception {
    	String _companyIds[] = companyIds.split(",");
    	for(String _companyId: _companyIds) {
    		companyMapper.deleteCompany(Integer.parseInt(_companyId));
    	}
    	return _companyIds.length;
    }
}
