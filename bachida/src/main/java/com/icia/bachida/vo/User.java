package com.icia.bachida.vo;

import java.util.*;

import lombok.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
	private String id;
	private String name;
	private String email;
	private String tel;
	private String password;
	private String birthDate;
	private boolean enable;
	private String joinDate;
	private int warningCnt;
	private int cash;
	private List<Authority> authorities;
	private List<Interest> interests;
}
