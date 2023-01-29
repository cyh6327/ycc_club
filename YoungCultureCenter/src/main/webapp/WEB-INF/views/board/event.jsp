<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
    <title>이벤트/행사 게시판</title>
</head>

  <body>
  <!-- header inlcude -->
<%@include file="/WEB-INF/views/header.jsp"%>
<div class="container pt-5">
  <h2 class="eventTitle">
  	<a id="eventList">이벤트/행사</a>
  </h2>
  <!-- 게시판 테이블 -->
		
		<table class="table table-group-divider  table table-striped table table-hover mt-5" >
			<colgroup>
				<col width="50%">
				<col width="15%">
				<col width="20%">
				<col width="15%">
			</colgroup>
			<thead>
		 		<tr class="table-primary">
				     <th scope="col" class="title" style="text-align: center; ">제목</th>
					 <th scope="col" class="writer" style="text-align: center; ">작성자</th>
					 <th scope="col" class="regdate" style="text-align: center; ">작성일</th>
					 <th scope="col" class="viewcnt" style="text-align: center; ">조회수</th>
				</tr>
			</thead>
	
			<c:forEach var="boardDto" items="${eList }">
				<tr>
					<td class="title"  >
						<a style="text-decoration: none; color: black;" href="<c:url value="/board/post${pr.sc.queryString }&article_id=${boardDto.article_id  }"/>">
							${boardDto.article_title }
		      			</a>
					</td>
					<td class="writer" style = text-align:center;>${boardDto.user_id }</td>
					<td class="regdate" style = text-align:center;><fmt:formatDate value="${boardDto.article_date }" pattern="yyyy-MM-dd" type="date"/></td>
					<td class="viewcnt" style = text-align:center;>${boardDto.article_viewcnt }</td>
				</tr>
			</c:forEach>
		 </table>
		 
		 			 <!-- 작성하기 버튼  -->
		<!-- 관리자만 보이도록 구현하기 -->
		 <sec:authentication property="principal" var="pinfo"/>
		 <sec:authorize access="isAuthenticated()">
			<c:if test ="${pinfo.member.user_grade eq '관리자'}">
				<div class="row">
					<div class="col">
						<a id="writeBtn" class="btn btn-primary " style="float:right" onclick="location.href='<c:url value="/board/write" />' "role="button">작성하기</a>    	
		 			</div>
				</div>
			</c:if>
		</sec:authorize>
		
	


		<!-- 페이징 시작 -->
		<div class="paging-container">
			<ul class="pagination pt-3" style="justify-content: center;">
				<c:if test="${totalCnt == null || totalCnt == 0}">
					<div>게시물이 없습니다.</div>
				</c:if>
				<c:if test="${totalCnt != null || totalCnt != 0}">
					<c:if test="${pr.showPrev}">
						<a class="page-link " href="/ycc/board/event${pr.sc.getQueryString(pr.beginPage-1)}">이전</a>
					</c:if>
					<c:forEach var="i" begin="${pr.beginPage}" end="${pr.endPage}">
					<c:if test="${pr.sc.page == i }">
						<c:if test="${pr.sc.page > 0 }">
							<li class="page-item active"><a class="page-link" href="/ycc/board/event${pr.sc.getQueryString(i)}">${i}</a></li>
						</c:if>
					</c:if>
					<c:if test="${pr.sc.page != i }">
						<c:if test="${pr.sc.page > 0 }">
							<li class="page-item"><a class="page-link" href="/ycc/board/event${pr.sc.getQueryString(i)}">${i}</a></li>
						</c:if>
					</c:if>
					</c:forEach>
					<c:if test="${pr.showNext }">
						<a class="page-link" href="<c:url value="/board/event${pr.sc.getQueryString(pr.endPage + 1) }" />">다음</a>
					</c:if>
				</c:if>
			</ul>
		</div>
		<!-- 페이징 끝 -->
		

	
		<!-- 검색 -->
		<div class="container text-center">
			<form action="<c:url value= "/board/event"/>" class="searchForm" method="get">
				<div class="row justify-content-md-center pt-5 pb-5">
					<div class = "col-sm-auto px-1">
						<select class="form-select" name="option" style="width: 150px;">
							<option selected>전체</option>
							<option value="T" ${pr.sc.option == 'T' ? "selected" : ""}>제목</option>
							<option value="TC" ${pr.sc.option == 'TC' || pr.sc.option == '' ? "selected" : ""}>제목 + 내용</option>
							<option value="W" ${pr.sc.option == 'W' ? "selected" : ""}>작성자</option>
						</select>
					</div>
					<!-- keyword입력부분 -->
					<div class="col-sm-auto px-1">
						<input type="text" name="keyword" class="form-control" value="${param.keyword }" placeholder="검색어를 입력해주세요"  style="width: 340px;">
					</div>
					<!-- 검색버튼 -->
					<div class="col-sm-auto px-1">
						<input type="submit" id="search_button" class="btn btn-secondary"  value="검색" >
					</div>
	 			</div>
	 		</form>
	 	</div>
 	<!-- 검색 끝 -->
	</div>
  <!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
  <script type="text/javascript">
  
	//이벤트 클릭시 공지사항 첫 페이지로 이동 
	$("#eventList").on("click", function() {
		location.href ="<c:url value='/board/event'/>";
	})

  </script>
  
  
</body>

</html>