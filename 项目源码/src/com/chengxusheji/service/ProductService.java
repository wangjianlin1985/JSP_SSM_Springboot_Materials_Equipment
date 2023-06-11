package com.chengxusheji.service;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.chengxusheji.mapper.ProductMapper;
import com.chengxusheji.po.Company;
import com.chengxusheji.po.Product;
import com.chengxusheji.po.Supplier;
@Service
public class ProductService {

	@Resource ProductMapper productMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加物资记录*/
    public void addProduct(Product product) throws Exception {
    	productMapper.addProduct(product);
    }

    /*按照查询条件分页查询物资记录*/
    public ArrayList<Product> queryProduct(String productName,Supplier supplierObj,Company companyObj,String luruTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_product.supplierObj=" + supplierObj.getSupplierId();
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_product.companyObj=" + companyObj.getCompanyId();
    	if(!luruTime.equals("")) where = where + " and t_product.luruTime like '%" + luruTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return productMapper.queryProduct(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Product> queryProduct(String productName,Supplier supplierObj,Company companyObj,String luruTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_product.supplierObj=" + supplierObj.getSupplierId();
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_product.companyObj=" + companyObj.getCompanyId();
    	if(!luruTime.equals("")) where = where + " and t_product.luruTime like '%" + luruTime + "%'";
    	return productMapper.queryProductList(where);
    }

    /*查询所有物资记录*/
    public ArrayList<Product> queryAllProduct()  throws Exception {
        return productMapper.queryProductList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String productName,Supplier supplierObj,Company companyObj,String luruTime) throws Exception {
     	String where = "where 1=1";
    	if(!productName.equals("")) where = where + " and t_product.productName like '%" + productName + "%'";
    	if(null != supplierObj && supplierObj.getSupplierId()!= null && supplierObj.getSupplierId()!= 0)  where += " and t_product.supplierObj=" + supplierObj.getSupplierId();
    	if(null != companyObj && companyObj.getCompanyId()!= null && companyObj.getCompanyId()!= 0)  where += " and t_product.companyObj=" + companyObj.getCompanyId();
    	if(!luruTime.equals("")) where = where + " and t_product.luruTime like '%" + luruTime + "%'";
        recordNumber = productMapper.queryProductCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取物资记录*/
    public Product getProduct(int productId) throws Exception  {
        Product product = productMapper.getProduct(productId);
        return product;
    }

    /*更新物资记录*/
    public void updateProduct(Product product) throws Exception {
        productMapper.updateProduct(product);
    }

    /*删除一条物资记录*/
    public void deleteProduct (int productId) throws Exception {
        productMapper.deleteProduct(productId);
    }

    /*删除多条物资信息*/
    public int deleteProducts (String productIds) throws Exception {
    	String _productIds[] = productIds.split(",");
    	for(String _productId: _productIds) {
    		productMapper.deleteProduct(Integer.parseInt(_productId));
    	}
    	return _productIds.length;
    }
}
