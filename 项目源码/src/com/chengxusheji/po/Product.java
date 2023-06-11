package com.chengxusheji.po;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Product {
    /*物品id*/
    private Integer productId;
    public Integer getProductId(){
        return productId;
    }
    public void setProductId(Integer productId){
        this.productId = productId;
    }

    /*物品名称*/
    @NotEmpty(message="物品名称不能为空")
    private String productName;
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
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

    /*物品图片*/
    private String productPhoto;
    public String getProductPhoto() {
        return productPhoto;
    }
    public void setProductPhoto(String productPhoto) {
        this.productPhoto = productPhoto;
    }

    /*物品价格*/
    @NotNull(message="必须输入物品价格")
    private Float productPrice;
    public Float getProductPrice() {
        return productPrice;
    }
    public void setProductPrice(Float productPrice) {
        this.productPrice = productPrice;
    }

    /*物品数量*/
    @NotNull(message="必须输入物品数量")
    private Integer productCount;
    public Integer getProductCount() {
        return productCount;
    }
    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
    }

    /*物品描述*/
    @NotEmpty(message="物品描述不能为空")
    private String productDesc;
    public String getProductDesc() {
        return productDesc;
    }
    public void setProductDesc(String productDesc) {
        this.productDesc = productDesc;
    }

    /*录入时间*/
    @NotEmpty(message="录入时间不能为空")
    private String luruTime;
    public String getLuruTime() {
        return luruTime;
    }
    public void setLuruTime(String luruTime) {
        this.luruTime = luruTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonProduct=new JSONObject(); 
		jsonProduct.accumulate("productId", this.getProductId());
		jsonProduct.accumulate("productName", this.getProductName());
		jsonProduct.accumulate("supplierObj", this.getSupplierObj().getSupplierName());
		jsonProduct.accumulate("supplierObjPri", this.getSupplierObj().getSupplierId());
		jsonProduct.accumulate("companyObj", this.getCompanyObj().getCompanyName());
		jsonProduct.accumulate("companyObjPri", this.getCompanyObj().getCompanyId());
		jsonProduct.accumulate("productPhoto", this.getProductPhoto());
		jsonProduct.accumulate("productPrice", this.getProductPrice());
		jsonProduct.accumulate("productCount", this.getProductCount());
		jsonProduct.accumulate("productDesc", this.getProductDesc());
		jsonProduct.accumulate("luruTime", this.getLuruTime().length()>19?this.getLuruTime().substring(0,19):this.getLuruTime());
		return jsonProduct;
    }}