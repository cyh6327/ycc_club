<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp" %>
	<title>수강목록</title>
    <style>@media(max-width:768px){ #d-col { display: none; } #w-40 { width: 40%; } #w-17 { width: 17%; } }</style>	
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp" %>

	<!-- body -->
	<div class="container mt-5">
		<h2>수강목록</h2>
		<hr>
		<table class="table table-bordered text-center align-middle">
				<thead class="bg-light">
					<th class="col">강좌명</th>
					<th class="col" id="d-col">강사명</th>
					<th class="col" id="w-40">기간</th>
					<th class="col" id="d-col">결제금액(원)</th>
					<th class="col" id="w-17">상태</th>
					<th class="col" id="w-17">후기</th>
				</thead>
				<c:forEach var ="CourseDto" items = "${courseList }">
					<tr>
						<td><a href="/ycc/course/detail?page=1&pageSize=10&cate=&target=&stat=&keyword=&orderby=&course_id=${CourseDto.course_id}">${CourseDto.course_nm}</a></td>
						<td id="d-col">${CourseDto.user_name}</td>
						<td>${CourseDto.course_sd()}~${CourseDto.course_ed()}</td>
						<td id="d-col">${CourseDto.course_cost}</td>
						<td>${CourseDto.reg_stat()}</td>
						<td>
							<c:if test="${CourseDto.reg_stat() eq '수강완료'}">
								<a href="/ycc/course/detail?page=1&pageSize=10&cate=&target=&stat=&keyword=&orderby=&course_id=${CourseDto.course_id}#tabReview" >후기 작성</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
		</table>
		<div class="d-grid gap-1 d-sm-block text-center">
			<a href="/ycc" class="btn btn-primary">홈으로</a>
			<a href="/ycc/course/search" class="btn btn-primary">다른강좌보기</a>
		</div>
	</div>

	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>