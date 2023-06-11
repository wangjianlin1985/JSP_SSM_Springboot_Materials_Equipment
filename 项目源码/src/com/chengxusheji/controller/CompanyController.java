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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chengxusheji.po.Company;
import com.chengxusheji.service.CompanyService;
import com.chengxusheji.utils.ExportExcelUtil;

//Company管理控制层
@Controller
@RequestMapping("/Company")
public class CompanyController extends BaseController {

    /*业务层对象*/
    @Resource CompanyService companyService;

	@InitBinder("company")
	public void initBinderCompany(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("company.");
	}
	/*跳转到添加Company视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Company());
		return "Company_add";
	}

	/*客户端ajax方式提交添加公司物需点信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Company company, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        companyService.addCompany(company);
        message = "公司物需点添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询公司物需点信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String companyName,String city,String telephone,String bPerson,String djrlxfs,String luruTime,String luruRen,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (companyName == null) companyName = "";
		if (city == null) city = "";
		if (telephone == null) telephone = "";
		if (bPerson == null) bPerson = "";
		if (djrlxfs == null) djrlxfs = "";
		if (luruTime == null) luruTime = "";
		if (luruRen == null) luruRen = "";
		if(rows != 0)companyService.setRows(rows);
		List<Company> companyList = companyService.queryCompany(companyName, city, telephone, bPerson, djrlxfs, luruTime, luruRen, page);
	    /*计算总的页数和总的记录数*/
	    companyService.queryTotalPageAndRecordNumber(companyName, city, telephone, bPerson, djrlxfs, luruTime, luruRen);
	    /*获取到总的页码数目*/
	    int totalPage = companyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = companyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Company company:companyList) {
			JSONObject jsonCompany = company.getJsonObject();
			jsonArray.put(jsonCompany);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询公司物需点信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Company> companyList = companyService.queryAllCompany();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Company company:companyList) {
			JSONObject jsonCompany = new JSONObject();
			jsonCompany.accumulate("companyId", company.getCompanyId());
			jsonCompany.accumulate("companyName", company.getCompanyName());
			jsonArray.put(jsonCompany);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询公司物需点信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String companyName,String city,String telephone,String bPerson,String djrlxfs,String luruTime,String luruRen,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (companyName == null) companyName = "";
		if (city == null) city = "";
		if (telephone == null) telephone = "";
		if (bPerson == null) bPerson = "";
		if (djrlxfs == null) djrlxfs = "";
		if (luruTime == null) luruTime = "";
		if (luruRen == null) luruRen = "";
		List<Company> companyList = companyService.queryCompany(companyName, city, telephone, bPerson, djrlxfs, luruTime, luruRen, currentPage);
	    /*计算总的页数和总的记录数*/
	    companyService.queryTotalPageAndRecordNumber(companyName, city, telephone, bPerson, djrlxfs, luruTime, luruRen);
	    /*获取到总的页码数目*/
	    int totalPage = companyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = companyService.getRecordNumber();
	    request.setAttribute("companyList",  companyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("companyName", companyName);
	    request.setAttribute("city", city);
	    request.setAttribute("telephone", telephone);
	    request.setAttribute("bPerson", bPerson);
	    request.setAttribute("djrlxfs", djrlxfs);
	    request.setAttribute("luruTime", luruTime);
	    request.setAttribute("luruRen", luruRen);
		return "Company/company_frontquery_result"; 
	}

     /*前台查询Company信息*/
	@RequestMapping(value="/{companyId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer companyId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键companyId获取Company对象*/
        Company company = companyService.getCompany(companyId);

        request.setAttribute("company",  company);
        return "Company/company_frontshow";
	}

	/*ajax方式显示公司物需点修改jsp视图页*/
	@RequestMapping(value="/{companyId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer companyId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键companyId获取Company对象*/
        Company company = companyService.getCompany(companyId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCompany = company.getJsonObject();
		out.println(jsonCompany.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新公司物需点信息*/
	@RequestMapping(value = "/{companyId}/update", method = RequestMethod.POST)
	public void update(@Validated Company company, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			companyService.updateCompany(company);
			message = "公司物需点更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "公司物需点更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除公司物需点信息*/
	@RequestMapping(value="/{companyId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer companyId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  companyService.deleteCompany(companyId);
	            request.setAttribute("message", "公司物需点删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "公司物需点删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条公司物需点记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String companyIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = companyService.deleteCompanys(companyIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出公司物需点信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String companyName,String city,String telephone,String bPerson,String djrlxfs,String luruTime,String luruRen, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(companyName == null) companyName = "";
        if(city == null) city = "";
        if(telephone == null) telephone = "";
        if(bPerson == null) bPerson = "";
        if(djrlxfs == null) djrlxfs = "";
        if(luruTime == null) luruTime = "";
        if(luruRen == null) luruRen = "";
        List<Company> companyList = companyService.queryCompany(companyName,city,telephone,bPerson,djrlxfs,luruTime,luruRen);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Company信息记录"; 
        String[] headers = { "物需点id","公司名称","所在城市","物需点电话","物需点地址","B方对接人","对接人联系方式","录入时间","录入人"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<companyList.size();i++) {
        	Company company = companyList.get(i); 
        	dataset.add(new String[]{company.getCompanyId() + "",company.getCompanyName(),company.getCity(),company.getTelephone(),company.getAddress(),company.getBPerson(),company.getDjrlxfs(),company.getLuruTime(),company.getLuruRen()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Company.xls");//filename是下载的xls的名，建议最好用英文 
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
