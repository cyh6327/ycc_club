<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp" %>
	<title>회원탈퇴완료</title>
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp" %>

	<!-- body -->
	<div class="container mt-5">
		<h2>회원탈퇴완료페이지</h2>
		<hr>
		<div class="row text-center">
			<div class="col-md-12">
				<img class="img-fluid" src="/ycc/resources/img/main_img/logo.png" alt="회원탈퇴완료아이콘">
			</div>
			<div class="col-md-12 bg-light pt-4 pb-1">
				<h3>회원탈퇴가 완료되었습니다.</h3>
				<hr>
				<p>영문화센터를 이용해주시고 사랑해주셔서 감사합니다.<br>더욱더 노력하고 발전하는 영문화센터가 되겠습니다.</p>
			</div>
		</div>
		<div class="d-grid d-sm-block text-center mt-3">
			<a class="btn btn-primary" href="/ycc" role="button">확인</a>
		</div>
	</div>

	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>