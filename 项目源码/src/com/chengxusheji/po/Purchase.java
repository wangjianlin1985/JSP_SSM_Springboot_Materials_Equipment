package com.chengxusheji.po;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Purchase {
    /*采购id*/
    private Integer purchaseId;
    public Integer getPurchaseId(){
        return purchaseId;
    }
    public void setPurchaseId(Integer purchaseId){
        this.purchaseId = purchaseId;
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

    /*入库数量*/
    @NotNull(message="必须输入入库数量")
    private Integer purchaseCount;
    public Integer getPurchaseCount() {
        return purchaseCount;
    }
    public void setPurchaseCount(Integer purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

    /*入库时间*/
    @NotEmpty(message="入库时间不能为空")
    private String purchaseTime;
    public String getPurchaseTime() {
        return purchaseTime;
    }
    public void setPurchaseTime(String purchaseTime) {
        this.purchaseTime = purchaseTime;
    }

    /*状态*/
    @NotEmpty(message="状态不能为空")
    private String purchaseState;
    public String getPurchaseState() {
        return purchaseState;
    }
    public void setPurchaseState(String purchaseState) {
        this.purchaseState = purchaseState;
    }

    /*操作人*/
    @NotEmpty(message="操作人不能为空")
    private String czr;
    public String getCzr() {
        return czr;
    }
    public void setCzr(String czr) {
        this.czr = czr;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPurchase=new JSONObject(); 
		jsonPurchase.accumulate("purchaseId", this.getPurchaseId());
		jsonPurchase.accumulate("productObj", this.getProductObj().getProductName());
		jsonPurchase.accumulate("productObjPri", this.getProductObj().getProductId());
		jsonPurchase.accumulate("supplierObj", this.getSupplierObj().getSupplierName());
		jsonPurchase.accumulate("supplierObjPri", this.getSupplierObj().getSupplierId());
		jsonPurchase.accumulate("companyObj", this.getCompanyObj().getCompanyName());
		jsonPurchase.accumulate("companyObjPri", this.getCompanyObj().getCompanyId());
		jsonPurchase.accumulate("purchaseCount", this.getPurchaseCount());
		jsonPurchase.accumulate("purchaseTime", this.getPurchaseTime().length()>19?this.getPurchaseTime().substring(0,19):this.getPurchaseTime());
		jsonPurchase.accumulate("purchaseState", this.getPurchaseState());
		jsonPurchase.accumulate("czr", this.getCzr());
		return jsonPurchase;
    }}