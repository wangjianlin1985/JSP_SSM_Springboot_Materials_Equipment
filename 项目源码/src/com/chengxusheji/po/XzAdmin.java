package com.chengxusheji.po;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class XzAdmin {
    /*用户名*/
    @NotEmpty(message="用户名不能为空")
    private String xzUserName;
    public String getXzUserName(){
        return xzUserName;
    }
    public void setXzUserName(String xzUserName){
        this.xzUserName = xzUserName;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*所在分公司*/
    private Company companyObj;
    public Company getCompanyObj() {
        return companyObj;
    }
    public void setCompanyObj(Company companyObj) {
        this.companyObj = companyObj;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*联系方式*/
    @NotEmpty(message="联系方式不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*备注信息*/
    private String xzMemo;
    public String getXzMemo() {
        return xzMemo;
    }
    public void setXzMemo(String xzMemo) {
        this.xzMemo = xzMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonXzAdmin=new JSONObject(); 
		jsonXzAdmin.accumulate("xzUserName", this.getXzUserName());
		jsonXzAdmin.accumulate("password", this.getPassword());
		jsonXzAdmin.accumulate("companyObj", this.getCompanyObj().getCompanyName());
		jsonXzAdmin.accumulate("companyObjPri", this.getCompanyObj().getCompanyId());
		jsonXzAdmin.accumulate("name", this.getName());
		jsonXzAdmin.accumulate("sex", this.getSex());
		jsonXzAdmin.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonXzAdmin.accumulate("telephone", this.getTelephone());
		jsonXzAdmin.accumulate("xzMemo", this.getXzMemo());
		return jsonXzAdmin;
    }}