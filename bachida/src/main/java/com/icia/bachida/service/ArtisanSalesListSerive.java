package com.icia.bachida.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.security.access.prepost.*;
import org.springframework.stereotype.*;

import com.google.gson.*;
import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

@Service
public class ArtisanSalesListSerive {
	@Autowired private ArtisanSalesListDao dao;
	@Autowired	private Gson gson;
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	//@PreAuthorize("#id == principal.username")
	public Map<String, Object> getSalesList(String artisanId, int pageno) {
		System.out.println("서비스 : "+artisanId);
		int productSalesCnt = dao.getlistProductCnt(artisanId);
		Pagination pagination = PagingUtil.setPageMaker(pageno, productSalesCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		//페이징
		map.put("pagination", pagination);
		//판매 갯수
		map.put("productSalesCnt", productSalesCnt);
		//리스트
		map.put("list", dao.getSalesProductList(pagination.getStartArticleNum(), pagination.getEndArticleNum(), artisanId));
		return map;
	}
	
	public String getOriginalFileName(int productIdx,String fileName) {
		return dao.getOriginalFileName(productIdx, fileName);
	}
	
	/*
	 * 상태별 정렬 추가 중
	 */	
	
	
}
