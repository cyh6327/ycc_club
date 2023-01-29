package com.youngtvjobs.ycc.member;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.util.WebUtils;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class LoginController {
	public LoginController() {
		// TODO Auto-generated constructor stub
	}

	
	@Autowired
	MemberDao memberDao;

	@Autowired(required=false)
	MemberDto user;
	
	
	@GetMapping("/login")
	public String login(HttpServletRequest request) {
		
		// Referer 헤더값을 통해 이전 페이지에 대한 정보를 가져옴 
		String referer = request.getHeader("Referer");
		// 이전페이지에 대한 정보가 있다면 세션에 prevPage로 저장 
		if(referer != null && !referer.contains("/login")) {
			request.getSession().setAttribute("prevPage", referer);
		}
		return "member/loginForm";
	}
	
	
	@PostMapping("/login")
	public String login(String id, String pw, String toURL, boolean save_id, boolean autoLogin,
			HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		//user 객체에 id로 조회해서 나온 DB 튜플을 저장
		user = memberDao.loginSelect(id);
		
		//세션 객체 생성
		HttpSession session = request.getSession();
		
		//세션에 필요한 데이터 저장
		session.setAttribute("id", id);
		session.setAttribute("name", user.getUser_name());
		session.setAttribute("grade", user.getUser_grade());
		//세선 속 데이터 체크 로깅
		System.out.println("아이디 : " + session.getAttribute("id"));
		System.out.println("이름 : " + session.getAttribute("name"));
		System.out.println("회원등급 : " + session.getAttribute("grade"));

		// 아이디 저장 체크박스
		// True: 아이디가 저장된 쿠키 생성 후 response객체에 쿠키저장
		if (save_id) {
			Cookie cookie = new Cookie("id", id);
			response.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("id", id);
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		toURL = toURL == null || toURL.equals("") ? "/" : toURL;
		return "redirect:" + toURL;
	}
	
	/*
	 * Spring Security 적용하면서 로그아웃 기능은 컨트롤러를 거치지 않음.
	 * security-context 의 security:logout 속성 참조.
	 * 
	@GetMapping("/logout")
	public String getLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		postLogout(request, response, session);
		return "member/logout";
	}
	
	@PostMapping("/logout")
	public String postLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		return "redirect:/";
	}
	*/
}

