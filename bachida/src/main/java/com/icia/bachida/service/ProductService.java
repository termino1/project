package com.icia.bachida.service;

import java.io.*;
import java.util.*;

import javax.annotation.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.*;
import org.springframework.util.*;
import org.springframework.web.multipart.*;

import com.google.gson.*;
import com.icia.bachida.dao.*;
import com.icia.bachida.util.*;
import com.icia.bachida.vo.*;

import lombok.*;
@Service
public class ProductService {
	@Autowired private ProductDao productDao;
	@Autowired private UserDao userDao;
	@Autowired private Gson gson;
	@Getter	private String metaCategoryName;	//소분류
	@Getter private String mainCategoryName;	//대분류
	@Value("\\\\192.168.0.210\\upload")
	private String uploadPath;
	
	//카테고리 
	@PostConstruct
	public void init() {
		gson = new Gson();
		metaCategoryName = gson.toJson(productDao.getMetaCategory());
		mainCategoryName = gson.toJson(productDao.getMainCategory());
	}
	
	//리스트 & 페이징
	public Map<String, Object> listArtisanProductSalse(int pageno, String artisanId,Product product) {
		int productCnt = productDao.getProductCnt(artisanId);
		System.out.println("서비스단 상품 리스트:"+product);
		Pagination pagination = PagingUtil.setPageMaker(pageno, productCnt);
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println(map+"am");
		map.put("pagination", pagination);
		map.put("productList", productDao.listArtisanProductSalse(pagination.getStartArticleNum(),pagination.getEndArticleNum(),artisanId));
		//map.put("productOption", productDao.listProductOption(product,artisanId));
		return map;
	}
	
	//작품 등록
	public boolean insertProduct(Product product, MultipartFile[] files) throws IOException {
		List<Option> list = product.getOptions();
		int productIdx = productDao.getProductIdxSeq(product);
		product.setProductIdx(productIdx);
		
		productDao.insertProduct(product);
		System.out.println("실행====");
		
		if(files!=null) {
			//파일이 들어가지 않는다면 if문 실행
			for(MultipartFile file:files) {
				if(file.getOriginalFilename().equals(""))
					break;
				String savedFileName = System.currentTimeMillis() + "-" + file.getOriginalFilename();
				ProductAttach attach = new ProductAttach();
				attach.setOriginalFileName(file.getOriginalFilename());
				attach.setSavedFileName(savedFileName);
				File f = new File(uploadPath, savedFileName);
				FileCopyUtils.copy(file.getBytes(), f);
				//파일 업로드(view)
				productDao.insertProductAttach(productIdx,attach);
			}
		}
		
		if(list!=null) {
			//옵션이 들어가지 않는다면 if문 실행
			for(Option option: list) {
				if(list.size()!=0)
					productDao.insertOption(productIdx, option);
			}
		}
		
		return true;
	}
	
	//작품 수정, 매진처리(상태변경)
	public Boolean updateProduct(Product product) {
		System.out.println("serviceProduct"+product);
		return productDao.updateProduct(product)==1? true : false;
	}
	
	//작품,작품 옵션, 작품사진 삭제
	public boolean deleteProduct(List<Integer> checkbox) {
		boolean result = false;
		for(Integer idx:checkbox) {
			int delp = productDao.deleteProduct(idx);
			int dela = productDao.deleteProductAttach(idx);
			int delpo = productDao.deleteProductOption(idx);
			System.out.println("\n상품삭제:"+delp+"\n저장삭제:"+dela+"\n옵션삭제:"+delpo);
			if(delp !=0) {
				System.out.println(idx+"servicePart");
				if(dela!=0) {
					System.out.println(idx+"사진??");
					if(delpo!=0) {
						System.out.println("옵션삭제~:"+idx);
					}else {
						result = false;
					}
				}else {
					result = false;
				}
				result = true;
			}else {
				result = false;
				break;
			}
		}
		return result;
		/*for(Integer idx:checkbox) {
			if(productDao.deleteProduct(idx)==1) {
				System.out.println(idx+"servicePart");
				if(productDao.deleteProductAttach(idx)==1) {
					System.out.println(idx+"사진??");
					if(productDao.deleteProductOption(idx)==1) {
						System.out.println("옵션삭제~:"+idx);
					}else {
						result = false;
					}
				}else {
					result = false;
				}
				result = true;
			}else {
				result = false;
				break;
			}
		}
		return result;*/
	}

	//저장파일 
	public String getOriginalFileName(int productIdx, String fileName) {
		return productDao.getOriginalFileName(productIdx,fileName);
	}
	//viewPage
	public Map<String,Object> viewProduct(int productIdx) {
		Product product = productDao.viewProduct(productIdx);	//글보기
		productDao.increaseViewProductCnt(productIdx);			//조회수
		//옵션 불러오기
		List<Option> optionList = product.getOptions();
		List<ProductAttach> fileName = product.getAttach();
		//map에 상품 옵션 파일 카테고리를 담아 이름 추출
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("product", product);
		map.put("attachList", fileName);
		map.put("optionList", optionList);
		map.put("mainCategoryName", mainCategoryName);
		map.put("metaCategoryName", metaCategoryName);
		
		return map;
	}


}
