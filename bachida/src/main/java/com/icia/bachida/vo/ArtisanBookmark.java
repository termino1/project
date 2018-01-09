package com.icia.bachida.vo;

import lombok.*;


// 작가즐겨찾기테이블요소
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArtisanBookmark {
	private int artisanBookmarkIdx;
	private String id;
	private String artisanId;
}
