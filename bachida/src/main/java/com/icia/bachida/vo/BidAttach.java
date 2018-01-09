package com.icia.bachida.vo;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BidAttach {
	private int bidIdx;
	private String originalFileName;
	private String savedFileName;
}
