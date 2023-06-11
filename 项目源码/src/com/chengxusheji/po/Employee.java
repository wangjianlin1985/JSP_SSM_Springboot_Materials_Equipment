package com.chengxusheji.po;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Employee {
    /*员工号*/
    @NotEmpty(message="员工号不能为空")
    private String employeeNo;
    public String getEmployeeNo(){
        return employeeNo;
    }
    public void setEmployeeNo(String employeeNo){
        this.employeeNo = employeeNo;
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
    private String bornDate;
    public String getBornDate() {
        return bornDate;
    }
    public void setBornDate(String bornDate) {
        this.bornDate = bornDate;
    }

    /*员工照片*/
    private String employeePhoto;
    public String getEmployeePhoto() {
        return employeePhoto;
    }
    public void setEmployeePhoto(String employeePhoto) {
        this.employeePhoto = employeePhoto;
    }

    /*所在分公司*/
    private Company companyObj;
    public Company getCompanyObj() {
        return companyObj;
    }
    public void setCompanyObj(Company companyObj) {
        this.companyObj = companyObj;
    }

    /*所属部门*/
    private Department departmentObj;
    public Department getDepartmentObj() {
        return departmentObj;
    }
    public void setDepartmentObj(Department departmentObj) {
        this.departmentObj = departmentObj;
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

    /*工位号*/
    @NotEmpty(message="工位号不能为空")
    private String gwh;
    public String getGwh() {
        return gwh;
    }
    public void setGwh(String gwh) {
        this.gwh = gwh;
    }

    /*员工备注*/
    private String employeeMemo;
    public String getEmployeeMemo() {
        return employeeMemo;
    }
    public void setEmployeeMemo(String employeeMemo) {
        this.employeeMemo = employeeMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonEmployee=new JSONObject(); 
		jsonEmployee.accumulate("employeeNo", this.getEmployeeNo());
		jsonEmployee.accumulate("password", this.getPassword());
		jsonEmployee.accumulate("name", this.getName());
		jsonEmployee.accumulate("sex", this.getSex());
		jsonEmployee.accumulate("bornDate", this.getBornDate().length()>19?this.getBornDate().substring(0,19):this.getBornDate());
		jsonEmployee.accumulate("employeePhoto", this.getEmployeePhoto());
		jsonEmployee.accumulate("companyObj", this.getCompanyObj().getCompanyName());
		jsonEmployee.accumulate("companyObjPri", this.getCompanyObj().getCompanyId());
		jsonEmployee.accumulate("departmentObj", this.getDepartmentObj().getDepartmentName());
		jsonEmployee.accumulate("departmentObjPri", this.getDepartmentObj().getDepartmentId());
		jsonEmployee.accumulate("telephone", this.getTelephone());
		jsonEmployee.accumulate("gwh", this.getGwh());
		jsonEmployee.accumulate("employeeMemo", this.getEmployeeMemo());
		return jsonEmployee;
    }}