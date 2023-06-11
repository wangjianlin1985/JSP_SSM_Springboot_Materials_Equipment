package com.chengxusheji.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chengxusheji.mapper.ApplyMapper;
import com.chengxusheji.po.Apply;
import com.chengxusheji.po.Company;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.Supplier;
@Service
public class ApplyService {

	@Resource ApplyMapper applyMapper;
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

    /*添加物资申领记录*/
    public void addApply(Apply apply) throws Exception {
    	applyMapper.addApply(apply);
    }

    /*按照查询条件分页查询物资申领记录*/
    public ArrayList<Apply> queryApply(Product productObj,Supplier supplierObj,Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_apply.productObj=" + productObj.getProductId();
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_apply.supplierObj=" + supplierObj.getSupplierId();
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_apply.companyObj=" + companyObj.getCompanyId();
    	if(!sqr.equals("")) where = where + " and t_apply.sqr like '%" + sqr + "%'";
    	if(!sqsj.equals("")) where = where + " and t_apply.sqsj like '%" + sqsj + "%'";
    	if(!applyState.equals("")) where = where + " and t_apply.applyState like '%" + applyState + "%'";
    	if(!shenpiren.equals("")) where = where + " and t_apply.shenpiren like '%" + shenpiren + "%'";
    	if(!cksj.equals("")) where = where + " and t_apply.cksj like '%" + cksj + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return applyMapper.queryApply(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Apply> queryApply(Product productObj,Supplier supplierObj,Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_apply.productObj=" + productObj.getProductId();
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_apply.supplierObj=" + supplierObj.getSupplierId();
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_apply.companyObj=" + companyObj.getCompanyId();
    	if(!sqr.equals("")) where = where + " and t_apply.sqr like '%" + sqr + "%'";
    	if(!sqsj.equals("")) where = where + " and t_apply.sqsj like '%" + sqsj + "%'";
    	if(!applyState.equals("")) where = where + " and t_apply.applyState like '%" + applyState + "%'";
    	if(!shenpiren.equals("")) where = where + " and t_apply.shenpiren like '%" + shenpiren + "%'";
    	if(!cksj.equals("")) where = where + " and t_apply.cksj like '%" + cksj + "%'";
    	return applyMapper.queryApplyList(where);
    }

    /*查询所有物资申领记录*/
    public ArrayList<Apply> queryAllApply()  throws Exception {
        return applyMapper.queryApplyList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Product productObj,Supplier supplierObj,Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj) throws Exception {
     	String where = "where 1=1";
    	if(null != productObj && productObj.getProductId()!= null && productObj.getProductId()!= 0)  where += " and t_apply.productObj=" + productObj.getProductId();
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_apply.supplierObj=" + supplierObj.getSupplierId();
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_apply.companyObj=" + companyObj.getCompanyId();
    	if(!sqr.equals("")) where = where + " and t_apply.sqr like '%" + sqr + "%'";
    	if(!sqsj.equals("")) where = where + " and t_apply.sqsj like '%" + sqsj + "%'";
    	if(!applyState.equals("")) where = where + " and t_apply.applyState like '%" + applyState + "%'";
    	if(!shenpiren.equals("")) where = where + " and t_apply.shenpiren like '%" + shenpiren + "%'";
    	if(!cksj.equals("")) where = where + " and t_apply.cksj like '%" + cksj + "%'";
        recordNumber = applyMapper.queryApplyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取物资申领记录*/
    public Apply getApply(int applyId) throws Exception  {
        Apply apply = applyMapper.getApply(applyId);
        return apply;
    }

    /*更新物资申领记录*/
    public void updateApply(Apply apply) throws Exception {
        applyMapper.updateApply(apply);
    }

    /*删除一条物资申领记录*/
    public void deleteApply (int applyId) throws Exception {
        applyMapper.deleteApply(applyId);
    }

    /*删除多条物资申领信息*/
    public int deleteApplys (String applyIds) throws Exception {
    	String _applyIds[] = applyIds.split(",");
    	for(String _applyId: _applyIds) {
    		applyMapper.deleteApply(Integer.parseInt(_applyId));
    	}
    	return _applyIds.length;
    }
}
