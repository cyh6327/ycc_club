<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<header>
    <!-- Header 시작 -->
    <nav class="navbar navbar-expand-lg bg-light" aria-label="Fifth navbar example">
        <div class="container-fluid">
            <!-- 로고 이미지, 이름 부분 -->
            <a class="navbar-brand" href="/ycc/"><img src="/ycc/resources/img/main_img/logo.png" class="me-2"
                    alt="Young문화센터로고" style="width: 50px; height: 50px;">
                YOUNG문화센터</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarsExample05" aria-controls="navbarsExample05" aria-expanded="false"
                aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- 반응형 햄버거 버튼 시작 -->
            <div class="collapse navbar-collapse" id="navbarsExample05">
                <!-- 드롭다운 메뉴 시작 -->
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">시설안내</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/ycc/map">오시는 길</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">교육강좌</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/ycc/course/courseinfo">수강 신청 안내</a></li>
                            <li><a class="dropdown-item" href="/ycc/course/search">수강 신청</a></li>
                            <li><a class="dropdown-item" href="/ycc/course/schedule">수강 캘린더</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">시설예약</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/ycc/rental/place">대관신청</a></li>
                            <li><a class="dropdown-item" href="/ycc/rental/studyroom">독서실예약</a></li>
                            <li><a class="dropdown-item" href="/ycc/rental/locker">사물함신청</a></li>
                        </ul>
                    </li>
                    <!-- <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">커뮤니티</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/ycc/club">동아리</a></li>
                        </ul>
                    </li> -->
                    <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">이용안내</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/ycc/board/notice">공지사항</a></li>
                            <li><a class="dropdown-item" href="/ycc/board/event">이벤트/행사</a></li>
                            <li><a class="dropdown-item" href="/ycc/board/faq">자주하는 질문</a></li>
                        </ul>
                    </li>
                </ul>
                <!-- 검색버튼 부분 -->
                <form class="me-2" role="search" action="/ycc/search/">
                    <input name= "keyword" value="${param.keyword }" class="form-control"  type="search" placeholder="검색어를 입력하세요." aria-label="Search">
                </form>

               <!-- Spring 시큐리티 객체 생성 -->
               <sec:authentication property="principal" var="pinfo"/>
               <!-- 익명의 사용자의 경우, 로그인 하지 않은 경우 해당 -->
                <sec:authorize access="isAnonymous()">
	                <div class="nav p-2 d-flex" style="justify-content: center; flex-wrap: nowrap;">
	                    <a class="btn btn-primary mx-2 text-nowrap" href="/ycc/login">로그인</a>
	                    <a class="btn btn-outline-primary text-nowrap" href="/ycc/signup/agree">회원가입</a>
	                </div>
                </sec:authorize>


               <!-- 시큐리티 : 사용자 인증되었을때 보여주기  -->
               <sec:authorize access="isAuthenticated()">
                <div class="navbar-nav d-flex" style="justify-content: center; flex-wrap: nowrap;">
                	<script type="text/javascript" charset="utf-8" src="/ycc/resources/js/timeoutchk.js"></script>
                	<button class="btn btn-outline-success btn-sm me-2 hover-timer" style="white-space: nowrap;" onclick="javascript:refreshTimer()"><span id="timer"></span><p class="mb-0"></p></button>
                	<div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        ${pinfo.member.user_name} 님!</button>
                    <ul class="dropdown-menu dropdown-menu-lg-end">
                        <li><button class="dropdown-item" type="button"
                                onclick="location.href='/ycc/mypage/pwcheck'">마이페이지</button></li>
                        <li><button class="dropdown-item" type="button" onclick="location.href='/ycc/mypage/mycourse'">나의 수강목록</button></li>
                        <li><button class="dropdown-item" type="button" onclick="location.href='/ycc/mypage/inquiry'">나의 문의내역</button></li>
			
                        <!-- 관리자 일떄 접근 가능한 관리자 페이지 버튼 -->
                        <c:if test="${pinfo.member.user_grade eq '관리자'}">
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><button class="dropdown-item" type="button"
                                    onclick="location.href='/ycc/admin'">관리자 페이지</button></li>
                        </c:if>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                        <sec:authorize access="isAuthenticated()">
                        	<form action="/ycc/logout"  method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        		<button class="dropdown-item dropdown-item-danger" type="submit">로그아웃</button>
                            </form>
                        </sec:authorize>
                        </li>
                    </ul>
                </div>
                </div>
               </sec:authorize>
                
            </div>
            <!-- 반응형 햄버거버튼 종료 -->
        </div>
    </nav>
</header>