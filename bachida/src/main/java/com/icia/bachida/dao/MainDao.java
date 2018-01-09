package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

@Repository
public class MainDao {
	@Autowired
	private SqlSessionTemplate tpl;

	public List<Product> getRecentProductList() {
		return tpl.selectList("mainMapper.getRecentProductList");
	}

	public ProductAttach getProductAttach(int productIdx) {
		return tpl.selectOne("mainMapper.getProductAttach",productIdx);
	}

	public List<Product> getPopularProductList() {
		return tpl.selectList("mainMapper.getPopularProductList");
	}

	public List<Product> getRecommendProductlist(int mainCategoryIdx) {
		return tpl.selectList("mainMapper.getRecommendProductlist",mainCategoryIdx);
	}

	public int getMessageCnt(String id) {
		return tpl.selectOne("mainMapper.getMessageCnt",id);
	}

	public List<Integer> activeBookmark(String id) {
		return tpl.selectList("UproductMapper.activeBookmark",id);
	}

	

}
