package com.chengxusheji.po;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Supplier {
    /*供应商id*/
    private Integer supplierId;
    public Integer getSupplierId(){
        return supplierId;
    }
    public void setSupplierId(Integer supplierId){
        this.supplierId = supplierId;
    }

    /*供应商名称*/
    @NotEmpty(message="供应商名称不能为空")
    private String supplierName;
    public String getSupplierName() {
        return supplierName;
    }
    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    /*所在城市*/
    @NotEmpty(message="所在城市不能为空")
    private String city;
    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }

    /*A方对接人*/
    @NotEmpty(message="A方对接人不能为空")
    private String aPerson;
    public String getAPerson() {
        return aPerson;
    }
    public void setAPerson(String aPerson) {
        this.aPerson = aPerson;
    }

    /*对接人联系方式*/
    @NotEmpty(message="对接人联系方式不能为空")
    private String djrlxfs;
    public String getDjrlxfs() {
        return djrlxfs;
    }
    public void setDjrlxfs(String djrlxfs) {
        this.djrlxfs = djrlxfs;
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

    /*录入人*/
    @NotEmpty(message="录入人不能为空")
    private String luruRen;
    public String getLuruRen() {
        return luruRen;
    }
    public void setLuruRen(String luruRen) {
        this.luruRen = luruRen;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonSupplier=new JSONObject(); 
		jsonSupplier.accumulate("supplierId", this.getSupplierId());
		jsonSupplier.accumulate("supplierName", this.getSupplierName());
		jsonSupplier.accumulate("city", this.getCity());
		jsonSupplier.accumulate("aPerson", this.getAPerson());
		jsonSupplier.accumulate("djrlxfs", this.getDjrlxfs());
		jsonSupplier.accumulate("luruTime", this.getLuruTime().length()>19?this.getLuruTime().substring(0,19):this.getLuruTime());
		jsonSupplier.accumulate("luruRen", this.getLuruRen());
		return jsonSupplier;
    }}