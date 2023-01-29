<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<!-- head & meta tag include -->
<%@ include file="/WEB-INF/views/metahead.jsp"%>
<title>아이디/비밀번호 찾기</title>
<style>th { padding: 10px 20px 10px 20px; background-color: #F4F7F9; } td { padding: 10px 20px 10px 20px; }</style>
</head>
<body>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp"%>

	<!-- body -->
	<div class="container mt-5">
		<h2 class="text-start">아이디/비밀번호찾기</h2><hr>
		<div>
			<p>아이디 찾기 또는 비밀번호 찾기를 하실 경우 회원가입시 등록하신 이메일 주소로 안내메일이 발송됩니다.</p>
		</div>
		<ul class="nav nav-pills nav-fill" id="pills-tab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active border-bottom" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home"
				type="button" role="tab" aria-controls="pills-home" aria-selected="true">아이디 찾기</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link border-bottom" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile"
				type="button" role="tab" aria-controls="pills-profile" aria-selected="false">비밀번호 찾기</button>
			</li>
		</ul>
		<br>
		<div class="tab-content" id="pills-tabContent">
			<!-- 아이디찾기 -->
			<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0">
				<h5 class="text-start">| 아이디 찾기</h5>
				<form action="loginForm.html">
					<div>
						<table class="table-group-divider container-fluid">
							<tbody>
							<colgroup>
								<col width="30%">
							</colgroup>
							<!-- 성명 -->
							<tr>
								<th scope="row">이름</th>
								<td>
									<div class="col-md-5">
										<input type="name" class="form-control" id="user_name" name="user_name" placeholder="이름을 입력해주세요." autofocus required>
									</div>
								</td>
							</tr>
							<!-- 생년월일 -->
							<!-- <tr>
								<th scope="row">생년월일</th>
								<td>
									<div class="col-md-5">
										<input class="form-control" type="date" id="date" name="user_birth" required>
									</div>
								</td>
							</tr> -->
							<!-- 회원 가입 시 등록한 이메일 -->
							<tr>
								<th scope="row">회원 가입 시 등록한 이메일</th>
								<td>
									<div class="col-md-12">
										<div class="row g-1">
											<div class="col-md-4">
												<input type="text" class="form-control" name="user_email" id="user_email" placeholder="abc123" aria-label="Username" required>
											</div>
											<div class="col-md-5">
												<div class="input-group">
													<span class="input-group-text">@</span>
													<!-- <input id='name' onchange='printName()' /><div id='result'></div> -->
													<select class="form-select form-select-sm" id="detail_email" name="detail_email" aria-label=".form-select-sm example" required>
														<option selected></option>
														<option value="naver.com">naver.com</option>
														<option value="hanmail.net">hanmail.net</option>
														<option value="gmail.com">gmail.com</option>
													</select>
													<!-- <input type="text" class="form-control" placeholder="example.com" aria-label="Server"> -->
												</div>
											</div>
										</div>
									</div>
								</td>
							</tr>
							<!-- 성별 -->
							<!-- <tr>
								<th scope="row">성별</th>
								<td>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="user_gender" id="inlineRadio1" value="option1">
										<label class="form-check-label" for="inlineRadio1">남</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="user_gender" id="inlineRadio2" value="option2">
										<label class="form-check-label" for="inlineRadio2">여</label>
									</div>
								</td>
							</tr> -->
							</tbody>
						</table>
					</div>
					<hr>
					<div class="d-grid d-sm-block text-end">
						<!-- Button trigger modal -->
						<button type="button" id="findId" name="findId" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal1">아이디찾기</button>
					</div>
				</form>
			</div>
			<!-- 비밀번호찾기 -->
			<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
				<h5 class="text-start">| 비밀번호 찾기</h5>
				<form action="#">
					<div class="d-flex justify-content-center">
						<table class="table-group-divider container-fluid">
							<tbody>
								<tr>
									<th scope="row">아이디</th>
									<td>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="user_id" name="user_id" placeholder="아이디를 입력해주세요." autofocus required>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row">이름</th>
									<td>
										<div class="col-sm-6">
											<input type="text" class="form-control" id="user_name_pw" name="user_name_pw" placeholder="이름을 입력해주세요." required>
										</div>
									</td>
								</tr>
								<!-- <tr>
									<th scope="row">생년월일</th>
									<td>
										<div class="col-sm-6">
											<input class="col-sm-12 form-control" type="date" id="user_birth" name="user_birth" required>
										</div>
									</td>
								</tr> -->
							</tbody>
						</table>
					</div>
					<hr>
					<div>
						<p>비밀번호 찾기를 누르시면 <span class="text-danger">아이디에 등록된 이메일</span>로 새	비밀번호 발급절차가 진행됩니다.</p>
						<p>등록된 이메일 주소를 기억하지 못할 경우 관리자에게 연락 주십시오.</p>
					</div>
					<div class="d-grid d-sm-block text-end">
						<button type="button" class="btn btn-primary" id="findPw" name ="findPw" data-bs-toggle="modal" data-bs-target="#exampleModal2">비밀번호찾기</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp"%>
	
	<!-- 아이디찾기 Modal -->
	<div class="modal fade" name="exampleModal1" id="exampleModal1" tabindex="-1" aria-labelledby="exampleModalLabel1" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel1">아이디 찾기</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	        <input type="text" class="user_id" id="user_id" readonly="true"/>
	       	<p>개인정보 보호를 위해 아이디의 일부만 노출됩니다.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <a href="/ycc/login" type="button" class="btn btn-primary">로그인하기</a>
	      </div>
	    </div>
	  </div>
	</div>
	<!-- 비밀번호찾기 Modal -->
	<div class="modal fade" id="exampleModal2" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel2">Modal title</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body text-center">
	        <p>재설정된 비밀번호가 <b class="fs-5">e-mail로 전송</b>되었습니다.</p>
	        <p>로그인 후 비밀번호를 변경해주세요.</p>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	        <a href="/ycc/login" type="button" class="btn btn-primary">로그인하기</a>
	      </div>
	    </div>
	  </div>
	</div>
	
<script>
	//아이디 찾기(모달창에 정보 띄우기)
	$("#findId").click(function() {
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue= "${_csrf.token}";
		let a = $('#user_email').val()+'@'+$('#detail_email').val()
		let b = $('#user_name').val()
		//아이디 찾기 이메일 데이터 넘기기 Todo 성명, 생년월일, 이메일, 성별 모두 넘기기 
       	$.ajax({
     	  beforeSend: function(xhr){
    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);},
          type: 'post',
          url: '/ycc/mypage/findId',
          headers : {"content-type" : "application/json"},
          data: JSON.stringify({user_email:a, user_name:b}),
          dataType: 'text',
          success: function(user_id) {
        	if (user_id == "" || user_name == ""){
        		alert("정보를 다시 확인해주세요.")
        	}
        	else{
				let str_length = user_id.length		//str(admin)의 length를 받음 : 5글자
				user_id = user_id.substr(0, (str_length/2))	//id값의 반만 보여줌 : admin : ad
				user_id = user_id.padEnd(str_length,"*")	//없는 글자 이후(3,4) : in 부분을 **로 채움
				$(".modal-body #user_id").val(user_id)	//모달창에 갑을 전달하는 함수
        	}
			},
          error: function(){
          	alert ("error")
          	}
          
         })
	})
