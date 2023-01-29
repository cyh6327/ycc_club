<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- head - meta tag  -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 부트스트랩 실행 코드 -->
<link href="/ycc/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" >
<script src="/ycc/resources/js/bootstrap.bundle.min.js"></script>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>


<!-- 헤더 네비바 스타일 시트 -->
<link href="/ycc/resources/css/header.css" rel="stylesheet" type="text/css" >

<!-- 파비콘 추가 -->
<link rel="shortcut icon" href="/ycc/resources/favicon/favicon.ico">
<style>
.hover-timer:hover span{
  display: none;
}

.hover-timer:hover p:after {
  content:'연장';
}
</style>

<!-- 토큰 생성 -->
<script type="text/javascript">
	const csrfHeader = "${_csrf.headerName}"
	const csrfToken = "${_csrf.token}"
</script>

<!-- metahead end -->
