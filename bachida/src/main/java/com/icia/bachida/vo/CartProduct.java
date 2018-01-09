package com.icia.bachida.vo;

import java.util.*;

import lombok.*;

@Data@AllArgsConstructor
@NoArgsConstructor
public class CartProduct {
	private Integer cartProductIdx;
	private Integer price;
	private Integer quantity;
	private Integer productIdx;
	private Integer cartIdx;
	private List<CartOption> cartOptions;
}
