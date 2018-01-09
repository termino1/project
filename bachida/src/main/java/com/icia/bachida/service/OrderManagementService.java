package com.icia.bachida.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;
import org.springframework.transaction.annotation.*;

import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Service
public class OrderManagementService {
	@Autowired
	private OrderManagementDao dao;
	
	@PreAuthorize("#id == principal.username")
	public Map<String, Object> getOrderList(String id, int pageno) {
		Map<String, Object> map = new HashMap<String, Object>();
		int OrderTotalCnt = dao.getTotalOrderCnt(id);
		Pagination pagination = PagingUtil.setPageMaker(pageno, OrderTotalCnt);
		List<OrderProduct> list = dao.getOrderList(id,pagination.getStartArticleNum(), pagination.getEndArticleNum());
		List<OrderOption> optionListByIdx = new ArrayList<OrderOption>();
		List<List<OrderOption>> optionList = new ArrayList<List<OrderOption>>();
		
		for(OrderProduct op:list) {
			optionListByIdx = dao.getOrderOptionList(op.getOrderProductIdx());
			optionList.add(optionListByIdx);
		}
		map.put("totalOrderCnt",OrderTotalCnt);
		map.put("orderStateCnt", dao.getOrderStateCnt(id));
		map.put("productionStateCnt", dao.getProductionStateCnt(id));
		map.put("deliveryStateCnt", dao.getDeliveryStateCnt(id));
		map.put("pagination", pagination);
		map.put("list", list);
		map.put("optionList", optionList);
		return map;
	}
	//@PreAuthorize("")
	public boolean updateProductionProcessing(List<Integer> checkbox) {
		boolean result = false;
		for(Integer idx:checkbox) {
			if(dao.updateProductionProcessing(idx)==1) {
				result = true;
			}else {
				result = false;
				break;
			}
		}
		return result;
	}
	// 기간별 조회 list
	@PreAuthorize("#id == principal.username")
	public Map<String, Object> getOrderListByDate(String id, int pageno, int searchDate) {
		Map<String, Object> map = new HashMap<String, Object>();
		int OrderTotalCnt = dao.getTotalOrderCntByDate(id,searchDate);
		
		Pagination pagination = PagingUtil.setPageMaker(pageno, OrderTotalCnt);
		
		List<OrderProduct> list = dao.getOrderListByDate(id,searchDate,pagination.getStartArticleNum(), pagination.getEndArticleNum());
		List<OrderOption> optionListByIdx = new ArrayList<OrderOption>();
		List<List<OrderOption>> optionList = new ArrayList<List<OrderOption>>();
		
		for(OrderProduct op:list) {
			optionListByIdx = dao.getOrderOptionList(op.getOrderProductIdx());
			optionList.add(optionListByIdx);
		}
		map.put("orderCntByDate", OrderTotalCnt );
		map.put("pagination", pagination);
		map.put("list", list);
		map.put("optionList", optionList);
		return map;
	}
	// 상태별
	@PreAuthorize("#id == principal.username")
	public Map<String, Object> getOrderListByState(String id, int pageno, String state) {
		Map<String, Object> map = new HashMap<String, Object>();
		int OrderTotalCnt = dao.getTotalOrderCntByState(id,state);
		
		Pagination pagination = PagingUtil.setPageMaker(pageno, OrderTotalCnt);
		
		List<OrderProduct> list = dao.getOrderListByState(id,state,pagination.getStartArticleNum(), pagination.getEndArticleNum());
		List<OrderOption> optionListByIdx = new ArrayList<OrderOption>();
		List<List<OrderOption>> optionList = new ArrayList<List<OrderOption>>();
		
		for(OrderProduct op:list) {
			optionListByIdx = dao.getOrderOptionList(op.getOrderProductIdx());
			optionList.add(optionListByIdx);
		}
		map.put("orderCntByState", OrderTotalCnt );
		map.put("pagination", pagination);
		map.put("list", list);
		map.put("optionList", optionList);
		return map;
	}
	@PreAuthorize("#id == principal.username")
	public Map<String, Object> getOrderByList(String id, int pageno, String state, String orderby, String sort) {
		Map<String, Object> map = new HashMap<String, Object>();
		int OrderTotalCnt = dao.getTotalOrderCntByState(id,state);
		
		Pagination pagination = PagingUtil.setPageMaker(pageno, OrderTotalCnt);
		
		List<OrderProduct> list = dao.getOrderByList(id,state,orderby,sort,pagination.getStartArticleNum(), pagination.getEndArticleNum());
		List<OrderOption> optionListByIdx = new ArrayList<OrderOption>();
		List<List<OrderOption>> optionList = new ArrayList<List<OrderOption>>();
		
		for(OrderProduct op:list) {
			optionListByIdx = dao.getOrderOptionList(op.getOrderProductIdx());
			optionList.add(optionListByIdx);
		}
		map.put("orderCntByState", OrderTotalCnt );
		map.put("pagination", pagination);
		map.put("list", list);
		map.put("optionList", optionList);
		return map;
	}
	// insert 성공하면 상태 update
	@PreAuthorize("#id == principal.username")
	@Transactional
	public Boolean insertParcelAndUpdateState(OrderProduct orderProduct, String parcelTotal, String id) {
		if(parcelTotal!=null) {
			dao.insertAllOrderProductParcel(orderProduct);
			return dao.updateAllDeliveryProcessing(orderProduct.getOrdersIdx())==1? true: false;
		}else {
			dao.insertOrderProductParcel(orderProduct);
			return dao.updateDeliveryProcessing(orderProduct.getOrderProductIdx())==1? true: false;
		}
	}

	public Map<String, Object> getListByOrdersIdx(int ordersIdx) {
		Map<String, Object> map = new HashMap<String, Object>();
		Order order = dao.getOrder(ordersIdx);
		List<OrderProduct> list = dao.getOrderListByOrdersIdx(ordersIdx);
		List<OrderOption> optionListByIdx = new ArrayList<OrderOption>();
		List<List<OrderOption>> optionList = new ArrayList<List<OrderOption>>();
		for(OrderProduct op:list) {
			optionListByIdx = dao.getOrderOptionList(op.getOrderProductIdx());
			optionList.add(optionListByIdx);
		}
		map.put("order", order);
		map.put("list", list);
		map.put("optionList", optionList);
		return map;
	}

	
}
