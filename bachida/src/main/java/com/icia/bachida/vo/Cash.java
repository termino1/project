package com.icia.bachida.vo;

import lombok.*;


//캐쉬내역
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cash {
	private int cashIdx;
	private String content;
	private int updateCash;
	private String updateDate;
	private String id;
}
