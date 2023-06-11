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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.chengxusheji.po.Company;
import com.chengxusheji.po.XzAdmin;
import com.chengxusheji.service.CompanyService;
import com.chengxusheji.service.XzAdminService;
import com.chengxusheji.utils.ExportExcelUtil;

//XzAdmin管理控制层
@Controller
@RequestMapping("/XzAdmin")
public class XzAdminController extends BaseController {

    /*业务层对象*/
    @Resource XzAdminService xzAdminService;

    @Resource CompanyService companyService;
	@InitBinder("companyObj")
	public void initBindercompanyObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("companyObj.");
	}
	@InitBinder("xzAdmin")
	public void initBinderXzAdmin(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("xzAdmin.");
	}
	/*跳转到添加XzAdmin视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new XzAdmin());
		/*查询所有的Company信息*/
		List<Company> companyList = companyService.queryAllCompany();
		request.setAttribute("companyList", companyList);
		return "XzAdmin_add";
	}

	/*客户端ajax方式提交添加行政管理信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated XzAdmin xzAdmin, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		if(xzAdminService.getXzAdmin(xzAdmin.getXzUserName()) != null) {
			message = "用户名已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
        xzAdminService.addXzAdmin(xzAdmin);
        message = "行政管理添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询行政管理信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String xzUserName,@ModelAttribute("companyObj") Company companyObj,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (xzUserName == null) xzUserName = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)xzAdminService.setRows(rows);
		List<XzAdmin> xzAdminList = xzAdminService.queryXzAdmin(xzUserName, companyObj, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    xzAdminService.queryTotalPageAndRecordNumber(xzUserName, companyObj, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = xzAdminService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = xzAdminService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(XzAdmin xzAdmin:xzAdminList) {
			JSONObject jsonXzAdmin = xzAdmin.getJsonObject();
			jsonArray.put(jsonXzAdmin);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询行政管理信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<XzAdmin> xzAdminList = xzAdminService.queryAllXzAdmin();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(XzAdmin xzAdmin:xzAdminList) {
			JSONObject jsonXzAdmin = new JSONObject();
			jsonXzAdmin.accumulate("xzUserName", xzAdmin.getXzUserName());
			jsonXzAdmin.accumulate("name", xzAdmin.getName());
			jsonArray.put(jsonXzAdmin);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询行政管理信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String xzUserName,@ModelAttribute("companyObj") Company companyObj,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (xzUserName == null) xzUserName = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<XzAdmin> xzAdminList = xzAdminService.queryXzAdmin(xzUserName, companyObj, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    xzAdminService.queryTotalPageAndRecordNumber(xzUserName, companyObj, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = xzAdminService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = xzAdminService.getRecordNumber();
	    request.setAttribute("xzAdminList",  xzAdminList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("xzUserName", xzUserName);
	    request.setAttribute("companyObj", companyObj);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
	    List<Company> companyList = companyService.queryAllCompany();
	    request.setAttribute("companyList", companyList);
		return "XzAdmin/xzAdmin_frontquery_result"; 
	}

     /*前台查询XzAdmin信息*/
	@RequestMapping(value="/{xzUserName}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String xzUserName,Model model,HttpServletRequest request) throws Exception {
		/*根据主键xzUserName获取XzAdmin对象*/
        XzAdmin xzAdmin = xzAdminService.getXzAdmin(xzUserName);

        List<Company> companyList = companyService.queryAllCompany();
        request.setAttribute("companyList", companyList);
        request.setAttribute("xzAdmin",  xzAdmin);
        return "XzAdmin/xzAdmin_frontshow";
	}

	/*ajax方式显示行政管理修改jsp视图页*/
	@RequestMapping(value="/{xzUserName}/update",method=RequestMethod.GET)
	public void update(@PathVariable String xzUserName,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键xzUserName获取XzAdmin对象*/
        XzAdmin xzAdmin = xzAdminService.getXzAdmin(xzUserName);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonXzAdmin = xzAdmin.getJsonObject();
		out.println(jsonXzAdmin.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新行政管理信息*/
	@RequestMapping(value = "/{xzUserName}/update", method = RequestMethod.POST)
	public void update(@Validated XzAdmin xzAdmin, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			xzAdminService.updateXzAdmin(xzAdmin);
			message = "行政管理更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "行政管理更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除行政管理信息*/
	@RequestMapping(value="/{xzUserName}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String xzUserName,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  xzAdminService.deleteXzAdmin(xzUserName);
	            request.setAttribute("message", "行政管理删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "行政管理删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条行政管理记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String xzUserNames,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = xzAdminService.deleteXzAdmins(xzUserNames);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出行政管理信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String xzUserName,@ModelAttribute("companyObj") Company companyObj,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(xzUserName == null) xzUserName = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<XzAdmin> xzAdminList = xzAdminService.queryXzAdmin(xzUserName,companyObj,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "XzAdmin信息记录"; 
        String[] headers = { "用户名","登录密码","所在分公司","姓名","性别","出生日期","联系方式"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<xzAdminList.size();i++) {
        	XzAdmin xzAdmin = xzAdminList.get(i); 
        	dataset.add(new String[]{xzAdmin.getXzUserName(),xzAdmin.getPassword(),xzAdmin.getCompanyObj().getCompanyName(),xzAdmin.getName(),xzAdmin.getSex(),xzAdmin.getBirthDate(),xzAdmin.getTelephone()});
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
			response.setHeader("Content-disposition","attachment; filename="+"XzAdmin.xls");//filename是下载的xls的名，建议最好用英文 
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
