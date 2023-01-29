package com.youngtvjobs.ycc.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class AuthDto {
	//권한 DTO
	private String user_id;
	private String auth;
}
