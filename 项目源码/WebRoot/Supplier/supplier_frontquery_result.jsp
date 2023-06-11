﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Supplier" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Supplier> supplierList = (List<Supplier>)request.getAttribute("supplierList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String supplierName = (String)request.getAttribute("supplierName"); //供应商名称查询关键字
    String city = (String)request.getAttribute("city"); //所在城市查询关键字
    String aPerson = (String)request.getAttribute("aPerson"); //A方对接人查询关键字
    String djrlxfs = (String)request.getAttribute("djrlxfs"); //对接人联系方式查询关键字
    String luruTime = (String)request.getAttribute("luruTime"); //录入时间查询关键字
    String luruRen = (String)request.getAttribute("luruRen"); //录入人查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>供应商查询</title>
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
			    	<li role="presentation" class="active"><a href="#supplierListPanel" aria-controls="supplierListPanel" role="tab" data-toggle="tab">供应商列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Supplier/supplier_frontAdd.jsp" style="display:none;">添加供应商</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="supplierListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>供应商id</td><td>供应商名称</td><td>所在城市</td><td>A方对接人</td><td>对接人联系方式</td><td>录入时间</td><td>录入人</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<supplierList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Supplier supplier = supplierList.get(i); //获取到供应商对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=supplier.getSupplierId() %></td>
 											<td><%=supplier.getSupplierName() %></td>
 											<td><%=supplier.getCity() %></td>
 											<td><%=supplier.getAPerson() %></td>
 											<td><%=supplier.getDjrlxfs() %></td>
 											<td><%=supplier.getLuruTime() %></td>
 											<td><%=supplier.getLuruRen() %></td>
 											<td>
 												<a href="<%=basePath  %>Supplier/<%=supplier.getSupplierId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="supplierEdit('<%=supplier.getSupplierId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="supplierDelete('<%=supplier.getSupplierId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>供应商查询</h1>
		</div>
		<form name="supplierQueryForm" id="supplierQueryForm" action="<%=basePath %>Supplier/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="supplierName">供应商名称:</label>
				<input type="text" id="supplierName" name="supplierName" value="<%=supplierName %>" class="form-control" placeholder="请输入供应商名称">
			</div>






			<div class="form-group">
				<label for="city">所在城市:</label>
				<input type="text" id="city" name="city" value="<%=city %>" class="form-control" placeholder="请输入所在城市">
			</div>






			<div class="form-group">
				<label for="aPerson">A方对接人:</label>
				<input type="text" id="aPerson" name="aPerson" value="<%=aPerson %>" class="form-control" placeholder="请输入A方对接人">
			</div>






			<div class="form-group">
				<label for="djrlxfs">对接人联系方式:</label>
				<input type="text" id="djrlxfs" name="djrlxfs" value="<%=djrlxfs %>" class="form-control" placeholder="请输入对接人联系方式">
			</div>






			<div class="form-group">
				<label for="luruTime">录入时间:</label>
				<input type="text" id="luruTime" name="luruTime" class="form-control"  placeholder="请选择录入时间" value="<%=luruTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="luruRen">录入人:</label>
				<input type="text" id="luruRen" name="luruRen" value="<%=luruRen %>" class="form-control" placeholder="请输入录入人">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="supplierEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;供应商信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="supplierEditForm" id="supplierEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="supplier_supplierId_edit" class="col-md-3 text-right">供应商id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="supplier_supplierId_edit" name="supplier.supplierId" class="form-control" placeholder="请输入供应商id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="supplier_supplierName_edit" class="col-md-3 text-right">供应商名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_supplierName_edit" name="supplier.supplierName" class="form-control" placeholder="请输入供应商名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_city_edit" class="col-md-3 text-right">所在城市:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_city_edit" name="supplier.city" class="form-control" placeholder="请输入所在城市">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_aPerson_edit" class="col-md-3 text-right">A方对接人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_aPerson_edit" name="supplier.aPerson" class="form-control" placeholder="请输入A方对接人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_djrlxfs_edit" class="col-md-3 text-right">对接人联系方式:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_djrlxfs_edit" name="supplier.djrlxfs" class="form-control" placeholder="请输入对接人联系方式">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_luruTime_edit" class="col-md-3 text-right">录入时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date supplier_luruTime_edit col-md-12" data-link-field="supplier_luruTime_edit">
                    <input class="form-control" id="supplier_luruTime_edit" name="supplier.luruTime" size="16" type="text" value="" placeholder="请选择录入时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="supplier_luruRen_edit" class="col-md-3 text-right">录入人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="supplier_luruRen_edit" name="supplier.luruRen" class="form-control" placeholder="请输入录入人">
			 </div>
		  </div>
		</form> 
	    <style>#supplierEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxSupplierModify();">提交</button>
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
    document.supplierQueryForm.currentPage.value = currentPage;
    document.supplierQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.supplierQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.supplierQueryForm.currentPage.value = pageValue;
    documentsupplierQueryForm.submit();
}

/*弹出修改供应商界面并初始化数据*/
function supplierEdit(supplierId) {
	$.ajax({
		url :  basePath + "Supplier/" + supplierId + "/update",
		type : "get",
		dataType: "json",
		success : function (supplier, response, status) {
			if (supplier) {
				$("#supplier_supplierId_edit").val(supplier.supplierId);
				$("#supplier_supplierName_edit").val(supplier.supplierName);
				$("#supplier_city_edit").val(supplier.city);
				$("#supplier_aPerson_edit").val(supplier.aPerson);
				$("#supplier_djrlxfs_edit").val(supplier.djrlxfs);
				$("#supplier_luruTime_edit").val(supplier.luruTime);
				$("#supplier_luruRen_edit").val(supplier.luruRen);
				$('#supplierEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除供应商信息*/
function supplierDelete(supplierId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Supplier/deletes",
			data : {
				supplierIds : supplierId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#supplierQueryForm").submit();
					//location.href= basePath + "Supplier/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交供应商信息表单给服务器端修改*/
function ajaxSupplierModify() {
	$.ajax({
		url :  basePath + "Supplier/" + $("#supplier_supplierId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#supplierEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#supplierQueryForm").submit();
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

    /*录入时间组件*/
    $('.supplier_luruTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
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

