package com.icia.bachida.vo;




import java.util.*;

import lombok.*;


//주문상품
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderProduct {
	private int orderProductIdx;
	private String productName;
	private int quantity;
	private String state;
	private String parcelName;
	private String parcelIdx;
	private String orderName;
	private String orderTel;
	private String orderEmail;
	private String address;
	private int price;
	private int ordersIdx;
	private int productIdx;
	private String artisanId;
	private String orderDate;
	private boolean commentCheck;
	private List<OrderOption> options;
}
