package com.icia.bachida.vo;

import java.util.*;

import lombok.*;


// 작가신청테이블요소 + 저장
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArtisanApply {
	private int artisanApplyIdx;
	private String artisanTel;
	private String artisanEmail;
	private String artisanIntro;
	private String craftIntro;
	private String state;
	private String id;
	private String applyDate;
	private List<ApplyAttach> attach;
}
