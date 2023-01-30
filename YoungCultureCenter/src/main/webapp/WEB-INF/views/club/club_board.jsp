<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
</head>
<body>
  <!-- header -->
  <%@include file="/WEB-INF/views/header.jsp"%>
  
  <c:set var="clubSelect" value="${clubSelect}"></c:set>
  <c:set var="myClubList" value="${myClubList }"></c:set>

  <!--start container-->
  <div class="container">
    <br>
    
    <h3>${clubSelect[0].club_title}</h3>
    <hr /><br>
    <div class="input-group" style="width: 200px; margin-left:80%; padding-bottom: 20px;">
      <select class="form-select form-select-sm" aria-label=".form-select-sm example"
        style="width: 90px; margin-right: 10px;">
        <option value="1">최신순</option>
        <option value="2">조회순</option>
        <option value="3">관련순</option>
      </select>
    </div>
    <!--게시판 부분-->
    <c:if test="${clubSelect[0].club_article_id != null }">
    <table class="table table-hover">
      <thead>
        <tr>
          <th scope="col" style="text-align: center;">제목</th>
          <th scope="col">글쓴이</th>
          <th scope="col">날짜</th>
          <th scope="col">조회수</th>
        </tr>
      </thead>
      <tbody>
      <c:forEach var="clubDto" items="${clubSelect }">
        <tr>
          <th scope="row"><a href="<c:url value='/club/board/view?club_id=${clubDto.club_id }&club_article_id=${clubDto.club_article_id }' />" class="text-decoration-none">${clubDto.club_article_title }</a></th>
          <td>${clubDto.user_id }</td>
          <td><fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_board_upload_time }" /></td>
          <td>${clubDto.club_article_viewcnt }</td>
        </tr>
	  </c:forEach>
      </tbody>
    </table>
    <!--창 하단 페이지 숫자-->
    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center">
        <li class="page-item disabled">
          <a class="page-link" href="#" tabindex="-1" aria-disabled="true">이전</a>
        </li>
        <li class="page-item"><a class="page-link" href="#">1</a></li>
        <li class="page-item"><a class="page-link" href="#">2</a></li>
        <li class="page-item"><a class="page-link" href="#">3</a></li>
        <li class="page-item"><a class="page-link" href="#">4</a></li>
        <li class="page-item"><a class="page-link" href="#">5</a></li>
        <li class="page-item">
          <a class="page-link" href="#">다음</a>
        </li>
      </ul>
    </nav>
    </c:if>
        <c:if test="${clubSelect[0].club_article_id == null }">
    	<p class="text-center fw-bold">게시글이 없습니다.</p>
    </c:if>
    
    <!--글쓰기 버튼-->
	<a id="writeBtn" class="btn btn-primary float-end" href="<c:url value='/club/board/write?club_id=${param.club_id }' />" role="button">글쓰기</a>
    
    <div class="bottomsearch" style="display: flex; margin-left: 30%; margin-top: 50px;">
      <select class="form-select form-select-sm" aria-label=".form-select-sm example"
        style="width: 90px; margin-right: 10px;">
        <option value="1">제목</option>
        <option value="2">작성자</option>
      </select>
      <input type="text" class="form-control" aria-label="title" aria-describedby="basic-addon1" style="width: 300px;">
      <button type="button" class="btn btn-primary" style="margin-left: 10px;">검색</button>
    </div>
  </div>
  
  <script>
  $(document).ready(function(){
	  
	  let list = new Array();
 	  const url = new URL(window.location.href)
 	  console.log(url)
  	  const urlParams = url.searchParams;
	  var club_id = urlParams.get("club_id")
	  
	  <c:forEach items="${myClubList}" var="clubDto">
		console.log("${clubDto.club_id}");	// 위에 list나 변수를 선언하고 alert 자리에 담으면 차례대로 값을 받는다.
		list.push("${clubDto.club_id}");
	  </c:forEach>
	 
 	  if(!list.includes(club_id)) {
 		 $('#writeBtn').hide()
 	  }
		  
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