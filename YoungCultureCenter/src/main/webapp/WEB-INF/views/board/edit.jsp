<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<!-- head & meta tag include -->
  <%@include file="/WEB-INF/views/metahead.jsp"%>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<!--summernote-->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css"> <!-- header-->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>

<style type="text/css">
@media(min-width:387px) {
	#d-none {
		display: none;
	}
}
</style>
    
<title>Young문화센터 - 게시글 수정</title>
</head>
<body>
 <!-- header inlcude -->
<%@include file="/WEB-INF/views/header.jsp"%>
  
	<div class="container mt-5">
	    <!-- 제목 -->
		<c:if test="${boardDto.article_Board_type eq '공지사항'}">
			<h2 class="writing-header mb-3">공지사항</h2>
		</c:if>
		<c:if test="${boardDto.article_Board_type eq '이벤트'}">
			<h2 class="writing-header mb-3">이벤트/행사</h2>
		</c:if>
		<form id="form" class="frm" action="" method="post"> 
			<div class="card mb-4">
				<div class="card-body">
					<!-- 게시글 정보 -->
					<select class="form-select mb-2"  id="boardType" name="article_Board_type" style="width: 180px;">
					  <option selected disabled="disabled">선택해주세요.</option>
					  <option value="공지사항">공지사항</option>
					  <option value="이벤트">이벤트/행사</option>
					</select>
	    			<input type="hidden" name="article_id"  value="${boardDto.article_id }"> 		<!--값 받아오는 곳 -->
	    			<div class="form-floating mb-3">
					  <input type="email" class="form-control" name="article_title" id="article_title" value="${boardDto.article_title }">
					  <label for="floatingInput">제목</label>
					</div>
					<p class="writingInfo">작성자 : ${boardDto.user_id} |
						게시일 : <fmt:formatDate value="${boardDto.article_date }" pattern="yyyy-MM-dd" type="date"/> 
						| 조회수 : ${boardDto.article_viewcnt }
					</p>
					<!-- 내용 -->
					<textarea class="summernote mb-3" id="article_contents" name="article_contents" >
                	${boardDto.article_contents}</textarea>   					
				</div>
			 </div>                       
	         <div class="mt-2 text-end">
	         	<button type="button" class="btn btn-outline-secondary" id="noticeBtn" name="noticeBtn">목록</button>
	            <button type="button" class="btn btn-outline-success" id="regBtn" name="regBtn">등록</button>
	            <input type="hidden" name="boardDto" value="${boardDto}"> 
	         </div>
	         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	    </form>
    </div>

<script type="text/javascript">
	$('.summernote').summernote({
	    height: 400,
	    lang: "ko-KR"
	});

	$(document).ready(function(){
		
		 $("#noticeBtn").on("click", function() { 
			let form = $("#form")
			form.attr("action","<c:url value='/board/notice'/>")
			form.attr("method", "get")
			form.submit()
		})	
		//등록버튼 클릭시 
	    $("#regBtn").on("click", function() { 
		    // 게시판 유형 값이 없으면 alert창 띄우기 
	     	if($("#boardType option:selected").val()=="선택해주세요."){
		  		alert("게시판 유형을 선택해주세요.")
		  		return
		  	}
	     	else if(!confirm("정말로 등록하시겠습니까?")) return;
			
			let form = $("#form")
			form.attr("action","<c:url value='/board/edit1${searchItem.queryString}' />")
			form.attr("method", "post")
			form.submit()
			
		})
		
		
	})
</script>    

    <!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>