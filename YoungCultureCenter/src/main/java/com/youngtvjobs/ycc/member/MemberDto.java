package com.youngtvjobs.ycc.member;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;



@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class MemberDto
{

	private String user_id;
	private String user_name;
	private String user_pw;
	private String user_gender;
	private String birthYear;
	private String birthMonth;
	private String birthDay;
	private Date user_birth_date;
	private String user_email;
	private String user_phone_number;
	private String user_postcode;
	private String user_rNameAddr;
	private String user_detailAddr;
	private Date user_regdate;
	private String user_grade;
	private String user_social_type;
	private List<AuthDto> authList;
	


	
	}	

