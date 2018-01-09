package com.icia.bachida.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Pagination {
	private int pageno;
	private int startArticleNum;
	private int endArticleNum;
	private int startPage;
	private int endPage;
	private int prev;
	private int next;
}
