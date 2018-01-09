package com.icia.bachida.service;

import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.google.gson.*;
import com.icia.bachida.dao.*;
import com.icia.bachida.vo.*;

@Service
public class MainService {
	@Autowired
	private MainDao dao;
	// 최신상품 3개
	public Map<String,Object> getRecentProductList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Product> recentList = dao.getRecentProductList();
		for(int i =0; i<recentList.size(); i++) {
			List<ProductAttach> recentAttach = new ArrayList<ProductAttach>();
			 ProductAttach pa = dao.getProductAttach(recentList.get(i).getProductIdx());
			 recentAttach.add(pa);
			 recentList.get(i).setAttach(recentAttach); 
		}
		map.put("recentList", recentList);
		return map;
	}
	// 인기상품 8개
	public Map<String, Object> getPopularProductList() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<Product> popularList = dao.getPopularProductList();
		for(int i =0; i<popularList.size(); i++) {
			List<ProductAttach> popularAttach = new ArrayList<ProductAttach>();
			 ProductAttach pa = dao.getProductAttach(popularList.get(i).getProductIdx());
			 popularAttach.add(pa);
			 popularList.get(i).setAttach(popularAttach); 
		}
		map.put("popularList", popularList);
		return map;
	}

	public Map<String,Object> getRecommendProductlist(List<Interest> interests) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<List<Product>> recommendList = new ArrayList<List<Product>>();
		
		for(Interest mainIdx:interests) {
			//System.out.println("=============================="+mainIdx.getMainCategoryIdx());
			List<Product> recommendListByCategory = dao.getRecommendProductlist(mainIdx.getMainCategoryIdx());
			for(int i =0; i<recommendListByCategory.size(); i++) {
				List<ProductAttach> recommendAttach = new ArrayList<ProductAttach>();
				 ProductAttach pa = dao.getProductAttach(recommendListByCategory.get(i).getProductIdx());
				 recommendAttach.add(pa);
				 recommendListByCategory.get(i).setAttach(recommendAttach); 
			}
			recommendList.add(recommendListByCategory);
		}
		//System.out.println(recommendList+"=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-");
		map.put("recommendList", recommendList);
		return map;
	}
	// 안읽은 메세지 개수가져오깅
	public int getMessageCnt(String id) {
		return dao.getMessageCnt(id);
	}
	public List<Integer> activeBookmark(String id) {
		return dao.activeBookmark(id);
	}
}
