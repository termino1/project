package com.icia.bachida.vo;

import java.sql.*;

import lombok.*;

//작가타임라인
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ArtisanTimeline {
	private int artisanTimelineIdx;
	private String content;
	private int recommend;
	private Date writeDate;
	private String originalFileName;
	private String savedFileName;
	private String artisanId;
}
