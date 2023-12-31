﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Department" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Department department = (Department)request.getAttribute("department");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改部门信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">部门信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="departmentEditForm" id="departmentEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="department_departmentId_edit" class="col-md-3 text-right">部门id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="department_departmentId_edit" name="department.departmentId" class="form-control" placeholder="请输入部门id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="department_departmentName_edit" class="col-md-3 text-right">部门名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="department_departmentName_edit" name="department.departmentName" class="form-control" placeholder="请输入部门名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="department_departmentDesc_edit" class="col-md-3 text-right">部门职责:</label>
		  	 <div class="col-md-9">
			    <textarea id="department_departmentDesc_edit" name="department.departmentDesc" rows="8" class="form-control" placeholder="请输入部门职责"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxDepartmentModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#departmentEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改部门界面并初始化数据*/
function departmentEdit(departmentId) {
	$.ajax({
		url :  basePath + "Department/" + departmentId + "/update",
		type : "get",
		dataType: "json",
		success : function (department, response, status) {
			if (department) {
				$("#department_departmentId_edit").val(department.departmentId);
				$("#department_departmentName_edit").val(department.departmentName);
				$("#department_departmentDesc_edit").val(department.departmentDesc);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交部门信息表单给服务器端修改*/
function ajaxDepartmentModify() {
	$.ajax({
		url :  basePath + "Department/" + $("#department_departmentId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#departmentEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "Department/frontlist";
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    departmentEdit("<%=request.getParameter("departmentId")%>");
 })
 </script> 
</body>
</html>

