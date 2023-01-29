<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp" %>
	<title>Young문화센터 - 로그인</title>
  <style>
    @media(max-width: 767px) { #left_login { border-right: hidden !important; } }
    @media(min-width: 767px) { #d-none { display: none !important; } }
    #msg { font-size: 16px; color: red; }
  </style>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
    <meta name="google-signin-client_id" content="879383765948-nosm8poi9168kc4nj2snn6at14otnp1c.apps.googleusercontent.com">
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp" %>

	<!-- login 시작 -->
	<div class="container mt-5">
		<h1>로그인</h1>
		<hr>
		<div class="row">
			<div class="col-md-6" id="left_login" style="border-right: solid 1px rgba(0, 0, 0, .25);">
				<form action="/ycc/login" method="post" class="w-75 mx-auto" onsubmit="return formCheck(this)">
					<div id="msg" class="row mb-2 text-center">
							<p style="color:red; font-weight:bold;">${requestScope.loginFailMsg}</p>
					</div>
					<div class="row mb-2">
						<label for="inputEmail3" class="col-sm-3 col-form-label">아이디</label>
						<div class="col-sm-9  align-self-center">
							<input type="text" class="form-control" name="username" value="${cookie.id.value }" placeholder="아이디를 입력해주세요." autofocus required>
						</div>
					</div>
					<div class="row mb-2">
						<label for="inputPassword3" class="col-sm-3 col-form-label">비밀번호</label>
						<div class="col-sm-9 align-self-center">
							<input type="password" class="form-control" name="password" placeholder="비밀번호를 입력해주세요." required>
						</div>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<input type="hidden" name="toURL" value="${param.toURL}" />
					<fieldset class="row mb-2">
						<div>
							<div class="form-check-inline">
								<input class="form-check-input" type="checkbox" name="save_id" id="saveId" value="on" ${empty cookie.id.value ? "" : "checked" } />
								<label class="form-check-label" for="saveId">아이디 저장</label>
							</div>
							<div class="form-check-inline">
								<input class="form-check-input" type="checkbox" name="remember-me" >자동로그인
								
							</div>
							<button type="submit" class="btn btn-primary btn-sm float-end">로그인</button>
						</div>
					</fieldset>
					<hr>
					<div class="mx-auto" id="bottom-login">
						<div><span>아이디/비밀번호를 잊으셨나요?</span><a href="/ycc/mypage/forget">아이디/비밀번호 찾기</a></div>
						<div><span>회원가입을 안하셨나요?</span><a href="/ycc/signup/agree">회원가입</a></div>
					</div>
					<hr id="d-none">
				</form>
			</div>
			<div class="col-md-6 align-self-center">
				<div class="w-75 mx-auto">
					<h3>SNS계정으로 로그인</h3>
					<div class="d-grid gap-3">
<!-- 						<div id="googleLoginBtn" class="g-signin2" data-onsuccess="onSignin">구글로그인</div> -->
<!-- 						<div class="google"> -->
<!-- 							<button type="button" onclick="location.href='/ycc/login/google'"> <i class="fa fa-google" aria-hidden="true"></i> -->
<!-- 								구글 로그인</button> -->
<!-- 						</div> -->
						<a href="/login/google" class="btn btn-danger btn-lg">구글계정으로 로그인</a>
						<a href="/login/naver" class="btn btn-success btn-lg">네이버계정으로 로그인</a>
						<a href="/login/kakao" class="btn btn-warning btn-lg">카카오계정으로 로그인</a>
					</div>
				</div>
			</div>
		</div>
		<hr>
	</div>
	<script>
		const onClickGoogleLogin = (e) => {
	    	//구글 인증 서버로 인증코드 발급 요청
	 		window.location.replace("https://accounts.google.com/o/oauth2/v2/auth?
	        client_id=879383765948-nosm8poi9168kc4nj2snn6at14otnp1c.apps.googleusercontent.com
	        &redirect_uri=http://localhost:8080/ycc/login/oauth2callback
	        &response_type=code
	        &scope=email%20profile%20openid
	        &access_type=offline")
	 	}
		
		const googleLoginBtn = document.getElementById("googleLoginBtn");
		googleLoginBtn.addEventListener("click", onClickGoogleLogin);
	</script>
	<script src="https://apis.google.com/js/platform.js" async defer></script>
	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp"%>
	
</body>
</html>