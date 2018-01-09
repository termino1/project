package com.icia.bachida.vo;

import lombok.*;


// 제재목록
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Restriction {
	private int restrictionIdx;
	private String restrictionContent;
	private String resrtictionDate;
	private String id;
	private int reportIdx;
}
