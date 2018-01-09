package com.icia.bachida.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Custom {
	private int customIdx;
	private String title;
	private String content;
	private String writeDate;
	private String id;
	private int wishPrice;
	private int quantity;
	private String state;
	private String closingDate;
	private String originalFileName;
	private String savedFileName;
	private int viewCnt;
}
