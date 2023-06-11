<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Purchase" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Supplier" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Purchase> purchaseList = (List<Purchase>)request.getAttribute("purchaseList");
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
    String purchaseTime = (String)request.getAttribute("purchaseTime"); //入库时间查询关键字
    String purchaseState = (String)request.getAttribute("purchaseState"); //状态查询关键字
    String czr = (String)request.getAttribute("czr"); //操作人查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物资采购查询</title>
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
			    	<li role="presentation" class="active"><a href="#purchaseListPanel" aria-controls="purchaseListPanel" role="tab" data-toggle="tab">物资采购列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Purchase/purchase_frontAdd.jsp" style="display:none;">添加物资采购</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="purchaseListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>采购id</td><td>物品名称</td><td>物品供应商</td><td>行政物需点</td><td>入库数量</td><td>入库时间</td><td>状态</td><td>操作人</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<purchaseList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Purchase purchase = purchaseList.get(i); //获取到物资采购对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=purchase.getPurchaseId() %></td>
 											<td><%=purchase.getProductObj().getProductName() %></td>
 											<td><%=purchase.getSupplierObj().getSupplierName() %></td>
 											<td><%=purchase.getCompanyObj().getCompanyName() %></td>
 											<td><%=purchase.getPurchaseCount() %></td>
 											<td><%=purchase.getPurchaseTime() %></td>
 											<td><%=purchase.getPurchaseState() %></td>
 											<td><%=purchase.getCzr() %></td>
 											<td>
 												<a href="<%=basePath  %>Purchase/<%=purchase.getPurchaseId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="purchaseEdit('<%=purchase.getPurchaseId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="purchaseDelete('<%=purchase.getPurchaseId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>物资采购查询</h1>
		</div>
		<form name="purchaseQueryForm" id="purchaseQueryForm" action="<%=basePath %>Purchase/frontlist" class="mar_t15">
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
				<label for="purchaseTime">入库时间:</label>
				<input type="text" id="purchaseTime" name="purchaseTime" class="form-control"  placeholder="请选择入库时间" value="<%=purchaseTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="purchaseState">状态:</label>
				<input type="text" id="purchaseState" name="purchaseState" value="<%=purchaseState %>" class="form-control" placeholder="请输入状态">
			</div>






			<div class="form-group">
				<label for="czr">操作人:</label>
				<input type="text" id="czr" name="czr" value="<%=czr %>" class="form-control" placeholder="请输入操作人">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="purchaseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;物资采购信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="purchaseEditForm" id="purchaseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="purchase_purchaseId_edit" class="col-md-3 text-right">采购id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="purchase_purchaseId_edit" name="purchase.purchaseId" class="form-control" placeholder="请输入采购id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="purchase_productObj_productId_edit" class="col-md-3 text-right">物品名称:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_productObj_productId_edit" name="purchase.productObj.productId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_supplierObj_supplierId_edit" class="col-md-3 text-right">物品供应商:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_supplierObj_supplierId_edit" name="purchase.supplierObj.supplierId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_companyObj_companyId_edit" class="col-md-3 text-right">行政物需点:</label>
		  	 <div class="col-md-9">
			    <select id="purchase_companyObj_companyId_edit" name="purchase.companyObj.companyId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseCount_edit" class="col-md-3 text-right">入库数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_purchaseCount_edit" name="purchase.purchaseCount" class="form-control" placeholder="请输入入库数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseTime_edit" class="col-md-3 text-right">入库时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date purchase_purchaseTime_edit col-md-12" data-link-field="purchase_purchaseTime_edit">
                    <input class="form-control" id="purchase_purchaseTime_edit" name="purchase.purchaseTime" size="16" type="text" value="" placeholder="请选择入库时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_purchaseState_edit" class="col-md-3 text-right">状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_purchaseState_edit" name="purchase.purchaseState" class="form-control" placeholder="请输入状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="purchase_czr_edit" class="col-md-3 text-right">操作人:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="purchase_czr_edit" name="purchase.czr" class="form-control" placeholder="请输入操作人">
			 </div>
		  </div>
		</form> 
	    <style>#purchaseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPurchaseModify();">提交</button>
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
    document.purchaseQueryForm.currentPage.value = currentPage;
    document.purchaseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.purchaseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.purchaseQueryForm.currentPage.value = pageValue;
    documentpurchaseQueryForm.submit();
}

/*弹出修改物资采购界面并初始化数据*/
function purchaseEdit(purchaseId) {
	$.ajax({
		url :  basePath + "Purchase/" + purchaseId + "/update",
		type : "get",
		dataType: "json",
		success : function (purchase, response, status) {
			if (purchase) {
				$("#purchase_purchaseId_edit").val(purchase.purchaseId);
				$.ajax({
					url: basePath + "Product/listAll",
					type: "get",
					success: function(products,response,status) { 
						$("#purchase_productObj_productId_edit").empty();
						var html="";
		        		$(products).each(function(i,product){
		        			html += "<option value='" + product.productId + "'>" + product.productName + "</option>";
		        		});
		        		$("#purchase_productObj_productId_edit").html(html);
		        		$("#purchase_productObj_productId_edit").val(purchase.productObjPri);
					}
				});
				$.ajax({
					url: basePath + "Supplier/listAll",
					type: "get",
					success: function(suppliers,response,status) { 
						$("#purchase_supplierObj_supplierId_edit").empty();
						var html="";
		        		$(suppliers).each(function(i,supplier){
		        			html += "<option value='" + supplier.supplierId + "'>" + supplier.supplierName + "</option>";
		        		});
		        		$("#purchase_supplierObj_supplierId_edit").html(html);
		        		$("#purchase_supplierObj_supplierId_edit").val(purchase.supplierObjPri);
					}
				});
				$.ajax({
					url: basePath + "Company/listAll",
					type: "get",
					success: function(companys,response,status) { 
						$("#purchase_companyObj_companyId_edit").empty();
						var html="";
		        		$(companys).each(function(i,company){
		        			html += "<option value='" + company.companyId + "'>" + company.companyName + "</option>";
		        		});
		        		$("#purchase_companyObj_companyId_edit").html(html);
		        		$("#purchase_companyObj_companyId_edit").val(purchase.companyObjPri);
					}
				});
				$("#purchase_purchaseCount_edit").val(purchase.purchaseCount);
				$("#purchase_purchaseTime_edit").val(purchase.purchaseTime);
				$("#purchase_purchaseState_edit").val(purchase.purchaseState);
				$("#purchase_czr_edit").val(purchase.czr);
				$('#purchaseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除物资采购信息*/
function purchaseDelete(purchaseId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Purchase/deletes",
			data : {
				purchaseIds : purchaseId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#purchaseQueryForm").submit();
					//location.href= basePath + "Purchase/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交物资采购信息表单给服务器端修改*/
function ajaxPurchaseModify() {
	$.ajax({
		url :  basePath + "Purchase/" + $("#purchase_purchaseId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#purchaseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#purchaseQueryForm").submit();
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

    /*入库时间组件*/
    $('.purchase_purchaseTime_edit').datetimepicker({
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

