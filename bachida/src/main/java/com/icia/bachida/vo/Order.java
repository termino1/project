package com.icia.bachida.vo;

import lombok.*;


//주문
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
	private int ordersIdx;
	private String id;
	private int totalPrice;
	private String address;
	private String orderDate;
	private int orderQuantity;
}
