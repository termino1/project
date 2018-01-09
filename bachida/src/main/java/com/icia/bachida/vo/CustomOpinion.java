package com.icia.bachida.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomOpinion {
	private int customOpinionIdx;
	private String content;
	private String originalFileName;
	private String savedFileName;
	private int bidIdx;
	private String id;
	private String writeDate;
}
