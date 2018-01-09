package com.icia.bachida.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.google.gson.*;
import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;
@Service
public class SalesManagementService {
@Autowired private SalesManagementDao dao;
	
	public Map<String, Object> listSalesManagement(int pageno,String artisanId) {
		int orderCnt = dao.getSalseCnt(artisanId);
		System.out.println("서비스단 주문 완결내역"+artisanId);
		Pagination pagination = PagingUtil.setPageMaker(pageno, orderCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("pagination", pagination);
		map.put("listSales", dao.listSalesManagement(pagination.getStartArticleNum(),pagination.getEndArticleNum(),artisanId));
		map.put("total", dao.totalProductSales(artisanId));//상품 판매가 합계
		map.put("deduct", dao.deductProductSales(artisanId));//공제내역
		map.put("gross", dao.grossProductSalse(artisanId));//정산금액
		return map;
	}
	/*
	 * 차트는 추후에..
	 */

}
