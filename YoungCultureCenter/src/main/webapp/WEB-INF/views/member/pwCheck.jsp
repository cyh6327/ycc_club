
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp" %>
	<title>본인인증</title>
  <style>@media (max-width: 767px) { #gtc { text-align: center !important; align-items: center !important; } }</style>
</head>
<body>
  <!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp" %>

  <!-- body -->
  <div class="container mt-5 text-center">
    <h2 class="text-start">본인인증페이지</h2><hr>
    <form class="row g-3 text-center" action="pwcheck" method="post">
      <div class="col-md-12">
        <div class="row">
          <div class="col-md-12">
          	<img class="img-fluid" src="<c:url value="/resources/img/ico_self_auth.png" />" alt="본인인증아이콘">
        	</div>
      	</div>
      </div>
      <div class="col-md-12 align-self-center">
        <div class="row g-3 bg-light">
          <div class="col-md-12 align-self-center fs-5">계속하려면 먼저 본인임을 인증하세요.</div>
          <div class="col-md-4 text-center">
          </div>
          <div class="col-md-4">
          	<label for="inputPassword" class="visually-hidden">Password</label>
          	<input type="password" class="form-control" id="inputPassword" name="inputPassword" placeholder="Password">
          	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          </div>
          <div class="col-md-4 text-start d-grid d-md-block">
          	<button type="submit" class="btn btn-primary mb-3">확인</button>
        	</div>
      	</div>
    	</div>
  	</form>
	${alert}
	</div>

  <!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp" %>
	
	
	
</body>
</html>