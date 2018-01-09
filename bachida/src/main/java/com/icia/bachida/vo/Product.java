package com.icia.bachida.vo;

import java.util.*;

import lombok.*;

// 상품 + 옵션 + 저장
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
	private int productIdx;
	private String productName;
	private int productPrice;
	private String productInfo;
	private String recommend;
	private String viewCnt;
	private String writeDate;
	private String artisanId;
	private int metaCategoryIdx;
	private int mainCategoryIdx;
	private String productState;
	private String artisanName;
	private List<Option> options;
	private List<ProductAttach> attach;
}
