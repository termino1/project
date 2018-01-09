package com.icia.bachida.vo;

import lombok.*;


//메세지
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Message {
	private int messageIdx;
	private String sender;
	private String receiver;
	private String sendDate;
	private String messageContent;
	private String confirm;
}
