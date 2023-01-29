
 <!-- 작성자 : alwaysFinn(김지호)
 	  최초 작성일 : '22. 12. 02
 	  마지막 업데이트 : '23.01.05
 	  업데이트 내용 : code clean up
 	  기능 : 독서실 예약할 수 있는 view 파일 -->
 

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authentication property="principal" var="pinfo"/>
<c:set var="loginId" value="${pinfo.member.user_id }" />
    
<!DOCTYPE html>
<html>
  <head>
    <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>

	<link rel="stylesheet" href="/ycc/resources/css/studyRoom.css" type="text/css"/>	
	<script type="text/javascript" src="/ycc/resources/js/studyRoom.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <title>독서실 예약</title>

    <style>
      th {
        background-color: bisque !important;
      }
    </style>
</head>

<body>
    <!-- include header -->
<%@include file="/WEB-INF/views/header.jsp"%>

        
 
<div class="container mt-3">
  <h4 class= "fw-bold">독서실 예약</h4>
  <hr>
</div>
    <!-- 좌석 선택 폼 -->
     <div class="container w-100 pt-1" >
		<div class="container-lg d-grid" style="border: solid 1px gray; border-radius: 10px; overflow: scroll;">
        	<ol class="rRoomTotal" style="margin-top:3 %">
          		<ol class="rRoomUpper mb-5">
          			<li class="row row--1">
            			<ol class="seats" type="A">
	            			<c:forEach var="i" begin="0" end="11">
	            				<li class="seat">
				            		<input
				            			type="checkbox"
				            			id="${i+1 }"
				            			name="indvSeat"
				            			onclick="checkOnlyOne(this)"
				            			
				            		/>
				            		<label for="${i+1 }">${i+1 }</label>
	            				</li>
	        				</c:forEach>
           				 </ol>
         			 </li>

          			<li class="row row--2">
           				<ol class="seats" type="A">
              				<c:forEach var="i" begin="12" end="23">
	            				<li class="seat">
				            		<input
				            			type="checkbox"
				            			id="${i+1 }"
				            			name="indvSeat"
				            			onclick="checkOnlyOne(this)"
				            		/>
				            		<label for="${i+1 }">${i+1 }</label>
	            				</li>
	        				</c:forEach>
            			</ol>
          			</li>
				</ol>

         		<ol class="rRoomUnder" style="margin-bottom: 2%">
            		<li class="row row--3">
              			<ol class="seats" type="A">
                			<c:forEach var="i" begin="24" end="35">
	            				<li class="seat">
				            		<input
				            			type="checkbox"
				            			id="${i+1 }"
				            			name="indvSeat"
				            			onclick="checkOnlyOne(this)"
				            		/>
	            					<label for="${i+1 }">${i+1 }</label>
	            				</li>
	        				</c:forEach>
             			</ol>
            		</li>

            		<li class="row row--4">
             			<ol class="seats" type="A">
                			<c:forEach var="i" begin="36" end="47">
	            				<li class="seat">
				            		<input
				            			type="checkbox"
				            			id="${i+1 }"
				            			name="indvSeat"
				            			onclick="checkOnlyOne(this)"
				            		/>
	            					<label for="${i+1 }">${i+1 }</label>
	            				</li>
	        				</c:forEach>
              			</ol>
            		</li>
          		</ol>
        	</ol>
      	</div>
		<!-- 좌석 선택 정보 이미지 -->
		<div class="row">
			<div class="col-md-2">
		      <div class="fs-6 pt-3 mb-4">
		        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" style="fill: #39adffed;"
		          class="bi bi-square-fill" viewBox="0 0 16 16">
		          <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2z"></path>
		        </svg>
		        사용가능
		      </div>
		    </div>
		    <div class="col-md-2">
		      <div class="fs-6 pt-3  mb-3">
		        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" style="fill: #dddddd" class="bi bi-square-fill"
		          viewBox="0 0 16 16">
		          <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2z"></path>
		        </svg>
		        사용중
		      </div>
		    </div>
		    <div class="col-md-2">
		      <div class="fs-6 pt-3  mb-3">
		        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" style="fill: #bada55;"
		          class="bi bi-square-fill" viewBox="0 0 16 16">
		          <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2z"></path>
		        </svg>
		        선택
		      </div>
		    </div>
	  	</div>
	
    </div>

    <!-- 예약 정보 폼 -->
      <div class="container mt-5">
        <div class="row text-center" >
          <div class="col-md-6">
            <label for="time" >입실 예정 시간은 '현재시각' 기준입니다. </label>
          </div>
          <div class="col-md-6">
            <label for="usetime" class=" col-form-label">
              이용시간 :
            </label>
            <select
              id="usetime"
              class="form-control w-auto"
              style="display: inline"
              >
              <option value="1">1</option>
              <option value="2">2</option>
              <option value="3">3</option>
              <option value="4">4</option>
              <option value="5">5</option>
              <option value="6">6</option>
              <option value="12">12</option>	<!-- 시간 유효성 테스트 테스트용 -->
            </select>
            <label for="usetime" class="col-form-label"> 시간</label>
            <!-- 유효성 체크 #2 사용자가 입력한 사용 종료 시간이 00시를 넘길경우 예약 불가능하게 하는 기능  -->
            <div id="timealert"></div> <!-- 이용가능한 시간이 아닙니다 문구가 출력될 부분 -->
          </div>
        </div>
      </div>

      <br />
	  <!-- 모달 버튼  -->
	  <div id="foralert"></div>	<!-- 유효성 체크 #1 이미 예약한 user일 경우 경고 메세지를 띄울 부분 -->
	  <div class="text-center">
	    <button
	      id="modalBtn"
	      type="button"
	      class="btn btn-primary"
	      data-bs-toggle="modal"
	      data-bs-target="#staticBackdrop"
	      >
	      확인
	    </button>
		</div>
		<!-- 결제 전 예약정보 확인 모달창 -->
		<form id="form" method="post" action="" >
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			<div
			  class="modal fade"
			  id="staticBackdrop"
			  data-bs-backdrop="static"
			  data-bs-keyboard="false"
			  tabindex="-1"
			  aria-labelledby="staticBackdropLabel"
			  aria-hidden="true"
			>
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h1 class="modal-title fs-5 fw-bold" id="staticBackdropLabel">
			          정보 확인 안내
			        </h1>
			      </div>
			      <div class="modal-body text-center">
			        <div class="justify-content-center">
			        	<div id="yn"><!-- 사용자의 선택 결과에 따라 보여줄 화면 -->
			        	</div>
			        </div>
			      </div>
			    </div>
			  </div>
			</div>
		</form>


	<script type="text/javascript">
	$(document).ready(function () {
		//체크박스 중복 선택 안되게 하는 함수
		function checkOnlyOne(element) {  
		      const checkboxes = document.getElementsByName("indvSeat");	
		      checkboxes.forEach((cb) => {
		        cb.checked = false;
		      })
		      element.checked = true;	 
		      $("#sroom_seat_id").html(element.getAttribute("id"))*1 
		    }

		/*해당 유저가 예약을 했는지 확인하는 부분*/
		
		/* jstl이 js보다 먼저 실행되므로 js에서 다룰 수 없음
		   따라서 새 배열을 만들고 controller에서 해당 값들을 배열에 담아줌
		   좌석의 비활성화, 유저 예약 여부 체크 동시 진행 */
		
		   var arr = new Array()	//controller에서 넘어온 dto의 값들을 담을 js 배열	
			<c:forEach items="${list}" var="test">	//반복문으로 모든 값 담음
				arr.push({user_id:"${test.user_id}"	//user_id 담음
					,sroom_seat_id:"${test.sroom_seat_id}"})	//좌석번호 담음
			</c:forEach>
			
		//유효성체크 #1 해당 user가 예약한 내역이 있는지 확인하는 기능
		//반복문으로 배열 안에 있는 값들 체크 후 로그인한 user_id가 DB에 있으면 중복예약으로 확인버튼, 이용시간 비활성화
		for(var i = 0; i<arr.length; i++){
			if(arr[i].user_id=="${pinfo.member.user_id }"){
				$("#modalBtn").attr("disabled", true);
				$("#usetime").attr("disabled", true);
				$("#foralert").append(	//alert 대신 화면에 출력하는 방식
					'<span class="text-primary">'
				   +'<p class="text-center fw-bold fs-3">'
				   +'이미 예약된 좌석이 있습니다.'
				   +'<br>'
				   +'예약 좌석 : '
				   +arr[i].sroom_seat_id+'번'	//해당 유저가 예약한 좌석 번호
				   +'</p>'
				   +'</span>'
				   
				)
				//버튼이 비활성화 되었으므로 버튼의 색도 파란색 -> 회색으로 변경
				document.getElementById('modalBtn').classList.replace('btn-primary', 'btn-secondary');
				
			}//해당 좌석이 예약되어있는지 확인하여 예약된 좌석에 비활성화를 주는 부분
			for(var j = 1; j <= 48; j++){
				if(arr[i].sroom_seat_id==j){
					document.getElementById(j).disabled = true;
				}
			}
		}	// 유효성 체크 #1 종료
		
		// 유효성 체크 #2 사용자가 입력한 사용 종료 시간이 00시를 넘길경우 예약 불가능하게 하는 기능
		$("#usetime").on('click', function(){
		        let vv = $(this).val()*1
		        let nh = new Date().getHours()*1
		        //console.log(vv)
		        //console.log(nh)
		        $("#disabletime").remove()
		        $("#modalBtn").attr("disabled", false);
		        document.getElementById('modalBtn').classList.replace('btn-secondary', 'btn-primary');
		        	if(vv+nh>24 || vv+nh<6){
		        	   $("#timealert").append(
							'<p id ="disabletime" class="text-center text-danger fw-bold">'
						   +'현재 이용 가능한 시간이 아닙니다.'
						   +'</p>'
						)
					   $("#modalBtn").attr("disabled", true);
			        	   if($("#modalBtn").is(":disabled") == true){
			        		   document.getElementById('modalBtn').classList.replace('btn-primary', 'btn-secondary');
			       			}
					}	
	    }); // 유효성 체크 #2 종료
 

	    // 사용자가 고른 값들 보여줄 modal에 대한 정의
		$("#modalBtn").on('click', function(){
			
			//DB에 보낼 예약 종료 시간 값의 형태를 DB 타입과 같게 변화하는 기능 
			function getFormatTime(date) {
				var yy = date.getFullYear()
				var MM = date.getMonth()+1
				var dd = date.getDate()
				var hh = (date.getHours()*1)+(document.getElementById("usetime").value*1)
				hh = hh >= 10 ? hh : '0' + hh
				var mm = date.getMinutes()
				mm = mm >= 10 ? mm : '0' + mm
				var ss = date.getSeconds()
				ss = ss >= 10 ? ss : '0' + ss
				var ms = date.getMilliseconds()
				
				return yy+"-"+MM+"-"+dd+" "+hh+':'+mm+':'+ss+"."+ms;
			}
			
			// 사용자에게 예약 종료 시간 값 간단하게 보여주는 부분
			function getFT(date){
				var hh = (date.getHours()*1)+(document.getElementById("usetime").value*1)
				hh = hh >= 10 ? hh : '0' + hh
				var mm = date.getMinutes()
				mm = mm >= 10 ? mm : '0' + mm
				var ss = date.getSeconds()
				ss = ss >= 10 ? ss : '0' + ss
						
				return hh+':'+mm+':'+ss
			}
				
			let time = getFormatTime(new Date())	//DB에 넣는 용
			let spantime = getFT(new Date())	//사용자에게 보여줄 용
			
			//선택한 좌석 번호 받아오는 변수 (DB에 넣는 용도)
			let selected = $("input[name='indvSeat']:checked").attr('id')*1
			//선택한 좌석 번호 받아오는 변수 (사용자에게 보여줄 용도)
			let showselected = $("input[name='indvSeat']:checked").attr('id')
			
			//예약 종료시간 값 가져오는 부분
			let rentime = document.getElementById("usetime").value*1
		
			//지불 금액 값 계산 (DB에 넣는 용도)
			let pay = rentime * 1000
			//지불 금액 값 계산 (사용자에게 보여주는 용도)
			let spanpay = rentime * 1000

			//사용자가 좌석을 선택하면 보여줄 모달 화면
			if($("input[name='indvSeat']").is(":checked") == true){
				$("#yn").append(
					'<table class="table container-fluid border">'
		            +'<tbody>'
		            +'<tr>'
		            +'<th scope="row" class="col-sm-4">이름</th>'
		            +'<td>'
		            +'<div class="col-sm-12">${pinfo.member.user_name }</div>'
		            +'</td>'
		            +'</tr>'
		            +'<tr>'
		            +'<th scope="row">시설명</th>'
		            +'<td>'
		            +'<div class="col-sm-12"></div>'
		            +'YOUNG문화센터 독서실​'
		            +'</td>'
		            +'</tr>'
		            +'<tr>'
		            +'<th scope="row">좌석번호</th>'
		            +'<td>'
		            +'<textarea class="col-sm-12 visually-hidden" id="sroom_seat_id" name="sroom_seat_id"></textarea>'
		            +'<span id="show_sroom_seat_id"></span>'
		            +'</td>'
		            +'</tr>'
		            +'<tr>'
		            +'<th scope="row">이용시간</th>'
		            +'<td>'
		            +'<textarea class="col-sm-12 visually-hidden" id="sroom_rental_etime" name="sroom_rental_etime"></textarea>'
		            +'<span id="show_sroom_rental_etime"></span>'
		            +'</td>'
		            +'</tr>'
		            +'<tr>'
		            +'<th scope="row">결제금액</th>'
		                +'<td>'
		                +'<textarea class="col-sm-12 visually-hidden" id="sroompay" name="sroompay"></textarea>'
		                +'<span id="show_sroompay"></span>'
		                +'</td>'
		                +'</tr>'
		                +'</tbody>'
		                +'</table>'
		                +'</div>'
		                +'<p>해당 정보가 맞으십니까?</p>'
		                +'</div>'
		                +'<div class="modal-footer" style="justify-content: center;">'
		                +'<button type="button" class="btn btn-secondary " data-bs-dismiss="modal" id="cencelBtn">취소'
              			+'</button>'
              			+'<button id="submitBtn" type="submit" class="btn btn-primary">결제</button>'
				);

				//이용 시간에 따른 가격 (이용시간 * 1,000원)
				document.getElementById("sroompay").innerHTML = pay
				//-->span안에 for 보여주기식
				document.getElementById("show_sroompay").innerHTML = spanpay

	        	//클릭 시 장소값 넘겨주는 기능 type을 int로 바꾸기 위해 *1 --> input안에
	        	document.getElementById("sroom_seat_id").innerHTML = selected
	        	//-->span 안에 for 보여주기식
	        	document.getElementById("show_sroom_seat_id").innerHTML = showselected
	        	
	        	//클릭 시 종료시간 넘겨주는 기능
	        	document.getElementById("sroom_rental_etime").innerHTML = time
	        	//-->span 안에 for 보여주기식
	        	document.getElementById("show_sroom_rental_etime").innerHTML = spantime
			}else if($("input[name='indvSeat']").is(":checked") == false){
				$("#yn").append(//사용자가 좌석을 선택하지 않은 경우 보여줄 모달 화면
					'<div">선택되지 않은 값이 있습니다.</div>'
					+'<div class="modal-footer" style="justify-content: center;">'
	                +'<button type="button" class="btn btn-secondary " data-bs-dismiss="modal" id="cencelBtn">돌아가기'
	      			+'</button>'
      			);
			}
			
			
	             
		})
        //결제 버튼 연동 기능 누를 시 post 방식으로 보냄
        $("#submitBtn").on("click", function(){
	        	let form = $("#form")
				form.attr("action", "<c:url value='/rental/studyroom' />")
				form.attr("method", "post")
				form.submit()
        	
		})
		
		//취소 버튼 클릭 시 새로고침을 주기 위한 부분
		//cencleBtn에 바로 접근하면 읽지 못하기에 id에 선 접근 후 그 안에 있는 cencleBtn으로 접근
		$("#yn").on("click", "#cencelBtn", function(){
			location.href = "<c:url value='/rental/studyroom' />"
		})

		
		
		
	})
	</script>
	
	<!-- footer include -->
<%@include file="/WEB-INF/views/footer.jsp"%>

  </body>
</html>