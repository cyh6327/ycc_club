<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
	
	<main class="mt-5 pt-5">
		<div class="container px-4">
			<h4></h4>
					<div class="card mb-4">
	    				<div class="card-body">
    						<!-- 게시글 정보 -->
    						<form id="form" action="" method="post">
    							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">	
	    						<input type="hidden" name="club_article_title" value="${postSelect[0].club_article_title }" />
	    						<input type="hidden" name="club_article_id" value="${param.club_article_id }" />
	    						<input type="hidden" name="club_id" value="${postSelect[0].club_id }" />
	    						<!-- <input type="hidden" name="_method" value="delete"/> -->
	    						<c:set var="postSelect" value="${postSelect}"></c:set>
	  							<h4 class="title">${postSelect[0].club_article_title }</h4>
	  							<p class="writingInfo">작성자 : ${postSelect[0].user_id} |
	   								게시일 : <fmt:formatDate value="${postSelect[0].club_board_upload_time }" pattern="yyyy-MM-dd" type="date"/> 
	  								| 조회수 : ${postSelect[0].club_article_viewcnt }
		  							<!-- 본인이 쓴 게시글에만 수정, 삭제 가능 -->
									<!-- 세션 아이디와 boardDto에 저장된 아이디가 같으면 수정, 삭제 버튼 활성화 -->
									<sec:authentication property="principal" var="pinfo"/>
									<sec:authorize access="isAuthenticated()">
										<c:if test="${pinfo.member.user_id eq postSelect[0].user_id}">
											<button type="button" class="btn btn-outline-danger float-end" id="deleteBtn">
								  			<i class="bi bi-trash3"></i>삭제</button>
							  				<button type="button" class="btn btn-outline-success float-end" id="modifyBtn">
							  				<i class="bi bi-pen"></i>수정</button> 
							      		</c:if>
						      		</sec:authorize>
	 							</p>
	 							<hr>
	 							<!-- 내용 -->
	  							<p class="content" >${postSelect[0].club_article_content }</p>
	  							<hr>
	  							<div>
	  								<h5>댓글</h5>
	  								<ul id="commentList" style="list-style:none;">
	  								<c:forEach var="clubDto" items="${postSelect }" varStatus="status">
	  									<li data-cno="${status.count}">
		  									<p class="mb-0">${clubDto.club_comment_id == null? "" : clubDto.user_id }</p>
		  									<p class="mb-0">${clubDto.club_comment }</p>
		  									<p class="mb-2"><fmt:formatDate pattern="yyyy-MM-dd" value="${clubDto.club_comment_time }" /></p>
	  									</li>
	  								</c:forEach>
	  								</ul>
	  								<div class="border">
	  								<c:set var="user_id" value="${user_id}"></c:set>
	  									<p id="writer">${user_id}</p>
	  									<textarea id="comment" class="w-100" placeholder="댓글을 남겨보세요" rows="1"></textarea>
	  									<button type="button" id="registBtn" class="btn btn-primary float-end">등록</button>
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
		
		function refreshCmtList(){
			location.reload();
		}

		//공지사항 클릭시 공지사항 첫 페이지로 이동 
		$("#noticeList").on("click", function() {
			location.href ="<c:url value='/board/notice'/>";
		})
		
		$("#eventList").on("click", function() {
			location.href ="<c:url value='/board/event'/>";
		})
		
 		$("#registBtn").on("click", function() {
			
			let club_comment = $("#comment").val()
			let user_id = $("#writer").text()
			let club_article_id = ${param.club_article_id}
			
			if(club_comment == "") {
				alert("댓글을 작성해주세요")
			} else {
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
						alert("댓글 등록 성공 !")
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
			location.href ="<c:url value='/club/board/edit?club_article_id=${param.club_article_id}' />";
		})
		
		$("#deleteBtn").on("click", function() {
 			let form = $("#form");
			form.attr("action", "<c:url value ='/club/board/delete'/>")
			form.attr("method", "post")
			form.submit()
		})
		
	})
	
</script>
    
  <!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
</body>

</html>
