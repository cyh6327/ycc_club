package com.youngtvjobs.ycc.member.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.youngtvjobs.ycc.member.MemberDto;
import com.youngtvjobs.ycc.member.MemberService;

import lombok.Setter;

//유저의 로그인 서비스로 구현
public class CustomUserDetailsService implements UserDetailsService {
	// UserDetailsService는 사용자가 입력한 user_id로 loadUserByUsername 메소드 호출 
	@Setter(onMethod_= {@Autowired})
	private MemberService service;
	
	@Override
	// DB에 있는 사용자의 정보를 UserDetails타입으로 가져옴 
	// 입력된 정보와 DB에 저장되어있는 정보를 비교, 두 개의 정보가 다르다면 UsernameNotFoundException을 통해 예외처리 
	public UserDetails loadUserByUsername(String user_id) throws UsernameNotFoundException {
		
		    
	    MemberDto dto = null;
		try {
			dto = service.read(user_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		// null이 아니면 CustomUser를 반환
		return dto == null ? null : new CustomUser(dto);

	}

}
