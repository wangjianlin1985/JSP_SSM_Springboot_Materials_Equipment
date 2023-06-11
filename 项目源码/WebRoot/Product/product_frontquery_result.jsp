<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Product" %>
<%@ page import="com.chengxusheji.po.Company" %>
<%@ page import="com.chengxusheji.po.Supplier" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Product> productList = (List<Product>)request.getAttribute("productList");
    //获取所有的companyObj信息
    List<Company> companyList = (List<Company>)request.getAttribute("companyList");
    //获取所有的supplierObj信息
    List<Supplier> supplierList = (List<Supplier>)request.getAttribute("supplierList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String productName = (String)request.getAttribute("productName"); //物品名称查询关键字
    Supplier supplierObj = (Supplier)request.getAttribute("supplierObj");
    Company companyObj = (Company)request.getAttribute("companyObj");
    String luruTime = (String)request.getAttribute("luruTime"); //录入时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>物资查询</title>
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
  			<li><a href="<%=basePath %>Product/frontlist">物资信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Product/product_frontAdd.jsp" style="display:none;">添加物资</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<productList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Product product = productList.get(i); //获取到物资对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Product/<%=product.getProductId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=product.getProductPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		物品id:<%=product.getProductId() %>
			     	</div>
			     	<div class="field">
	            		物品名称:<%=product.getProductName() %>
			     	</div>
			     	<div class="field">
	            		物品供应商:<%=product.getSupplierObj().getSupplierName() %>
			     	</div>
			     	<div class="field">
	            		行政物需点:<%=product.getCompanyObj().getCompanyName() %>
			     	</div>
			     	<div class="field">
	            		物品价格:<%=product.getProductPrice() %>
			     	</div>
			     	<div class="field">
	            		物品数量:<%=product.getProductCount() %>
			     	</div>
			     	<div class="field">
	            		录入时间:<%=product.getLuruTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Product/<%=product.getProductId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="productEdit('<%=product.getProductId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="productDelete('<%=product.getProductId() %>');" style="display:none;">删除</a>
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
    		<h1>物资查询</h1>
		</div>
		<form name="productQueryForm" id="productQueryForm" action="<%=basePath %>Product/frontlist" class="mar_t15">
			<div class="form-group">
				<label for="productName">物品名称:</label>
				<input type="text" id="productName" name="productName" value="<%=productName %>" class="form-control" placeholder="请输入物品名称">
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
				<label for="luruTime">录入时间:</label>
				<input type="text" id="luruTime" name="luruTime" class="form-control"  placeholder="请选择录入时间" value="<%=luruTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="productEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;物资信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="productEditForm" id="productEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="product_productId_edit" class="col-md-3 text-right">物品id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="product_productId_edit" name="product.productId" class="form-control" placeholder="请输入物品id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="product_productName_edit" class="col-md-3 text-right">物品名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_productName_edit" name="product.productName" class="form-control" placeholder="请输入物品名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_supplierObj_supplierId_edit" class="col-md-3 text-right">物品供应商:</label>
		  	 <div class="col-md-9">
			    <select id="product_supplierObj_supplierId_edit" name="product.supplierObj.supplierId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_companyObj_companyId_edit" class="col-md-3 text-right">行政物需点:</label>
		  	 <div class="col-md-9">
			    <select id="product_companyObj_companyId_edit" name="product.companyObj.companyId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productPhoto_edit" class="col-md-3 text-right">物品图片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="product_productPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="product_productPhoto" name="product.productPhoto"/>
			    <input id="productPhotoFile" name="productPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productPrice_edit" class="col-md-3 text-right">物品价格:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_productPrice_edit" name="product.productPrice" class="form-control" placeholder="请输入物品价格">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productCount_edit" class="col-md-3 text-right">物品数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="product_productCount_edit" name="product.productCount" class="form-control" placeholder="请输入物品数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_productDesc_edit" class="col-md-3 text-right">物品描述:</label>
		  	 <div class="col-md-9">
			 	<textarea name="product.productDesc" id="product_productDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="product_luruTime_edit" class="col-md-3 text-right">录入时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date product_luruTime_edit col-md-12" data-link-field="product_luruTime_edit">
                    <input class="form-control" id="product_luruTime_edit" name="product.luruTime" size="16" type="text" value="" placeholder="请选择录入时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#productEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxProductModify();">提交</button>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var product_productDesc_edit = UE.getEditor('product_productDesc_edit'); //物品描述编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.productQueryForm.currentPage.value = currentPage;
    document.productQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.productQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.productQueryForm.currentPage.value = pageValue;
    documentproductQueryForm.submit();
}

/*弹出修改物资界面并初始化数据*/
function productEdit(productId) {
	$.ajax({
		url :  basePath + "Product/" + productId + "/update",
		type : "get",
		dataType: "json",
		success : function (product, response, status) {
			if (product) {
				$("#product_productId_edit").val(product.productId);
				$("#product_productName_edit").val(product.productName);
				$.ajax({
					url: basePath + "Supplier/listAll",
					type: "get",
					success: function(suppliers,response,status) { 
						$("#product_supplierObj_supplierId_edit").empty();
						var html="";
		        		$(suppliers).each(function(i,supplier){
		        			html += "<option value='" + supplier.supplierId + "'>" + supplier.supplierName + "</option>";
		        		});
		        		$("#product_supplierObj_supplierId_edit").html(html);
		        		$("#product_supplierObj_supplierId_edit").val(product.supplierObjPri);
					}
				});
				$.ajax({
					url: basePath + "Company/listAll",
					type: "get",
					success: function(companys,response,status) { 
						$("#product_companyObj_companyId_edit").empty();
						var html="";
		        		$(companys).each(function(i,company){
		        			html += "<option value='" + company.companyId + "'>" + company.companyName + "</option>";
		        		});
		        		$("#product_companyObj_companyId_edit").html(html);
		        		$("#product_companyObj_companyId_edit").val(product.companyObjPri);
					}
				});
				$("#product_productPhoto").val(product.productPhoto);
				$("#product_productPhotoImg").attr("src", basePath +　product.productPhoto);
				$("#product_productPrice_edit").val(product.productPrice);
				$("#product_productCount_edit").val(product.productCount);
				product_productDesc_edit.setContent(product.productDesc, false);
				$("#product_luruTime_edit").val(product.luruTime);
				$('#productEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除物资信息*/
function productDelete(productId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Product/deletes",
			data : {
				productIds : productId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#productQueryForm").submit();
					//location.href= basePath + "Product/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交物资信息表单给服务器端修改*/
function ajaxProductModify() {
	$.ajax({
		url :  basePath + "Product/" + $("#product_productId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#productEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#productQueryForm").submit();
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
    $('.product_luruTime_edit').datetimepicker({
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

