package com.icia.bachida.vo;

import lombok.*;


//1:1제작요청의견조율
@Data
@AllArgsConstructor
@NoArgsConstructor
public class PcustomOpinion {
	private int pcustomOpinionIdx;
	private String content;
	private String originalFileName;
	private String savedFileName;
	private int pcustomIdx;
	private String id;
	private String writeDate;
}
