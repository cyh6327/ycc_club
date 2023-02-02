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
			<button id="moveCreateFormBtn" class="btn btn-primary btn-sm h-25 mt-4" 
			onclick="location.href='<c:url value='/club/createForm'/>'">동아리 생성</button>
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
							<a href="#" class="text-reset text-decoration-none"><p class="mb-2">${clubDto.club_article_title }</p></a>
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
								<div class="text-muted text-start mt-2">동아리장 : ${clubDto.club_master_id } | 멤버 : ${clubDto.club_member_cnt }명</div>
							</div>
						</div>
		    		</li>
	    		</c:forEach>
	    	</ul>
   		</div>
	    
	    
    <!-- 페이지네이션 -->
	<nav class="m-5" aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
			<c:if test="${totalCnt == null || totalCnt == 0 }">
				<div>게시물이 없습니다.</div>
			</c:if>
			<c:if test="${totalCnt != null || totalCnt != 0 }">
				<c:if test="${pr.showPrev }">
					<li class="page-item"><a class="page-link" 
					href="<c:url value="/club${pr.sc.getQueryString(pr.beginPage-1) }" />">&lt; </a></li>
				</c:if>
				<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage }">
					<li class="page-item"><a class="page-link" 
					href="<c:url value="/club${pr.sc.getQueryString(i)}" />">${i }</a></li>
				</c:forEach>
				<c:if test="${pr.showNext }">
					<li class="page-item"><a class="page-link" 
					href="<c:url value="/club${pr.sc.getQueryString(pr.endPage+1) }" />">&gt; </a></li>
				</c:if>
			</c:if>
		</div>
		</ul>
	</nav>
    
    <!-- 검색 영역 -->
    <div class="center">
		<form action="<c:url value="/club" />" method="get">
		<div class="d-flex justify-content-center"> 
		      <select class="form-select form-select-sm mx-2" style="width: 120px" aria-label=".form-select-sm example">
		        <option value="1">동아리명</option>
		        <!-- <option value="2">동아리장</option> -->
		      </select>
		      <input type="text" class="form-control mx-2 w-50" name="keyword" placeholder="검색어를 입력해주세요."
		      value="${param.keyword }" aria-label="title" aria-describedby="basic-addon1">
		      <button type="submit" class="btn btn-primary mx-2" style="width: 80px">검색</button>
      	</div>
      	</form>
    </div>
   
  
	</div> <!-- 컨테이너 end -->
	
<script>
  $(document).ready(function(){
		  
		/* let msg = "${msg}"
		if(msg == "OVERLAP") alert("중복된 동아리명입니다.") */
			
/* 	  	let dbCheckClubTitle = function() {
			let form = $('#form')
			
			form.attr("action", "<c:url value='/club.dbCheckClubTitle'/>")
			form.attr("method", "get")
			
			form.submit()
	  	} */
	  	
/*  	  	$('.page-link').on("click", function() {
	  		alert("clicked")
	  		let number = $(this).text()
	  		$(this).addClass("active")
	  	}) */
	  	
	  	
	  	$('#dbCheckBtn').on("click", function() {
	  		alert("dbCheckBtn")
	  		var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			let club_title = $('input[name=club_title]').val()
			console.log(club_title)
	  		$.ajax({
	  			beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
				},
				type : 'post',
				url : '/ycc/club/dbCheckClubTitle',
				data : {
					club_title : club_title
				},
				dataType : 'json',
				success : function(result) {
					alert(result)
					if (result == 0) {
						alert("사용 가능한 동아리명입니다.")
					} else {
						alert("중복된 동아리명입니다.")
					}
				},
				error : function() {
					alert("error")
				}
	  		})
	  	})
	  
		let formCheck = function() {
			// html태그와 trim()으로 제거되지 않는 공백문자(=&nbsp;)를 제거
			let res = $('textarea[name=club_info]').val().replace(/&nbsp;|<[^>]*>?/g, '');
			let club_title_list = new Array();
			
			<c:forEach items="${cList}" var="clubDto">
				console.log("${clubDto.club_title}");	
				club_title_list.push("${clubDto.club_title}");
		    </c:forEach>
			
			if($.trim($('input[name=club_title]').val()) == "") {
				alert("동아리명을 입력해 주세요.")
				return false
			}
			
			if($('input[name=club_title]').val().match(/^\s/)) {
				alert("동아리명은 공백으로 시작할 수 없습니다.")
				return false
			}
			
			if($.trim(res) == "") {
				alert("동아리 소개글을 작성해 주세요.")
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
		/* if(!formCheck()) */
	  
/* 	  <c:forEach items="${myClubList}" var="clubDto">
		console.log("${clubDto.club_article_title}");	// 위에 list나 변수를 선언하고 alert 자리에 담으면 차례대로 값을 받는다.
	  </c:forEach> */
	  
  })
  
</script>

	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>