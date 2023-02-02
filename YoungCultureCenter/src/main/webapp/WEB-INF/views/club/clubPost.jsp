<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>

<!-- head & meta tag include -->
<%@include file="/WEB-INF/views/metahead.jsp"%>


<title>동아리 게시글 상세보기</title>
</head>
<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	<c:set var="user_id" value="${user_id}"></c:set>
	<c:set var="commentSelect" value="${commentSelect}"></c:set>
	
	<main class="mt-5 pt-5">
		<div class="container px-4">
			<h4></h4>
					<div class="card mb-4">
	    				<div class="card-body p-5">
    						<!-- 게시글 정보 -->
    						<form id="form" action="" method="post">
    							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">	
	    						<input type="hidden" name="club_article_title" value="${postSelect[0].club_article_title }" />
	    						<input type="hidden" name="club_article_id" value="${param.club_article_id }" />
	    						<input type="hidden" name="club_id" value="${postSelect[0].club_id }" />
	    						<!-- <input type="hidden" name="_method" value="delete"/> -->
	    						<c:set var="postSelect" value="${postSelect}"></c:set>
	  							<h3 class="title fw-bold">${postSelect[0].club_article_title }</h3>
	  							<div class="d-flex">
		  							<span class="writingInfo flex-grow-1">작성자 : ${postSelect[0].user_id} |
		   								게시일 : <fmt:formatDate value="${postSelect[0].club_board_upload_time }" pattern="yyyy-MM-dd" type="date"/> 
		  								| 조회수 : ${postSelect[0].club_article_viewcnt }
		  							</span>
		  							<!-- 본인이 쓴 게시글에만 수정, 삭제 가능 -->
									<!-- 세션 아이디와 boardDto에 저장된 아이디가 같으면 수정, 삭제 버튼 활성화 -->
									<sec:authentication property="principal" var="pinfo"/>
									<sec:authorize access="isAuthenticated()">
										<c:if test="${pinfo.member.user_id eq postSelect[0].user_id}">
										<span>
							  				<button type="button" class="btn btn-sm btn-primary" id="modifyBtn">
							  				<i class="bi bi-pen"></i>수정</button>
							  				<button type="button" class="btn btn-sm btn-danger" id="deleteBtn">
								  			<i class="bi bi-trash3"></i>삭제</button>
							  			</span> 
							      		</c:if>
						      		</sec:authorize>
	 							</div>
	 							<hr>
	 							<!-- 내용 -->
	  							<p class="content my-5" >${postSelect[0].club_article_content }</p>
	  							<!-- 테스트 -->
<%-- 	  							<c:forEach var="result" items="${postSelect}" varStatus="status">
	  								<c:set var="text" value="${fn:split(result,',')}" />
	  								<c:forEach var="textValue" items="${text}" varStatus="varStatus">
	  									${textValue }
	  								</c:forEach>
	  							</c:forEach> --%>
	  							<hr>
	  							<div>
	  								<!-- 댓글 -->
	  								<h5 class="fw-bold">${commentSelect[0] == null ? "" : "댓글"}</h5> 
	  								<ul id="commentList" style="list-style:none;">
	  								<c:forEach var="clubDto" items="${commentSelect }" varStatus="status">
	  									<li data-cno="${status.count}" class="py-2">
		  									<p class="mb-0 fw-semibold">${clubDto.club_comment_id == null? "" : clubDto.user_id }
		  										<c:if test="${clubDto.user_id == user_id }">
		  											<span class="badge text-bg-primary">나</span>
		  										</c:if>
		  									</p>
		  									<p class="mb-0">${clubDto.club_comment }</p>
		  									<p class="mb-2"><fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_comment_time }" /></p>
	  									</li>
	  								</c:forEach>
	  								</ul>
	  								<div id="commentWrite" class="border">
	  									<p id="writer" class="p-2 mb-0">${user_id}</p>
	  									<div class="d-flex m-2">
	  										<span class="flex-grow-1"><textarea id="comment" class="w-100 p-1" placeholder="댓글을 남겨보세요." rows="1" style="border:none; resize:none;"></textarea></span>
	  										<span><button type="button" id="registBtn" class="btn btn-sm btn-primary float-end px-3 mx-1">등록</button></span>
	  									</div>
	  								</div>
	  							</div>
  							</form>
	    				</div>
					</div>				
					
					<div class="row pb-5" style="float:right">
						<div class="col-auto px-1" >
			  				<a id="listBtn" class="btn btn-outline-secondary" ><i class="bi bi-justify"></i>목록</a>	
						</div>
			       </div>

		  	
			       <!-- 이전글, 다음글  -->
			       <div class="prevNext">
						<table class="table table-bordered table-hover" style="border-radius:5px;">
							<colgroup>
								<col width="120px;">
								<col width="auto;">
							</colgroup>
			    			<tbody>
			    				<tr>
			    					<th scope="row" class="text-center table-primary"  >이전글<i class="bi bi-caret-up-fill"></i></th>
			    						<td class="pre" id="preTitle"> 
			    							<c:if test ="${preView.preId != 9999}">
			    								<a style="text-decoration: none; color: black;">	 
			    								${preView.preTitle}</a>
	      									</c:if>
	      									<c:if test = "${preView.preId == 9999}">
	      										<div class="fs-6" style="font-size: bold;">이전글이 없습니다.</div>
	      									</c:if>
	      								</td>
			    				</tr>
			    				<tr>
			    					<th scope="row" class="text-center table-primary">다음글<i class="bi bi-caret-down-fill"></i></th>
			    						<td  class="next" id="nextTitle">
			    							<c:if test ="${nextView.nextId != 9999}" >
			    								<a style="text-decoration: none; color: black;">
			    							 	${nextView.nextTitle}</a>
			    							</c:if>
			    							<c:if test ="${nextView.nextId == 9999}">
			    								<div class="fs-6" style="font-size: bold;">다음글이 없습니다.</div>
			    							</c:if>
			    						</td>
			    				</tr>
			    			</tbody>
			    		</table>
			    	</div>
			    	</div>
			</main>
		
				
