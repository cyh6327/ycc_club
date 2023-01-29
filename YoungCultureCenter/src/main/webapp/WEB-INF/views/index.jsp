<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>	
<!-- head & meta tag include -->
<%@include file="/WEB-INF/views/metahead.jsp"%>
	<style type="text/css">
	 
	.img_size01 {
	/* 슬라이드에 들어가는 이미지 크기 조절*/
	height: 450px;
	width: 100%;
	}
	
	 	.boardlist > li
	{
		list-style: none;
		overflow: hidden;
		text-overflow: ellipsis;
		margin-top: 0.25em;
		margin-bottom: 0.25em;
	}
	
	.boardlist > li > a, .more
	{
		text-decoration: none;
		color: graytext;
	}
	
	 	.quickIcon
	{
		width: 50px;
		height: 50px;
	}
	
	#quickMenu > li
	{
		display : inline-block;
		position: relative;
	}
	
	#quickMenu > li > a
	{
	display:block;
	position:relative;
	padding-bottom:30px;
	margin: 50px;
	}
	
	#quickMenu > li > a > span
	{
		position:absolute;
		bottom:0;
		left:50%;
		color:#666;
		line-height:1.462em;
		white-space:nowrap;
		transform:translate(-50%, 0);
	}
	</style>
	<!-- 쿠키 저장 자바스크립트 -->
	<script type="text/javascript">
	/* 스토리지 제어 함수 정의 */
	var handleStorage = {
	  // 스토리지에 데이터 쓰기(이름, 만료일)
	  setStorage: function (name, exp) {
	    // 만료 시간 구하기(exp를 ms단위로 변경)
	    var date = new Date();
	    date = date.setTime(date.getTime() + exp * 24 * 60 * 60 * 1000);

	    // 로컬 스토리지에 저장하기
	        // (값을 따로 저장하지 않고 만료 시간을 저장)
	    localStorage.setItem(name, date)
	  },
	  // 스토리지 읽어오기
	  getStorage: function (name) {
	    var now = new Date();
	    now = now.setTime(now.getTime());
	    // 현재 시각과 스토리지에 저장된 시각을 각각 비교하여
	    // 시간이 남아 있으면 true, 아니면 false 리턴
	    return parseInt(localStorage.getItem(name)) > now
	  }
	};
	</script>

<title>YOUNG문화체육센터</title>
</head>
<body>
	<script>
	//오늘 하루 다시 보지 않기 버튼 (쿠키 저장)
		//쿠키 생성
	function setCookie( name, value, expiredays) {
	    var todayDate = new Date();
	    todayDate.setDate( todayDate.getDate() + expiredays );
	    document.cookie = name + "=" + value + "; path=/; expires=" + todayDate.toGMTString() + ";";
	}
		//쿠키 가져오기
	function getCookie() {
	    var cookiedata = document.cookie;
	    
	    //쿠기가 없는 경우, 모달 출력
	    if ( cookiedata.indexOf("noMoreToday=done") < 0 ){
	         $("#modal1").modal('show');
	    }
	    //그 외에, 모달 숨기기
	    else {
	        $("#modal1").hide();
	    }
	}
		$(function() {
			getCookie();
			//모달 닫기버튼
			$('#btn_close').click(function(){
				$('#modal1').hide();	
			})
			//모달 오늘하루 보지 않기
		    $(".btn_today_close").click(function () {		    		
		        setCookie("noMoreToday", "done" , 1);		//이름, 값, 만료시간
		        $("#modal1").hide();
		    });
		});
		 
		
	</script>
	
	<!-- 모달#1 콘텐츠 -->
	<div class="modal" id="modal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: inline-block;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="width: auto;">
				<div class="modal-body p-0">
					<a href="/ycc/board/notice">
					<img alt="" src="/ycc/resources/modal/modal1.jpg">
					</a>
				</div>
				<div class="p-1 px-2 text-bg-dark d-flex">
