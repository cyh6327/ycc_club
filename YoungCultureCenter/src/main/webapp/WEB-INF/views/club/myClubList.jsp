<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% pageContext.setAttribute("replaceStr", "\\"); %>

<!DOCTYPE html>
<html>

<head>
	<!-- head & meta tag include -->
  <%@include file="/WEB-INF/views/metahead.jsp"%>
  
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<title>Young문화센터 - 내 동아리 전체보기</title>
	
	<style type="text/css">
		.paging { color: black; width: 100%; align-items: center; }
		.page { color: black; padding: 6px; margin-right: 10px; }
		.paging-container { width: 100%; height: 70px; display: flex; margin-top: 50px; margin: auto; text-align: center; }
		a { text-decoration: none; color: black; }
		ul { list-style-type: none; }
		form > ul > li { display: list-item; border-bottom : 1px solid lightgrey; }
		.bold { font-weight: bold; }
	</style>
</head>

<body>
	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	<div class="m-5 p-5">
    	<h2 class="m-4 py-3 fw-bold">내 동아리</h2>
    	<hr>
			<div class="m-3 px-2 py-5">
				<c:forEach var="clubDto" items="${myClubList }">
					<div class="text-start px-4">
						<div class="d-flex me-auto">
							<div id="result_card" class="mx-3 mb-3" style="height: 150px; width: 150px;">
							<c:set var="upload_path" value="${fn:replace(clubDto.upload_path, replaceStr, '&#47;')}" />
							<c:set var="fileCallPath" value="${upload_path }/s_${clubDto.uuid }_${clubDto.file_name }"  />
								<c:choose>
									<c:when test="${clubDto.uuid != null }">
										<img class="w-100 h-100 p-0" src='<%=request.getContextPath()%>/club/display?file_name=${fileCallPath}'>
									</c:when>
									<c:otherwise>
										<img class="w-100 h-100 p-0" src='<%=request.getContextPath()%>/resources/img/club/no_image.png'>
									</c:otherwise>
								</c:choose>
							</div>
						<!-- 동아리 이동(제목클릭) -->
						<div class="text-truncate block">
							<a href="<c:url value='/club/board?club_id=${clubDto.club_id }'/>" method="GET" style="text-decoration: none; text-decoration-color: none;">
							<h5 class="mt-2 fw-bold">${clubDto.club_title }</h5>
							<small class="text-muted">동아리장 : ${clubDto.club_master_id } | 멤버수 : ${clubDto.club_member_cnt }명 | 생성일 : <fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_create_time }" /></small></a>
							<a href="#" class="text-reset text-decoration-none"><p class="mb-2">${clubDto.club_article_title }</p></a>
							<div class="txt text-start">${clubDto.club_info }</div>
						</div>
						
					</div>
					<hr>
					</div>
				</c:forEach>
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
							href="<c:url value="/club/myClubList${pr.sc.getQueryString(pr.beginPage-1) }" />">&lt; </a></li>
						</c:if>
						<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage }">
							<li class="page-item"><a class="page-link" 
							href="<c:url value="/club/myClubList${pr.sc.getQueryString(i)}" />">${i }</a></li>
						</c:forEach>
						<c:if test="${pr.showNext }">
							<li class="page-item"><a class="page-link" 
							href="<c:url value="/club/myClubList${pr.sc.getQueryString(pr.endPage+1) }" />">&gt; </a></li>
						</c:if>
					</c:if>
				</div>
				</ul>
			</nav>
			
	</div>
     
  <!-- footer inlcude -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>