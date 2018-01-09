package com.icia.bachida.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Cart {
	private Integer cartIdx;
	private Integer totalPrice;
	private String id;
}
