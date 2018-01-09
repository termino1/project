package com.icia.bachida.vo;

import lombok.*;


// 신고
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Report {
	private int reportIdx;
	private String reportId;
	private String reportContent;
	private String reportState;
	private String writeDate;
	private String savedFileName;
	private String originalFileName;
	private String id;
}
