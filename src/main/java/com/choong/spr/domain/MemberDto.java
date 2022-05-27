package com.choong.spr.domain;

import java.time.LocalDateTime;

import lombok.Data;



@Data
public class MemberDto {
	private String id;
	private String password;
	private String email;
	private String nickName;
	private LocalDateTime inserted;
}
