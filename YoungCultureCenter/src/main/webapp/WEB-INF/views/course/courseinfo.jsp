<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>	
	  <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
	<title>강좌안내</title>
</head>

<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>
  <div class="container pt-5 w-100">
    <div class="input-form col-md-12 mx-auto">
      <p class="fw-bolder fs-4">수강안내</p>
      <div class="accordion" id="accordionExample">
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingOne">
            <button class="accordion-button fs-5" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne"
              aria-expanded="true" aria-controls="collapseOne">
               수강안내
            </button>
          </h2>
          <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
            data-bs-parent="#accordionExample">
            <div class="accordion-body">
              <ul>
                <li class="fs-6">정규강좌 수업은 평균 주 1회, 3개월 12회를 기본으로 이루어집니다.</li>
                <li class="fs-6">강좌가 개강된 이후에는 수강하실 수 없으며, 예외적으로 수강시 수강료는 전액납부하셔야합니다.</li>
                <li class="fs-6">신청한 강좌의 연장 또는 타인 양도는 불가합니다.</li>
                <li class="fs-6">각 강좌는 정원에 따라 선착순으로 접수, 마감되며, 강좌 별 최소 인원이 미달 시 폐강될 수 있습니다.<br /> 폐강시 수강료는 환불해 드립니다.</li>
                <li class="fs-6">원활한 강의 진행을 위해 수강 회원만 강의 참여 가능합니다.</li>
              </ul>
            </div>
            <!--accordion-body -->
          </div>
          <!--collapseOne-->
        </div>
        <!--accordion-item-->
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingTwo">
            <button class="accordion-button collapsed fs-5" type="button" data-bs-toggle="collapse"
              data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
              수강취소 시 유의사항
            </button>
          </h2>
          <div id="collapseTwo" class="accordion-collapse collapse " aria-labelledby="headingTwo"
            data-bs-parent="#accordionExample">
            <div class="accordion-body">
              <ul>
                <li class="fs-6">강좌의 취소는 강좌 시작 전까지, 재료 준비 강좌는 2일전까지 가능합니다.</li>
                <li class="fs-6">강의 개강 후 취소는 평생교육법 시행령 학습비 반환기준에 의거하여 환불합니다.</li>
                <p class="fs-6"> * 1개월 이내 강좌 : 강좌 진행 1/3, 1/2 경과 전 각 2/3, 1/2 환불, 1/2 이상 경과 시 환불 불가 <br />
                  * 1개월 초과 강좌 : 1개월 이내 기준 적용 환불 + 잔여월분 환불</p>
                <li class="fs-6">온라인으로 신청한 강좌의 카드결제 취소는 카드사에 따라 처리기간이 다소 차이가 있으며, 최종 결제 승인취소는 온라인으로 취소신청 한 시점에서 10일 경과 후
                  확인 하실 수 있습니다.</li>
                <li class="fs-6">온 라인 수강신청 시에도 부분 취소가 가능합니다.</li>
                <li class="fs-6">온라인 결제 후 90일이 지난 강좌는 방문 후 현금취소만 가능합니다.<br />
                  (※여신전문금융업법 제 27조 4에 의거)</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="accordion-item">
          <h2 class="accordion-header" id="headingThree">
            <button class="accordion-button collapsed fs-5" type="button" data-bs-toggle="collapse"
              data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
              신청안내
            </button>
          </h2>
          <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree"
            data-bs-parent="#accordionExample">
            <div class="accordion-body">
              <div class="d-flex justify-content-around">
                <div class="row">
                  <div class="col p-5">
                      <img src="https://www.mapo.go.kr/design/theme/mll/images/mll-img-list_bg01.gif"
                        class="card-img-top  " alt="...">
                      <p class="card-text fs-6 pt-3 ">1.로그인</p>
                  </div>
                  <div class="col p-5">
                      <img src="https://www.mapo.go.kr/design/theme/mll/images/mll-img-list_bg02.gif"
                        class="card-img-top " alt="...">
                      <p class="card-text fs-6 pt-2 ">2.강좌선택</p>
                  </div>
                  <div class="col p-5">
                      <img src="https://www.mapo.go.kr/design/theme/mll/images/mll-img-list_bg03.gif"
                        class="card-img-top " alt="...">
                      <p class="card-text fs-6 pt-4 ">3.강좌확인</p>
                  </div>
                  <div class="col p-5">
                      <img src="https://www.mapo.go.kr/design/theme/mll/images/mll-img-list_bg04.gif"
                        class="card-img-top " alt="...">
                      <p class="card-text fs-6 pt-3 ">4.신청</p>
                  </div>
                </div>
              </div>
            <div>
              <p class="fs-5 pt-5 mb-1">로그인</p>
              <p class="fs-6">YOUNG문화센터 수강신청 시 로그인 후 이용가능합니다.</p>
            </div>
            <div>
              <p class="fs-5 mb-1">강좌 선택</p>
              <p class="fs-6">원하는 강좌를 선택합니다.</p>
            </div>
            <div>
              <p class="fs-5 mb-1">강좌 확인</p>
              <p class="fs-6">강좌 선택 후 시간, 장소 등 강좌정보를 확인합니다.</p>
            </div>
            <div>
              <p class="fs-5 mb-1">강좌 신청</p>
              <p class="fs-6">유료수강인 경우 온라인 결제가 가능합니다.</p>
            </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
    <!-- footer include -->
  	<%@include file="/WEB-INF/views/footer.jsp"%>
	
</body>
</html>