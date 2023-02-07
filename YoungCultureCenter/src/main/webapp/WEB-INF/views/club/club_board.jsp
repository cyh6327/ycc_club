<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<!-- head & meta tag include -->
<%@include file="/WEB-INF/views/metahead.jsp"%>
<style>
	a {color:black; text-decoration:none;}
</style>
<title>YOUNG문화센터 - 동아리 상세페이지</title>
</head>
<body>
  <!-- header -->
  <%@include file="/WEB-INF/views/header.jsp"%>
  
  <c:set var="clubSelect" value="${clubSelect}"></c:set>
  <c:set var="myClubList" value="${myClubList }"></c:set>

  <!--start container-->
  <div class="container p-5">
    <h2 class="my-3">${clubSelect[0].club_title}</h2>
    <hr>
<!--     <div class="input-group" style="width: 200px; margin-left:80%; padding-bottom: 20px;">
      <select class="form-select form-select-sm" aria-label=".form-select-sm example"
        style="width: 90px; margin-right: 10px;">
        <option value="1">최신순</option>
        <option value="2">조회순</option>
        <option value="3">관련순</option>
      </select>
    </div> -->
    
    <!--글쓰기 버튼-->
	<%-- <a id="writeBtn" class="btn btn-primary float-end" href="<c:url value='/club/board/write?club_id=${param.club_id }' />" role="button">글쓰기</a> --%>
	<!-- <button type="button" id="writeBtn" class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#exampleModal">가입하기</button> -->
	<button type="button" id="writeBtn" class="btn btn-primary float-end m-3">가입하기</button>
	
    <!--게시판 부분-->
    <c:if test="${clubSelect[0].club_article_id != null }">
    <div class="p-5">
    <table class="table table-hover">
      <thead>
        <tr class="row" style="text-align: center;">
          <th class="col-7">제목</th>
          <th class="col-2">글쓴이</th>
          <th class="col-2">날짜</th>
          <th class="col-1">조회수</th>
        </tr>
      </thead>
      <tbody>
      <c:forEach var="clubDto" items="${clubSelect }">
        <tr class="row">
          <th scope="row" class="col-7"><a href="<c:url value='/club/board/view?club_id=${clubDto.club_id }&club_article_id=${clubDto.club_article_id }' />" class="text-decoration-none'">${clubDto.club_article_title }</a></th>
          <td class="col-2" style="text-align: center;">${clubDto.user_id }</td>
          <td class="col-2" style="text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_board_upload_time }" /></td>
          <td class="col-1" style="text-align: center;">${clubDto.club_article_viewcnt }</td>
        </tr>
	  </c:forEach>
      </tbody>
    </table>
    </div>
    </c:if>
    
 	<!-- Modal -->
<!-- 	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h1 class="modal-title fs-5" id="exampleModalLabel">동아리 가입하기</h1>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        ...
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary">가입하기</button>
	      </div>
	    </div>
	  </div>
	</div> -->
	
    <!-- 페이지네이션 -->
	<nav class="m-5" aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
			<c:if test="${totalCnt == null || totalCnt == 0 }">
				<div>게시물이 없습니다.</div>
			</c:if>
			<c:if test="${totalCnt != null || totalCnt != 0 }">
				<c:if test="${pr.showPrev }">
					<li class="page-item"><a class="page-link" 
					href="<c:url value="/club/board${pr.sc.getQueryString(pr.beginPage-1) }&club_id=${param.club_id }" />">&lt; </a></li>
				</c:if>
				<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage }">
					<li class="page-item"><a class="page-link" 
					href="<c:url value="/club/board${pr.sc.getQueryString(i)}&club_id=${param.club_id }" />">${i }</a></li>
				</c:forEach>
				<c:if test="${pr.showNext }">
					<li class="page-item"><a class="page-link" 
					href="<c:url value="/club/board${pr.sc.getQueryString(pr.endPage+1) }&club_id=${param.club_id }" />">&gt; </a></li>
				</c:if>
			</c:if>
		</ul>
	</nav>
	
<!--     <div class="bottomsearch" style="display: flex; margin-left: 30%; margin-top: 50px;">
      <select class="form-select form-select-sm" aria-label=".form-select-sm example"
        style="width: 90px; margin-right: 10px;">
        <option value="1">제목</option>
        <option value="2">작성자</option>
      </select>
      <input type="text" class="form-control" aria-label="title" aria-describedby="basic-addon1" style="width: 300px;">
      <button type="button" class="btn btn-primary" style="margin-left: 10px;">검색</button>
    </div> -->

  
  <button type="button" id="quitBtn" class="btn btn-sm btn-outline-secondary float-end mx-5">탈퇴하기</button>
   </div> 
  
<script>
/* 	let msg = "${msg}"
	if(msg == "JOIN_OK") 
		alert("가입이 완료되었습니다!")
	if(msg == "DEL_OK")
		alert("탈퇴가 완료되었습니다.") */
			
$(document).ready(function(){
	  
	let list = new Array();
	const url = new URL(window.location.href)
	const urlParams = url.searchParams;
	let club_id = urlParams.get("club_id")
	  
	// 로그인한 유저가 가입한 동아리 목록(=myClubList)을 가져와서 list에 담음
	<c:forEach items="${myClubList}" var="clubDto">
		list.push("${clubDto.club_id}");
	</c:forEach>
	 
	// 유저가 가입한 동아리 목록에 현재 동아리가 포함되어 있으면 '가입하기'버튼을 '글쓰기'버튼으로 변경
	if(list.includes(club_id)) {
		$('#writeBtn').text("글쓰기")
	}
 	  
	// 유저가 가입한 동아리 목록에 현재 동아리가 포함되어 있지 않으면 '탈퇴하기'버튼 안 보이게 설정
	if(!list.includes(club_id)) {
		$('#quitBtn').hide()
	}
		  
	$('#writeBtn').on("click", function() {
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		if($(this).text() == "가입하기") {
			if (confirm("동아리에 가입하시겠습니까?")) {
				$.ajax({
		  			beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
					},
					type : 'post',
					url : '/ycc/club/join',
					data : {
						club_id : ${param.club_id}
					},
					dataType : 'text',
					success : function(data) { 	
						alert("가입이 완료되었습니다!")
						location.reload();
					},
					error : function() {
						alert("error")
					}
 		    	})
			}
		} else {
 			// 게시글 작성 페이지로 이동
			location.href = "<c:url value='/club/board/write?club_id=${param.club_id }' />"
		}
 	})
 	  
	$('#quitBtn').on("click", function() {
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		if (confirm("동아리에서 탈퇴하시겠습니까?")) {
	 		$.ajax({
	  			beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				type : 'post',
				url : '/ycc/club/member/delete',
				data : {
					club_id : ${param.club_id}
				},
				dataType : 'text',
				success : function(data) {
					alert("탈퇴가 완료되었습니다.")
					location.href = "<c:url value='/club' />"
				},
				error : function() {
					alert("error")
				}
			})
		}
	})
 	  
/*  	  	$("#exampleModal").on('show.bs.modal', function(e){
 	  		if($('#writeBtn').text() == "글쓰기") {
				e.preventDefault();
				location.href = "<c:url value='/club/board/write?club_id=${param.club_id }' />"
			}
		}) */
 	  
})

</script>
	  
	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
  
  <!--end of container-->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
    crossorigin="anonymous"></script>
</body>

</html>