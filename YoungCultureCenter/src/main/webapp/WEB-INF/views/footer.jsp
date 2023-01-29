<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!-- footer 시작 -->

		<!-- 상단 이동하기 버튼 -->
		<script>
		$(document).ready(function(){
			$(function() {
		        $("#btn_gotop").click(function() {
		            $('html, body').animate({
		                scrollTop : 0
		            }, 400);
		            return false;
		        });
		    });
		});
		</script>
	

<div class="bg-light mt-5 border-top border-1">
	<div class="container">
		<a href="#" id="btn_gotop" >
			<img class="position-absolute" src="/ycc/resources/img/top-button.png" style="width:80px;height:80px;right:10%">
		</a>
		<footer	class="d-flex flex-wrap justify-content-between align-items-center my-1">
			<p class="col-md-4 mb-0 text-muted">
				<img class="img-fluid" src="/ycc/resources/img/main_img/logo.png" style="width: 100px; height: 100px;"><br> 
		<!-- <div style="position:fixed; bottom:150px; right:150px; z-index:99;"> -->
			
		<!-- </div> -->
				서울특별시 서초구 서초4 서초대로77길<br> Tel : 02-123-1234 / Fax : 02-123-1235<br>
				사업자등록번호 : 123-80-12345<br> 
				김영채 최나리 전수정 김성호 최선혜 김지호 최연희<br><br>
			 	&copy; YOUNG’teve Jobs All rights reserved
			</p>
			<a href="/" class="col-md-4 d-flex align-items-center justify-content-center mb-3 mb-md-0 me-md-auto link-dark text-decoration-none">
				스크롤하는 이미지 구현 부 <svg class="bi me-2" width="40" height="32"><use xlink:href="#bootstrap" /></svg></a>
			<ul class="nav col-md-4 justify-content-end">
				<li class="nav-item"><a href="/ycc" class="nav-link px-2 text-muted">Home</a></li>
				<li class="nav-item"><a href="/ycc/board/faq" class="nav-link px-2 text-muted">FAQs</a></li>
				<li class="nav-item"><a href="/ycc/map" class="nav-link px-2 text-muted">Map</a></li>
			</ul>
		</footer>
		
	</div>
</div>

