package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class OrderManagementDao {
	@Autowired
	private SqlSessionTemplate tpl;

	// 페이징 위한 총 주문 개수
	public int getTotalOrderCnt(String id) {
		return tpl.selectOne("artisanOrderManagementMapper.getTotalOrderCnt",id);
	}

	public List<OrderProduct> getOrderList(String id, int startArticleNum, int endArticleNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("artisanId", id);
		return tpl.selectList("artisanOrderManagementMapper.getOrderList",map);
	}

	public List<OrderOption> getOrderOptionList(int orderProductIdx) {
		return tpl.selectList("artisanOrderManagementMapper.getOrderOptionList",orderProductIdx);
	}
	// 상태 업데이트 (제작)
	public int updateProductionProcessing(Integer idx) {
		return tpl.update("artisanOrderManagementMapper.updateProductionProcessing",idx);
	}
	//(배송)
	public int updateDeliveryProcessing(Integer idx) {
		return tpl.update("artisanOrderManagementMapper.updateDeliveryProcessing",idx);
	}
	

	// 상태별 개수 ( 주문, 제작, 배송)
	public int getOrderStateCnt(String id) {
		return tpl.selectOne("artisanOrderManagementMapper.getOrderStateCnt",id);
	}
	public int getProductionStateCnt(String id) {
		return tpl.selectOne("artisanOrderManagementMapper.getProductionStateCnt",id);
	}

	public int getDeliveryStateCnt(String id) {
		return tpl.selectOne("artisanOrderManagementMapper.getDeliveryStateCnt",id);
	}
	
	// 기간별 조회를 위한.....부분들!!
	public int getTotalOrderCntByDate(String id, int searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("date", searchDate);
		return tpl.selectOne("artisanOrderManagementMapper.getTotalOrderCntByDate",map);
	}

	public List<OrderProduct> getOrderListByDate(String id, int searchDate, int startArticleNum, int endArticleNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("artisanId", id);
		map.put("date", searchDate);
		return tpl.selectList("artisanOrderManagementMapper.getOrderListByDate",map);
	}
	// 상태별 조회를 위한..
	public int getTotalOrderCntByState(String id, String state) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("state", state);
		return tpl.selectOne("artisanOrderManagementMapper.getTotalOrderCntByState",map);
	}

	public List<OrderProduct> getOrderListByState(String id, String state, int startArticleNum, int endArticleNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("artisanId", id);
		map.put("state", state);
		return tpl.selectList("artisanOrderManagementMapper.getOrderListByState",map);
	}

	public List<OrderProduct> getOrderByList(String id, String state, String orderby, String sort, int startArticleNum,
			int endArticleNum) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("artisanId", id);
		map.put("state", state);
		map.put("orderby", orderby);
		map.put("sort", sort);
		return tpl.selectList("artisanOrderManagementMapper.getOrderByList",map);
	}
	// 배송정보입력 : 1개상품
	public void insertOrderProductParcel(OrderProduct orderProduct) {
		tpl.update("artisanOrderManagementMapper.insertOrderProductParcel",orderProduct);
	}
	// 배송정보입력 : 일괄처리
	public void insertAllOrderProductParcel(OrderProduct orderProduct) {
		tpl.update("artisanOrderManagementMapper.insertAllOrderProductParcel",orderProduct);
	}
	// 배송상태 처리 : 일괄
	public int updateAllDeliveryProcessing(int ordersIdx) {
		return tpl.update("artisanOrderManagementMapper.updateAllDeliveryProcessing",ordersIdx);
	}

	public Order getOrder(int ordersIdx) {
		return tpl.selectOne("artisanOrderManagementMapper.getOrder",ordersIdx);
	}

	public List<OrderProduct> getOrderListByOrdersIdx(int ordersIdx) {
		return tpl.selectList("artisanOrderManagementMapper.getOrderListByOrdersIdx",ordersIdx);
	}

	
	

	
}
