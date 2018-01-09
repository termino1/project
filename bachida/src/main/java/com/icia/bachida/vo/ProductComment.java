package com.icia.bachida.vo;

import lombok.*;


//상품평
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductComment {
	private int productCommentIdx;
	private int productIdx;
	private String content;
	private String savedFileName;
	private String originalFileName;
	private String id;
	private String writeDate;
}
