package com.boot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
	private int user_no;
	private String user_id;
	private String user_password;
	private String user_name;
	private String user_email;
	private String user_province;
	private String user_city;
}