package com.icia.bachida.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CartOption {
	private String optionContent;
	private Integer cost;
	private Integer optionQuantity;
}