<script>

var csrfHeaderName = "${_csrf.headerName}"
var csrfTokenValue= "${_csrf.token}"

	$(document).ready(function(){
		
		let formCheck = function() {
			// html태그와 trim()으로 제거되지 않는 공백문자(=&nbsp;)를 제거
			let res = $('#comment').val().replace(/&nbsp;|<[^>]*>?/g, '');	
			if($.trim(res) == "") {
				alert("댓글 내용을 입력해 주세요.")
				return false
			}	
			return true;
		}
		
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
			$('#commentWrite').hide()
		}
		
		function refreshCmtList(){
			location.reload();
		}
		
		$('li[data-cno!=1][data-cno]').attr("style", "border-top: 1px solid rgba(0, 0, 0, 0.175);")

		//공지사항 클릭시 공지사항 첫 페이지로 이동 
		$("#noticeList").on("click", function() {
			location.href ="<c:url value='/board/notice'/>";
		})
		
		$("#eventList").on("click", function() {
			location.href ="<c:url value='/board/event'/>";
		})
		
 		$("#registBtn").on("click", function() {
 			/* <c:set var="user_id" value="${user_id}"></c:set> */
			let club_comment = $("#comment").val()
			let user_id = $("#writer").text()
			console.log("user_id=",user_id)
			let club_article_id = ${param.club_article_id}
			
			if(formCheck()) {
				$.ajax({
					beforeSend: function(xhr) {
						console.log("beforeSend")
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					},
					type: 'POST',			
					url: '/ycc/club/board/comment',		
					data: {club_comment:club_comment, user_id:user_id, 
						club_article_id:club_article_id},	
					dataType : 'text',
					success : function(data) {
						console.log(data)
						alert("댓글이 등록 되었습니다.")
						refreshCmtList();
						
					},
					error : function(data) { 
						alert("댓글 등록 실패")
					}
				})
			}
				
		})
		
		
		$("#listBtn").on("click", function() {
			location.href ="<c:url value='/club/board?club_id=${param.club_id}' />";
			
		})
		
		$("#modifyBtn").on("click", function() {
			location.href ="<c:url value='/club/board/edit?club_id=${param.club_id}&club_article_id=${param.club_article_id}' />";
		})
		
		$("#deleteBtn").on("click", function() {
 			let form = $("#form");
 			let yn = confirm("삭제하시겠습니까?")
 			
			form.attr("action", "<c:url value ='/club/board/delete'/>")
			form.attr("method", "post")
			
			if(yn == true) {
				form.submit()
				alert("삭제되었습니다.")
			}
				
		})
		
	})
	
</script>
    
  <!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
</body>

</html>
