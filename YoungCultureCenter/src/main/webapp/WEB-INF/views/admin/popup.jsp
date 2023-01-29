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
	function deleteCard(x) {
		  const div = document.getElementById('card'+x);
		  div.remove();
		  i = i - 1;
		} 
	</script>
	<title>YOUNG문화체육센터 - 팝업 설정</title>
</head>

<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<form action="" method="post">
		<div class="container text-center mt-5" id="original">
			<h1 class="text-start">공지사항 관리</h1>
			<hr>
			
			<!-- 1번 항목 - 오리지널 -->
			<div class="card text-start text-bg-light mb-3" id="card1">
				<div class="card-header" style="display: flex; align-items: center;">
				<h5 class="card-title mb-0">공지사항1</h5>
				<button type="button" class="btn-close ms-auto" name="action" onclick="deleteCard(1)" value="delete" aria-label="Close"></button>
				</div>
				
				<div class="card-body">
					<div class="row mb-3">
						<label for="attached-file1" class="col-sm-2 col-form-label card-subtitle">URL</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="url-1">
						</div>
					</div>
						<div class="row mb-3">
						<label for="attached-file1" class="col-sm-2 col-form-label card-subtitle">첨부파일</label>
						<div class="col-sm-10">
							<input type="file" class="form-control form-control-sm" aria-label="Small file input example">
						</div>
					</div>	
				</div>
			</div>
	
			<!-- DB에서 ROWNUMBER 받아옴 -->
			<!-- 추가되는 위치 -->
			
		</div>
		
		<!-- 추가 버튼 -->
		<div class="container text-center mt-5">
			<button type="button" class="btn btn-primary" id="add-button">+</button>
			
			<!-- 추가 버튼 눌렀을 때 동작 - jQuery -->
			<script type="text/javascript">
			// i를 재활용 할 수 있도록 전역변수로 선언
			var i=2;		// 추후에 2 대신에 DB에 저장된 index를 받아와야 함.
			$(document).ready(function() {
				console.log('작동')
			  $("#add-button").click(function() {
				if(i<=10)
					{
					$("#original").append(
				    		'<div class="card text-start text-bg-light mb-3" id="card'+i+'">'
				    		+'<div class="card-header" style="display: flex; align-items: center;">'
				    		+'<h5 class="card-title mb-0">공지사항'+i+'</h5>'
				    		+'<button type="button" class="btn-close ms-auto" onclick="deleteCard('+i+')" name="action" value="delete" aria-label="Close"></button>'
				    		+'</div>'
				    		+'<div class="card-body">'
				    		+'<div class="row mb-3">'
				    		+'<label for="attached-file1" class="col-sm-2 col-form-label">URL</label>'
				    		+'<div class="col-sm-10">'
				    		+'<input type="text" class="form-control" id="url-'+i+'">'
				    		+'</div>'
				    		+'</div>'
				    		+'<div class="row mb-3">'
				    		+'<label for="attached-file1" class="col-sm-2 col-form-label">첨부파일</label>'
				    		+'<div class="col-sm-10">'
				    		+'<input type="file" class="form-control form-control-sm" aria-label="Small file input example">'
				    		+'</div>'
				    		+'</div>'
				    		+'</div>'
				    		+'</div>'
				    		);
				    i++
					}
			  });
			});
			</script>
			
			<!-- 저장/취소 버튼 -->
			<div class="p-2 m-2">
				<button type="submit" class="btn btn-primary" name="action" value="save" style="width: 100px">저장</button>
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='/ycc/admin'" style="width: 100px">취소</button>
			</div>
		</div>
		${alert}
	</form>

	
	<!-- footer 여백 -->
	<div style="height: 150px;"></div>
	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>