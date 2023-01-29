package com.youngtvjobs.ycc.member.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.youngtvjobs.ycc.member.MemberDto;

import lombok.Getter;

@Getter
// User는 스프링 시큐리티에서 제공하는 UserDetails을 상속하는 클래스 
public class CustomUser extends User{

	private static final  long serialVersionUID = 1L;
	
	private MemberDto member;
	
	// GrantedAuthority : 회원에 대한 권한 객체 구현 
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser (MemberDto dto) {
		super(dto.getUser_id(), dto.getUser_pw(), 
				dto.getAuthList().stream().map(auth -> new SimpleGrantedAuthority(auth.getAuth())).
				collect(Collectors.toList()));
		this.member = dto;
		
	}

}
