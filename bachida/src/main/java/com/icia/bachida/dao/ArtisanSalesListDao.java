package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class ArtisanSalesListDao {
	@Autowired private SqlSessionTemplate tpl;
	//페이징 리스트 카운트
	public int getlistProductCnt(String artisanId) {
		
		return tpl.selectOne("productSalesMapper.getlistProductCnt",artisanId);
	}
	//리스트
	public List<Product> getSalesProductList(int startArticleNum, int endArticleNum, String artisanId) {
		System.out.println(artisanId);
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("artisanId", artisanId);
		return tpl.selectList("productSalesMapper.getSalesProductList",map);
	}
	//원본파일 불러오기
	public String getOriginalFileName(int productIdx,String fileName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productIdx", productIdx);
		map.put("savedFileName", fileName);
		return tpl.selectOne("productSalesMapper.getOriginalFileName",map);
	}

	

}
