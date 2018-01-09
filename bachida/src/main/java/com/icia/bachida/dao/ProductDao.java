package com.icia.bachida.dao;

import java.util.*;

import org.mybatis.spring.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;

import com.icia.bachida.vo.*;

import oracle.net.nt.*;

@Repository
public class ProductDao {

	@Autowired
	private SqlSessionTemplate product_tpl;
	
	//시퀀스 mapper 00
	public int getProductIdxSeq(Product product) {
		return product_tpl.selectOne("productMapper.getProductIdxSeq",product);
	}
	
	// 등록 작품 cnt 01
	public int getProductCnt(String artisanId ) {
		return product_tpl.selectOne("productMapper.getProductCnt",artisanId);
	}

	// 등록 상품 list 02
	public List<Product> listArtisanProductSalse(int startArticleNum, int endArticleNum, String artisanId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startArticleNum", startArticleNum);
		map.put("endArticleNum", endArticleNum);
		map.put("artisanId", artisanId);
		return product_tpl.selectList("productMapper.listArtisanProductSalse", map);
	}

	// 작품 등록 03
	public int insertProduct(Product product) {
		return product_tpl.insert("productMapper.insertProduct", product);
	}

	// 작품 수정 04
	public int updateProduct(Product product) {
		return product_tpl.update("productMapper.updateProduct", product);
	}

	// 작품 삭제 05
	public int deleteProduct(int idx) {
		return product_tpl.delete("productMapper.deleteProduct", idx);
	}

	// 작품 리스트 사진파일 삭제 06
	public int deleteProductAttach(int productIdx) {
		return product_tpl.delete("productMapper.deleteProductAttach", productIdx);
	}

	// 파일 불러오기 07
	public String getOriginalFileName(int productIdx, String fileName) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productIdx", productIdx);
		map.put("savedFileName", fileName);
		return product_tpl.selectOne("productMapper.getOriginalFileName", map);
	}

	// 파일 저장 08
	public int insertProductAttach(int productIdx, ProductAttach attach) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("savedFileName", attach.getSavedFileName());
		map.put("originalFileName", attach.getOriginalFileName());
		map.put("productIdx", productIdx);
		return product_tpl.insert("productMapper.insertProductAttach", map);
	}

	
	//옵션 insert 10 
	public int insertOption(int productIdx, Option option) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("optionContent", option.getOptionContent());
		map.put("cost", option.getCost());
		map.put("productIdx", productIdx);
		return product_tpl.insert("productMapper.insertOption", map);
	}

	// 메인 카테고리 list 11
	public List<MainCategory> getMainCategory() {
		return product_tpl.selectList("productMapper.getMainCategory");
	}

	// 메타 카테고리 list 12
	public List<MetaCategory> getMetaCategory() {
		return product_tpl.selectList("productMapper.getMetaCategory");
	}
	//상품 수정페이지용 view
	public Product viewProduct(int productIdx) {
		return product_tpl.selectOne("productMapper.viewProduct",productIdx);
	}
	//조회수
	public int increaseViewProductCnt(int productIdx) {
		return product_tpl.update("productMapper.increaseViewProductCnt",productIdx);
	}
	//옵션 삭제
	public int deleteProductOption(int productIdx) {
		return product_tpl.delete("productMapper.deleteProductOption", productIdx);
	}
	

}
