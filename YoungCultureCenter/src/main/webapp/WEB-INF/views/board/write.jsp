<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
  	<!--summernote-->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js">	</script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
  
  <%
//   	String noticeURI = request.getParameter("board");
//   	String eventURI = request.getParameter("board");
  %>
<title>글쓰기</title>
</head>

<body>
  	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>
  		<!--container start-->
  		<form action='<c:url value="/board/write" />' name="writeForm" method="post">
  			<div class="container mt-5">
    			<h3 class="posttitle pt-3">글쓰기</h3>
   				<hr>
   					<!-- 게시판 유형 선택 시 value값이 DB에 저장  -->
	   				<select class="form-select mb-2"  id="boardType" name="article_Board_type" style="width: 180px;">
						  <option selected disabled="disabled">선택해주세요.</option>
						  <option value="공지사항">공지사항</option>
						  <option value="이벤트">이벤트/행사</option>
					</select>
   					<input type="text" class="form-control mb-3" id="title" name="article_title"
   					 placeholder="제목을 입력해주세요" value="${boardDto.article_title }">
    				<textarea class="summernote mb-5" id="contents" name="article_contents"  >
    				${boardDto.article_contents}</textarea>
    				
				<!-- summernote 업로드 -->
<!--    				<div class="input-group mb-3 mt-3"> -->
<!--       				<input type="file" class="form-control" id="inputGroupFile02"> -->
<!--       				<label class="input-group-text" for="inputGroupFile02">Upload</label> -->
<!--     			</div> -->
    			<!-- 게시글 등록, 취소 버튼 -->
    			
    			
	    		<div class="m-5" style="text-align: center;">
	      			<input class="btn btn-primary mx-3" id="regBtn" type="button" onclick="regCheck()" value="등록하기" >
	      			<input class="btn btn-secondary" type="button" value="취소하기">
	    		</div>
	    		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  			</div><!--container end-->
  		</form>

  <script>

   //summernot 
  $('.summernote').summernote({
      height: 400,
      lang: "ko-KR"
    });
  
   
   
  function regCheck() {
	  	// 게시판 유형 값이 없으면 alert창 띄우기 
	  	if($("#boardType option:selected").val()=="선택해주세요."){
	  		alert("게시판 유형을 선택해주세요.")
	  	}
	  	//title에 값이 없으면 alert창 띄우고 ,focus
	  	else if($("#title").val()== ""){
			alert("제목을 입력해주세요");
			document.writeForm.article_title.focus();
		}
	  	//contents에 값이 없으면 alert창 띄우고 ,focus
		else if($("#contents").val()==""){
			alert("내용을 입력해주세요");
			document.writeForm.article_contents.focus();
		}
		//title, contents에 값이 있으면 submit 후 alert창 띄우기 
		else if($("#title").val()!="" && $("#contents").val()!="") {
			document.writeForm.submit();
			alert("등록되었습니다.")
		}
				
  }
  
  
  
  </script>
    <!-- footer inlcude -->

    <!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>

</body>

</html>