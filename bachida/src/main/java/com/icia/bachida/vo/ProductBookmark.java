package com.icia.bachida.vo;

import lombok.*;


/* 
 * 상품즐겨찾기
 * 고민(다중조인으로 즐겨찾기내역에서 상품사진이랑 상품정보를 가져와야하나
 * 아님 따로따로 dao만들어서 읽어들여야 하나
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductBookmark {
	private int productBookMarkIdx;
	private String id;
	private int productIdx;
}
