package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;
@Repository
public class CustomizeDao {
	@Autowired
	private SqlSessionTemplate tpl;
	
	public List<Bid> getBidList(String id, int startArticleNum, int endArticleNum) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("endArticleNum", endArticleNum);
		map.put("startArticleNum", startArticleNum);
		return tpl.selectList("customizeMapper.getBidList", map);
	}

	public ProductionOrder getProductionOrder(int bidIdx) {
		return tpl.selectOne("customizeMapper.getProductionOrder",bidIdx);
	}

	public List<CustomOpinion> getCustomOpinionList(int bidIdx) {
		return tpl.selectList("customizeMapper.getCustomOpinionList",bidIdx);
	}

	public Bid getBid(int bidIdx) {
		return tpl.selectOne("customizeMapper.getBid",bidIdx);
	}

	public List<BidAttach> getBidAttach(int bidIdx) {
		return tpl.selectList("customizeMapper.getBidAttach",bidIdx);
	}

	public void insertCustomOpinion(CustomOpinion opinion) {
		tpl.insert("customizeMapper.insertCustomOpinion",opinion);
	}

	public int insertProductOrder(ProductionOrder order) {
		return tpl.insert("customizeMapper.insertProductionOrder",order);
	}

	public int updateAddress(String address, int productionOrderIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("address", address);
		map.put("productionOrderIdx", productionOrderIdx);
		return tpl.update("customizeMapper.updateAddress",map);
	}

	public String getUsersCash(String id) {
		return tpl.selectOne("customizeMapper.getUsersCash",id);
	}

	public int depositPayment(Map<String, Object> map) {
		return tpl.update("customizeMapper.updateDepositCash",map);
	}

	public int insertDepositCash(Map<String, Object> map) {
		return tpl.insert("customizeMapper.insertDepositCash",map);
	}

	public int updateProductionOrderState(int productionOrderIdx) {
		return tpl.update("customizeMapper.updateProductState",productionOrderIdx);
	}

	public int updateCompleteProductionState(int productionOrderIdx) {
		return tpl.update("customizeMapper.updateCompleteProductionState",productionOrderIdx);
	}

	public int insertBalanceCash(Map<String, Object> map) {
		return tpl.insert("customizeMapper.insertBalanceCash",map);
	}

	public int updateCompletePaymentState(int productionOrderIdx) {
		return tpl.update("customizeMapper.updateCompletePaymentState",productionOrderIdx);
	}

	public int updateDeliveryState(int productionOrderIdx, int parcelIdx, String parcelName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productionOrderIdx", productionOrderIdx);
		map.put("parcelIdx", parcelIdx);
		map.put("parcelName", parcelName);
		return tpl.update("customizeMapper.updateDeliveryState",map);
	}

	public int getBidCount(String id) {
		return tpl.selectOne("customizeMapper.getBidCount", id);
	}

	public List<Bid> getAllBidList(String id) {
		return tpl.selectList("customizeMapper.getAllBidListById",id);
	}

	public int updateAddTotalCashForArtisan(String artisanId, int totalPrice) {
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("totalPrice", totalPrice);
		return tpl.update("customizeMapper.updateAddTotalCashForArtisan",map);
	}

	public int insertTotalCashForArtisan(String artisanId, int totalPrice, int productionOrderIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("totalPrice", totalPrice);
		map.put("content", productionOrderIdx+"번 주문제작 입금");
		return tpl.insert("customizeMapper.insertTotalCashForArtisan",map);
	}

	public Artisan getArtisan(String artisanId) {
		return tpl.selectOne("customizeMapper.getArtisan",artisanId);
	}

	public int updateProductionOrder(ProductionOrder order) {
		return tpl.update("customizeMapper.updateProductionOrder",order);
	}

	public Artisan artisanInfo(String artisanId) {
		return tpl.selectOne("artisanTimelineMapper.artisanInfo",artisanId);
	}

	

}
