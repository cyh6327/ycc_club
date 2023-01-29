<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>	
		<!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
	<script type="text/javascript" src="/ycc/resources/js/singnincheck.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.slim.js" 
		integrity="sha256-HwWONEZrpuoh951cQD1ov2HUK5zA5DwJ1DNUXaM6FsY=" crossorigin="anonymous"></script>
	
 <title>회원가입약관동의</title>
</head>
<body>
	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>

<div class="container w-50">
  <h2 class="p-5" style="text-align: center;">회원가입</h2>
    <div class="position-relative m-4">
        <div class="progress" style="height: 5px;">
            <div class="progress-bar bg-primary" role="progressbar" style="width: 50%;" aria-valuenow="50"
                aria-valuemin="0" aria-valuemax="100">
            </div>
        </div>
        <button type="button"
            class="position-absolute top-0 start-0 translate-middle btn btn-sm btn-primary rounded-pill"
            style="width: 3.5rem; height:3.5rem;">Step1</button>
        <button type="button"
            class="position-absolute top-0 start-50 translate-middle btn btn-sm btn-secondary rounded-pill"
            style="width: 3.5rem; height:3.5rem;">Step2</button>
        <button type="button"
            class="position-absolute top-0 start-100 translate-middle btn btn-sm btn-secondary rounded-pill"
            style="width: 3.5rem; height:3.5rem;">Step3</button>
    </div>
   


    <h4 class="pt-5">회원가입약관</h4>
    <hr>
   <form action="siForm.jsp" id="form_check" method="post">
    <label for="memberInfo" class="col control-label pt-2 pb-3 fw-bold fs-5">이용약관</label>
  

    <div class="row">
      <div class="col">
        <textarea class="form-control" rows="8" style="width: 100%;" readonly="readonly">${adminDto.join_terms }</textarea>
      <input class="inputcheck" type="checkbox" id="check1" name="check" value="check1" onclick="checkSelectAll()" />(필수)동의합니다<br />
    </div>
  </div>

  <div class="form-group">
    <label for="memberInfo" class="col control-label pt-5 pb-3 fw-bold fs-5">개인정보취급방침</label>
      <div class="col" id="memberInfo">
        <textarea class="form-control" rows="8" style="width: 100%;" readonly="readonly">${adminDto.join_privacy_terms }</textarea>

	<input class="inputcheck" type="checkbox" id="check2" name="check" value="check2" onclick="checkSelectAll()" />(필수)동의합니다<br />
    <input class="inputcheck" type="checkbox" id="selectall" name="selectall" value="selectall" onclick="selectAll(this)" /> <b>모든 약관에 동의합니다.</b>

  	</div>
  
  <div class="row">
    <div class="col text-center">
      <input type="button" id="button"  class="btn btn-primary" value="확인" onclick="/member/siForm"  >
      <a href="/ycc/" class="btn btn-secondary" role="button">취소</a>
    </div>
  </div>
  </div>
  </form>
</div> 

<script type="text/javascript">
$(document).ready(function(){
    
    $("#button").click(function(){    
        if($("#selectall").is(":checked") == false){
            alert("필수 약관에 동의 하셔야 다음 단계로 진행 가능합니다.");
            return false;
      
        } 
        else if($("#selectall").is(":checked") != false){
            $(location).attr('href', '<c:url value='/signup/form'/>');
            return true;
      
        }
    
    })  
})
</script>

<!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>
	
</body>
</html>
