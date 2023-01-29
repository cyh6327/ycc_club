<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="pinfo"/>

<c:if test="${pinfo != 'anonymousUser' }">
	<c:set var="userGrade" value="${pinfo.member.user_grade }" />
</c:if>

<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@include file="/WEB-INF/views/metahead.jsp"%>
  
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
  
  <style type="text/css">
  	.searchBox { background-color: #f1f1f1; }
  	.tdeco-none { text-decoration: none; color: black; }
  </style>
	
	<title>YOUNG문화체육센터</title>
</head>
<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<script>
    function test() {
        $('#cate').val("")
        $('#target').val("")
        $('#stat').val("")
        $('#keyword').val("")
    }
    
		let msg = "${msg}"
		if(msg == "DEL_OK") alert("성공적으로 삭제되었습니다.")
		if(msg == "DEL_ERR") alert("삭제되었거나 없는 게시물입니다.")
		if(msg == "WRT_OK") alert("성공적으로 등록되었습니다.")
		if(msg == "MOD_OK") alert("성공적으로 수정되었습니다.")
		if(msg == "overcapacity") alert("정원이 마감되었습니다.\n새로고침 후 신청인원을 확인해주세요.")
		if(msg == "NO_PERIOD") alert("접수기간이 아닙니다.\n접수기간을 확인해주세요.")
		if(msg == "OVERLAP") alert("중복 신청은 할 수 없습니다.\n나의 수강목록에서 확인해주세요.")
	</script>

	<!-- 본문 -->
	<div class="container mt-5">
		<h2>수강신청</h2>
		<hr>
		<form method="get">
			<div class="searchBox row p-3 d-flex" style="justify-content: space-around;">
				<div class="col-lg-10 row">
					<div class="col-md-4">
						<div class="row">
							<label for="sidebar-position2" class="col-4 align-self-center text-center">분류</label>
							<div class="col-8">
								<select class="form-select" aria-label=".form-select-sm example" name="cate" id="cate">
									<option value="All" ${pr.sc.cate=='All' || pr.sc.cate=='' ? "selected" : ""}>전체</option>
									<option value="Spo" ${pr.sc.cate=='Spo' ? "selected" : ""}>운동</option>
									<option value="Cul" ${pr.sc.cate=='Cul' ? "selected" : ""}>문화</option>
									<option value="Edu" ${pr.sc.cate=='Edu' ? "selected" : ""}>교육</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="row">
							<label for="sidebar-position2" class="col-4 align-self-center text-center">수강대상</label>
							<div class="col-8">
								<select class="form-select"	aria-label=".form-select example" name="target" id="target">
									<option value="All" ${pr.sc.target=='All' || pr.sc.target=='' ? "selected" : ""}>전체</option>
									<option value="Adu" ${pr.sc.target=='Adu' ? "selected" : ""}>성인</option>
									<option value="Stu" ${pr.sc.target=='Stu' ? "selected" : ""}>청소년</option>
									<option value="Chd" ${pr.sc.target=='Chd' ? "selected" : ""}>유아</option>
									<option value="Old" ${pr.sc.target=='Old' ? "selected" : ""}>노인</option>
								</select>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="row">
							<label for="sidebar-position3" class="col-4 align-self-center text-center">접수상태</label>
							<div class="col-8">
								<select class="form-select"	aria-label=".form-select example" name="stat" id="stat">
									<option value="All" ${pr.sc.stat=='All' || pr.sc.stat=='' ? "selected" : ""}>전체</option>
									<option value="P" ${pr.sc.stat=='P' ? "selected" : ""}>접수가능</option>
									<option value="O" ${pr.sc.stat=='O' ? "selected" : ""}>오픈예정</option>
								</select>
							</div>
						</div>
					</div>
					<div role="search" class="col-md-12">
						<input class="form-control" type="text" name="keyword" value="${param.keyword }" placeholder="검색어를 입력해주세요" aria-label="Search" id="keyword">
					</div>
				</div>
				<div class="col-lg-2 align-items-center gap-2" style="display: -webkit-inline-box;">
					<div class="col-lg-6">
						<input type="submit" class="btn btn-primary" value="검색" style="width:100%; height:100%;">
					</div>
					<div class="col-lg-6" >
						<button onclick="test()" class="btn btn-outline-primary" style="width:100%; height:100%; white-space: nowrap;">초기화</button>
					</div>
				</div>
			</div>
			<div class="row py-3 float-end gap-1">
				<select class="form-select col-auto" name="orderby" aria-label=".form-select-sm example" style="width: auto;">
					<option value="New" ${pr.sc.orderby=='New' || pr.sc.orderby=='' ? "selected" : ""}>강좌명순</option>
					<option value="End" ${pr.sc.orderby=='End' ? "selected" : ""}>접수가능순</option>
					<option value="Start" ${pr.sc.orderby=='Start' ? "selected" : ""}>수강시작일순</option>
					<%-- <option value="Star" ${pr.sc.orderby=='Star' ? "selected" : ""}>강의평점순</option> --%>
				</select>
				<button class="col-auto btn btn-secondary">조회</button>
			</div>
		</form>

		<table class="table text-center">
			<thead class="table-light align-middle">
				<tr>
					<th>강좌명</th>
					<th>수강기간</th>
					<th>수강시간</th>
					<th>강사명</th>
					<th>수강료</th>
					<th>접수기간</th>
					<th>상태</th>
				</tr>
			</thead>
			<tbody class="table-group-divider align-middle">
				<c:forEach var="courseDto" items="${list }">
					<tr>
						<td>																			<!-- detailpage에서 목록 버튼클릭시 주소를 유지시키기 위해서 -->
							<a class="tdeco-none" href="<c:url value="/course/detail${pr.sc.queryString }&course_id=${courseDto.course_id }" />">
								${courseDto.course_nm }
							</a>
						</td>
						<td>${courseDto.course_sd() }<br>~${courseDto.course_ed() }</td>
						<td>${courseDto.course_day }<br>${courseDto.course_time }</td>
						<td>${courseDto.user_name }</td>
						<td>${courseDto.course_cost }원</td>
						<td>${courseDto.reg_sd() }<br>~${courseDto.reg_ed() }</td>
						<td>
							<button class="${courseDto.course_stat() == '접수가능' ? 'btn btn-primary' : 'btn btn-secondary' } 
							${courseDto.course_stat() == '정원마감' ? 'btn btn-danger' : '' }">
								${courseDto.course_stat() }
							</button>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav aria-label="Page navigation example">
			<c:if test="${totalCnt == null || totalCnt == 0}">
				<div class="text-center mb-5">게시물이 없습니다.</div>
			</c:if>
			<c:if test="${totalCnt != null && totalCnt != 0}">
				<ul class="pagination justify-content-center">
					<c:if test="${pr.showPrev }">
						<li class="page-item"><a class="page-link" href="<c:url value="/course/search${pr.sc.getQueryString(pr.beginPage-1) }" />"> &lt; </a></li>
					</c:if>
					<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage }">
						<a class="page-link" href="<c:url value="/course/search${pr.sc.getQueryString(i) }" />">${i }</a>
					</c:forEach>
					<c:if test="${pr.showNext }">
						<li class="page-item"><a class="page-link" href="<c:url value="/course/search${pr.sc.getQueryString(pr.endPage+1) }" />"> &raquo; </a></li>
					</c:if>
				</ul>
			</c:if>
		</nav>
		<c:if test="${userGrade == '강사' || userGrade == '관리자' }">
			<div class="text-end">
				<button id="writeBtn" class="btn btn-primary btn_write" onclick="location.href='<c:url value="/course/write" />' ">강좌등록</button>
			</div>
		</c:if>
	</div>

	<!-- footer inlcude -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>