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
    
    <title>1:1 문의 작성하기</title>
  </head>
  <body>
 
      <!-- include header -->
<%@include file="/WEB-INF/views/header.jsp"%>

	<script type="text/javascript">
		$(document).ready(function() {	
			
			let formCheck = function() {
				let form = document.getElementById("form")
				if(form.inq_cate.value==""){
					alert("분류를 선택해 주세요.")
					return false
				}
				if(form.inq_title.value=="") {
					alert("제목을 입력해 주세요.")
					form.inq_title.focus()
					return false
				}
				if(form.inq_content.value=="") {
					alert("내용을 입력해 주세요.")
					form.inq_content.focus()
					return false
				}	
				return true;
			}
			
			$("#writeBtn").on("click", function() {
				let form = $("#form");
				form.attr("action", "<c:url value ='/mypage/inquiry/write'/>")
				form.attr("method", "post")
				
				if(formCheck())
					form.submit()
			})
			

		}) 
	</script>

	<script type="text/javascript">
  		let msg = "${msg}"
  	  	if(msg=="WRT_ERR") alert("문의글 등록에 실패하였습니다. 다시 시도해 주세요.")
  	</script>

	<!-- 1:1 문의 작성 폼  -->
   <div class="container mt-3">
    <h2>1:1 문의</h2>
    <hr>
  </div>
  <form action="" method="post" id="form"> <!-- 비동기처리를 위해 action 속성은 비워둠 -->
  <input type="hidden" name="inq_id">
    <div class="container border border-secondary rounded p-5" >
     <br>
      *는 필수항목입니다.
      <hr>
           <p>문의 유형: * </p>
           <div class="row">
           <select
             name="inq_cate"
             class="form-select form-select-sm me-lg-1"
             style="display: inline;width: 30%;margin-left: 1em;">
             <option value="">문의유형</option>
             <option value="결제">결제</option>
             <option value="교육강좌">교육강좌</option>
             <option value="기타">기타</option>
           </select>
           </div>
         <hr>
           <p>문의 내용: * </p>
           <input
           name="inq_title"
           type="text"
           class="form-control mb-2"
           placeholder="제목을 입력해주세요"
         	/>
	<!--text area :썸머노트 스마트 에디터로 교체-->
       <textarea class="summernote" name="inq_content" 
       style="margin-bottom: 30px;">
       </textarea>
       <script>
       $(document).ready(function(){
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
       }) 
       </script>
           <!-- submit으로 넘어가지 않도록 button타입 지정 -->
           <div class="d-flex justify-content-end">
          	 <button type="button" class="btn btn-primary mt-3" id="writeBtn">등록</button>
           </div>
           <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      </div>
	</form>

	<!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
	  
  </body>
</html>