<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.XzAdmin" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<XzAdmin> xzAdminList = (List<XzAdmin>)request.getAttribute("xzAdminList");
    //获取所有的companyObj信息
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String xzUserName = (String)request.getAttribute("xzUserName"); //用户名查询关键字
    Company companyObj = (Company)request.getAttribute("companyObj");
    String name = (String)request.getAttribute("name"); //姓名查询关键字
    String birthDate = (String)request.getAttribute("birthDate"); //出生日期查询关键字
    String telephone = (String)request.getAttribute("telephone"); //联系方式查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>行政管理查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#xzAdminListPanel" aria-controls="xzAdminListPanel" role="tab" data-toggle="tab">行政管理列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>XzAdmin/xzAdmin_frontAdd.jsp" style="display:none;">添加行政管理</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="xzAdminListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>用户名</td><td>登录密码</td><td>所在分公司</td><td>姓名</td><td>性别</td><td>出生日期</td><td>联系方式</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<xzAdminList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		XzAdmin xzAdmin = xzAdminList.get(i); //获取到行政管理对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=xzAdmin.getXzUserName() %></td>
 											<td><%=xzAdmin.getPassword() %></td>
 											<td><%=xzAdmin.getCompanyObj().getCompanyName() %></td>
 											<td><%=xzAdmin.getName() %></td>
 											<td><%=xzAdmin.getSex() %></td>
 											<td><%=xzAdmin.getBirthDate() %></td>
 											<td><%=xzAdmin.getTelephone() %></td>
 											<td>
 												<a href="<%=basePath  %>XzAdmin/<%=xzAdmin.getXzUserName() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="xzAdminEdit('<%=xzAdmin.getXzUserName() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="xzAdminDelete('<%=xzAdmin.getXzUserName() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>行政管理查询</h1>
		</div>
		<form name="xzAdminQueryForm" id="xzAdminQueryForm" action="<%=basePath %>XzAdmin/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="xzUserName">用户名:</label>
				<input type="text" id="xzUserName" name="xzUserName" value="<%=xzUserName %>" class="form-control" placeholder="请输入用户名">
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
				<label for="name">姓名:</label>
				<input type="text" id="name" name="name" value="<%=name %>" class="form-control" placeholder="请输入姓名">
			</div>






			<div class="form-group">
				<label for="birthDate">出生日期:</label>
				<input type="text" id="birthDate" name="birthDate" class="form-control"  placeholder="请选择出生日期" value="<%=birthDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
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
<div id="xzAdminEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;行政管理信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="xzAdminEditForm" id="xzAdminEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="xzAdmin_xzUserName_edit" class="col-md-3 text-right">用户名:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="xzAdmin_xzUserName_edit" name="xzAdmin.xzUserName" class="form-control" placeholder="请输入用户名" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="xzAdmin_password_edit" class="col-md-3 text-right">登录密码:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xzAdmin_password_edit" name="xzAdmin.password" class="form-control" placeholder="请输入登录密码">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xzAdmin_companyObj_companyId_edit" class="col-md-3 text-right">所在分公司:</label>
		  	 <div class="col-md-9">
			    <select id="xzAdmin_companyObj_companyId_edit" name="xzAdmin.companyObj.companyId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xzAdmin_name_edit" class="col-md-3 text-right">姓名:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xzAdmin_name_edit" name="xzAdmin.name" class="form-control" placeholder="请输入姓名">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xzAdmin_sex_edit" class="col-md-3 text-right">性别:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xzAdmin_sex_edit" name="xzAdmin.sex" class="form-control" placeholder="请输入性别">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xzAdmin_birthDate_edit" class="col-md-3 text-right">出生日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date xzAdmin_birthDate_edit col-md-12" data-link-field="xzAdmin_birthDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="xzAdmin_birthDate_edit" name="xzAdmin.birthDate" size="16" type="text" value="" placeholder="请选择出生日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xzAdmin_telephone_edit" class="col-md-3 text-right">联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="xzAdmin_telephone_edit" name="xzAdmin.telephone" class="form-control" placeholder="请输入联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="xzAdmin_xzMemo_edit" class="col-md-3 text-right">备注信息:</label>
		  	 <div class="col-md-9">
			    <textarea id="xzAdmin_xzMemo_edit" name="xzAdmin.xzMemo" rows="8" class="form-control" placeholder="请输入备注信息"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#xzAdminEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxXzAdminModify();">提交</button>
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
    document.xzAdminQueryForm.currentPage.value = currentPage;
    document.xzAdminQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.xzAdminQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.xzAdminQueryForm.currentPage.value = pageValue;
    documentxzAdminQueryForm.submit();
}

/*弹出修改行政管理界面并初始化数据*/
function xzAdminEdit(xzUserName) {
	$.ajax({
		url :  basePath + "XzAdmin/" + xzUserName + "/update",
		type : "get",
		dataType: "json",
		success : function (xzAdmin, response, status) {
			if (xzAdmin) {
				$("#xzAdmin_xzUserName_edit").val(xzAdmin.xzUserName);
				$("#xzAdmin_password_edit").val(xzAdmin.password);
				$.ajax({
					url: basePath + "Company/listAll",
					type: "get",
					success: function(companys,response,status) { 
						$("#xzAdmin_companyObj_companyId_edit").empty();
						var html="";
		        		$(companys).each(function(i,company){
		        			html += "<option value='" + company.companyId + "'>" + company.companyName + "</option>";
		        		});
		        		$("#xzAdmin_companyObj_companyId_edit").html(html);
		        		$("#xzAdmin_companyObj_companyId_edit").val(xzAdmin.companyObjPri);
					}
				});
				$("#xzAdmin_name_edit").val(xzAdmin.name);
				$("#xzAdmin_sex_edit").val(xzAdmin.sex);
				$("#xzAdmin_birthDate_edit").val(xzAdmin.birthDate);
				$("#xzAdmin_telephone_edit").val(xzAdmin.telephone);
				$("#xzAdmin_xzMemo_edit").val(xzAdmin.xzMemo);
				$('#xzAdminEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除行政管理信息*/
function xzAdminDelete(xzUserName) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "XzAdmin/deletes",
			data : {
				xzUserNames : xzUserName,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#xzAdminQueryForm").submit();
					//location.href= basePath + "XzAdmin/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交行政管理信息表单给服务器端修改*/
function ajaxXzAdminModify() {
	$.ajax({
		url :  basePath + "XzAdmin/" + $("#xzAdmin_xzUserName_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#xzAdminEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#xzAdminQueryForm").submit();
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
    $('.xzAdmin_birthDate_edit').datetimepicker({
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

