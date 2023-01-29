<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>	
	<!-- head & meta tag include -->
	<%@include file="/WEB-INF/views/metahead.jsp"%>
  
	<style>
	.turquoise { background: #1abc9c; }
	.emerland { background: #2ecc71; }
	.peterriver { background: #3498db; }
	.amethyst { background: #9b59b6; }
	.wetasphalt { background: #34495e; }
	.greensea { background: #16a085; }
	.nephritis { background: #27ae60; }
	.belizehole { background: #2980b9; }
	.wisteria { background: #8e44ad; }
	.midnightblue { background: #2c3e50; }
	.sunflower { background: #f1c40f; }
	.carrot { background: #e67e22; }
	.alizarin { background: #e74c3c; }
	.clouds { background: #ecf0f1; color: #999; }
	.concrete { background: #95a5a6; }
	.orange { background: #f39c12; }
	.pumpkin { background: #d35400; }
	.pomegranate { background: #c0392b; }
	.silver { background: #bdc3c7; }
	.asbestos { background: #7f8c8d; }
	
	.flat-menu
	{
		float: left;
		color: #fff;
		position: relative;
		transition: opacity 0.5s ease;
		height: 100px;
	}
	
	.flat-menu:hover
	{
		opacity: 0.6;
	}
	</style>
  
	<title>YOUNG문화체육센터 - 관리자 페이지</title>
</head>

<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<div class="container text-center mt-5">
		<h1 class="text-start">관리자 페이지</h1>
		<hr>
		<div class="row m-1 h-25">
			<div class="col-md-3 mb-3">
				<button type="button" class="flat-menu border border-0 w-100 belizehole fs-5" onclick="location.href='/ycc/admin/profile'">홈페이지 관리</button>
			</div>
			<div class="col-md-3 mb-3">
				<button type="button"  class="flat-menu border border-0 w-100 orange fs-5" onclick="location.href='/ycc/admin'">회원 관리</button>
			</div>
			<div class="col-md-3 mb-3">
				<button type="button"  class="flat-menu border border-0 w-100 greensea fs-5" onclick="location.href='/ycc/admin/popup'">공지사항 관리</button>
			</div>
			<div class="col-md-3 mb-3">
				<button type="button"  class="flat-menu border border-0 w-100 wisteria fs-5" onclick="location.href='/ycc/admin/club'">동아리 관리</button>
			</div>
			<div class="col-md-3 mb-3">
				<button type="button"  class="flat-menu border border-0 w-100 peterriver fs-5" onclick="location.href='/ycc/admin/agreement'">이용약관 관리</button>
			</div>
			<div class="col-md-3 mb-3">
				<button type="button"  class="flat-menu border border-0 w-100 turquoise fs-5" onclick="location.href='/ycc/admin'">대관신청 관리</button>
			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		let msg = "${msg}"
		if(msg == "UPDATE_FAIL") alert("수정 실패")
		if(msg == "UPDATE_SUCCESS") alert("수정 성공")		
	</script>
	
	
	<!-- footer 여백 -->
	<div style="height: 150px;"></div>
	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>