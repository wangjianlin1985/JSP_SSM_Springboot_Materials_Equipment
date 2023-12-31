﻿<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/department.css" /> 

<div id="department_manage"></div>
<div id="department_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="department_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="department_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="department_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="department_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="department_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="departmentQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="departmentEditDiv">
	<form id="departmentEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">部门id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentId_edit" name="department.departmentId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">部门名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="department_departmentName_edit" name="department.departmentName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">部门职责:</span>
			<span class="inputControl">
				<textarea id="department_departmentDesc_edit" name="department.departmentDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Department/js/department_manage.js"></script> 