</script>
<script>
//패스워드 찾기(모달창에 정보 띄우기)
	$("#findPw").click(function() {
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue= "${_csrf.token}";
		let a = document.getElementById("user_id").value;
		let b = document.getElementById("user_name_pw").value;
		//alert("모달창 진입") 
		//아이디 찾기 이메일 데이터 넘기기  
	    $.ajax({
	      beforeSend: function(xhr){
	      xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);},
	      type: 'POST',
	      url: '/ycc/mypage/findPw',
	      headers : { "content-type" : "application/json" },
	      data: JSON.stringify({user_id:a, user_name:b}), 
	      dataType: 'text',
	      success: function(user_email) {
	    	  //alert(b)
	    	  $.ajax({
	    		  beforeSend: function(xhr){
		    	  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);},
		          type: 'post',
		          url: '/ycc/signin/pwEmail',
		          headers : { "content-type" : "application/json" },
		          data: JSON.stringify({user_email:user_email}), 
		          dataType: 'text',
		          success: function(user_email) {
		        	  
		          },
		          error: function(){
		            alert ("정보를 다시 확인해주세요(1).")
		          }
		          
		         })
	      },
	      error: function(){
	        alert ("정보를 다시 확인해주세요(2).")
	      }
	      
	     })
	  })
</script>
</body>
</html>