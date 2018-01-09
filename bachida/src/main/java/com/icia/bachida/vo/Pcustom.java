package com.icia.bachida.vo;

import lombok.*;


//1:1제작요청
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Pcustom {
	private int pcustomIdx;
	private String title;
	private String content;
	private String writeDate;
	private String state;
	private String originalFileName;
	private String savedFileName;
	private String id;
	private String artisanId;
}
