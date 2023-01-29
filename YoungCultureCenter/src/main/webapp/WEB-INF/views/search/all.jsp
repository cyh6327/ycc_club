<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<head>
	<!-- head & meta tag include -->
  <%@include file="/WEB-INF/views/metahead.jsp"%>
  
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<title>Young문화센터 - 전체보기</title>
	
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
<script type="text/javascript">

	$(document).ready(function() {
		
      	 const url = new URL(window.location.href)
    	 const urlParams = url.searchParams;
    	 const param = urlParams.get('type')
		 
		// 검색어 자동완성
		$('#search').autocomplete({

			source : function(request, response) { //source: 입력시 보일 목록
			     $.ajax({
			           url : "/ycc/search/autocomplete"   
			         , type : "POST"
			         , dataType: "JSON"
			         , data : {value: request.term, type: param}	
			         , success : function(data){

						var arr = [];
 						for(var i = 0; i < data.autocompleteAll.length; i++) {
							arr.push(data.autocompleteAll[i].article_title)
							arr.push(data.autocompleteAll[i].course_nm)
						} 
 						
 						const set = new Set(arr);	//중복값이 있는 배열을 Set 객체로 만들어서 중복을 제거한 후,
 						const setToArr = [...set];	//Spread Operator(전개연산자)를 사용하여 Set 객체를 다시 배열로 변환
 						
 						// 위 반복문에서 생성되는 undefined를 필터링해서 제거해줌
 						var arrUnique = setToArr.filter((element) => element !== undefined);
 						
						response(
								$.map(arrUnique, function(item) {
									return { label:item, value:item }
								})
						)	//response
						
			         } //success
			         ,error : function(){ //실패
			             alert("오류가 발생했습니다.");
			         }
			     });
			}
			,focus : function(event, ui) { // 방향키로 자동완성단어 선택 가능하게 만들어줌	
					return false;
			}
			,minLength: 1// 최소 글자수
			,autoFocus : true // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
			,delay: 100	//autocomplete 딜레이 시간(ms)
			,select : function(evt, ui) { 
		      	// 아이템 선택시 실행 ui.item 이 선택된 항목을 나타내는 객체, lavel/value/idx를 가짐
					console.log(ui.item.label);
					console.log(ui.item.idx);
			 }
		});
	})
