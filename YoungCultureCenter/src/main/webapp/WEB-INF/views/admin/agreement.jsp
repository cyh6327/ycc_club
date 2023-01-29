<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>	
	<!-- head & meta tag include -->
	<%@include file="/WEB-INF/views/metahead.jsp"%>
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<style type="text/css">
	
	</style>

	<script type="text/javascript">
		$("#modifyBtn").on("click", function(){
			let form = $("#form")
			form.attr("action", "<c:url value='/admin/agreement${join_terms}' />")
			form.attr("method", "post")
			form.submit()
		})

	</script>
	<title>YOUNG문화체육센터 - 이용약관 설정</title>
</head>

<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<form id="form" action="" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<div class="container text-center mt-5" id="original">
			<h1 class="text-start">이용약관 관리</h1>
			<hr>
			
			<!-- 이용 약관 -->
			<div class="card text-start text-bg-light mb-3" id="card1">
				<div class="card-header" style="display: flex; align-items: center;">
				<h5 class="card-title mb-0">이용약관</h5>
				</div>
				
				<div class="card-body">
					<div class="row mb-3">
						<label for="attached-file1" class="col-sm-2 col-form-label card-subtitle"></label>
						<div class="">
							<textarea class="join_terms" name="join_terms" rows="8" style="width: 100%;">${adminDto.join_terms }</textarea>
						</div>
					</div>
				</div>
			</div>
			
			<!-- 2번 항목 -->
			<div class="card text-start text-bg-light mb-3" id="card1">
				<div class="card-header" style="display: flex; align-items: center;">
				<h5 class="card-title mb-0">개인정보취급방침</h5>
				</div>
				
				<div class="card-body">
					<div class="row mb-3">
						<label for="attached-file1" class="col-sm-2 col-form-label card-subtitle"></label>
						<div class="">
							<textarea class="form-control" name="join_privacy_terms" rows="8" style="width: 100%;">${adminDto.join_privacy_terms }</textarea>
						</div>
					</div>
				</div>
			</div>		
			<!-- 저장/취소 버튼 -->
			<div class="p-2 m-2">
				<button type="submit" id="modifyBtn" class="btn btn-primary" name="action" value="modidfy" style="width: 100px">저장</button>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='/ycc/admin'" style="width: 100px">취소</button>
			</div>
		</div>
	</form>

	<!-- footer 여백 -->
	<div style="height: 150px;"></div>
	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>