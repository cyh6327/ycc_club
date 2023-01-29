<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<title>Young문화센터 - 통합검색</title>
<style type="text/css">
	.paging {
		color: black;
		width: 100%;
		align-items: center;
	}
	
	.page {
		color: black;
		padding: 6px;
		margin-right: 10px;
	}
	
	.paging-container {
		width: 100%;
		height: 70px;
		display: flex;
		margin-top: 50px;
		margin: auto;
		text-align: center;
	}
	
	.noResult {
		font-weight: bold;
		text-align: center;
	}
	
	.nav-link {
		--bs-nav-link-color: black;
	}
	
	.nav-link.active {
		--bs-nav-tabs-link-active-color: blue;
	}
	
	a {
		text-decoration: none;
		color: black;
	}
	
	ul {
		list-style-type: none;
	}
	
	form > ul > li {
		display: list-item;
		border-bottom : 1px solid lightgrey;
	}
	.bold {
		font-weight: bold;
	}
	.cont{display:none;}
	.is_on.cont{display:block;}
	
	
</style>
</head>
<body>
<!-- header inlcude -->
<%@include file="/WEB-INF/views/header.jsp"%>

<body>

<script type="text/javascript">
	var csrfHeaderName = "${_csrf.headerName}"
	var csrfTokenValue= "${_csrf.token}"
	$(document).ready(function() {
		const url = new URL(window.location.href)	//현재 페이지의 url 객체 생성
    	const urlParams = url.searchParams;			//url의 파라미터를 가져옴
    	const param = urlParams.get('type')			//url의 type 파라미터 값
    	const keyword = urlParams.get('keyword')	//url의 keyword 파라미터 값
		$.ajax({
			type : 'get',
		    url: '/ycc/search/array',
		    dataType : 'json',
		    data : {keyword:keyword},
		    headers: { "content-type" : "application/json" },
		    success : function(data) {
		    	$("ul.nList").html(printNList(data))
		        $("ul.eList").html(printEList(data))
		        $("ul.courseList").html(printCourseList(data))
		    },
		    error : function(data) { 
		    	alert("error")
		    }
		})
 
		// 검색어 자동완성
		$('#search').autocomplete({
			source : function(request, response) { //source: 글자 입력시 보일 목록
			     $.ajax({
			 		beforeSend: function(xhr) {
						console.log("beforeSend")
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					},
			           url : "/ycc/search/autocomplete"   
			         , type : "POST"
			         , dataType: "JSON"
					 , data : {value: request.term, type: param}	
			         	// type: param => url의 type 파라미터
			         , success : function(data){
						let arr = [];
 						for(var i = 0; i < data.resultList.length; i++) {
							arr.push(data.resultList[i].article_title)
							arr.push(data.resultList[i].course_nm)
						} 
						let set = new Set(arr);		//중복값이 있는 배열을 Set 객체로 만들어서 중복을 제거한 후,
 						let setToArr = [...set];	//Spread Operator(전개연산자)를 사용하여 Set 객체를 다시 배열로 변환
 						// 위 반복문에서 생성되는 undefined를 필터링해서 제거해줌
 						let arrUnique = setToArr.filter((element) => element !== undefined);
							response(
								// $.map : arrUnique 배열을 label, value의 형태로 변경
								$.map(arrUnique, function(item) {
									return { label:item, value:item }
								})
							)								
			         	}
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
    	 
    	
  		$("#arrayBtn").click(function() {
 	     	 const array = $('#array option:selected').val()
 	    	 console.log(array) 
				$.ajax({
					type : 'get',
					url: '/ycc/search/array/',
					dataType : 'json',
					data: {array:array, keyword:keyword} ,
					headers: { "content-type" : "application/json" },
					success : function(data) {
						$("ul.nList").html(printNList(data))
						$("ul.eList").html(printEList(data))
						$("ul.courseList").html(printCourseList(data))
					},
					error : function(data) { 
						alert("error")
					}
			   	})
 		}) 
 					 
 		let printNList = function(data) {
 			let tmp = ''
 			for(idx in data.nList) {
 				tmp += '<li>'
 		 		tmp += '<div class="p-3">'
 		 		tmp += '<h5 id="nTitle" class="fw-bold">'
 		 		tmp += '<a href="<c:url value="/board/post?article_id='+data.nList[idx].article_id+'" />">' + data.nList[idx].article_title + '</a>'
 		 		tmp += '</h5>'
 		 		tmp += '<p>' + data.nList[idx].article_contents + '</p>'
 		 		tmp += '<div class="d-flex flex-row">'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">작성자</span>'
 		 		tmp += '<span class="fw-light">' + data.nList[idx].user_id + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">작성일</span>'
 		 		tmp += '<span class="fw-light">' + data.nList[idx].article_date + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">조회수</span>'
 		 		tmp += '<span class="fw-light">' + data.nList[idx].article_viewcnt + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '</div>'
 		 		tmp += '</div>'
 		 		tmp += '</li>'
 			};
	 		return tmp += ''
 		}
  		
 		let printEList = function(data) {
 			let tmp = ''
 			for(idx in data.eList) {
 				tmp += '<li>'
 		 		tmp += '<div class="p-3">'
 		 		tmp += '<h5 id="eTitle" class="fw-bold">'
 		 		tmp += '<a href="<c:url value="/board/post?article_id='+data.eList[idx].article_id+'" />">' + data.eList[idx].article_title + '</a>'
 		 		tmp += '</h5>'
 		 		tmp += '<p>' + data.eList[idx].article_contents + '</p>'
 		 		tmp += '<div class="d-flex flex-row">'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">작성자</span>'
 		 		tmp += '<span class="fw-light">' + data.eList[idx].user_id + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">작성일</span>'
 		 		tmp += '<span class="fw-light">' + data.eList[idx].article_date + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">조회수</span>'
 		 		tmp += '<span class="fw-light">' + data.eList[idx].article_viewcnt + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '</div>'
 		 		tmp += '</div>'
 		 		tmp += '</li>'
 			};
	 		return tmp += ''
 		}
 		
 		let printCourseList = function(data) {
 			let tmp = ''
 			for(idx in data.courseList) {
 				tmp += '<li>'
 		 		tmp += '<div class="p-3">'
 		 		tmp += '<h5 id="cTitle" class="fw-bold">'
 		 		tmp += '<a href="<c:url value="/course/detail?course_id='+data.courseList[idx].course_id+'" />">' + data.courseList[idx].course_nm + '</a>'
 		 		tmp += '</h5>'
 		 		tmp += '<p>' + data.courseList[idx].course_info + '</p>'
 		 		tmp += '<div class="d-flex flex-row">'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">강사명</span>'
 		 		tmp += '<span class="fw-light">' + data.courseList[idx].user_id + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">수강시간</span>'
 		 		tmp += '<span class="fw-light">' + data.courseList[idx].course_day + '</span>'
 		 		tmp += '<span class="fw-light">' + data.courseList[idx].course_time + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '<span class="pe-4">'
 		 		tmp += '<span class="fw-bold">수강료</span>'
 		 		tmp += '<span class="fw-light">' + data.courseList[idx].course_cost + '</span>'
 		 		tmp += '</span>'
 		 		tmp += '</div>'
 		 		tmp += '</div>'
 		 		tmp += '</li>'
 			};
	 		return tmp += ''
 		}

		const content = document.querySelectorAll('.cont');
		const active = document.querySelectorAll('.tab_menu .list li a');
		// 각 탭을 클릭하면
		$(".nav-link").click(function(e) {
			e.preventDefault();
			// 탭 클릭시 is on, active 클래스 요소를 삭제(초기화시킴)
			for(var j = 0; j < content.length; j++){
				// .cont 클래스를 가진 태그에서 'is_on' class를 모두 삭제
		        content[j].classList.remove('is_on');
		      }
			for(var i = 0; i <= content.length; i++){
				// 탭의 a 태그에서 'active' class를 모두 삭제 
		        active[i].classList.remove('active');
		      }
			// 각 탭을 클릭했을 때 is on 요소를 줌 ==> .is_on.cont{display:block;} 가 되면서 해당 컨텐츠 부분이 나타남
			// 각 탭 활성화
			if($(this).hasClass("notice") === true){
				$("#notice").addClass("is_on")
				$(".nav-link.notice").addClass("active")
			} else if($(this).hasClass("event") === true) {
				$("#event").addClass("is_on")
				$(".nav-link.event").addClass("active")
			} else if($(this).hasClass("course") === true) {
				$("#course").addClass("is_on")
				$(".nav-link.course").addClass("active")
			} /* else if($(this).hasClass("club") === true) {
				$("#club").addClass("is_on")
				$(".nav-link.club").addClass("active")
			} */ else {	// 전체 탭
				$("#notice").addClass("is_on")
				$("#event").addClass("is_on")
				$("#course").addClass("is_on")
				/* $("#club").addClass("is_on") */
				$(".nav-link.all").addClass("active")
			}
		})
	})

</script>	
	<!-- 검색창 -->
	<div class="m-5">
		<h2 class="m-4">통합검색</h2>
			<div class="m-4">
				<form action="<c:url value="/search" />" class="search-form" method="get">
					<div class="row">
						<div class="col-10">
							<input id="search" name="keyword" type="text" class="form-control" value="${param.keyword }" 
							 placeholder="검색어를 입력해주세요." aria-label="search" aria-describedby="button-addon2">
						</div>
						<div class="col-2">
							<button class="btn btn-success" type="submit" id="button-addon2" style="width: 100%;">검색</button>
						</div>
					</div>
				</form>
			</div>
		
		<!-- 탭 -->
		<div class="tab_menu m-4">
			<ul class="list nav nav-tabs">
				<!-- Controller에서 정의된 totalCnt(select 서브쿼리로 select count 구현) -->
				<li class="nav-item"><a class="nav-link all active" aria-current="page" href="#">
					전체(${totalCnt }건)</a></li>
				<li class="nav-item">
					<!-- dto에 count를 추가해 count 출력 ==> Mapper에서 서브쿼리로 select count(*) -->
					<a class="nav-link notice" href="#notice">
						공지사항(${noticeList[0].count == null ? "0" : noticeList[0].count }건)</a>
				</li>
				<li class="nav-item"><a class="nav-link event" href="#event">
					이벤트(${eventList[0].count == null ? "0" : eventList[0].count }건)</a></li>
<%-- 				<li class="nav-item"><a class="nav-link club" href="#club">
					동아리(${clubList[0].count == null ? "0" : clubList[0].count }건)</a></li> --%>
				<li class="nav-item"><a class="nav-link course" href="#course">
					강좌(${courseList[0].count == null ? "0" : courseList[0].count }건)</a></li>
			</ul>
		</div>

		<div>
			<form id="frm" action="<c:url value="/search" />" class="search-form" method="get">
				<input name="keyword" type="hidden" value="${param.keyword }" /> 
				<!-- 검색시 기본적으로 정확도순으로 정렬됨. 키워드랑 완전히 일치하는 검색결과일 경우 0점으로 가장 우선순위로 조회되고,
				키워드 앞 뒤에 키워드 이외의 글자가 많이 붙어있을수록(1점, 2점, ...) 우선순위가 낮아지는 식 (searchMapper) -->
				<div class="row float-end me-4 array">
				<select class="form-select form-select-sm col-auto" id="array" name="array" aria-label=".form-select-sm example" style="width: auto; margin-right: 10px;">
						<option value="A" ${pr.sc.array=='A' || pr.sc.array=='' ? "selected" : ""}>정확도순</option>
						<option value="V" ${pr.sc.array=='V' ? "selected" : ""}>조회순</option>
						<option value="N" ${pr.sc.array=='N' ? "selected" : ""}>최신순</option>
					</select>   
					<!-- <input type="submit" class="search-button btn btn-secondary col-auto" value="정렬"> -->
					<input type="button" id="arrayBtn" class="search-button btn btn-secondary col-auto" value="정렬">
				</div>
			</form>
			<p class="ms-5 mt-3">총 <b>${totalCnt }</b>건이 검색되었습니다.</p>
		</div>
		
		<!-- 공지사항 -->
		<div class="p-5	">
			<div id="notice" class="p-3 is_on cont">
				<h4 class="text-start fw-bold">공지사항 (${noticeList[0].count == null ? "0" : noticeList[0].count }건)</h4>
				<hr>
				<!-- 더보기 버튼 클릭시 type="공지사항" 파라미터 넘김 -> all 페이지에서 파라미터 받고 그에 공지사항 결과만 가져오게끔 함 -->
				<form action="<c:url value="/search/all?type=${noticeList[0].article_Board_type }" />">
					<input type="hidden" name="type" value="${noticeList[0].article_Board_type }" /> 
					<input type="hidden" name="keyword" value="${param.keyword }" />
					<!-- choose 태그로 검색결과가 없을 때는 결과 없다는 문구만 출력, 검색결과가 있으면 검색결과 출력 -->
					<c:choose>
						<c:when test="${noticeList[0].count == 0 || noticeList[0].count == null}">
							<p class="noResult m-5">검색결과가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<!-- 검색결과가 6개 이상이면 더보기 버튼 활성화 -->
							<c:if test="${noticeList[0].count gt 5}">
								<input style="float: right;" class="btn btn-write" type="submit" value="더보기" >
							</c:if>	
							<ul class="mx-3 nList"style="padding-left: 0px;margin-bottom: 0px;">
							</ul>
						</c:otherwise>
					</c:choose>
				</form>
			</div>
			
			<!-- 이벤트 -->
			<div id="event" class="p-3 is_on cont">
				<h4 class="text-start fw-bold">이벤트 (${eventList[0].count == null ? "0" : eventList[0].count }건)</h4>
				<hr>
				<form action="<c:url value="/search/all?type=${eventList[0].article_Board_type }" />">
					<input type="hidden" name="type" value="${eventList[0].article_Board_type }" /> 
					<input type="hidden" name="keyword" value="${param.keyword }" />
					<c:choose>
						<c:when test="${eventList[0].count == 0 || eventList[0].count == null}">
							<p class="noResult m-5">검색결과가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:if test="${eventList[0].count gt 5}">
								<input style="float: right;" class="btn btn-write" type="submit" value="더보기" >
							</c:if>	
							<ul class="mx-3 eList"style="padding-left: 0px;margin-bottom: 0px;">
							</ul>
						</c:otherwise>
					</c:choose>
				</form>
			</div>
			
			<!-- 동아리 -->
<%-- 			<div id="club" class="p-3 is_on cont">
				<h4 class="text-start fw-bold">동아리 (${clubList[0].count == null ? "0" : clubList[0].count }건)</h4>
				<hr>
				<c:set var="club" value="동아리" />
				<form action="<c:url value="/search/all?type=${club }" />">
					<input type="hidden" name="type" value="${club }" /> 
					<input type="hidden" name="keyword" value="${param.keyword }" />
					<c:choose>
						<c:when test="${clubList[0].count == 0 || clubList[0].count == null}">
							<p class="noResult m-5">검색결과가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:if test="${clubList[0].count gt 5}">
								<input style="float: right;" class="btn btn-write" type="submit" value="더보기" >
							</c:if>	
							<ul class="mx-3"style="padding-left: 0px;margin-bottom: 0px;">
								<c:forEach var="ClubDto" items="${clubList }">
									<li>
										<div class="p-3">
											<h5 id="aTitle" class="fw-bold"><a href="<c:url value="/board/post" />">${ClubDto.club_title }</a></h5>
											<p>${ClubDto.club_info }</p>
											<div class="d-flex flex-row">
												<span class="pe-4">
													<span class="fw-bold">동아리장</span>
													<span class="fw-light">${ClubDto.club_master_id }</span>
												</span>
												<span class="pe-4">
													<span class="fw-bold">개설일</span>
													<span class="fw-light"><fmt:formatDate pattern="yyyy-MM-dd" value="${ClubDto.club_create_time }" /></span>
												</span>
											</div>
										</div>
									</li>
								</c:forEach>
							</ul>
						</c:otherwise>
					</c:choose>
				</form>
			</div> --%>

			<!-- 강좌 -->
			<div id="course" class="p-3 is_on cont">
				<h4 class="text-start fw-bold">강좌 (${courseList[0].count == null ? "0" : courseList[0].count }건)</h4>
				<hr>
				<c:set var="course" value="강좌" />
				<form action="<c:url value="/search/all?type=${course }" />">
					<input type="hidden" name="type" value="${course }" /> 
					<input type="hidden" name="keyword" value="${param.keyword }" />
					<c:choose>
						<c:when test="${courseList[0].count == 0 || courseList[0].count == null}">
							<p class="noResult m-5">검색결과가 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:if test="${courseList[0].count gt 5}">
								<input style="float: right;" class="btn btn-write" type="submit" value="더보기" >
							</c:if>	
							<ul class="mx-3 courseList"style="padding-left: 0px;margin-bottom: 0px;">
							</ul>
						</c:otherwise>
					</c:choose>
				</form>
			</div>
		</div>
	</div>
	
	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>