<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp"%>
	
	<style>
		@media ( max-width :429px) { #w-28 { width: 28%; } #d-col { display: none; } }
	</style>
	
	<title>Insert title here</title>
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<!-- body -->
	<div class="container mt-5">
		<h2>통합결제페이지</h2>
		<hr>
		<div class="row">
			<div class="col-md-12 mt-3">
				<c:if test="${param.course_id != null }">
					<h5>| 강의결제</h5>
					<table class="table table-bordered text-center">
						<thead class="bg-light align-middle">
							<th>강좌명</th>
							<th width="20%" id="d-col">수강자명</th>
							<th width="20%" id="d-col">요일</th>
							<th width="20%" id="w-28">결제금액(원)</th>
						</thead>
						<tbody>
							<tr>
								<td>초코칩 쿠키 만들기</td>
								<td id="d-col">최선혜</td>
								<td id="d-col">월, 수, 금</td>
								<td>50000</td>
							</tr>
						</tbody>
					</table>
				</c:if>
				
				<c:if test="${param != null }">
					<h5>| 대관결제</h5>
					<table class="table table-bordered text-center">
						<thead class="bg-light align-middle">
							<th>대관장소</th>
							<th width="20%" id="d-col">이용자명</th>
							<th width="20%" id="d-col">요일/시간</th>
							<th width="20%" id="w-28">결제금액(원)</th>
						</thead>
						<tbody>
							<tr>
								<td>강당</td>
								<td id="d-col">김지호</td>
								<td id="d-col">월/8:00~10:10</td>
								<td>20000</td>
							</tr>
						</tbody>
					</table>
				</c:if>
				
				<c:if test="${param != null }">
					<h5>| 독서실/사물함 결제</h5>
					<table class="table table-bordered text-center">
						<thead class="bg-light align-middle">
							<th>위치/자리</th>
							<th width="20%" id="d-col">이용자명</th>
							<th width="20%" id="d-col">기간</th>
							<th width="20%" id="w-28">결제금액(원)</th>
						</thead>
						<tbody>
							<tr>
								<td>2층/43번</td>
								<td id="d-col">김지호</td>
								<td id="d-col">11-26~12-02</td>
								<td>7000</td>
							</tr>
						</tbody>
					</table>
				</c:if>
			</div>
			<div class="text-center d-grid d-sm-block gap-1">
				<a href="#" class="btn btn-secondary" type="button">취소</a> 
				<a href="#" class="btn btn-primary" type="button">결제</a>
			</div>
		</div>
	</div>

	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>