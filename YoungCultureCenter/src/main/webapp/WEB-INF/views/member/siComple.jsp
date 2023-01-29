<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>	
	 <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
<title>회원가입완료</title>
</head>
<body>
	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>
  	<!--step container -->
	<div class="container w-50">
    <h2 class="p-5" style="text-align: center;">회원가입</h2>
    <div class="container-lg pt-5">
      <div class="position-relative m-4">
        <div class="progress" style="height: 7px;">
          <div class="progress-bar bg-dark" role="progressbar" style="width: 100%;" aria-valuenow="50" aria-valuemin="0"
            aria-valuemax="100">
          </div>
        </div>
        <button type="button" class="position-absolute top-0 start-0 translate-middle btn btn-sm btn-dark rounded-pill"
        style="width: 3.5rem; height:3.5rem;">Step1</button>
        <button type="button" class="position-absolute top-0 start-50 translate-middle btn btn-sm btn-dark rounded-pill"
        style="width: 3.5rem; height:3.5rem;">Step2</button>
        <button type="button" class="position-absolute top-0 start-100 translate-middle btn btn-sm btn-dark rounded-pill"
        style="width: 3.5rem; height:3.5rem;">Step3</button>
      </div>
    </div>
   	</div>
  <!--회원가입완료문구  -->
   <form action= "member/sicomple" name="signupcomple" method="post">
  <div class="container w-150 ">
    <div class="bg-light p-5 rounded justify-content-center text-center">
      <img src="/ycc/resources/img/joinmember/check.png" style="width: 50px; height: 50px;">
        <p class="col display-5 fs-3 fw-bold text-primary pt-4 mb-0" id="name"></p>
<%--           <sec:authorize access="isAnonymous()"> --%>
<%--         <p class="col display-5 fs-3" id="user_id" >${principal.member.user_name}</p> --%>
<%--         	</sec:authorize> --%>
        <p class="col display-5 fs-3 fw-bold ">회원가입이 완료되었습니다.</p>
        <p class="fs-5"> YOUNG문화센터 회원가입을 축하합니다.<br />로그인 후 서비스를 이용하실 수 있습니다. </p>
        <a class="btn btn-primary col-4" href="/ycc/login" role="button">로그인페이지로 이동 &raquo;</a>
    </div>
  </div>
  </form>

 <!--  
    <script charset="utf-8">
      var para2 = document.location.href.split("?name=").reverse()[0];
      let para = decodeURI(para2)
      document.getElementById("name").innerHTML = para + "님,";
   </script>
-->	
	
	<!-- footer inlcude -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>