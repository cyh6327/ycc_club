<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="pinfo"/>
<c:set var="loginId" value="${pinfo.member.user_id }" />
<c:set var="userGrade" value="${pinfo.member.user_grade }" />

<!DOCTYPE html>
<html>
<head>
	<!-- head & meta tag include -->
	<%@ include file="/WEB-INF/views/metahead.jsp" %>
	
	<link rel="stylesheet" href="/ycc/resources/css/starrating.css">
	
	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
	
	<title>강좌상세</title>
	
	<style>
		table { vertical-align: middle !important; }
		th { text-align: center; background-color: #F4F7F9 !important; }
		@media ( min-width : 768px) { #dcol { display: none; } }
		@media ( max-width : 768px) { #wcol { display: none; } }
		@media ( max-width : 514px) { #w-15 { width: 19% !important; } }
		#result_card img{ max-width: 100%; height: auto; display: block; padding: 5px; margin-top: 10px; margin: auto; }
		#result_card { position: relative; }
 		.imgDeleteBtn{ position: absolute; top: 0; right: 5%; background-color: #ef7d7d; color: wheat; font-weight: 900; width: 30px;
	    						 height: 30px; border-radius: 50%; line-height: 26px; text-align: center; border: none; display: block; cursor: pointer; }
	</style>
</head>
<body>
	<script>
		
		x=location.hash
		
		 $(document).ready(function() { 
			// hash값이 tabReview이면 수강후기탭 열기
			 if (x == '#tabReview') {
			   $('#review-tab').tab('show');
			   
			 } 
		 });
	</script>
	<!-- header include -->
	<%@ include file="/WEB-INF/views/header.jsp" %>

	<!-- body -->
	<div class="container-md mt-5">
	
		<!-- 제목 -->
		<c:if test="${mode eq 'new' }">
			<h1 id="writing-header">강좌등록페이지</h1>
		</c:if>
		<c:if test="${mode ne 'new' }">
			<h1 id="writing-header">${mode=="modify" ? "강좌수정페이지" : "강좌상세페이지" }</h1>
		</c:if>
		<hr>
		<!-- // 제목 -->
		
		<form id="form" class="frm" action="" method="POST">
			<h6>| 강좌상세정보</h6>
			<div class="row g-0">
				<input type="hidden" name="course_id" value="${courseDto.course_id }">
				<div class="col-md-6">
					<div class="table table-bordered h-100">
						<input class="form-control" type="hidden" name="user_id" value="${courseDto.user_id }"/>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<table class="table h-100">
							<tbody>
							<colgroup><col width="25%"></colgroup>
							<tr>
								<th>강좌명</th>
								<td><input class="form-control" type="text" name="course_nm" value="${courseDto.course_nm }" ${mode=="new" || mode=="modify" ? "" : "readonly" }></td>
							</tr>
							
							<!-- 출력값 -->
							<c:if test="${mode ne 'new' && mode ne 'modify' }">
								<tr>
									<th>강사명</th>
									<td>${courseDto.user_name }</td>
								</tr>
								<tr>
									<th>강의실</th>
									<td>${courseDto.croom_name }</td>
								</tr>
								<tr>
									<th>접수기간</th>
									<td>${courseDto.reg_sd() } ~ ${courseDto.reg_ed() }</td>
								</tr>
								<tr>
									<th>수강대상</th>
									<td>${courseDto.course_target }</td>
								</tr>
							</c:if>
							
							<!-- 입력값 -->
							<c:if test="${mode eq 'new' || mode eq 'modify' }">
								<tr>
									<th>강의실</th>
									<td>
										<select class="form-select w-auto" name="croom_id">
											<option>선택</option>
											<c:forEach var="classroom" items="${classroomList }"> 
												<option value="${classroom.croom_id }" ${courseDto.croom_id == classroom.croom_id? 'selected' : '' }>${classroom.croom_name }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>강좌분류</th>
									<td>
										<select class="form-select w-auto" name="course_cate_cd">
											<option>선택</option>
											<c:forEach var="courseType" items="${typeList }">
												<option value="${courseType.course_cate_cd }" ${courseDto.course_cate_cd == courseType.course_cate_cd? 'selected' : '' }>${courseType.course_cate_name }</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th>수강대상</th>
									<td>
										<select class="form-select w-auto" name="course_target">
											<option>선택</option>
											<option ${courseDto.course_target.trim() == '성인'? 'selected' : '' }>성인</option>
											<option ${courseDto.course_target.trim() == '청소년'? 'selected' : '' }>청소년</option>
											<option ${courseDto.course_target.trim() == '유아'? 'selected' : '' }>유아</option>
											<option ${courseDto.course_target.trim() == '노인'? 'selected' : '' }>노인</option>
										</select>
									</td>
								</tr>	
								<tr>
									<th>접수시작일</th>
									<td><input class="form-control w-auto" type="date" id="regStartDate" name="course_reg_start_date" value="${courseDto.reg_sd() }" onchange="validationChk1()"></td>
								</tr>
								<tr>
									<th>접수마감일</th>
									<td><input class="form-control w-auto" type="date" id="regEndDate" name="course_reg_end_date" value="${courseDto.reg_ed() }" onchange="validationChk2()"></td>
								</tr>
								<tr>
									<th>수강시작일</th>
									<td><input class="form-control w-auto" type="date" id="startDate" name="course_start_date" value="${courseDto.course_sd() }" onchange="validationChk3()"></td>
								</tr>
								<tr>
									<th>수강종료일</th>
									<td><input class="form-control w-auto" type="date" id="endDate" name="course_end_date" value="${courseDto.course_ed() }" onchange="validationChk4()"></td>
								</tr>
							</c:if>
							<!-- //입력값 -->
							
							<!-- 입출력값 -->
							<tr>
								<th>수강료</th>
								<td><input class="form-control w-50 d-inline" id="price" type="number" onchange="onlyInteger()" name="course_cost" value="${courseDto.course_cost }" ${mode=="new" || mode=="modify" ? "" : "readonly" }>원</td>
							</tr>
							<!-- //입출력값 -->
							</tbody>
						</table>
					</div>
				</div>
				<div class="col-md-6">
					<div class="table table-bordered h-100">
						<table class="table h-100">
							<tbody>
							<colgroup><col width="25%"></colgroup>
							<c:if test="${mode eq 'new' || mode eq 'modify' }">
								<tr>
									<th>수강요일</th> <!-- 체크박스로 변경 -->
									<td>
										<!-- courseDto.course_day.indexOf("월") != -1 ==> (해석) db에 '월'이 존재하면 -->
										<input class="form-check-input" type="checkbox" name="course_day" value="월" 
										${courseDto.course_day.indexOf("월") != -1 && courseDto.course_day.indexOf("월") != null  ? 'checked' : '' }>월
										<input class="form-check-input" type="checkbox" name="course_day" value="화" 
										${courseDto.course_day.indexOf("화") != -1 && courseDto.course_day.indexOf("화") != null ? 'checked' : '' }>화
										<input class="form-check-input" type="checkbox" name="course_day" value="수" 
										${courseDto.course_day.indexOf("수") != -1 && courseDto.course_day.indexOf("수") != null ? 'checked' : '' }>수
										<input class="form-check-input" type="checkbox" name="course_day" value="목" 
										${courseDto.course_day.indexOf("목") != -1 && courseDto.course_day.indexOf("목") != null ? 'checked' : '' }>목
										<input class="form-check-input" type="checkbox" name="course_day" value="금" 
										${courseDto.course_day.indexOf("금") != -1 && courseDto.course_day.indexOf("금") != null ? 'checked' : '' }>금
										<input class="form-check-input" type="checkbox" name="course_day" value="토" 
										${courseDto.course_day.indexOf("토") != -1 && courseDto.course_day.indexOf("토") != null ? 'checked' : '' }>토
										<input class="form-check-input" type="checkbox" name="course_day" value="일" 
										${courseDto.course_day.indexOf("일") != -1 && courseDto.course_day.indexOf("일") != null ? 'checked' : '' }>일
									</td>
								</tr>
							</c:if>
							<!-- 출력값 -->
							<c:if test="${mode ne 'new' && mode ne 'modify' }">
								<tr>
									<th>수강요일</th> <!-- 체크박스로 변경 -->
									<td>${courseDto.course_day }</td>
								</tr>
							</c:if>
							<tr>
								<th>수강시간</th>
								<td><input class="form-control w-75" type="text" name="course_time" value="${courseDto.course_time }" ${mode=="new" || mode=="modify" ? "" : "readonly" }></td>
							</tr>
							<c:if test="${mode ne 'new' && mode ne 'modify' }">
								<tr>
									<th>수강기간</th>
									<td>${courseDto.course_sd() } ~ ${courseDto.course_ed() }</td>
								</tr>
								<tr>
									<th>총정원</th>
									<td>${courseDto.croom_mpop }명</td>
								</tr>
								<tr>
									<th>신청인원</th>
									<td class="${courseDto.course_applicants >= courseDto.croom_mpop ? 'text-danger' : '' }">
										${courseDto.course_applicants }명${courseDto.course_applicants >= courseDto.croom_mpop ? '(정원이 마감되었습니다.)' : '' }
									</td>
								</tr>
							</c:if>
							<!-- //출력값 -->
							<c:if test="${mode eq 'new' || mode eq 'modify' }">
								<tr>
									<th>강좌 소개</th>
									<td><textarea class="form-control" rows="15" name="course_info">${courseDto.course_info }</textarea></td>
								</tr>
							</c:if>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<c:if test="${mode eq 'new' || mode eq 'modify' }">	
				<!-- <div class="input-group my-3">
				  <input type="file" class="form-control" id="inputGroupFile02" name="">
					<input id="" class="btn btn-primary" type="button" value="이미지업로드" onclick="showUploadImage();">
				</div> -->
				<div class="form_section">
     			<div class="form_section_content">
     				<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;" multiple>
     				<div id="uploadResult"></div>
     			</div>
     		</div>
			</c:if>	
			<div class="d-grid gap-2 d-sm-block text-center mt-3">
				<c:if test="${mode ne 'new' && mode ne 'modify'}">
					<a id="courseRegBtn" class="btn  ${courseDto.course_applicants >= courseDto.croom_mpop ? 'disabled btn-secondary' : 'btn-primary' }" 
						 role="button" ${courseDto.course_applicants >= courseDto.croom_mpop ? 'aria-disabled="true"' : '' }>수강신청</a> 
					<button type="button" id="listBtn" class="btn btn-primary btn-list">목록</button>
				</c:if>
			</div><hr>
		</form>
		
			<!-- tab -->
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#home-tab-pane"
					type="button" role="tab" aria-controls="home-tab-pane" aria-selected="true" >강의계획서</button>
				</li>
				<c:if test="${mode ne 'new' && mode ne 'modify' }">
					<li class="nav-item" role="presentation" id="tabReview">
						<button class="nav-link" id="review-tab" data-bs-toggle="tab" data-bs-target="#paneReview"
						type="button" role="tab" aria-controls="profile-tab-pane" aria-selected="false">수강후기</button>
					</li>
				</c:if>
			</ul>
			
			<div class="tab-content mt-2" id="myTabContent">
				<!-- 강의계획서 -->
				<div class="tab-pane fade show active" id="home-tab-pane" role="tabpanel" aria-labelledby="home-tab" tabindex="0">
					<div class="row">
						
						<!-- 캐러셀
						<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
						  <div class="carousel-indicators">
						    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
						    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
						  </div>
						  <div class="carousel-inner">
						    <div class="carousel-item active">
						      <img src="#" class="d-block w-100" alt="...">
						    </div>
						    <div class="carousel-item">
						      <img src="..." class="d-block w-100" alt="...">
						    </div>
						    <div class="carousel-item">
						      <img src="..." class="d-block w-100" alt="...">
						    </div>
						  </div>
						  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Previous</span>
						  </button>
						  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="visually-hidden">Next</span>
						  </button>
						</div> //캐러셀 -->
						
						<div class="col-lg-5 mb-3 form_section align-self-center">
							<div class="form_section_content">
								<div id="uploadResult2"></div>
							</div>
						</div>
						<div class="col-lg-7 mb-3">
							<table class="container-fluid table table-bordered h-100">
								<tbody>
								<colgroup><col width="25%"></colgroup>
								<tr>
									<th>강좌명</th>
									<td>${courseDto.course_nm }</td>
								</tr>
								<tr>
									<th>강사명</th>
									<td>
										<div class="row">
											<div class="col-6 align-self-center">${courseDto.user_name }</div>
											<div class="col-6 text-end">
												<a href="#" type="button" class="btn btn-sm btn-outline-primary" hidden>강사소개</a> 
											</div>
										</div>
									</td>
								</tr>
								<tr>
									<th>수강기간</th>
									<td>${courseDto.course_sd() } ~ ${courseDto.course_ed() }</td>
								</tr>
								<tr>
									<th>수강요일</th>
									<td>${courseDto.course_day }</td>
								</tr>
								<tr>
									<th>수강시간</th>
									<td>${courseDto.course_time }</td>
								</tr>
								<tr>
									<th>수강료</th>
									<td>${courseDto.course_cost }원</td>
								</tr>
								</tbody>
							</table>
						</div>
					</div>
	
					<!-- 강좌정보 -->
					<c:if test="${mode ne 'new' && mode ne 'modify' }"> 
						<h6>| 강좌정보</h6>
						<table class="container-fluid table table-bordered">
							<tbody>
								<colgroup>
									<col width="25%">
								</colgroup>
								<tr>
									<th>강의실</th>
									<td>${courseDto.croom_name }</td>
								</tr>
								<tr>
									<th>강좌 소개</th>
									<td><textarea class="form-control-plaintext" rows="20" name="course_info" readonly>${courseDto.course_info }</textarea></td>
								</tr>
							</tbody>
						</table>
					</c:if>
					<!-- 안내사항 -->
					<c:if test="${mode ne 'new' }">
						<h6>| 안내사항</h6>
						<div class="container-md bg-light p-4 mb-3">
							<h5>꼭! 알아두세요.</h5><hr>
							<ul>
								<li>자녀 교육 프로그램 중 <em>'영아 강좌'의 수강료는 2인 기준 금액</em>입니다.</li>
								<li>'영아 강좌'의 수강 신청은 엄마와 자녀가 동시(2인)에 자동 신청되며, 결제 진행 과정에서 수강자 중 한 명을 자녀 이름으로 변경하십시오.</li>
								<li>쌍둥이 및 다둥이 자녀인 경우 수강신청 &gt; 강좌 바구니에서 수강자 추가 버튼을 클릭하여 수강자를 인원 수 만큼 추가하여 결제하시면 됩니다.</li>
								<li>쌍둥이 및 다둥이 자녀를 선택하여 결제하시면 개별 취소 및 강좌 변경이 불가능 하오니 신중히 검토하시어 결제해 주십시오.</li>
								<li>강좌가 마감되었어도 '대기신청'으로 표기되어 있을 때 신청해 주시면 강좌등록인원 변경이 발생할 경우 대기순번에 따라 연락 드리겠습니다.</li>
								<li>점포별로 유사한 강좌가 있사오니 수강 신청하시는 점포를 꼭 확인해 주시기 바랍니다.</li>
								<li>강좌 관련 궁금한 점이 생기시면 <em>'고객센터 &gt; 이용문의'</em>에서 문의하시기 바랍니다.</li>
								<li><em>일일특강과 요리강좌의 재료비,교재비 환불은 직접 수납시(센터결제) 개강 3일전까지 취소가 가능하며 개강 이후에는 중도환불이 불가합니다.</em></li>
								<li>신청하신 강좌는 <em>최소 정원에 미달되거나 사정에 의해 폐강</em> 될 수 있으니 양해 바랍니다.</li>
							</ul>
						</div>
					</c:if>
					
					<div class="text-end">
						<c:if test="${mode eq 'modify'}">
							<button type="button" id="backtoDetail" class="btn btn-secondary btn-list">뒤로</button>
							<button type="button" id="courseModifyBtn" class="btn btn-primary btn-modify">수정하기</button>
						</c:if>
						
						<c:if test="${mode eq 'new' }">
							<button type="button" id="writeBtn" class="btn btn-primary btn-write">등록</button>
							<button type="button" id="backtoSearch" class="btn btn-secondary btn-list">뒤로</button>
						</c:if>
						
						<c:if test="${mode ne 'new' && userGrade == '강사' }">
							<button type="button" id="writeNewBtn" class="btn btn-primary btn-write">강좌등록</button>
						</c:if>
						
						<c:if test="${courseDto.user_id eq loginId || userGrade == '관리자' }"> 
							<c:if test="${mode ne 'modify' && mode ne 'new'}">
								<button type="button" id="courseModBtn" class="btn btn-primary btn-modify">수정</button>
							</c:if>
							<c:if test="${mode ne 'new' }">
								<button type="button" id="removeBtn" class="btn btn-danger btn-remove">삭제</button>
							</c:if>
						</c:if>
					</div>
				</div>
				<!-- 수강후기 -->
				<div class="container-md tab-pane fade" id="paneReview" role="tabpanel" aria-labelledby="review-tab" tabindex="0">
					<div class="row">
						<!-- 별점 -->
						<h6>| 평균평점</h6>
						<div class="col-sm-12">
							<div class="row text-center bg-light p-1">
								<div class="col-sm-3 fs-3 align-self-center">평균 평점</div>
								<div class="col-sm-3 fs-3 align-self-center">${rating }/5.00</div>
								<div class="Stars col-sm-6" style="--rating: ${rating };" aria-label="Rating of this product is ${rating } out of 5."></div>
							</div>
						</div>
	
						<!-- 수강후기게시판 -->
						<h6 class="mt-3">| 수강후기 <span id="reviewCnt" class="text-primary">[${courseDto.review_cnt }개]</span></h6>
						<div class="col-md-12">
							<div id="${courseDto.review_cnt > 0 ? 'reviewList' : '' }" class="${courseDto.review_cnt > 0 ? '' : 'text-center mt-2 mb-5' }"
							style="${courseDto.review_cnt > 0 ? 'max-height:750px; overflow-y: auto;' : '' }">${courseDto.review_cnt > 0 ? '' : '첫 번째 수강후기를 등록하세요.' }</div>
							<div class="row mb-1 mt-3">
								<div class="col-sm-10">
									<textarea placeholder="후기를 작성해주세요." type="text" name="review_content" class="form-control mb-1" ></textarea>
								</div>
								<div class="col-sm-2">
									<select class="form-select" name="review_rating">
										<option value="" selected >별점 선택</option>
										<option value="5" >5</option>
										<option value="4" >4</option>
										<option value="3" >3</option>
										<option value="2" >2</option>
										<option value="1" >1</option>
									</select>
								</div>
							</div>
							<div class="gap-1 d-grid d-sm-block text-end">
								<button id="modifyBtn" type="button" class="btn btn-secondary">수정하기</button>
								<button id="insertBtn" type="button" class="btn btn-primary">후기작성</button>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
	
	<!-- 접수일&수강일/수강료 validation check -->
	<script type="text/javascript">
		// 수강료
		function onlyInteger() {
			var price = document.getElementById("price").value
			price = Math.floor(price/1000)*1000
			if(document.getElementById("price").value == "") {
				alert("수강료를 입력해주세요.")
			} else if(document.getElementById("price").value < 1000) {
				alert("수강료는 1000원보다 작을 수 없습니다.")
				document.getElementById("price").value = 1000
			} else if(document.getElementById("price").value > 1000) {
				alert("수강료는 1000 단위로만 입력이 가능합니다.")
				document.getElementById("price").value = price
			}
		}
		
		// 접수일&수강일
		let nowdate = Date.now()
		let timeOff = new Date().getTimezoneOffset()*60000
		let today = new Date(nowdate-timeOff).toISOString().split("T")[0]
		
		document.getElementById("regStartDate").setAttribute("min", today)
		document.getElementById("regEndDate").setAttribute("min", today)
		document.getElementById("startDate").setAttribute("min", today)
		document.getElementById("endDate").setAttribute("min", today)
		
		// 접수시작일 : document.getElementById("regStartDate").value 
		// 접수마감일 : document.getElementById("regEndDate").value 
		// 수강시작일 : document.getElementById("startDate").value 
		// 수강마감일 : document.getElementById("endDate").value 
		
		function validationChk1() {
			if(document.getElementById("regStartDate").value >= document.getElementById("regEndDate").value) {
				if(document.getElementById("regEndDate").value == "") {
					alert("접수마감일을 먼저 설정해주세요.")
					document.getElementById("regStartDate").value = ""
					document.getElementById("regEndDate").focus()
				} else if(document.getElementById("regStartDate").value == document.getElementById("regEndDate").value) {
					alert("접수시작일은 접수마감일과 같게 설정할 수 없습니다.\n접수마감일을 확인해주세요.")
					document.getElementById("regStartDate").value = ""
					document.getElementById("regStartDate").focus()
				} else {
					alert("접수시작일은 접수마감일과 같거나 이후로 설정할 수 없습니다.\n접수마감일을 확인해주세요.")
					document.getElementById("regStartDate").value = ""
					document.getElementById("regStartDate").focus()
				}
			}
		}
		function validationChk2() {
			if(document.getElementById("regStartDate").value >= document.getElementById("regEndDate").value) {
				alert("접수마감일을 접수시작일과 같거나 이전으로 설정할 수 없습니다.\n접수마감일을 다시 선택해주세요.")
				document.getElementById("regEndDate").value = ""
				document.getElementById("regEndDate").focus()
			} else if(document.getElementById("startDate").value != ""){
					if(document.getElementById("regEndDate").value >= document.getElementById("startDate").value) {
					alert("접수마감일은 수강시작일과 같거나 이후로 설정할 수 없습니다.\n수강시작일을 확인해주세요.")
					document.getElementById("regEndDate").value = ""
					document.getElementById("regEndDate").focus()
				}
			}
		}
		// validationChk1()과 같은 맥락 기억하기
		function validationChk3() {
			if(document.getElementById("endDate").value == "") {
				alert("수강종료일을 먼저 선택해주세요.")
				document.getElementById("startDate").value = ""
				document.getElementById("endDate").focus()
			} else if(document.getElementById("startDate").value <= document.getElementById("regEndDate").value) {
				alert("수강시작일은 접수마감일과 같거나 이전으로 설정할 수 없습니다.\n수강시작일을 다시 선택해주세요")
				document.getElementById("startDate").value = ""
				document.getElementById("startDate").focus()
			} else if(document.getElementById("startDate").value >= document.getElementById("endDate").value) {
				alert("수강시작일을 수강종료일과 같거나 이후로 설정할 수 없습니다.\n수강시작일을 다시 선택해주세요.")
				document.getElementById("startDate").value = ""
				document.getElementById("startDate").focus()
			}
		}
		function validationChk4() {
			if(document.getElementById("endDate").value <= document.getElementById("regEndDate").value) {
				alert("수강종료일은 접수마감일과 같거나 이전으로 설정할 수 없습니다.\n수강종료일을 다시 선택해주세요.")
				document.getElementById("endDate").value = ""
				document.getElementById("endDate").value.focus()
			} else if(document.getElementById("startDate").value >= document.getElementById("endDate").value) {
				alert("수강종료일을 수강시작일과 같거나 이전으로 설정할 수 없습니다.\n수강종료일을 다시 선택해주세요.")
				document.getElementById("endDate").value = ""
				document.getElementById("endDate").focus()
			}
		}
	</script>
	
	<script type="text/javascript">
		let msg = "${msg}"
		if(msg == "WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해주세요.")
		if(msg == "MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해주세요.")
		if(msg == "NOT_STUDENT") alert("수강생이 아닙니다.\n수강신청을 해주세요.")
		if(msg == "NOT_PASS_DEADLINE") alert("수강마감일이 아닙니다.\n수강마감일부터 작성하실 수 있습니다.")
	</script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			/* 이미지 업로드 */
			$("input[type='file']").on("change", function(e) {
				
				/* 이미지 존재시 삭제 */				
				if($(".imgDeleteBtn").length > 0) { deleteFile() }

				let formData = new FormData()
				let fileInput = $('input[name="uploadFile"]')
				let fileList = fileInput[0].files
				let fileObj = fileList[0]
				
				if(!fileCheck(fileObj.name, fileObj.size)) { return false }
				
				for(let i=0; i<fileList.length; i++) {
					formData.append("uploadFile", fileObj)
				}
				
				var csrfHeaderName = "${_csrf.headerName}"
				var csrfTokenValue= "${_csrf.token}"
				
				// processData와 contentType 속성의 값을 'false'로 해주어야만 첨부파일이 서버로 전송된다
				$.ajax({
					beforeSend: function(xhr){
						  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					}
					, url : '/ycc/course/uploadAjaxAction' // 서버로 요청을 보낼 url
					, processData : false // 서버로 전송할 데이터를 queryString 형태로 변환할지 여부
					, contentType : false // 서버로 전송되는 데이터의 content-type
					, data : formData // 서버로 전송할 데이터
					, type : 'POST' // 서버 요청 타입(GET, POST)
					, dataType : 'json' // 서버로부터 반환받을 데이터 타입
					, success : function(result) {
							console.log(result)
							showUploadImage(result) // reuslt, 즉 업로드한 이미지 데이터(filename, uuid, path)를 활용하여 이미지를 출력시키기 위함
					}
					, error : function(result) {
							alert("이미지 파일이 아닙니다.")						
					}
				})
				
				// 확인용
				console.log("fileList : " + fileList)
				console.log("fileObj : " + fileObj)
				console.log("fileName : " + fileObj.name)
				console.log("fileSize : " + fileObj.size)
				console.log("fileType(MimeType) : " + fileObj.type)
			})
			
			let regex = new RegExp("(.*?)\.(jpg|png)$")
			let maxSize = 1048576 //1MB
			
			// validation check 
			function fileCheck(fileName, fileSize) {
				if(fileSize >= maxSize){
					alert("파일 사이즈 초과")
					return false
				}
				if(!regex.test(fileName)){
					alert("해당 종류의 파일은 업로드할 수 없습니다.")
					return false
				}
				return true
			}
			
			/* 이미지 출력 */
			function showUploadImage(uploadResultArr) {
				/* 전달받은 데이터 검증 */
				if(!uploadResultArr || uploadResultArr.length == 0) { return } // 미리보기 이미지 태그의 존재 유무에 따라서 deleteFile()메서드를 호출
				
				let uploadResult = $("#uploadResult")
				let obj = uploadResultArr[0]
				let str = ""
				let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName)
				// replace 적용하지 않아도 가능
				// let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName)
				
				str += "<div id = 'result_card'>"
				str += " <img src='/ycc/course/imagedisplay?fileName=" + fileCallPath + "'>"
				str += " <div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>" // 파일 경로 데이터를 심기 위해 data 속성을 활용 -> 뷰에서 전달 해준 파일 경로 값을 굳이 디코딩해주었던 이유가 이 데이터를 전달할 것이기 때문
				str += " <input type='hidden' name='imageList[0].fileName' value='"+obj.fileName+"'>"
				str += " <input type='hidden' name='imageList[0].uuid' value='"+obj.uuid+"'>"
				str += " <input type='hidden' name='imageList[0].uploadPath' value='"+obj.uploadPath+"'>"
				str += "</div>"																															 
				
				uploadResult.append(str)
			}
			
			// 아래와 같은 메서드는 'x'를 클릭하였을 때 동작을 하지 않습니다. 
			// 'x'가 출력되어 있는 <div> 태그는 웹 페이지가 완전히 렌더링 된 이후 Javascript 코드를 통해 새롭게 출력된(동적으로 출력된) 태그이기 때문에
			// $(".imgDeleteBtn").click(function() {
			
			/* 이미지 삭제 버튼 동작 */ 
			// 'x'가 작성된 태그를 클릭하였을 경우 동작하는 메서드
			// 기존 렌더링 될 때 추가되어 있는 '#uploadReulst" <div> 태그를 식별자로 하여 그 내부에 있는 'imgDeleteBtn' <div> 태그를 클릭(click) 하였을 때 콜백 함수가 호출된다는 의미
			$("#uploadResult").on("click", ".imgDeleteBtn", function(e) { 
				deleteFile()
			})
			
			/* 파일 삭제 메서드 */
			function deleteFile() {
				let targetFile = $(".imgDeleteBtn").data("file")
				let targetDiv = $("#result_card");
				var csrfHeaderName = "${_csrf.headerName}"
				var csrfTokenValue= "${_csrf.token}"
				
				$.ajax({
					beforeSend: function(xhr){
						  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					}
					, url : '/ycc/course/deleteimage' // 파일 삭제를 수행하는 url 작성
					, data : {fileName : targetFile} // 객체 초기자를 활용하여 fileName 속성명에 targetFile(이미지 파일 경로) 속성 값을 부여 
					, dataType : 'text' // 전송하는 targetFile은 문자 데이터이기 때문에 'text'를 지정
					, type : 'POST' // 서버 요청 방식
					, success : function(result) {
							console.log(result)
							targetDiv.remove()
							$("input[type='file']").val("") // 파일 삭제를 성공한 경우 미리 보기 이미지를 삭제해 주고 파일 <input> 태그를 초기화
					}
					, error : function(result) {
							console.log(result)
							alert("파일을 삭제하지 못하였습니다.")
					}
				})
			}
			
			/* 기존 이미지 삭제 버튼 동작 */ 
			$("#uploadResult2").on("click", ".imgDeleteBtn", function(e) { 
				deleteFile2()
			})
			
			/* 파일 삭제 메서드 */
			function deleteFile2() {
				$("#result_card").remove()
			}
			
			/* 이미지 정보 호출 */
			let course_id2 = '<c:out value="${courseDto.course_id}"/>'
			let uploadResult2 = $("#uploadResult2")
			let modify = ${mode eq 'modify'}
			
			$.getJSON("/ycc/course/getCourseImageList", {course_id : course_id2}, function(arr) {
				
				// 데이터가 없을 경우 콜백 함수를 바로 빠져나갈 수 있도록 코드를 추가
				if(arr.length == 0) {
					let str = ""
					str += "<div id='result_card'>"
					str += " <img src='/ycc/resources/img/no_image.png'>"
					str += "</div>"
					
					uploadResult2.html(str)
					
					return
				}
				
				let str = ""
				let obj = arr[0]
				let fileCallPath2 = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName)
				
				str += "<div id='result_card'"
				str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'"
				str += ">"
				str += " <img class='w-100' src='/ycc/course/imagedisplay?fileName=" + fileCallPath2 + "'>"
				if(modify == true) {
					str += " <div hidden class='imgDeleteBtn' data-file='" + fileCallPath2 + "'>x</div>"
					str += " <input type='hidden' name='imageList[0].fileName' value='"+obj.fileName+"'>"
					str += " <input type='hidden' name='imageList[0].uuid' value='"+obj.uuid+"'>"
					str += " <input type='hidden' name='imageList[0].uploadPath' value='"+obj.uploadPath+"'>"
				}
				str += "</div>"
				
				uploadResult2.html(str)
				
			})
			
//=================================================수강후기=================================================
			let course_id = $("input[name=course_id]").val()
			
			// 수강후기 '수정하기'버튼 클릭
			$("#modifyBtn").click(function() {
				let review_id = $(this).attr("data-review_id")
				let review_content = $("textarea[name=review_content]").val()
				let review_rating = $("select[name=review_rating]").val()
				
				if(review_content.trim() == '') {
					alert("수강후기을 입력해주세요.")
					$("textarea[name=review_content]").focus
					return
				}
				
				var csrfHeaderName = "${_csrf.headerName}"
				var csrfTokenValue= "${_csrf.token}"
				
				$.ajax({
					beforeSend: function(xhr){
						  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					}
					, type : 'PATCH'
					, url : '/ycc/course/reviews/'+review_id
					, headers : { "content-type" : "application/json" }
					, data : JSON.stringify({review_id:review_id, review_content:review_content, review_rating:review_rating})
					, success : function(result) {
							alert(result)
							showList(course_id)
							$("textarea[name=review_content]").val("")
							$("select[name=review_rating]").val("")
					}
					, error : function() { alert("error") }
				})
			})
			
			// 수강후기 '수정'버튼 클릭
			$("#reviewList").on("click", "#modBtn", function() {
				let review_id = $(this).parent().attr("data-review_id")
				let review_content = $("span[id=review]", $(this).parent().parent()).text()
				let review_rating = $(this).parent().attr("data-review_rating")
				$("textarea[name=review_content]").val(review_content)
				$("select[name=review_rating]").val(review_rating)
				$("#modifyBtn").attr("data-review_id", review_id)
				$("textarea[name=review_content]").focus()
			})
			
			// 수강후기 '삭제'버튼 클릭
			$("#reviewList").on("click", "#delBtn", function() {
				var review_cnt = ${courseDto.review_cnt } 
				confirm("후기를 삭제하시겠습니까?")
				if(review_cnt > 0){
					let review_id = $(this).parent().attr("data-review_id")
					let course_id = $(this).parent().attr("data-course_id")
					var csrfHeaderName = "${_csrf.headerName}"
					var csrfTokenValue= "${_csrf.token}"
					
					$.ajax({
						beforeSend: function(xhr){
							  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
						}
						, type : 'Delete'
						, url : '/ycc/course/reviews/'+review_id+'?course_id='+course_id
						, success : function(result) {
								alert(result)
								showList(course_id)
						}
						, error : function() { alert("error") }
					})
				}
			})
			
			// 수강후기 '후기작성'버튼 클릭
			$("#insertBtn").click(function() {
				let review = $("textarea[name=review_content]").val()
				let rating = $("select[name=review_rating]").val()
				var csrfHeaderName = "${_csrf.headerName}"
				var csrfTokenValue= "${_csrf.token}"
				
				if(review.trim()=='') {
					alert("댓글을 입력해주세요.")
					$("textarea[name=review_content]").focus()
					return
				}
				if(rating=='') {
					alert("별점을 선택해주세요.")
					$("select[name=review_rating]").focus()
					return
				}
				
				$.ajax({
					beforeSend: function(xhr){
						  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					}
					, type : 'POST'
					, url : '/ycc/course/reviews?course_id='+course_id
					, headers : { "content-type" : "application/json" }
					, dataType : 'text'
					, data : JSON.stringify({review_content:review, review_rating:rating})
					, success : function(result) {
							alert(result)
							showList(course_id)
							$("textarea[name=review_content]").val("")
							$("select[name=review_rating]").val("")
					}
					, error : function() { alert("error") }
				})
			})
			
			// 수강후기리스트 출력
			let showList = function(course_id) {
				var csrfHeaderName = "${_csrf.headerName}"
				var csrfTokenValue= "${_csrf.token}"
				
				$.ajax({
					beforeSend: function(xhr){
						  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue)
					}
					, type : 'GET'
					, url : '/ycc/course/reviews?course_id='+course_id
					, success : function(result) {
							$("#reviewList").html(toHtml(result))
					}
					, error : function() { alert("error") }
				})
			}
			
			let toHtml = function(reviews) {
				let i = 0
				let tmp = "<table class='table table-bordered text-center'>"
				tmp += " <thead>"
				tmp += "  <tr>"
				tmp += "   <th style='width: 10%;' id='w-15'>번호</th>"
				tmp += "   <th class='align-middle'>제목</th>"
				tmp += "   <th style='width: 15%;' id='wcol'>작성일</th>"
				tmp += "   <th style='width: 15%;' id='wcol'>작성자</th>"
				tmp += "   <th style='width: 10%;' id='w-15'>평점</th>"
				tmp += "  </tr>"
				tmp += " </thead>"
				
				reviews.forEach(function(review) {
					var userId = '${loginId }'
					var userIdCheck = ( review.user_id == userId )
					var GradeCheck = ${userGrade == '관리자'}
					
					i = review.review_id
					tmp += '<tr>'
					tmp += ' <td>'+i+'</td>'
					tmp += ' <td class="text-start">'
					tmp += ' 	<div class="accordion accordion-flush" id="accordionFlushExample">'
					tmp += '   <div class="accordion-item">'
					tmp += ' 		<h2 class="accordion-header" id="flush-heading'+i+'">'
					tmp += ' 		 <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse'+i+'"'
					tmp += '		  aria-expanded="false" aria-controls="flush-collapse'+i+'"><span class="text-truncate" style="max-width: 128px;">'+review.review_content+'</span></button>'
					tmp += ' 		</h2>'
					tmp += ' 		<div id="flush-collapse'+i+'" class="accordion-collapse collapse" aria-labelledby="flush-heading'+i+'" data-bs-parent="#accordionFlushExample">'
					tmp += ' 		 <div class="accordion-body"><span id="review">'+review.review_content+'</span><hr id="dcol">'
					tmp += ' 			<div class="row" id="dcol">'
					tmp += ' 			 <div class="col-sm-12">'
					tmp += ' 				<div class="col-sm-6 fs-6">작성일:'+${review.review_datetime == review.review_updated_datetime ? "review.review_datetime":"review.review_updated_datetime"}+'</div>'
					tmp += ' 				<div class="col-sm-6 fs-6">작성자:'+review.user_id+'</div>'
					tmp += ' 			 </div>'
					tmp += ' 			</div>'
					
					if(userIdCheck || GradeCheck) {
						tmp += ' 			<hr>'
						tmp += '   		 <div data-review_id='+review.review_id+' data-course_id='+review.course_id+' data-review_rating='+review.review_rating+' class="text-end d-grid d-md-block gap-1">'
						tmp += '			  <button id="modBtn" class="btn btn-secondary">수정</button>'
						tmp += '   		  <button id="delBtn" class="btn btn-danger">삭제</button>'
						tmp += '		   </div>'
					}
					
					tmp += ' 		 </div>'
					tmp += ' 		</div>'
					tmp += ' 	 </div>'
					tmp += ' 	</div>'
					tmp += ' </td>'
					tmp += ' <td id="wcol">${'+review.review_datetime+' == '+review.review_updated_datetime+' ? "'+review.review_datetime+'" : "'+review.review_updated_datetime+'"}</td>'
					tmp += ' <td id="wcol">'+review.user_id+'</td>'
					tmp += ' <td><span id="rating">'+review.review_rating+'</span></td>'
					tmp += '</tr>'
				})
				
				return tmp += "</table>"
			}
			
			showList(course_id)

//===============================================강좌===============================================
			// 강좌 '수강신청'버튼 클릭
			$("#courseRegBtn").on("click", function() {
				if(!confirm("수강신청을 하시겠습니까?")) return
				
				location.href = "<c:url value='/course/regcomplete${pr.sc.queryString }&course_id=${courseDto.course_id }' />"
			})
				
			// 강좌 '수정하기'버튼 클릭
			$('#courseModifyBtn').on("click", function() {
				let form = $("#form")
				
				form.attr("action", "<c:url value='/course/modify${searchItem.queryString}' />")
				form.attr("method", "POST")
				form.submit()
			})
			
			// 강좌 '수정'버튼 클릭
			$("#courseModBtn").on("click", function() {
				location.href = "<c:url value='/course/modify${pr.sc.queryString }&course_id=${courseDto.course_id }' />"
			})
			
			// 강좌 '삭제'버튼 클릭
			$("#removeBtn").on("click", function() {
				if(!confirm("정말로 삭제하시겠습니까?")) return
				
				let form = $("#form")
				
				form.attr("action", "<c:url value='/course/remove${courseSearchItem.queryString}' />")
				form.attr("method", "POST")
				form.submit()
			})
			
			// 강좌 '등록'버튼 클릭
			$("#writeBtn").on("click", function() {
				let form = $('#form')
				
				form.attr("action", "<c:url value='/course/write' />")
				form.attr("method", "POST")
				
				if(formCheck())
					form.submit()
			})
			
			let formCheck = function() {
				let form = document.getElementById("form")
				if(form.course_nm.value == ""){
					alert("강좌명을 입력해주세요.")
					form.course_nm.focus()
					return false
				}
				if(form.course_info.value == ""){
					alert("강좌소개를 입력해주세요.")
					form.course_info.focus()
					return false
				}
				return true
			}
			
			// 강좌 '강좌생성'버튼 클릭
			$("#writeNewBtn").on("click", function() {
				location.href = "<c:url value='/course/write' />"
			})
			
			// 강좌 '목록'버튼 클릭
			$("#listBtn").on("click", function() {
				location.href = "<c:url value='/course/search${courseSearchItem.queryString}' />"
			})
			
			// 'new'에서 '뒤로'버튼 클릭
			$("#backtoSearch").on("click", function() {
				location.href = "<c:url value='/course/search' />"
			})
			
			// 'modify'에서 '뒤로'버튼 클릭
			$("#backtoDetail").on("click", function() {
				location.href = "<c:url value='/course/detail${pr.sc.queryString }&course_id=${courseDto.course_id }' />"
			})
		})
	</script>
	
	<!-- footer include -->
	<%@ include file="/WEB-INF/views/footer.jsp" %>
</body>
</html>