<!-- 					<button type="button" class="btn btn-secondary btn_today_close"
						data-bs-dismiss="modal">오늘 하루 보지 않기</button> -->
					<a class="btn btn-secondary btn_today_close" data-bs-dismiss="modal">오늘 하루 보지 않기</a>
					<button type="button" class="btn btn-primary ms-auto" id="btn_close" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 
 	모달#2 콘텐츠
	<div class="modal fade" id="modal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: inline-block;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="width: auto;">
				<div class="modal-body p-0">
					<a href="/ycc/board/notice">
					<img alt="" src="/ycc/resources/modal/b67128cb0f19daa18c4dc11659d6764d.gif">
					</a>
				</div>
				<div class="p-1 px-2 text-bg-dark d-flex">
					<button type="button" class="btn btn-secondary"	data-bs-dismiss="modal">오늘 하루 보지 않기</button>
					<button type="button" class="btn btn-primary ms-auto" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	모달#3 콘텐츠
	<div class="modal fade" id="modal3" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: inline-block;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="width: auto;">
				<div class="modal-body p-0">
					<a href="/ycc/board/notice">
					<img alt="" src="/ycc/resources/modal/i014104791013.gif">
					</a>
				</div>
				<div class="p-1 px-2 text-bg-dark d-flex">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">오늘 하루 보지 않기</button>
					<button type="button" class="btn btn-primary ms-auto" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
	
	모달#4 콘텐츠
	<div class="modal fade" id="modal4" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true" style="display: inline-block;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content" style="width: auto;">
				<div class="modal-body p-0">
					<a href="/ycc/board/notice">
					<img alt="" src="/ycc/resources/modal/i014126361567.gif">
					</a>
				</div>
				<div class="p-1 px-2 text-bg-dark d-flex">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">오늘 하루 보지 않기</button>
					<button type="button" class="btn btn-primary ms-auto" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div> -->

	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	<div class="container">
		<!-- 슬라이드 배너 캐러셀1 -->
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"
					aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"
					aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"
					aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="resources\img\slide\Youngculturecenter.png" class="img_size01" alt="Youngculture바로가기">
				</div>
				<div class="carousel-item">
					<img src="resources\img\slide\baking.jpg" class="img_size01" alt="베이킹 수업 바로가기">
				</div>
				<div class="carousel-item">
					<img src="resources\img\slide\coingclass.png" class="img_size01" alt="코딩수업 바로가기">
				</div>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"
				data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>



		<!-- 중단 퀵메뉴 -->
		<div class="text-center" style="list-style-type: none;">
			<ul id="quickMenu" name="quickMenu">
				<li><a href="/ycc/course/courseinfo"><img class="quickIcon"  src="resources\img\main_img\application_icon.png"
							alt="수강신청" /><span>수강신청</span></a></li>
				<li><a href="/ycc/rental/place"><img class="quickIcon" src="resources\img\main_img\rental_icon.png"
							alt="대관신청" /><span>대관 신청</span></a></li>
				<li><a href="/ycc/rental/locker"><img class="quickIcon" src="resources\img\main_img\studyroom_icon.png"
							alt="독서실예약" /><span>독서실 예약</span></a></li>
				<li><a href="/ycc/rental/locker"><img class="quickIcon" src="resources\img\main_img\Locker_icon.png"
							alt="사물함신청" /><span>사물함 신청</span></a></li>
				<li><a href="/ycc/club"><img class="quickIcon" src="resources\img\main_img\club_icon.png"
							alt="동아리" /><span>동아리</span></a></li>
				<li><a href="/ycc/map"><img class="quickIcon" src="resources\img\main_img\map_icon.png"
							alt="찾아오시는 길" /><span>찾아오시는 길</span></a></li>
			</ul>
		</div><!-- // banner_list -->
	
		<div class="row">
			<div class="col-lg-6 p-1 mb-2">
				<div class="border border-opacity-25 shadow p-4">
					<div class="d-flex align-items-center">
					<div>
						<span class="fs-4">공지사항</span>
					</div>
					<div class="ms-auto">
						<span><a href="/ycc/board/notice" class="more">더보기</a></span>
					</div>
				</div>
				<hr class="my-2">
				<ul class="ms-0 text-truncate ps-0 boardlist">
					<c:forEach var="boardDto" items="${nList }"  begin="0" end="4" step="1">
							<li class="title"  >
								<a style="text-decoration: none; color: black;"
									 href="<c:url value="/board/post?page=1&pageSize=10&option=&keyword=&article_id=${boardDto.article_id  }"/>">
									${boardDto.article_title }
				      			</a>
							</li>
					</c:forEach>
				</ul>
			</div>
			</div>
			<div class="col-lg-6 p-1 mb-2">
				<div class="border border-opacity-25 shadow p-4">
					<div class="d-flex align-items-center">
						<div>
							<span class="fs-4">행사/이벤트</span>
						</div>
						<div class="ms-auto">
							<span><a href="/ycc/board/event" class="more">더보기</a></span>
						</div>
					</div>
					<hr class="my-2">
					<ul class="ms-0 text-truncate ps-0 boardlist">
						<c:forEach var="boardDto" items="${eList }"  begin="0" end="4" step="1">
							<li class="title"  >
								<a style="text-decoration: none; color: black;"
									 href="<c:url value="/board/post?page=1&pageSize=10&option=&keyword=&article_id=${boardDto.article_id  }"/>">
									${boardDto.article_title }
				      			</a>
							</li>
					</c:forEach>
					</ul>
				</div>
			</div>
		</div>
	<!-- container END -->
	</div> 
	

	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>