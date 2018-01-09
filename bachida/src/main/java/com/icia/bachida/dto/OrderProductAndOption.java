package com.icia.bachida.dto;


import java.util.*;

import com.icia.bachida.vo.*;

import lombok.*;


//주문상품
@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderProductAndOption {
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
	private boolean commentCheck;
	private List<OrderOption> orderOption;
}
