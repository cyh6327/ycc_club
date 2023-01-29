<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%-- <sec:authentication property="principal" var="pinfo"/>
<c:set var="loginId" value="${pinfo.member.user_id }" /> --%>

<!DOCTYPE html>
<html>
<head>

<!-- head & meta tag include -->
<%@include file="/WEB-INF/views/metahead.jsp"%>

<style>
.club-info {
	background-color: rgba(0, 0, 0, 0.5);
	color: aliceblue;
	text-align: left;
	position: absolute;
	bottom: 0%;
	width: 100%;
}
</style>

<title>YOUNG문화센터 - 동아리 메인</title>
</head>
<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<!-- 인기동아리, 동아리 추가 부분 -->
	<div class="container text-center">
		<div class="d-flex justify-content-between mt-5">
			<h1 class="text-start" >인기 동아리</h1>
			<button class="btn btn-primary btn-sm h-25 mt-4" data-bs-toggle="modal" data-bs-target="#exampleModal">동아리 생성</button>
		</div>
		
		<!-- 동아리 생성 모달 -->
		<!-- Modal -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h1 class="modal-title fs-5" id="exampleModalLabel">동아리 생성</h1>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      <form id="form" class="frm" action="<c:url value='/club/create'/>" method="POST">
		      <c:set var="user_id" value="${user_id}"></c:set>
		      <input type="hidden" name="user_id" value="${user_id}" />
		      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
		      <div class="modal-body">
		        	<div class="text-start mb-2">
			        	<label for="name">동아리명</label>
						<input type="text" id="name" name="title" required minlength="2" maxlength="12" size="20">
					</div>
					<div class="text-start">
			        	<p style="margin-bottom: 5px;">소개글</p>
						<textarea class="w-100 h-75" name="info" rows="5" cols="3"></textarea>
					</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="submit" class="btn btn-primary">생성하기</button>
		      </div>
		      </form>
		    </div>
		  </div>
		</div>

		<hr>
		<div class="row">
			<c:forEach var="clubDto" items="${pClubList }">
			<!--인기동아리1 그리드-->
			<div class="col-md-4">
				<!-- 이미지 부분 -->
				<div style="position: relative;">
					<img class="img-fluid" src="/ycc/resources/img/club/catclub.jpg">
					<!-- 겹쳐지는 텍스트 부분 -->
					<div class="club-info">
						<div class="club-info px-2">
							<h2 style="font-size: 2vw">${clubDto.club_title }</h2>
							<p style="font-size: 0.8vw">
								동아리장 : ${clubDto.club_master_id } | 멤버 : ${clubDto.count }명 |<br>생성일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_create_time }" />
							</p>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
		</div>
		
		<!-- 내 동아리 -->
		<h1 class="text-start mt-5">내 동아리</h1>
		<hr>
		<c:set var="user_id" value="${user_id}"></c:set>
		<c:set var="myClubList" value="${myClubList}"></c:set>
		<c:choose>
			<c:when test="${myClubList[0] == null}">
				<p>가입한 동아리가 없습니다.</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="clubDto" items="${myClubList }">
					<div class="text-start px-4">
						<div class="d-flex me-auto">
							<img src="/ycc/resources/img/club/ycc_logo.png"
							class="img-thumbnail rounded-2 me-3" alt="영문화센터"
							style="height: 150px; width: 150px;">
						<!-- 동아리 이동(제목클릭) -->
						<div class="text-truncate">
							<a href="<c:url value='/club/board?club_id=${clubDto.club_id }'/>" method="GET" style="text-decoration: none; text-decoration-color: none;">
							<h4>${clubDto.club_title }</h4>
							<small class="text-muted">동아리장 : ${clubDto.club_master_id } | 멤버수 : ${clubDto.count }명 | 생성일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_create_time }" /></small></a>
							<a href="#" class="text-reset text-decoration-none"><p class="mb-2">가입 인사 합니다.</p></a>
							<a href="#" class="text-reset text-decoration-none"><p class="mb-2">게시글 제목 2</p></a>
							<a href="#" class="text-reset text-decoration-none"><p class="mb-2">안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~안녕하세요~</p></a>
						</div>
					</div>
					<hr>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
			
		<!-- 전체 동아리 -->
		<h1 class="text-start mt-5">전체 동아리</h1>
		<hr>
		
	    <!--게시판 부분-->
	    <div>
	    	<ul class="row" style="list-style:none;">
	    		<c:forEach var="clubDto" items="${cList }">
		    		<li class="col-6">
		    			<div class="list_thumb d-flex">
			    			<img src="/ycc/resources/img/club/ycc_logo.png"
								class="img-thumbnail rounded-2 me-3" alt="영문화센터"
								style="height: 150px; width: 150px;">
							<div class="list_info">
								<div class="text-start mt-2"><a href="<c:url value='/club/board?club_id=${clubDto.club_id }' />">${clubDto.club_title }</a></div>
								<div class="text-start">${clubDto.club_info }</div>
								<div class="text-muted text-start mt-2">동아리장 : ${clubDto.club_master_id } | 멤버 : ${clubDto.count }명</div>
							</div>
						</div>
		    		</li>
	    		</c:forEach>
	    	</ul>
   		</div>
	    
	    
    <!-- 페이지 네비게이션 -->
    <nav aria-label="Page navigation example">
      <ul class="pagination justify-content-center">
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
          </a>
        </li>
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
          </a>
        </li>
      </ul>
    </nav>
    
    <!-- 검색 영역 -->
	    <div class="d-flex flex-row mx-auto w-75">
	      <select class="form-select form-select-sm mx-2 w-25" aria-label=".form-select-sm example">
	        <option value="1">제목</option>
	        <option value="2">작성자</option>
	      </select>
	      <input type="text" class="form-control mx-2 w-50" aria-label="title" aria-describedby="basic-addon1">
	      <button type="button" class="btn btn-primary mx-2" style="width: 80px">검색</button>
	    </div>
    </div>
   
  
	</div> <!-- 컨테이너 end -->
	


	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>