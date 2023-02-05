
<%@page import="com.youngtvjobs.ycc.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<!-- head & meta tag include -->
<%@include file="/WEB-INF/views/metahead.jsp"%>

<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
</style>

<title>동아리 생성</title>

</head>
<body>
	<!-- header inlcude -->
	<%@include file="/WEB-INF/views/header.jsp"%>

	<div class="container w-50">
		<h2 class="p-5" style="text-align: center;">동아리 생성</h2>

		<form id="form" action=''method="post">
			<!-- 회원정보 입력 table -->
			<h2 class="mt-5">동아리 정보 입력</h2>
			<hr>
			<table class="table">
				<colgroup>
					<col width="20%">
					<col width="60%">
				</colgroup>
				<thead>
					<!-- 동아리명 -->
					<tr>
						<th class="col" style="vertical-align: middle !important;">동아리명</th>
						<td class="col-auto px-3">
							<div class="row">
								<input type="text" class="form-control onlyAlphabetAndNumber"
									id="club_title" name="club_title" placeholder="동아리명을 입력해주세요"
									maxlength="20" style="width: 340px;"> 
								<input type="button" id="dbCheckBtn" name="idCheckBtn"
									class="btn btn-outline-primary mx-1" value="중복확인"
									style="width: 100px;">
								<input type="hidden" name="dbCheck" value="dbUnchecked">
								<!-- 중복체크 검사결과  -->
								<span id="result"></span>
							</div>
						</td>
					</tr>
					
					<!-- 동아리 아이콘 -->
					<tr>
						<th class="col" style="vertical-align: middle !important;">동아리 아이콘</th>
						<td class="col-auto px-3">
							<div class="form_section">
                    			<div class="form_section_content">
									<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
									<!-- 이미지 미리보기 -->
									<div id="uploadResult">
									</div>
                    			</div>
                    		</div>  
						</td>
					</tr>

					<!-- 동아리 소개글 -->
					<tr>
						<th class="col" style="vertical-align: middle !important;">동아리 설명</th>
						<td><textarea class="w-100 h-75" name="club_info" rows="5" cols="3"></textarea></td>
					</tr>
					
				</thead>
			</table>
			<input type="hidden" name="${_csrf.parameterName}"
				value="${_csrf.token}">
			<!-- 회원가입 & 취소 버튼 -->
			<div class="row">
				<div class="col text-center pt-5">
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}"> <input type="button" id="createBtn"
						class="btn btn-primary" value="생성하기">
					<a href="/ycc/" class="cancle btn btn-secondary" role="button">취소</a>
				</div>
			</div>
		</form>
	</div>

	<script>
	
	/* 이미지 업로드
	<input>태그의 change 이벤트를 통해 FileList 객체에 접근 */
	$("input[type='file']").on("change", function(e){
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		/* 이미지 존재시 삭제 => 이미지 업로드 후 다시 이미지 업로드할 때, 기존 이미지가 삭제되어야 하므로
		이미지 미리 보기 태그의 존재 유무로 이미지가 업로드 됐는지 확인 */
		if($(".imgDeleteBtn").length > 0){
			deleteFile();
		}
		
		/* <form> 태그와 같은 역할을 해주는 객체 FormData 생성
		화면의 이동 없이 첨부파일을 서버로 전송하기 위해 form태그 대신 사용 */
		let formData = new FormData();
			
		/* FileList(배열 형태의 객체) 객체에 접근 */
		let fileInput = $('input[name="uploadFile"]');
		let fileList = fileInput[0].files;
		
		/* FileList의 요소로 있는 File 객체(=type이 'file'인 <input> 태그의 "files" 속성)에 접근
		사용자가 파일을 선택하면, 선택된 파일의 목록이 FileList 객체 형태로 files 속성에 저장됨.*/
		let fileObj = fileList[0];
		
 		if(!fileCheck(fileObj.name, fileObj.size)){
			return false;
		}
		
		// 사용자가 선택한 파일(fileObj)을 FormData에 "uploadFile"이란 이름(key)으로 추가
		formData.append("uploadFile", fileObj);
		
		/* File 인터페이스가 가진 속성(MDN File API 참고)을 사용하여 파일 이름, 파일 사이즈, 파일 타입을 console.log를 통해 출력 */
		console.log("fileName : " + fileObj.name);
		console.log("fileSize : " + fileObj.size);
		console.log("fileType(MimeType) : " + fileObj.type);
		
		$.ajax({
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			url: '/ycc/club/uploadAjaxAction',
	    	processData : false,	//서버로 전송할 데이터를 queryStirng 형태로 변환할지 여부
	    	contentType : false,	//서버로 전송되는 데이터의 content-type
	    	data : formData,
	    	type : 'POST',
	    	dataType : 'json',
	    	success : function(result){	//상태코드가 200 인 경우 응답
	    		console.log(result);
	    		showUploadImage(result);
	    	},
			error : function(result){	//에러 상태코드(400 등)일 때 응답
				alert("이미지 파일이 아닙니다.");
	    	} 
		});	
		
	});
	
	let regex = new RegExp("(.*?)\.(jpg|png)$");	//jpg, png 파일만 허용
	let maxSize = 1048576; 							//1MB의 크기만 허용	
	
	/* 파일 업로드 유효성 체크 */
	function fileCheck(fileName, fileSize){

		if(fileSize >= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(!regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;		
		
	}
	
	/* 이미지 출력 */
	function showUploadImage(uploadResultArr){
		
		/* 전달받은 데이터 검증 */
		if(!uploadResultArr || uploadResultArr.length == 0){return}
		
		let uploadResult = $("#uploadResult");
		let obj = uploadResultArr;
		console.log("obj = ", obj)
		/* @GetMapping("club/display")에 전달해줄 파일의 경로와 이름을 포함하는 값을 저장하기 위한 변수
		replace(/\\/g, '/') = 모든 '\'을 '/'로 변경 */
		console.log("obj.upload_path",obj.upload_path)
		
		let fileCallPath = obj.upload_path.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.file_name;
		console.log("fileCallPath",fileCallPath)
		
		let str = "";
		str += "<div id='result_card'>";
		str += "<img src='<%=request.getContextPath()%>/club/display?file_name=" + fileCallPath +"'>";
		str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>"
		str += "<input type='hidden' name='file_name' value='"+ obj.file_name +"'>";
		str += "<input type='hidden' name='uuid' value='"+ obj.uuid +"'>";
		str += "<input type='hidden' name='upload_path' value='"+ obj.upload_path +"'>";	
		str += "</div>";
		
		<!-- append() == html() -->
		uploadResult.append(str);   
	}
	
	/* 파일 삭제 메서드 */
	function deleteFile(){
		
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
		// .data() : 'data-속성' 값을 가져옴
		let targetFile = $(".imgDeleteBtn").data("file");
		let targetDiv = $("#result_card");
		
		$.ajax({
 			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			url: '/ycc/club/deleteImage',
			// 컨트롤러에서 파라미터명을 fileName으로 설정해둠
			data : {fileName : targetFile},
			dataType : 'text',
			type : 'POST',
			success : function(result){
				console.log(result);		
				targetDiv.remove();					//이미지 출력해주는 부분 삭제
				$("input[type='file']").val("");	//태그 초기화
			},
			error : function(result){
				console.log(result);
				alert("파일을 삭제하는 데 실패했습니다.")
			}
       });
	}
	
	/* 이미지 삭제 버튼 동작 
	<div class="imgDeleteBtn"> 태그는 웹페이지가 로드된 후 자바스크립트 코드를 통해 동적으로 출력된 태그이기 때문에
	.click 이 아니라 .on으로 설정해줘야 작동함 
	기존 렌더링 될 때 추가되어 있는 <div id="uploadReulst"> 태그를 식별자로 하여 
	그 내부에 있는 <div class="imgDeleteBtn"> 태그를 클릭(click) 하였을 때 동작한다는 의미 */
	$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
		alert("이미지삭제버튼")
		deleteFile();
	});
	
	let formCheck = function() {
		// html태그와 trim()으로 제거되지 않는 공백문자(=&nbsp;)를 제거
		let form = $('#form')
		let res = $('textarea[name=club_info]').val().replace(/&nbsp;|<[^>]*>?/g, '');
		let club_title = $('#club_title').val()
		
		if($.trim(club_title) == "") {
			alert("동아리명을 입력해 주세요.")
			return false
		} else if(club_title.match(/^\s/)) {
			alert("동아리명은 공백으로 시작할 수 없습니다.")
			return false
		} else if($.trim(res) == "") {
			alert("동아리 소개글을 작성해 주세요.")
			return false
		} else if($('#result').attr('data-check') == "false") {
			alert("중복된 동아리명입니다.")
			return false
		} else if($('input[name=dbCheck]').val() == "dbUnchecked") {
			alert("중복체크를 해주세요.")
			return false
		}
		return true;
	}
	
	$('#createBtn').on("click", function() {
		let form = $('#form')
		
		form.attr("action", "<c:url value='/club/create'/>")
		form.attr("method", "post")
		
		if(formCheck()) {
			form.submit()
			alert("동아리가 생성되었습니다!")
		}
	})
		
	$('#club_title').on("change keyup", function() {
	   $('input[name=dbCheck]').attr('value','dbUnchecked')
	})
	
  	$('#dbCheckBtn').on("click", function() {
 		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
	 		$.ajax({
	 			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName,csrfTokenValue);
			},
			type : 'post',
			url : '/ycc/club/dbCheckClubTitle',
			data : {
				'club_title' : $('input[name=club_title]').val()
			},
			dataType : 'json',
			success : function(result) {
				
				$('input[name=dbCheck]').attr('value','dbChecked')
				
				if (result == 0) {
					$("#result").text('사용 가능한 동아리명입니다.').css('color', 'blue');
					$("#result").attr("data-check", "true")
				} else {
					$("#result").text('동아리명이 이미 존재합니다.').css('color', 'red');
					$("#result").attr("data-check", "false")
				}
			},
			error : function() {
				alert("error")
			}
 		})
 	})
	
	</script>
	<!-- footer inlcude -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>