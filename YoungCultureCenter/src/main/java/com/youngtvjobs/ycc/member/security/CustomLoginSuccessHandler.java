/*
 * 작성자 : 최선혜
 * 최초 작성일 : '22. 12. 20
 * 마지막 업데이트 : '23.01.07
 * 업데이트 내용 : change logic & code clean up
 * 기능 : 로그인 성공 후 이전페이지 redirect 구현 
 */
package com.youngtvjobs.ycc.member.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.log4j.Log4j;

@Log4j
// 로그인 성공 핸들러 
public class CustomLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler
		implements AuthenticationSuccessHandler {

	/*
	 * requestCache : 사용자의 이전 정보를 가져오는 캐시 매커니즘 
	 * RedirectStrategy : security에서 화면 이동에 대한 규칙을 정의하는 인터페이스
	 */
	private final RequestCache requestCache = new HttpSessionRequestCache();
	private final RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response
			, Authentication auth) throws IOException, ServletException {

		/*	
		 *  사용자가 접근 권한이 없는 페이지 요청 후 로그인 페이지로 이동시 
		 *   → savedRequest : 사용자가 요청했던 request parameter, header 값을 저장
		 */
		SavedRequest savedRequest = requestCache.getRequest(request, response);
			System.out.println("리퀘스트" + requestCache); // requestCache 확인 출력 문구
			System.out.println("세이브" + savedRequest); // saveRequest 확인 출력 문구

		/* 	
		 * 	로그인 버튼을 직접 누르고 로그인 페이지로 이동 시 
		 *   → 세션에 이전페이지 정보가 저장된 prevPage를 prev로 설정
		 */
		String prev = (String) request.getSession().getAttribute("prevPage");

		String uri = "/";

		// savedRequest의 존재여부에 따라 redirect 할 uri를 결정
		if (savedRequest != null) {
			uri = savedRequest.getRedirectUrl();
		  // 회원가입, 아이디/비밀번호 찾기가 이전페이지(prev)일 때는 main으로 이동 
		} else if (prev != null) {
			if (prev.contains("/signup/form") || prev.contains("/mypage/forget")) {
				uri = "/";
			} else {

				uri = prev;
			}

		}
		
		redirectStrategy.sendRedirect(request, response, uri);

	}

}
