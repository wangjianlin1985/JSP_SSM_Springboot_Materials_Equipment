package com.chengxusheji.po;

import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Department {
    /*部门id*/
    private Integer departmentId;
    public Integer getDepartmentId(){
        return departmentId;
    }
    public void setDepartmentId(Integer departmentId){
        this.departmentId = departmentId;
    }

    /*部门名称*/
    @NotEmpty(message="部门名称不能为空")
    private String departmentName;
    public String getDepartmentName() {
        return departmentName;
    }
    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    /*部门职责*/
    @NotEmpty(message="部门职责不能为空")
    private String departmentDesc;
    public String getDepartmentDesc() {
        return departmentDesc;
    }
    public void setDepartmentDesc(String departmentDesc) {
        this.departmentDesc = departmentDesc;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDepartment=new JSONObject(); 
		jsonDepartment.accumulate("departmentId", this.getDepartmentId());
		jsonDepartment.accumulate("departmentName", this.getDepartmentName());
		jsonDepartment.accumulate("departmentDesc", this.getDepartmentDesc());
		return jsonDepartment;
    }}