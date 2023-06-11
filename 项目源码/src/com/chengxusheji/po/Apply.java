package com.chengxusheji.po;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Apply {
    /*申领id*/
    private Integer applyId;
    public Integer getApplyId(){
        return applyId;
    }
    public void setApplyId(Integer applyId){
        this.applyId = applyId;
    }

    /*物品名称*/
    private Product productObj;
    public Product getProductObj() {
        return productObj;
    }
    public void setProductObj(Product productObj) {
        this.productObj = productObj;
    }

    /*物品供应商*/
    private Supplier supplierObj;
    public Supplier getSupplierObj() {
        return supplierObj;
    }
    public void setSupplierObj(Supplier supplierObj) {
        this.supplierObj = supplierObj;
    }

    /*行政物需点*/
    private Company companyObj;
    public Company getCompanyObj() {
        return companyObj;
    }
    public void setCompanyObj(Company companyObj) {
        this.companyObj = companyObj;
    }

    /*出库数量*/
    @NotNull(message="必须输入出库数量")
    private Integer applyCount;
    public Integer getApplyCount() {
        return applyCount;
    }
    public void setApplyCount(Integer applyCount) {
        this.applyCount = applyCount;
    }

    /*申请人*/
    @NotEmpty(message="申请人不能为空")
    private String sqr;
    public String getSqr() {
        return sqr;
    }
    public void setSqr(String sqr) {
        this.sqr = sqr;
    }

    /*申请时间*/
    @NotEmpty(message="申请时间不能为空")
    private String sqsj;
    public String getSqsj() {
        return sqsj;
    }
    public void setSqsj(String sqsj) {
        this.sqsj = sqsj;
    }

    /*状态*/
    @NotEmpty(message="状态不能为空")
    private String applyState;
    public String getApplyState() {
        return applyState;
    }
    public void setApplyState(String applyState) {
        this.applyState = applyState;
    }

    /*审批人*/
    @NotEmpty(message="审批人不能为空")
    private String shenpiren;
    public String getShenpiren() {
        return shenpiren;
    }
    public void setShenpiren(String shenpiren) {
        this.shenpiren = shenpiren;
    }

    /*出库时间*/
    @NotEmpty(message="出库时间不能为空")
    private String cksj;
    public String getCksj() {
        return cksj;
    }
    public void setCksj(String cksj) {
        this.cksj = cksj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonApply=new JSONObject(); 
		jsonApply.accumulate("applyId", this.getApplyId());
		jsonApply.accumulate("productObj", this.getProductObj().getProductName());
		jsonApply.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonApply.accumulate("supplierObj", this.getSupplierObj().getSupplierName());
		jsonApply.accumulate("supplierObjPri", this.getSupplierObj().getSupplierId());
		jsonApply.accumulate("companyObj", this.getCompanyObj().getCompanyName());
		jsonApply.accumulate("companyObjPri", this.getCompanyObj().getCompanyId());
		jsonApply.accumulate("applyCount", this.getApplyCount());
		jsonApply.accumulate("sqr", this.getSqr());
		jsonApply.accumulate("sqsj", this.getSqsj().length()>19?this.getSqsj().substring(0,19):this.getSqsj());
		jsonApply.accumulate("applyState", this.getApplyState());
		jsonApply.accumulate("shenpiren", this.getShenpiren());
		jsonApply.accumulate("cksj", this.getCksj().length()>19?this.getCksj().substring(0,19):this.getCksj());
		return jsonApply;
    }}