</script>

	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	<div class="m-5">
		<div class="m-4">
			<form action="<c:url value="/search/all?type=${type }" />" class="search-form" method="get">
				<div class="row">
					<div class="col-10">
					<!-- all 페이지 내에서의 검색(해당 카테고리의 검색결과) -->
						<input name="keyword" type="text" id="search" class="form-control" value="${param.keyword }"
						placeholder="현재 페이지 내에서 검색" aria-label="search" aria-describedby="button-addon2">
						<input name="type" type="hidden" value="${param.type }">
					</div>
					<div class="col-2">
						<button class="btn btn-success" type="submit" id="button-addon2" style="width: 100%;">검색</button>
					</div>
				</div>
			</form>
		</div>
    
    <h2 class="m-4 fw-bold">${param.type }</h2>
    <hr>
     
		<div>
			<form id="frm" action="<c:url value="/search/all?type=${type }" />" class="search-form" method="get">
				<input name="keyword" type="hidden" value="${param.keyword }" /> 
				<input name="type" type="hidden" value="${param.type }">
				<div class="row float-end me-4">
					<select class="form-select form-select-sm col-auto" name="array" 
					aria-label=".form-select-sm example" style="width: auto; margin-right: 10px;">
						<option value="A" ${pr.sc.array=='A' || pr.sc.array=='' ? "selected" : ""}>정확도순</option>
						<option value="V" ${pr.sc.array=='V' ? "selected" : ""}>조회순</option>
						<option value="N" ${pr.sc.array=='N' ? "selected" : ""}>최신순</option>
					</select> 
					<input type="submit" class="search-button btn btn-secondary col-auto" value="정렬">
				</div>
			</form>
		</div>
		
		<!-- queryString에 입력되는 type을 type으로 선언 -->
    <c:set var ="type" value ="${param.type}"/>
		<input class="fw-bold" type="hidden" name="type" value="${param.type}" />

		<div class="m-3">
			<p>총 <b>${totalCnt }</b>건이 검색되었습니다.</p>
	
			<!-- 파라미터로 받은 type에 따라서 해당하는 type의 검색결과만 출력 -->        
			<!-- 선언된 type 즉, queryString의 type이 공지사항이면 실행 -->
			<c:choose>
				<c:when test="${fn:contains(type, '공지사항')}">
					<div class="p-3">
						<form action="<c:url value="/search/all?type=${noticeList[0].article_Board_type }" />">
							<input type="hidden" name="type" value="${noticeList[0].article_Board_type }" /> 
							<input type="hidden" name="keyword" value="${param.keyword }" />
							<ul class="mx-3"style="padding-left: 0px;margin-bottom: 0px;">
								<!-- 공지사항 리스트 출력 -->
								<c:forEach var="BoardDto" items="${noticeList }">
									<li>
										<div class="p-3">
											<h5 id="nTitle" class="fw-bold">
												<a href="<c:url value="/board/post?article_id=${BoardDto.article_id  }" />">${BoardDto.article_title }</a>
											</h5>
											<p>${BoardDto.article_contents }</p>
											<div class="d-flex flex-row">
												<span class="pe-4"></span>
												<span class="fw-bold">작성자</span>
												<span class="fw-light">${BoardDto.user_id }</span>
												<span class="pe-4"></span>
												<span class="fw-bold">작성일</span>
												<span class="fw-light"><fmt:formatDate pattern="yyyy-MM-dd" value="${BoardDto.article_date }" /></span>
												<span class="pe-4"></span>
												<span class="fw-bold">조회수</span>
												<span class="fw-light">${BoardDto.article_viewcnt }</span>			
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</form>
					</div>
				</c:when>
				
				<c:when test="${fn:contains(type, '이벤트')}">
					<div class="p-3">
						<form action="<c:url value="/search/all?type=${eventList[0].article_Board_type }" />">
							<input type="hidden" name="type" value="${eventList[0].article_Board_type }" /> 
							<input type="hidden" name="keyword" value="${param.keyword }" />
							<ul class="mx-3"style="padding-left: 0px;margin-bottom: 0px;">
								<c:forEach var="BoardDto" items="${eventList }">
									<li>
										<div class="p-3">
											<h5 id="eTitle" class="fw-bold">
												<a href="<c:url value="/board/post?article_id=${BoardDto.article_id }" />">${BoardDto.article_title }</a>
											</h5>
											<p>${BoardDto.article_contents }</p>
											<div class="d-flex flex-row">
												<span class="pe-4"></span>
												<span class="fw-bold">작성자</span>
												<span class="fw-light">${BoardDto.user_id }</span>
												<span class="pe-4"></span>
												<span class="fw-bold">작성일</span>
												<span class="fw-light"><fmt:formatDate pattern="yyyy-MM-dd" value="${BoardDto.article_date }" /></span>
												<span class="pe-4"></span>
												<span class="fw-bold">조회수</span>
												<span class="fw-light">${BoardDto.article_viewcnt }</span>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</form>
					</div>
				</c:when>
	
				<c:when test="${fn:contains(type, '동아리')}">
					<div id="club" class="p-3 is_on cont">
	<%-- 				<c:set var="course" value="동아리" /> --%>
						<form action="<c:url value="/search/all?type=${club }" />">
							<input type="hidden" name="type" value="${club }" /> 
							<input type="hidden" name="keyword" value="${param.keyword }" />
							<ul class="mx-3"style="padding-left: 0px;margin-bottom: 0px;">
								<c:forEach var="ClubDto" items="${clubList }">
									<li>
										<div class="p-3">
											<h5 id="aTitle" class="fw-bold"><a href="<c:url value="/board/post" />"> ${ClubDto.club_title }</a></h5>
											<p>${ClubDto.club_info }</p>
											<div class="d-flex flex-row">
												<span class="pe-4"></span>
												<span class="fw-bold">동아리장</span>
												<span class="fw-light">${ClubDto.club_master_id }</span>
												<span class="pe-4"></span>
												<span class="fw-bold">개설일</span>
												<span class="fw-light"><fmt:formatDate pattern="yyyy-MM-dd" value="${ClubDto.club_create_time }" /></span>		
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</form>
					</div>
				</c:when>
	
	
				<c:when test="${fn:contains(type, '강좌')}">
					<div id="course" class="p-3 is_on cont">
	<%-- 				<c:set var="course" value="강좌" /> --%>
						<form action="<c:url value="/search/all?type=${course }" />">
							<input type="hidden" name="type" value="${course }" />
							<input type="hidden" name="keyword" value="${param.keyword }" />
							<ul class="mx-3"style="padding-left: 0px;margin-bottom: 0px;">
								<c:forEach var="CourseDto" items="${courseList }">
									<li>
										<div class="p-3">
											<c:set var="course_id" value="${CourseDto.course_id }" />
											<h5 id="cTitle" class="fw-bold">
												<a href="<c:url value="/course/detail?course_id=${course_id }" />">${CourseDto.course_nm }</a>
											</h5>
											<p>${CourseDto.course_info }</p>
											<div class="d-flex flex-row">
												<span class="pe-4"></span>
												<span class="fw-bold">강사명</span>
												<span class="fw-light">${CourseDto.user_id }</span>
												<span class="pe-4"></span>
												<span class="fw-bold">수강시간</span>
												<span class="fw-light">${CourseDto.course_day }</span>
												<span class="fw-light">${CourseDto.course_time }</span>
												<span class="pe-4"></span>
												<span class="fw-bold">수강료</span>
												<span class="fw-light">${CourseDto.course_cost } 원</span>			
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</form>
					</div>
				</c:when>
			</c:choose>
		</div>

		<div class="paging-container">
			<div class="paging">
				<c:if test="${totalCnt == null || totalCnt == 0 }">
					<div>게시물이 없습니다.</div>
				</c:if>
				<c:if test="${totalCnt != null || totalCnt != 0 }">
					<c:if test="${pr.showPrev }">
						<a class="page" href="<c:url value="/search/all${pr.sc.getQueryString(pr.beginPage-1) }" />">&lt; </a>
					</c:if>
					<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage }">
						<a class="page" href="<c:url value="/search/all${pr.sc.getQueryString(i)}" />">${i }</a>
					</c:forEach>
					<c:if test="${pr.showNext }">
						<a class="page" href="<c:url value="/search/all${pr.sc.getQueryString(pr.endPage+1) }" />">&gt; </a>
					</c:if>
				</c:if>
			</div>
		</div>
	</div>
     
  <!-- footer inlcude -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>