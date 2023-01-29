<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" >
<!-- header-->
<%@include file="/WEB-INF/views/metahead.jsp"%>
    <title>게시글 상세 보기</title>
</head>
<body>
    <!-- header inlcude -->
<%@include file="/WEB-INF/views/header.jsp"%>
    
	<main class="mt-5 pt-5">
			<div class="container px-4">
				<!-- 제목 -->
				<!-- insert된 article_Board_type이 '공지사항'이면  -->
				<c:if test="${boardDto.article_Board_type eq '공지사항'}">
					<!-- 제목 : 공지사항 -->
					<!-- 게시판 목록이동 a태그 사용 -->
					<h2 class="writing-header mb-3">
						<a id="noticeList">공지사항</a> 
					</h2>
				</c:if>
				<!-- insert된 article_Board_type이 '이벤트'이면  -->
				<c:if test="${boardDto.article_Board_type eq '이벤트'}">
					<!-- 제목 : 이벤트/행사-->
					<h2 class="writing-header mb-3">
						<a id="eventList">이벤트/행사</a>	
					</h2>
				</c:if>

					<div class="card mb-4">
	    				<div class="card-body">
    						<!-- 게시글 정보 -->
    						<input type="hidden" name="article_id" value="${boardDto.article_id }">
  							<h4 class="title" >${boardDto.article_title }</h4>
  							<p class="writingInfo">작성자 : ${boardDto.user_id} |
   								게시일 : <fmt:formatDate value="${boardDto.article_date }" pattern="yyyy-MM-dd" type="date"/> 
  								| 조회수 : ${boardDto.article_viewcnt }
 							</p>
 							<hr>
 							<!-- 내용 -->
  							<p class="content" >${boardDto.article_contents }</p>	    					
	    				</div>
					</div>				
					
					<div class="row pb-5" style="float:right">
						<div class="col-auto px-1" >
			  				<a id="listBtn" class="btn btn-outline-secondary" ><i class="bi bi-justify"></i>목록</a>	
						</div>
						<!-- 본인이 쓴 게시글에만 수정, 삭제 가능 -->
						<!-- 세션 아이디와 boardDto에 저장된 아이디가 같으면 수정, 삭제 버튼 활성화 -->
						<sec:authentication property="principal" var="pinfo"/>
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.member.user_id eq boardDto.user_id}">
								<div class="col-auto px-1">
					  				<button type="button" class="btn btn-outline-success" id="modifyBtn">
					  				<i class="bi bi-pen"></i>수정</button>
								</div>
								<div class="col-auto px-1">
					  				<button type="button" class="btn btn-outline-danger" id="deleteBtn">
					  				<i class="bi bi-trash3"></i>삭제</button>
					      		</div>
				      		</c:if>
			      		</sec:authorize>
      			        
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
				    								<a style="text-decoration: none; color: black;"
				    								 href="<c:url value="/board/post?article_id=${preView.preId  }"/>">	 
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
				    								<a style="text-decoration: none; color: black; "
				    								 href="<c:url value="/board/post?article_id=${nextView.nextId  }"/>">
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

	$(document).ready(function(){
		
		
		//공지사항 클릭시 공지사항 첫 페이지로 이동 
		$("#noticeList").on("click", function() {
			location.href ="<c:url value='/board/notice'/>";
		})
		
		$("#eventList").on("click", function() {
		location.href ="<c:url value='/board/event'/>";
		})
		
		
		$("#listBtn").on("click", function() {
			location.href ="<c:url value='/board/notice${searchItem.queryString}' />";
		})
		
		$("#modifyBtn").on("click", function() {
			if(!confirm("수정하시겠습니까?")) return;
			let article_id = ${boardDto.article_id }
			let form = $("#form")
			form.attr("action", "<c:url value='/board/edit${searchItem.queryString}' />")
			form.attr("method", "get")
			form.submit()
			})
	
		$("#deleteBtn").on("click", function() {
			if(!confirm("정말로 삭제하시겠습니까?")) return;
			
			let form = $("#form")
			form.attr("action","<c:url value='/board/remove${searchItem.queryString}' />")
			form.attr("method", "post")
			form.submit()
		})	
		
	})
	
</script>
    
  <!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
</body>

</html>