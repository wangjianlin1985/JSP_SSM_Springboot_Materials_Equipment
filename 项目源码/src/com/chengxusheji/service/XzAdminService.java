package com.chengxusheji.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chengxusheji.mapper.XzAdminMapper;
import com.chengxusheji.po.Admin;
import com.chengxusheji.po.Company;
import com.chengxusheji.po.XzAdmin;
@Service
public class XzAdminService {

	@Resource XzAdminMapper xzAdminMapper;
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

    /*添加行政管理记录*/
    public void addXzAdmin(XzAdmin xzAdmin) throws Exception {
    	xzAdminMapper.addXzAdmin(xzAdmin);
    }

    /*按照查询条件分页查询行政管理记录*/
    public ArrayList<XzAdmin> queryXzAdmin(String xzUserName,Company companyObj,String name,String birthDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!xzUserName.equals("")) where = where + " and t_xzAdmin.xzUserName like '%" + xzUserName + "%'";
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_xzAdmin.companyObj=" + companyObj.getCompanyId();
    	if(!name.equals("")) where = where + " and t_xzAdmin.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_xzAdmin.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_xzAdmin.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return xzAdminMapper.queryXzAdmin(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<XzAdmin> queryXzAdmin(String xzUserName,Company companyObj,String name,String birthDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!xzUserName.equals("")) where = where + " and t_xzAdmin.xzUserName like '%" + xzUserName + "%'";
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_xzAdmin.companyObj=" + companyObj.getCompanyId();
    	if(!name.equals("")) where = where + " and t_xzAdmin.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_xzAdmin.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_xzAdmin.telephone like '%" + telephone + "%'";
    	return xzAdminMapper.queryXzAdminList(where);
    }

    /*查询所有行政管理记录*/
    public ArrayList<XzAdmin> queryAllXzAdmin()  throws Exception {
        return xzAdminMapper.queryXzAdminList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String xzUserName,Company companyObj,String name,String birthDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!xzUserName.equals("")) where = where + " and t_xzAdmin.xzUserName like '%" + xzUserName + "%'";
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_xzAdmin.companyObj=" + companyObj.getCompanyId();
    	if(!name.equals("")) where = where + " and t_xzAdmin.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_xzAdmin.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_xzAdmin.telephone like '%" + telephone + "%'";
        recordNumber = xzAdminMapper.queryXzAdminCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取行政管理记录*/
    public XzAdmin getXzAdmin(String xzUserName) throws Exception  {
        XzAdmin xzAdmin = xzAdminMapper.getXzAdmin(xzUserName);
        return xzAdmin;
    }

    /*更新行政管理记录*/
    public void updateXzAdmin(XzAdmin xzAdmin) throws Exception {
        xzAdminMapper.updateXzAdmin(xzAdmin);
    }

    /*删除一条行政管理记录*/
    public void deleteXzAdmin (String xzUserName) throws Exception {
        xzAdminMapper.deleteXzAdmin(xzUserName);
    }

    /*删除多条行政管理信息*/
    public int deleteXzAdmins (String xzUserNames) throws Exception {
    	String _xzUserNames[] = xzUserNames.split(",");
    	for(String _xzUserName: _xzUserNames) {
    		xzAdminMapper.deleteXzAdmin(_xzUserName);
    	}
    	return _xzUserNames.length;
    }
	
    
	/*保存业务逻辑错误信息字段*/
	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	
	/*验证用户登录*/
	public boolean checkLogin(Admin admin) throws Exception { 
		XzAdmin db_admin = (XzAdmin) xzAdminMapper.getXzAdmin(admin.getUsername());
		if(db_admin == null) { 
			this.errMessage = " 账号不存在 ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_admin.getPassword().equals(admin.getPassword())) {
			this.errMessage = " 密码不正确! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
}
