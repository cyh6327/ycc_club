<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    
<title>동아리 게시글 작성하기</title>
</head>

<body>
<!-- include header -->
<%@include file="/WEB-INF/views/header.jsp"%>

	<!-- 게시글 작성 폼  -->
   <div class="container mt-3">
    <h2>게시글 쓰기</h2>
    <hr>
  </div>
  <form action="" method="post" id="form"> <!-- 비동기처리를 위해 action 속성은 비워둠 -->
  <input type="hidden" name="user_id" value="${user_id}">
  <input type="hidden" name="club_id" value="${param.club_id}">
  <input type="hidden" name="club_article_id" value="${param.club_article_id}">
    <div class="container border border-secondary rounded p-5" >
     <br>
	<input name="post_title" type="text" class="form-control mb-2 post_title" placeholder="제목을 입력해주세요" 
	value="<c:out value="${postSelect[0].club_article_title}"/>"/>
	<!--text area :썸머노트 스마트 에디터로 교체-->
       <textarea id="content" class="summernote post_content" name="post_content" style="margin-bottom: 30px;"></textarea>
       
	     <div class="d-flex justify-content-end">
          	 <button type="button" class="btn btn-primary mt-3" id="writeBtn">등록</button>
           </div>
           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      </div>
	</form>
       
       <script>
       $(document).ready(function(){
    	   
    	   function removeHTML(text) {
    		   text = text.replace(/<br\/>/ig, "\n");
    		   text = text.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");
    		   return text
    	   }
    	   
    	   let content = '<c:out value="${postSelect[0].club_article_content}"/>';
    	   console.log(content)
    	   
    	   let url = window.location.href
    	   console.log(url)
    	   
    	   /* $('.summernote').summernote('code', content); */
    	   $('.summernote').val(content)
           $('.summernote').summernote({
           	   placeholder:"내용을 입력하세요.",
               height: 600,
               lang: "ko-KR",
               disableResizeEditor: true,	// 크기 조절 삭제
               toolbar: [
                   // [groupName, [list of button]]
                   ['fontname', ['fontname']],
                   ['fontsize', ['fontsize']],
                   ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
                   ['color', ['forecolor','color']],
                   ['table', ['table']],
                   ['para', ['ul', 'ol', 'paragraph']],
                   ['height', ['height']],
                   ['insert',['picture','link','video']],
                   ['view',['help']]
                 ]
           });
           
			let formCheck = function() {
				
				// html태그와 trim()으로 제거되지 않는 공백문자(=&nbsp;)를 제거
				let res = $('.post_content').val().replace(/&nbsp;|<[^>]*>?/g, '');
				
				if($.trim($('.post_title').val()) == "") {
					alert("제목을 입력해 주세요.")
					return false
				}	
				if($.trim(res) == "") {
					alert("내용을 입력해 주세요.")
					return false
				}	
				return true;
			}
			
			$("#writeBtn").on("click", function() {
				let form = $("#form");
				
				if(url.includes('edit')){
					form.attr("action", "<c:url value ='/club/board/edit'/>")
					if(formCheck()) {
						form.submit()
						alert("수정되었습니다.")
					}
				} else {
					form.attr("action", "<c:url value ='/club/board/write'/>")
					if(formCheck()) {
						form.submit()
						alert("게시글이 등록되었습니다.")
					}
				}
				
				if(formCheck())
					form.submit()
			})
			
       }) 
       
       let msg = "${msg}"
  	   if(msg=="WRT_ERR") alert("문의글 등록에 실패하였습니다. 다시 시도해 주세요.")
       </script>


	<!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
	  
  </body>
</html>