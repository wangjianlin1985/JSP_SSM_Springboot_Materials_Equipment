﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css" />
<div id="departmentAddDiv">
	<form id="departmentAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">部门名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentName" name="department.departmentName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">部门职责:</span>
			<span class="inputControl">
				<textarea id="department_departmentDesc" name="department.departmentDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="departmentAddButton" class="easyui-linkbutton">添加</a>
			<a id="departmentClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Department/js/department_add.js"></script> 
