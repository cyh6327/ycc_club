<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp"%>
	
	<title>회원정보수정</title>
	<style>tr { vertical-align: middle !important; } @media ( max-width : 767px) { #w-28 { width: 28%; } }</style>
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<div class="container mt-5">
		<h2>회원정보수정</h2><hr>
		<!-- 회원정보수정 -->
		<form action="<c:url value='/mypage/modify'/>"  method="post" onsubmit="return validCheck(this);">
		<table class="table table-group-divider text-center">
			<tbody>
			<colgroup><col width="15%" class="bg-light" id="w-28"></colgroup>
			<!-- CustomUser를 통해 principal 객체에 MemberDto의 데이터를 담은 것 -->
			<sec:authentication property="principal" var="p"/>
			<!-- 아이디 -->
			<tr>
				<th class="col">아이디</th>
				<td><input type="text" class="form-control-plaintext" id="id" maxlength="20" name="user_id" value="${p.member.user_id }" readonly>
				</td>
			</tr>
			<!-- 이름 -->
			<tr>
				<th class="col">이름</th>
				<td>
					<div class="row">
						<div class="col-lg-4">
							<input type="text" class="form-control-plaintext" id="name" name="user_name"
							placeholder="한글입력" maxlength="10" value="${p.member.user_name }" readonly>
						</div>
					</div>
				</td>
			</tr>
			<!-- 비밀번호 -->
			<tr>
				<th class="col">비밀번호</th>
				<td>
					<div class="row">
						<div class="col-lg-5">
							<input type="password" class="form-control" id="pw" name="user_pw"
							placeholder="8~15자, 영문+숫자 입력" maxlength="20" required>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</div>
					</div>
				</td>
			</tr>
			<!-- 비밀번호확인 -->
			<tr>
				<th class="col">비밀번호확인</th>
				<td>
					<div class="row">
						<div class="col-lg-5">
							<input type="password" class="form-control" id="pwChk" maxlength="20" required>
						</div>
					</div>
				</td>
			</tr>
			<!-- 성별 -->
			<tr>
				<th class="col">성별</th>
				<th class="text-start">
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" id="inlineRadio1"
						value="option1" ${p.member.user_gender.equals('M') ? "checked"  : "" } disabled>
						<label class="form-check-label" for="inlineRadio1">남</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" id="inlineRadio2"
						value="option2" ${p.member.user_gender.equals('F') ? "checked"  : "" } disabled>
						<label class="form-check-label" for="inlineRadio2">여</label>
					</div>
				</th>
			</tr>
			<!-- 생년월일 -->
			<tr><th class="col">생년월일</th>
				<td>
					<div class="row">
						<div class="col-lg-4">
							<input type="text" class="form-control-plaintext" id="birth_date"
							 value="${birth_date }" readonly>
						</div>
					</div>
				</td>
				</th>
			</tr>
			<!-- 이메일 -->
			<tr>
				<th class="col">이메일</th>
				<td>
					<div class="row g-1">
						<div class="col-md-4">
							<input type="text" class="form-control" id="divEmai" maxlength="40" value="${emailId}" disabled>
						</div>
						<div class="col-md-5">
							<div>
								<label class="visually-hidden" for="autoSizingInputGroup">Username</label>
								<div class="input-group">
									<div class="input-group-text">@</div>
									<select class="form-select" aria-label="Default select example" disabled>
										<option>${emailDomain}</option>

									</select>
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
			<!-- 휴대전화 -->
			<tr>
				<th class="col">휴대폰</th>
				<td>
					<div class="row">
						<div class="col-lg-5">
							<input type="tel" class="form-control onlyNumber" id="phoneNumber" value ="${p.member.user_phone_number}"
							 name ="user_phone_number" placeholder="-를 제외하고 숫자만 입력하세요." maxlength="11">
						</div>
					</div>
				</td>
			</tr>
			<!-- 주소 -->
			<tr>
				<th class="col">주소</th>
				<td>
					<div class="row g-1">
						<div class="col-md-12">
							<div class="row g-1">
								<div class="col-sm-4">
									<input type="text" class="form-control" id="sample6_postcode" placeholder="우편번호" 
									 name="user_postcode" value="${p.member.user_postcode}" required readonly>
								</div>
								<div class="col-sm-4 text-start d-grid d-md-block">
									<input class="btn btn-primary" onclick="sample6_execDaumPostcode()" type="button" value="우편번호검색">
								</div>
							</div>
						</div>
						<div class="col-md-12">
							<div class="row g-1">
								<div class="col-md-6">
									<input type="text" class="form-control" id="sample6_address" placeholder="도로명주소" 
									name="user_rNameAddr" value="${p.member.user_rNameAddr }" required readonly>
								</div>
								<div class="col-md-6">
									<input type="text" class="form-control" id="sample6_detailAddress" placeholder="상세주소를 입력해주세요."
									name="user_detailAddr" value="${p.member.user_detailAddr }">
								</div>
								<div class="col-md-12">
									<input type="hidden" class="form-control" id="sample6_extraAddress" placeholder="참고항목.">
								</div>
							</div>
						</div>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
		<!-- 버튼 -->
		<div class="row gap-1 justify-content-between">
			<div class="col-sm-auto">
				<div class="d-grid gap-1 d-sm-block">
<!-- 폼으로 버튼 변경	<a class="btn btn-primary" action="/ycc" role="submit" onclick="return formCheck(this);">수정</a> -->
					<button class="btn btn-primary">수정</button>
					<a class="btn btn-secondary" href="/ycc" role="button">취소</a>
				</div>
			</div>
			<div class="col-sm-auto">
				<div class="d-grid d-sm-block">
					<button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#exampleModal">회원탈퇴</button>
				</div>
			</div>
		</div>
		</form>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">탈퇴안내</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p class="text-danger">| 회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요. |</p>
					<ul>
						<li>회원 탈퇴 시 온라인과 오프라인을 통한 센터의 이용이 불가합니다.</li>
						<li>회원 탈퇴 시 매출관리를 위한 결제내역을 제외한 회원의 개인정보(ID, 이름, 생년월일, 휴대전화번호, 주소, 자택전화번호 등)가 삭제되어
						해당 정보를 통한 조회가 불가능하게 되며, 재가입시 이전 수강정보는 복원되지 않습니다.</li>
						<li>탈퇴된 사용자의 ID는 재사용할 수 없습니다.</li>
					</ul>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					<a href="withdraw" type="button" class="btn btn-danger">탈퇴</a>
				</div>
			</div>
		</div>
	</div>

	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp"%>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="http://code.jquery.com/jquery.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	
	
	<script type="text/javascript">
	 
	// 비밀번호 유효성 검사 (8-15자리, 영문/숫자 혼합, 비밀번호 확인)
	// 핸드폰번호 유효성 검사 (01~으로 시작, 11자리만 입력 확인)	 
	
	function validCheck(){

		 var pw = $("#pw").val();
		 var num = pw.search(/[0-9]/g);
		 var eng = pw.search(/[a-z]/ig);
		 var pwChk = $("#pwChk").val();
		 var phoneNum =/^01([0|1|6|7|9]?)?([0-9]{4})?([0-9]{4})$/;

		 if(pw.length < 8 || pw.length > 15){
		  alert("8자리 ~ 15자리 이내로 입력해주세요.");
		  return false;
		  
		 }else if(num < 0 || eng < 0){
		  alert("영문,숫자를 혼합하여 입력해주세요.");
		  return false;
		
		 }else if(pw.search(/\s/) != -1){
		  alert("비밀번호는 공백 없이 입력해주세요.");
		  return false;
		  
	 	 }else if(pw!=pwChk){
		  alert("비밀번호가 일치하지 않습니다.");
		  return false;
		  } 
		  else if(!phoneNum.test($("#phoneNumber").val())) {	
	 	  alert('핸드폰 번호를 확인 해주세요');
	 	  return false;
	 	  } 
		  else { 
		    return alert("수정이 완료되었습니다.");
		 }
		 
		}
	

	
 
	
    function setMessage(msg, element) {
        document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle">${'${msg}'}</i>`;
        if (element) {
            element.select(); // 값이 잘못 입력되었을 때 그 요소를 선택되게하는 것임 
        }
    }
	function getvalue() {
		var idx = document.getElementById('name').value;
		var url = '?name=' + idx;
		location.href = "/ycc/mypage/mypage2" + url;
	}
	function sample6_execDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수
				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}
				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) { extraAddr += data.bname; }
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') { extraAddr = ' (' + extraAddr + ')'; }
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("sample6_extraAddress").value = extraAddr;
				} else { document.getElementById("sample6_extraAddress").value = ''; }
				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('sample6_postcode').value = data.zonecode;
				document.getElementById("sample6_address").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("sample6_detailAddress").focus();
			}
		}).open();
	}
	</script>
</body>
</html>