package com.chengxusheji.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.chengxusheji.po.Purchase;

public interface PurchaseMapper {
	/*添加物资采购信息*/
	public void addPurchase(Purchase purchase) throws Exception;

	/*按照查询条件分页查询物资采购记录*/
	public ArrayList<Purchase> queryPurchase(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有物资采购记录*/
	public ArrayList<Purchase> queryPurchaseList(@Param("where") String where) throws Exception;

	/*按照查询条件的物资采购记录数*/
	public int queryPurchaseCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条物资采购记录*/
	public Purchase getPurchase(int purchaseId) throws Exception;

	/*更新物资采购记录*/
	public void updatePurchase(Purchase purchase) throws Exception;

	/*删除物资采购记录*/
	public void deletePurchase(int purchaseId) throws Exception;

}
