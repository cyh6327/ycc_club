<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
    
    <title>1:1 문의</title>
<style>tr { vertical-align: middle !important; } @media ( max-width : 767px) { #w-28 { width: 28%; } }</style>
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="container mt-5">
		<h2>1:1 문의</h2>
		<table class="table table-group-divider">
			<tbody>
			<colgroup><col width="15%" class="bg-light" id="w-28"></colgroup>
			<!-- 문의유형 -->
			<tr>
				<th class="col">문의유형</th>
				<td>
					<input type="text" class="form-control-plaintext" id="id" maxlength="20" name="id" value="${inquiryDto.inq_cate }" readonly>
				</td>
			</tr>
			<!-- 문의제목 -->
			<tr>
				<th class="col">문의제목</th>
				<td>
					<input type="text" class="form-control-plaintext" id="inq_title" maxlength="20" name="inq_title" value="${inquiryDto.inq_title }" readonly>
				</td>
			</tr>
			<!-- 문의내용 -->
			<tr>
				<th class="col" >문의내용</th>
					<td height="400" style="word-break:break-all">
						<div name="inq_content">
							${inquiryDto.inq_content}
						</div>
					</td>
			</tr>
			</tbody>
		</table>
		
		<table class="table table-group-divider text-center">
			<tbody>
			<colgroup><col width="15%" class="bg-light" id="w-28"></colgroup>
			<!-- 답변 -->
			<tr>
				<th class="col">답변</th>
					<td height="100">
						<div class="form-control-plaintext word-wrap"id="inq_ans" name="inq_ans" 
						style="display:flex;"
						readonly>
							${inquiryDto.inq_ans==null? "답변 준비중입니다." : inquiryDto.inq_ans}
						</div>
					</td>
			</tr>
			</tbody>
		</table>
		<div class="d-flex justify-content-center">
		<button type="button" class="btn btn-outline-primary me-2" onClick="location.href='javascript:history.back()'">이전</button>
		<button type="button" class="btn btn-primary" id="listBtn">목록</button>
		</div>
	</div>
	
	  
	  <!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp"%>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	
	<script>
	$(document).ready(function(){
		$("#listBtn").on("click", function() {
			location.href ="<c:url value='/mypage/inquiry' />";
		})
	})
	</script>
	
  </body>
</html>