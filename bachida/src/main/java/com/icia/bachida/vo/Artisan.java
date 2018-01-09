package com.icia.bachida.vo;

import lombok.*;


// 작가
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Artisan {
	private String artisanId;
	private String artisanName;
	private String artisanIntro;
	private String artisanPolicy;
	private String originalFileName;
	private String savedFileName;
	private String artisanTel;
	private String artisanEmail;
}
