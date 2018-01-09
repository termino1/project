package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class SalesManagementDao {
@Autowired private SqlSessionTemplate tap;

	public int getSalseCnt(String artisanId) {
		return tap.selectOne("artisanManagementMapper.SalesListCnt",artisanId);
	}

	public List<Map<String, String>> listSalesManagement(int startArticleNum, int endArticleNum, String artisanId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("artisanId", artisanId);
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		return tap.selectList("artisanManagementMapper.listSalesManagement", map);
	}
	//매출액
	public List<Product> totalProductSales(String artisanId) {
		return tap.selectList("artisanManagementMapper.totalProductSales",artisanId);
	}
	//수수료 공제 금액
	public List<Object> deductProductSales(String artisanId) {
		// TODO Auto-generated method stub
		return tap.selectList("artisanManagementMapper.deductProductSales",artisanId);
	}
	//총 합계 (총 매출)
	public List<Object> grossProductSalse(String artisanId) {
		// TODO Auto-generated method stub
		return tap.selectList("artisanManagementMapper.grossProductSalse",artisanId);
	}
	


}
