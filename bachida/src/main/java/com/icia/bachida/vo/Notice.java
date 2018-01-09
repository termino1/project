package com.icia.bachida.vo;

import lombok.*;


// 공지사항
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice {
	private int noticeIdx;
	private String title;
	private String content;
	private String savedFileName;
	private String originalFileName;
	private int viewCnt;
	private String writeDate;
}
