
<%@page import="com.youngtvjobs.ycc.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<!-- head & meta tag include -->
<%@include file="/WEB-INF/views/metahead.jsp"%>
<title>동아리 생성</title>

</head>
<body>
	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<div class="container w-50">
		<h2 class="p-5" style="text-align: center;">동아리 생성</h2>

		<form id="form" action=''method="post">
			<!-- 회원정보 입력 table -->
			<h2 class="mt-5">동아리 정보 입력</h2>
			<hr>
			<table class="table">
				<colgroup>
					<col width="20%">
					<col width="60%">
				</colgroup>
				<thead>
					<!-- 동아리명 -->
					<tr>
						<th class="col" style="vertical-align: middle !important;">동아리명</th>
						<td class="col-auto px-3">
							<div class="row">
								<input type="text" class="form-control onlyAlphabetAndNumber"
									id="club_title" name="club_title" placeholder="동아리명을 입력해주세요"
									maxlength="20" style="width: 340px;"> 
								<input type="button" id="dbCheckBtn" name="idCheckBtn"
									class="btn btn-outline-primary mx-1" value="중복확인"
									style="width: 100px;">
								<input type="hidden" name="dbCheck" value="dbUnchecked">
								<!-- 중복체크 검사결과  -->
								<span id="result"></span>
							</div>
						</td>
					</tr>

					<!-- 동아리 소개글 -->
					<tr>
						<th class="col" style="vertical-align: middle !important;">동아리 설명</th>
						<td><textarea class="w-100 h-75" name="club_info" rows="5" cols="3"></textarea></td>
					</tr>
					
				</thead>
			</table>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
			<!-- 회원가입 & 취소 버튼 -->
			<div class="row">
				<div class="col text-center pt-5">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}"> <input type="button" id="createBtn"
						class="btn btn-primary" value="생성하기">
					<a href="/ycc/" class="cancle btn btn-secondary" role="button">취소</a>
				</div>
			</div>
		</form>
	</div>

	<script>

	let formCheck = function() {
		// html태그와 trim()으로 제거되지 않는 공백문자(=&nbsp;)를 제거
		let form = $('#form')
		let res = $('textarea[name=club_info]').val().replace(/&nbsp;|<[^>]*>?/g, '');
		let club_title = $('#club_title').val()
		
		if($.trim(club_title) == "") {
			alert("동아리명을 입력해 주세요.")
			return false
		} else if(club_title.match(/^\s/)) {
			alert("동아리명은 공백으로 시작할 수 없습니다.")
			return false
		} else if($.trim(res) == "") {
			alert("동아리 소개글을 작성해 주세요.")
			return false
		} else if($('#result').attr('data-check') == "false") {
			alert("중복된 동아리명입니다.")
			return false
		} else if($('input[name=dbCheck]').val() == "dbUnchecked") {
			alert("중복체크를 해주세요.")
			return false
		}
		return true;
	}
	
	$('#createBtn').on("click", function() {
		let form = $('#form')
		
		form.attr("action", "<c:url value='/club/create'/>")
		form.attr("method", "post")
		
		if(formCheck()) {
			form.submit()
			alert("동아리가 생성되었습니다!")
		}
	})
		
	$('#club_title').on("change keyup", function() {
	   $('input[name=dbCheck]').attr('value','dbUnchecked')
	})
	
  	$('#dbCheckBtn').on("click", function() {
 		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
	 		$.ajax({
	 			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			type : 'post',
			url : '/ycc/club/dbCheckClubTitle',
			data : {
				'club_title' : $('input[name=club_title]').val()
			},
			dataType : 'json',
			success : function(result) {
				
				$('input[name=dbCheck]').attr('value','dbChecked')
				
				if (result == 0) {
					$("#result").text('사용 가능한 동아리명입니다.').css('color', 'blue');
					$("#result").attr("data-check", "true")
				} else {
					$("#result").text('동아리명이 이미 존재합니다.').css('color', 'red');
					$("#result").attr("data-check", "false")
				}
			},
			error : function() {
				alert("error")
			}
 		})
 	})
	
	</script>
	<!-- footer inlcude -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>