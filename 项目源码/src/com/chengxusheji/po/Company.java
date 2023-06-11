package com.chengxusheji.po;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Company {
    /*物需点id*/
    private Integer companyId;
    public Integer getCompanyId(){
        return companyId;
    }
    public void setCompanyId(Integer companyId){
        this.companyId = companyId;
    }

    /*公司名称*/
    @NotEmpty(message="公司名称不能为空")
    private String companyName;
    public String getCompanyName() {
        return companyName;
    }
    public void setCompanyName(String companyName) {
        this.companyName = companyName;
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

    /*物需点电话*/
    @NotEmpty(message="物需点电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*物需点地址*/
    @NotEmpty(message="物需点地址不能为空")
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*B方对接人*/
    @NotEmpty(message="B方对接人不能为空")
    private String bPerson;
    public String getBPerson() {
        return bPerson;
    }
    public void setBPerson(String bPerson) {
        this.bPerson = bPerson;
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
    	JSONObject jsonCompany=new JSONObject(); 
		jsonCompany.accumulate("companyId", this.getCompanyId());
		jsonCompany.accumulate("companyName", this.getCompanyName());
		jsonCompany.accumulate("city", this.getCity());
		jsonCompany.accumulate("telephone", this.getTelephone());
		jsonCompany.accumulate("address", this.getAddress());
		jsonCompany.accumulate("bPerson", this.getBPerson());
		jsonCompany.accumulate("djrlxfs", this.getDjrlxfs());
		jsonCompany.accumulate("luruTime", this.getLuruTime().length()>19?this.getLuruTime().substring(0,19):this.getLuruTime());
		jsonCompany.accumulate("luruRen", this.getLuruRen());
		return jsonCompany;
    }}