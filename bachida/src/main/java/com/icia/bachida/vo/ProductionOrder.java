package com.icia.bachida.vo;

import lombok.*;


//제작주문
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductionOrder {
	private int productionOrderIdx;	// 주문번호
	private int price;				// 가격
	private String address;			// 주소
	private String parcelName;		// 택배이름
	private String parcelIdx;		// 운송장번호
	private String orderDate;		// 주문일자
	private String state;			// 주문상태 (배송, 주문, ...)
	private String orderDivision;	// 주문구분 (제작요청, ..)
	private int quantity;			// 수량
	private String content;			// 내용
	private String id;				// 구매자아이디
	private int bidIdx;				// 입찰번호
	private int pcustomIdx;			// 1:1제작요청번호
	private String artisanId;		// 작가아이디
}
