﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Employee" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.Department" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Employee> employeeList = (List<Employee>)request.getAttribute("employeeList");
    //获取所有的companyObj信息
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    //获取所有的departmentObj信息
    List<Department> departmentList = (List<Department>)request.getAttribute("departmentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String employeeNo = (String)request.getAttribute("employeeNo"); //员工号查询关键字
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String bornDate = (String)request.getAttribute("bornDate"); //出生日期查询关键字
    Company companyObj = (Company)request.getAttribute("companyObj");
    Department departmentObj = (Department)request.getAttribute("departmentObj");
    String telephone = (String)request.getAttribute("telephone"); //联系方式查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>职工查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Employee/frontlist">职工信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Employee/employee_frontAdd.jsp" style="display:none;">添加职工</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<employeeList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Employee employee = employeeList.get(i); //获取到职工对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Employee/<%=employee.getEmployeeNo() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=employee.getEmployeePhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		员工号:<%=employee.getEmployeeNo() %>
			     	</div>
			     	<div class="field">
	            		姓名:<%=employee.getName() %>
			     	</div>
			     	<div class="field">
	            		性别:<%=employee.getSex() %>
			     	</div>
			     	<div class="field">
	            		出生日期:<%=employee.getBornDate() %>
			     	</div>
			     	<div class="field">
	            		所在分公司:<%=employee.getCompanyObj().getCompanyName() %>
			     	</div>
			     	<div class="field">
	            		所属部门:<%=employee.getDepartmentObj().getDepartmentName() %>
			     	</div>
			     	<div class="field">
	            		联系方式:<%=employee.getTelephone() %>
			     	</div>
			     	<div class="field">
	            		工位号:<%=employee.getGwh() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Employee/<%=employee.getEmployeeNo() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="employeeEdit('<%=employee.getEmployeeNo() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="employeeDelete('<%=employee.getEmployeeNo() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>职工查询</h1>
		</div>
		<form name="employeeQueryForm" id="employeeQueryForm" action="<%=basePath %>Employee/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="employeeNo">员工号:</label>
				<input type="text" id="employeeNo" name="employeeNo" value="<%=employeeNo %>" class="form-control" placeholder="请输入员工号">
			</div>
			<div class="form-group">
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>
			<div class="form-group">
				<label for="bornDate">出生日期:</label>
				<input type="text" id="bornDate" name="bornDate" class="form-control"  placeholder="请选择出生日期" value="<%=bornDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <div class="form-group">
            	<label for="companyObj_companyId">所在分公司：</label>
                <select id="companyObj_companyId" name="companyObj.companyId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Company companyTemp:companyList) {
	 					String selected = "";
 					if(companyObj!=null && companyObj.getCompanyId()!=null && companyObj.getCompanyId().intValue()==companyTemp.getCompanyId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=companyTemp.getCompanyId() %>" <%=selected %>><%=companyTemp.getCompanyName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="departmentObj_departmentId">所属部门：</label>
                <select id="departmentObj_departmentId" name="departmentObj.departmentId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Department departmentTemp:departmentList) {
	 					String selected = "";
 					if(departmentObj!=null && departmentObj.getDepartmentId()!=null && departmentObj.getDepartmentId().intValue()==departmentTemp.getDepartmentId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=departmentTemp.getDepartmentId() %>" <%=selected %>><%=departmentTemp.getDepartmentName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="telephone">联系方式:</label>
				<input type="text" id="telephone" name="telephone" value="<%=telephone %>" class="form-control" placeholder="请输入联系方式">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="employeeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;职工信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="employeeEditForm" id="employeeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="employee_employeeNo_edit" class="col-md-3 text-right">员工号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="employee_employeeNo_edit" name="employee.employeeNo" class="form-control" placeholder="请输入员工号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="employee_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_password_edit" name="employee.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_name_edit" name="employee.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_sex_edit" name="employee.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_bornDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date employee_bornDate_edit col-md-12" data-link-field="employee_bornDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="employee_bornDate_edit" name="employee.bornDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_employeePhoto_edit" class="col-md-3 text-right">员工照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="employee_employeePhotoImg" border="0px"/><br/>
			    <input type="hidden" id="employee_employeePhoto" name="employee.employeePhoto"/>
			    <input id="employeePhotoFile" name="employeePhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_companyObj_companyId_edit" class="col-md-3 text-right">所在分公司:</label>
		  	 <div class="col-md-9">
			    <select id="employee_companyObj_companyId_edit" name="employee.companyObj.companyId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_departmentObj_departmentId_edit" class="col-md-3 text-right">所属部门:</label>
		  	 <div class="col-md-9">
			    <select id="employee_departmentObj_departmentId_edit" name="employee.departmentObj.departmentId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_telephone_edit" class="col-md-3 text-right">联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_telephone_edit" name="employee.telephone" class="form-control" placeholder="请输入联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_gwh_edit" class="col-md-3 text-right">工位号:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="employee_gwh_edit" name="employee.gwh" class="form-control" placeholder="请输入工位号">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="employee_employeeMemo_edit" class="col-md-3 text-right">员工备注:</label>
		  	 <div class="col-md-9">
			    <textarea id="employee_employeeMemo_edit" name="employee.employeeMemo" rows="8" class="form-control" placeholder="请输入员工备注"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#employeeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxEmployeeModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.employeeQueryForm.currentPage.value = currentPage;
    document.employeeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.employeeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.employeeQueryForm.currentPage.value = pageValue;
    documentemployeeQueryForm.submit();
}

/*弹出修改职工界面并初始化数据*/
function employeeEdit(employeeNo) {
	$.ajax({
		url :  basePath + "Employee/" + employeeNo + "/update",
		type : "get",
		dataType: "json",
		success : function (employee, response, status) {
			if (employee) {
				$("#employee_employeeNo_edit").val(employee.employeeNo);
				$("#employee_password_edit").val(employee.password);
				$("#employee_name_edit").val(employee.name);
				$("#employee_sex_edit").val(employee.sex);
				$("#employee_bornDate_edit").val(employee.bornDate);
				$("#employee_employeePhoto").val(employee.employeePhoto);
				$("#employee_employeePhotoImg").attr("src", basePath +　employee.employeePhoto);
				$.ajax({
					url: basePath + "Company/listAll",
					type: "get",
					success: function(companys,response,status) { 
						$("#employee_companyObj_companyId_edit").empty();
						var html="";
		        		$(companys).each(function(i,company){
		        			html += "<option value='" + company.companyId + "'>" + company.companyName + "</option>";
		        		});
		        		$("#employee_companyObj_companyId_edit").html(html);
		        		$("#employee_companyObj_companyId_edit").val(employee.companyObjPri);
					}
				});
				$.ajax({
					url: basePath + "Department/listAll",
					type: "get",
					success: function(departments,response,status) { 
						$("#employee_departmentObj_departmentId_edit").empty();
						var html="";
		        		$(departments).each(function(i,department){
		        			html += "<option value='" + department.departmentId + "'>" + department.departmentName + "</option>";
		        		});
		        		$("#employee_departmentObj_departmentId_edit").html(html);
		        		$("#employee_departmentObj_departmentId_edit").val(employee.departmentObjPri);
					}
				});
				$("#employee_telephone_edit").val(employee.telephone);
				$("#employee_gwh_edit").val(employee.gwh);
				$("#employee_employeeMemo_edit").val(employee.employeeMemo);
				$('#employeeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除职工信息*/
function employeeDelete(employeeNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Employee/deletes",
			data : {
				employeeNos : employeeNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#employeeQueryForm").submit();
					//location.href= basePath + "Employee/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交职工信息表单给服务器端修改*/
function ajaxEmployeeModify() {
	$.ajax({
		url :  basePath + "Employee/" + $("#employee_employeeNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#employeeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#employeeQueryForm").submit();
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

    /*出生日期组件*/
    $('.employee_bornDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

