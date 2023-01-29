<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>	
    <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<title>사물함 안내</title>
</head>
<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>
  <div class="container w-100 pt-lg-5">
    <div class="mb-7 text-center">
      <h3 class="fs-xl-10 text-center fw-bold">사물함 이용안내</h3>
    </div> 
    <div class="row">
      <div class="col-lg-3 col-sm-6 mb-6">
        <div class="text-center align-items-center">
          <div class="card-body p-xxl-5 p-4">
            <div class="fs-2 mb-3 text-primary">
            <i class="bi bi-person-check fs-1"></i>
            </div> 
            <h4 class="mb-3 fw-bold text-secondary">신청대상</h4>
            <p class="mb-0 fw-medium">YOUNG문화센터 등록회원</p>
          </div> 
        </div> 
      </div>  
      <div class="col-lg-3 col-sm-6 mb-6"> 
        <div class=" text-center align-items-center">
          <div class="card-body p-xxl-5 p-4">
            <div class="fs-2 mb-3 text-primary">
            <i class="bi bi-calendar-check fs-1" ></i>
            </div> 
            <h4 class="mb-3 fw-bold  text-secondary">이용가능기간</h4>
            <p class="mb-0  fw-medium">최소 1일부터 최대 7일까지 신청가능 </p>
          </div> 
        </div>
      </div> 
      <div class="col-lg-3 col-sm-6 mb-6">
        <div class=" text-center align-items-center">
          <div class="card-body p-xxl-5 p-4">
            <div class="fs-2 mb-3 text-primary">
            <i class="bi-journal-text fs-1"></i>
            </div> 
            <h4 class="mb-3 fw-bold  text-secondary">신청방법</h4>
            <p class="mb-0 fw-medium">1.YOUNG문화센터 홈페이지<br/> 2.회원가입 또는 로그인<br/> 3.사물함 확인<br/> 4.사물함 신청 </p>
          </div> 
        </div> 
      </div> 
      <div class="col-lg-3 col-sm-6 mb-6">
        <div class="text-center align-items-center">
          <div class="card-body p-xxl-5 p-4">
            <div class="fs-2 mb-3 text-primary">
            <i class="bi bi-currency-dollar"></i>
          </div> 
          <h4 class="mb-3 fw-bold  text-secondary">요금</h4>
          <p class="mb-0 fw-medium">1일 1,000원</p>
          </div> 
        </div> 
      </div> 
    </div> 
  </div> 

  <div class="container ">
    <h3 class="card-header fw-bold text-center p-5">사물함 이용 시 유의사항</h3>
    <table class="table border-2 fw-normal pt-3 ">
      <tr>
        <td class="table-secondary">1인 1개 사물함 이용원칙, 타인에게 대여, 양도는 할 수 없습니다.</td>
      </tr>
      <tr>
        <td>사용기간 만료일 이후 보관되고 있는 물품은 별도 보관 후 1개월을 초과한 물품은 임의 처분합니다.</td>
      </tr>
      <tr>
        <td class="table-secondary">유해물품, 현금 및 귀중품 등 보관이 부적합한 물품은 보관하지 않습니다.</td>
      </tr>
      <tr>
        <td>보관품의 도난, 분실, 파손 책임은 이용자 본인에게 있으며, 회관은 일체 책임을 지지 않습니다.</td>
      </tr>
      <tr>
        <td class="table-secondary">사물함 이용 시 유의사항을 준수하여야 하며, 오ㆍ훼손, 파손 시 원상회복 또는 변상을 하여야 합니다.</td>
      </tr>
      <tr>
        <td >비밀번호를 분실한 경우 관리자가 신분증 및 연락처 확인 후 이용 가능합니다.</td>
      </tr>
  </table>

	<form id="form1">
	  <div class="row">
	    <div class="d-grid gap-2 col-md-3 mx-auto pt-5">
		  	<button class="btn btn-primary" onclick="gotolocker()">신청하기</button>
	    </div>  
	  </div> 
	</form>
</div> 

<script>
	function gotolocker() {
		let form = $("#form1")

		form.attr("action", "<c:url value='/rental/locker'/>")
		form.attr("method", "POST")
		form.append($('<input/>', {type : 'hidden', name : 'locker_location_id', value : '1' }))
		form.append($('<input/>', {type : 'hidden', name : '${_csrf.parameterName}', value : '${_csrf.token}' }))
	}
</script>


 		<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>

</html>