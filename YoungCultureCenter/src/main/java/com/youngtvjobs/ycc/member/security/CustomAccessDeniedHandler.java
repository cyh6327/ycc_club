package com.youngtvjobs.ycc.member.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

@Log4j
// 접근 제한 핸들러 
// 쿠키나 , 세션에 특정한 작업을 하거나 , HttpServletResponse에 특정한 헤더정보를 추가할경우 상속받아 구현
public class CustomAccessDeniedHandler implements AccessDeniedHandler{

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		
			log.error("Access Denied Handler");
			
			log.error("Redirect...");
			
//			접근 제한이 걸리는 경우 리다이렉트 하는 방식으로 동작
			response.sendRedirect("/ycc/error/403");
	}
	
}
