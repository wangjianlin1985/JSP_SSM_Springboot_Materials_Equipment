package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chengxusheji.po.Apply;
import com.chengxusheji.po.Company;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.Supplier;
import com.chengxusheji.service.ApplyService;
import com.chengxusheji.service.CompanyService;
import com.chengxusheji.service.ProductService;
import com.chengxusheji.service.SupplierService;
import com.chengxusheji.utils.ExportExcelUtil;

//Apply管理控制层
@Controller
@RequestMapping("/Apply")
public class ApplyController extends BaseController {

    /*业务层对象*/
    @Resource ApplyService applyService;

    @Resource CompanyService companyService;
    @Resource ProductService productService;
    @Resource SupplierService supplierService;
	@InitBinder("productObj")
	public void initBinderproductObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("productObj.");
	}
	@InitBinder("supplierObj")
	public void initBindersupplierObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("supplierObj.");
	}
	@InitBinder("companyObj")
	public void initBindercompanyObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("companyObj.");
	}
	@InitBinder("apply")
	public void initBinderApply(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("apply.");
	}
	/*跳转到添加Apply视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Apply());
		/*查询所有的Company信息*/
		List<Company> companyList = companyService.queryAllCompany();
		request.setAttribute("companyList", companyList);
		/*查询所有的Product信息*/
		List<Product> productList = productService.queryAllProduct();
		request.setAttribute("productList", productList);
		/*查询所有的Supplier信息*/
		List<Supplier> supplierList = supplierService.queryAllSupplier();
		request.setAttribute("supplierList", supplierList);
		return "Apply_add";
	}

	/*客户端ajax方式提交添加物资申领信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Apply apply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        applyService.addApply(apply);
        message = "物资申领添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式员工提交资申领信息*/
	@RequestMapping(value = "/empAdd", method = RequestMethod.POST)
	public void empAdd(Apply apply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		int productId = apply.getProductObj().getProductId(); 
		Product product = productService.getProduct(productId);
		apply.setCompanyObj(product.getCompanyObj());
		apply.setSupplierObj(product.getSupplierObj());
		 
        applyService.addApply(apply);
        message = "物资申领登记成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询物资申领信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,@ModelAttribute("companyObj") Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (sqr == null) sqr = "";
		if (sqsj == null) sqsj = "";
		if (applyState == null) applyState = "";
		if (shenpiren == null) shenpiren = "";
		if (cksj == null) cksj = "";
		if(rows != 0)applyService.setRows(rows);
		List<Apply> applyList = applyService.queryApply(productObj, supplierObj, companyObj, sqr, sqsj, applyState, shenpiren, cksj, page);
	    /*计算总的页数和总的记录数*/
	    applyService.queryTotalPageAndRecordNumber(productObj, supplierObj, companyObj, sqr, sqsj, applyState, shenpiren, cksj);
	    /*获取到总的页码数目*/
	    int totalPage = applyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = applyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Apply apply:applyList) {
			JSONObject jsonApply = apply.getJsonObject();
			jsonArray.put(jsonApply);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询物资申领信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Apply> applyList = applyService.queryAllApply();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Apply apply:applyList) {
			JSONObject jsonApply = new JSONObject();
			jsonApply.accumulate("applyId", apply.getApplyId());
			jsonArray.put(jsonApply);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询物资申领信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,@ModelAttribute("companyObj") Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (sqr == null) sqr = "";
		if (sqsj == null) sqsj = "";
		if (applyState == null) applyState = "";
		if (shenpiren == null) shenpiren = "";
		if (cksj == null) cksj = "";
		List<Apply> applyList = applyService.queryApply(productObj, supplierObj, companyObj, sqr, sqsj, applyState, shenpiren, cksj, currentPage);
	    /*计算总的页数和总的记录数*/
	    applyService.queryTotalPageAndRecordNumber(productObj, supplierObj, companyObj, sqr, sqsj, applyState, shenpiren, cksj);
	    /*获取到总的页码数目*/
	    int totalPage = applyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = applyService.getRecordNumber();
	    request.setAttribute("applyList",  applyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("supplierObj", supplierObj);
	    request.setAttribute("companyObj", companyObj);
	    request.setAttribute("sqr", sqr);
	    request.setAttribute("sqsj", sqsj);
	    request.setAttribute("applyState", applyState);
	    request.setAttribute("shenpiren", shenpiren);
	    request.setAttribute("cksj", cksj);
	    List<Company> companyList = companyService.queryAllCompany();
	    request.setAttribute("companyList", companyList);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<Supplier> supplierList = supplierService.queryAllSupplier();
	    request.setAttribute("supplierList", supplierList);
		return "Apply/apply_frontquery_result"; 
	}
	
	
	
	/*前台按照查询条件分页查询物资申领信息*/
	@RequestMapping(value = { "/empFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String empFrontlist(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,@ModelAttribute("companyObj") Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (sqr == null) sqr = "";
		if (sqsj == null) sqsj = "";
		if (applyState == null) applyState = "";
		if (shenpiren == null) shenpiren = "";
		if (cksj == null) cksj = "";
		sqr = session.getAttribute("user_name").toString();
		
		List<Apply> applyList = applyService.queryApply(productObj, supplierObj, companyObj, sqr, sqsj, applyState, shenpiren, cksj, currentPage);
	    /*计算总的页数和总的记录数*/
	    applyService.queryTotalPageAndRecordNumber(productObj, supplierObj, companyObj, sqr, sqsj, applyState, shenpiren, cksj);
	    /*获取到总的页码数目*/
	    int totalPage = applyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = applyService.getRecordNumber();
	    request.setAttribute("applyList",  applyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("productObj", productObj);
	    request.setAttribute("supplierObj", supplierObj);
	    request.setAttribute("companyObj", companyObj);
	    request.setAttribute("sqr", sqr);
	    request.setAttribute("sqsj", sqsj);
	    request.setAttribute("applyState", applyState);
	    request.setAttribute("shenpiren", shenpiren);
	    request.setAttribute("cksj", cksj);
	    List<Company> companyList = companyService.queryAllCompany();
	    request.setAttribute("companyList", companyList);
	    List<Product> productList = productService.queryAllProduct();
	    request.setAttribute("productList", productList);
	    List<Supplier> supplierList = supplierService.queryAllSupplier();
	    request.setAttribute("supplierList", supplierList);
		return "Apply/apply_empFrontquery_result"; 
	}

     /*前台查询Apply信息*/
	@RequestMapping(value="/{applyId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer applyId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键applyId获取Apply对象*/
        Apply apply = applyService.getApply(applyId);

        List<Company> companyList = companyService.queryAllCompany();
        request.setAttribute("companyList", companyList);
        List<Product> productList = productService.queryAllProduct();
        request.setAttribute("productList", productList);
        List<Supplier> supplierList = supplierService.queryAllSupplier();
        request.setAttribute("supplierList", supplierList);
        request.setAttribute("apply",  apply);
        return "Apply/apply_frontshow";
	}

	/*ajax方式显示物资申领修改jsp视图页*/
	@RequestMapping(value="/{applyId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer applyId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键applyId获取Apply对象*/
        Apply apply = applyService.getApply(applyId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonApply = apply.getJsonObject();
		out.println(jsonApply.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新物资申领信息*/
	@RequestMapping(value = "/{applyId}/update", method = RequestMethod.POST)
	public void update(@Validated Apply apply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		
		
		try {
			Apply db_apply = applyService.getApply(apply.getApplyId());	
			//确认出库之前需要判断下商品库存是否满足需求
			if(db_apply.getApplyState().equals("已申请") && apply.getApplyState().equals("已确认")) {
				//判断物资的库存是否满足申请的数量需求
				int productId = apply.getProductObj().getProductId();
				Product product = productService.getProduct(productId); 
				if(product.getProductCount() < apply.getApplyCount()) {
					message = "物资库存不能满足出库数量需求，请先补仓！";
					writeJsonResponse(response, success, message);
					return;
				}
				product.setProductCount(product.getProductCount() - apply.getApplyCount());
				productService.updateProduct(product);
			}
		
		
			applyService.updateApply(apply);
			message = "物资申领更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "物资申领更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除物资申领信息*/
	@RequestMapping(value="/{applyId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer applyId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  applyService.deleteApply(applyId);
	            request.setAttribute("message", "物资申领删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "物资申领删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条物资申领记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String applyIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = applyService.deleteApplys(applyIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出物资申领信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("productObj") Product productObj,@ModelAttribute("supplierObj") Supplier supplierObj,@ModelAttribute("companyObj") Company companyObj,String sqr,String sqsj,String applyState,String shenpiren,String cksj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(sqr == null) sqr = "";
        if(sqsj == null) sqsj = "";
        if(applyState == null) applyState = "";
        if(shenpiren == null) shenpiren = "";
        if(cksj == null) cksj = "";
        List<Apply> applyList = applyService.queryApply(productObj,supplierObj,companyObj,sqr,sqsj,applyState,shenpiren,cksj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Apply信息记录"; 
        String[] headers = { "申领id","物品名称","物品供应商","行政物需点","出库数量","申请人","申请时间","状态","审批人","出库时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<applyList.size();i++) {
        	Apply apply = applyList.get(i); 
        	dataset.add(new String[]{apply.getApplyId() + "",apply.getProductObj().getProductName(),apply.getSupplierObj().getSupplierName(),apply.getCompanyObj().getCompanyName(),apply.getApplyCount() + "",apply.getSqr(),apply.getSqsj(),apply.getApplyState(),apply.getShenpiren(),apply.getCksj()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Apply.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
