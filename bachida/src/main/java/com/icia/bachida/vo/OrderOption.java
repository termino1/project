package com.icia.bachida.vo;

import lombok.*;


//주문옵션
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderOption {
	private int orderProductIdx;
	private String optionContent;
	private int cost;
	private int optionQuantity;
}
