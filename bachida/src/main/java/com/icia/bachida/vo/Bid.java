package com.icia.bachida.vo;


import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Bid {
	public int bidIdx;
	public String content;
	private int price;
	private String state;
	private int customIdx;
	private String artisanId;
	private String writeDate;
}
