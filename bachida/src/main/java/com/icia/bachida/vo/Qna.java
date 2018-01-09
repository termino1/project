package com.icia.bachida.vo;

import lombok.*;


// 문의답변
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Qna {
	private int qnaIdx;
	private String title;
	private String content;
	private boolean qnaAnswerCheck;
	private String id;
	private String writeDate;
	private boolean qnaSecret;
	private String answerContent;
}
