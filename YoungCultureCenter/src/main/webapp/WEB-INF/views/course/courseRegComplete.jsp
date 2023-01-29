<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp" %>
	<title>수강신청완료</title>
	<style>@media ( max-width :429px) { #w-28 { width: 28%; } #d-col { display: none; } }</style>
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp" %>
	
	<script type="text/javascript">
		let msg = "${msg}"
		if(msg == "REG_COMPLETE") alert("신청이 완료되었습니다.")
	</script>
	
	<!-- body -->
	<div class="container mt-5">
		<h2>결제완료페이지</h2><hr>
		<div class="row">
			<div class="col-md-12 text-center">
				<p class="fs-5 bg-light p-4">신청하신 강좌가 등록 및 결제되었습니다.</p>
			</div>
			<div class="col-md-12 mt-3">
				<table class="table table-bordered text-center">
					<tbody>
					<thead class="bg-light align-middle">
						<th>강좌명</th>
						<th width="20%" id="d-col">수강기간</th>
						<th width="20%" id="d-col">수강요일/시간</th>
						<th width="20%" id="w-28">결제금액(원)</th>
					</thead>
					<tr class="align-middle">
						<td>${courseDto.course_nm }</td>
						<td id="d-col">${courseDto.course_sd() }<br/>~${courseDto.course_ed() }</td>
						<td id="d-col">${courseDto.course_day }<br/>${courseDto.course_time }</td>
						<td>${courseDto.course_cost }</td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="text-center d-grid d-sm-block gap-1">
				<a href="/ycc/course/search" class="btn btn-primary" type="button">다른강좌보기</a> 
				<a href="/ycc/mypage/mycourse" class="btn btn-primary" type="button">수강내역조회</a>
			</div>
		</div>
	</div>

	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>