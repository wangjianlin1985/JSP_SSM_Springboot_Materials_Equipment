<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Apply" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Supplier" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Apply> applyList = (List<Apply>)request.getAttribute("applyList");
    //获取所有的companyObj信息
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    //获取所有的productObj信息
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的supplierObj信息
    List<Supplier> supplierList = (List<Supplier>)request.getAttribute("supplierList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Product productObj = (Product)request.getAttribute("productObj");
    Supplier supplierObj = (Supplier)request.getAttribute("supplierObj");
    Company companyObj = (Company)request.getAttribute("companyObj");
    String sqr = (String)request.getAttribute("sqr"); //申请人查询关键字
    String sqsj = (String)request.getAttribute("sqsj"); //申请时间查询关键字
    String applyState = (String)request.getAttribute("applyState"); //状态查询关键字
    String shenpiren = (String)request.getAttribute("shenpiren"); //审批人查询关键字
    String cksj = (String)request.getAttribute("cksj"); //出库时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物资申领查询</title>
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
			    	<li role="presentation" class="active"><a href="#applyListPanel" aria-controls="applyListPanel" role="tab" data-toggle="tab">物资申领列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Apply/apply_frontAdd.jsp" style="display:none;">添加物资申领</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="applyListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>申领id</td><td>物品名称</td><td>物品供应商</td><td>行政物需点</td><td>出库数量</td><td>申请人</td><td>申请时间</td><td>状态</td><td>审批人</td><td>出库时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<applyList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Apply apply = applyList.get(i); //获取到物资申领对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=apply.getApplyId() %></td>
 											<td><%=apply.getProductObj().getProductName() %></td>
 											<td><%=apply.getSupplierObj().getSupplierName() %></td>
 											<td><%=apply.getCompanyObj().getCompanyName() %></td>
 											<td><%=apply.getApplyCount() %></td>
 											<td><%=apply.getSqr() %></td>
 											<td><%=apply.getSqsj() %></td>
 											<td><%=apply.getApplyState() %></td>
 											<td><%=apply.getShenpiren() %></td>
 											<td><%=apply.getCksj() %></td>
 											<td>
 												<a href="<%=basePath  %>Apply/<%=apply.getApplyId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="applyEdit('<%=apply.getApplyId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="applyDelete('<%=apply.getApplyId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>物资申领查询</h1>
		</div>
		<form name="applyQueryForm" id="applyQueryForm" action="<%=basePath %>Apply/frontlist" class="mar_t15">
            <div class="form-group">
            	<label for="productObj_productId">物品名称：</label>
                <select id="productObj_productId" name="productObj.productId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Product productTemp:productList) {
	 					String selected = "";
 					if(productObj!=null && productObj.getProductId()!=null && productObj.getProductId().intValue()==productTemp.getProductId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=productTemp.getProductId() %>" <%=selected %>><%=productTemp.getProductName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="supplierObj_supplierId">物品供应商：</label>
                <select id="supplierObj_supplierId" name="supplierObj.supplierId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Supplier supplierTemp:supplierList) {
	 					String selected = "";
 					if(supplierObj!=null && supplierObj.getSupplierId()!=null && supplierObj.getSupplierId().intValue()==supplierTemp.getSupplierId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=supplierTemp.getSupplierId() %>" <%=selected %>><%=supplierTemp.getSupplierName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="companyObj_companyId">行政物需点：</label>
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
				<label for="sqr">申请人:</label>
				<input type="text" id="sqr" name="sqr" value="<%=sqr %>" class="form-control" placeholder="请输入申请人">
			</div>






			<div class="form-group">
				<label for="sqsj">申请时间:</label>
				<input type="text" id="sqsj" name="sqsj" class="form-control"  placeholder="请选择申请时间" value="<%=sqsj %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="applyState">状态:</label>
				<input type="text" id="applyState" name="applyState" value="<%=applyState %>" class="form-control" placeholder="请输入状态">
			</div>






			<div class="form-group">
				<label for="shenpiren">审批人:</label>
				<input type="text" id="shenpiren" name="shenpiren" value="<%=shenpiren %>" class="form-control" placeholder="请输入审批人">
			</div>






			<div class="form-group">
				<label for="cksj">出库时间:</label>
				<input type="text" id="cksj" name="cksj" class="form-control"  placeholder="请选择出库时间" value="<%=cksj %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="applyEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;物资申领信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="applyEditForm" id="applyEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="apply_applyId_edit" class="col-md-3 text-right">申领id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="apply_applyId_edit" name="apply.applyId" class="form-control" placeholder="请输入申领id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="apply_productObj_productId_edit" class="col-md-3 text-right">物品名称:</label>
		  	 <div class="col-md-9">
			    <select id="apply_productObj_productId_edit" name="apply.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_supplierObj_supplierId_edit" class="col-md-3 text-right">物品供应商:</label>
		  	 <div class="col-md-9">
			    <select id="apply_supplierObj_supplierId_edit" name="apply.supplierObj.supplierId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_companyObj_companyId_edit" class="col-md-3 text-right">行政物需点:</label>
		  	 <div class="col-md-9">
			    <select id="apply_companyObj_companyId_edit" name="apply.companyObj.companyId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_applyCount_edit" class="col-md-3 text-right">出库数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="apply_applyCount_edit" name="apply.applyCount" class="form-control" placeholder="请输入出库数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_sqr_edit" class="col-md-3 text-right">申请人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="apply_sqr_edit" name="apply.sqr" class="form-control" placeholder="请输入申请人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_sqsj_edit" class="col-md-3 text-right">申请时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date apply_sqsj_edit col-md-12" data-link-field="apply_sqsj_edit">
                    <input class="form-control" id="apply_sqsj_edit" name="apply.sqsj" size="16" type="text" value="" placeholder="请选择申请时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_applyState_edit" class="col-md-3 text-right">状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="apply_applyState_edit" name="apply.applyState" class="form-control" placeholder="请输入状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_shenpiren_edit" class="col-md-3 text-right">审批人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="apply_shenpiren_edit" name="apply.shenpiren" class="form-control" placeholder="请输入审批人">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="apply_cksj_edit" class="col-md-3 text-right">出库时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date apply_cksj_edit col-md-12" data-link-field="apply_cksj_edit">
                    <input class="form-control" id="apply_cksj_edit" name="apply.cksj" size="16" type="text" value="" placeholder="请选择出库时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#applyEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxApplyModify();">提交</button>
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
    document.applyQueryForm.currentPage.value = currentPage;
    document.applyQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.applyQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.applyQueryForm.currentPage.value = pageValue;
    documentapplyQueryForm.submit();
}

/*弹出修改物资申领界面并初始化数据*/
function applyEdit(applyId) {
	$.ajax({
		url :  basePath + "Apply/" + applyId + "/update",
		type : "get",
		dataType: "json",
		success : function (apply, response, status) {
			if (apply) {
				$("#apply_applyId_edit").val(apply.applyId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#apply_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#apply_productObj_productId_edit").html(html);
		        		$("#apply_productObj_productId_edit").val(apply.productObjPri);
					}
				});
				$.ajax({
					url: basePath + "Supplier/listAll",
					type: "get",
					success: function(suppliers,response,status) { 
						$("#apply_supplierObj_supplierId_edit").empty();
						var html="";
		        		$(suppliers).each(function(i,supplier){
		        			html += "<option value='" + supplier.supplierId + "'>" + supplier.supplierName + "</option>";
		        		});
		        		$("#apply_supplierObj_supplierId_edit").html(html);
		        		$("#apply_supplierObj_supplierId_edit").val(apply.supplierObjPri);
					}
				});
				$.ajax({
					url: basePath + "Company/listAll",
					type: "get",
					success: function(companys,response,status) { 
						$("#apply_companyObj_companyId_edit").empty();
						var html="";
		        		$(companys).each(function(i,company){
		        			html += "<option value='" + company.companyId + "'>" + company.companyName + "</option>";
		        		});
		        		$("#apply_companyObj_companyId_edit").html(html);
		        		$("#apply_companyObj_companyId_edit").val(apply.companyObjPri);
					}
				});
				$("#apply_applyCount_edit").val(apply.applyCount);
				$("#apply_sqr_edit").val(apply.sqr);
				$("#apply_sqsj_edit").val(apply.sqsj);
				$("#apply_applyState_edit").val(apply.applyState);
				$("#apply_shenpiren_edit").val(apply.shenpiren);
				$("#apply_cksj_edit").val(apply.cksj);
				$('#applyEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除物资申领信息*/
function applyDelete(applyId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Apply/deletes",
			data : {
				applyIds : applyId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#applyQueryForm").submit();
					//location.href= basePath + "Apply/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交物资申领信息表单给服务器端修改*/
function ajaxApplyModify() {
	$.ajax({
		url :  basePath + "Apply/" + $("#apply_applyId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#applyEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#applyQueryForm").submit();
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

    /*申请时间组件*/
    $('.apply_sqsj_edit').datetimepicker({
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
    /*出库时间组件*/
    $('.apply_cksj_edit').datetimepicker({
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

