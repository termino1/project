package com.icia.bachida.vo;

import lombok.*;


// 소분류
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MetaCategory {
	private int metaCategoryIdx;
	private String metaCategoryName;
	private int mainCategoryIdx;
}
