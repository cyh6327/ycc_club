<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style type="text/css">

    </style>

    <script type="text/javascript">
        function deleteCard(x) {
            const div = document.getElementById('card'+x);
            div.remove();
            i = i - 1;
        }
    </script>
    <title>YOUNG문화체육센터 - 홈페이지 관리</title>
</head>

<body>
<!-- header include -->
<%@include file="/WEB-INF/views/header.jsp"%>

<form action="" method="post">
    <div class="container text-center mt-5" id="original">
        <h1 class="text-start">공지사항 관리</h1>
        <hr>

        <!-- 1번 항목 -->
        <div class="card text-start text-bg-light mb-3" id="card1">
            <div class="card-header" style="display: flex; align-items: center;">
                <h5 class="card-title mb-0">헤더 관리</h5>
                <button type="button" class="btn-close ms-auto" name="action" onclick="deleteCard(1)" value="delete" aria-label="Close"></button>
            </div>

            <div class="card-body">
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label card-subtitle">홈페이지 로고 관리</label>
                    <div class="col-sm-10">
                        <input type="file" class="form-control form-control-sm" aria-label="Small file input example">
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label card-subtitle">홈페이지 이름 관리</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="url-1">
                    </div>
                </div>
            </div>
        </div>

        <!-- DB에서 ROWNUMBER 받아옴 -->
        <!-- 추가되는 위치 -->

    </div>
        <!-- 저장/취소 버튼 -->
        <div class="p-2 m-2">
            <button type="submit" class="btn btn-primary" name="action" value="save" style="width: 100px">저장</button>
            <button type="button" class="btn btn-outline-secondary" onclick="location.href='/ycc/admin'" style="width: 100px">취소</button>
        </div>
</form>


<!-- footer 여백 -->
<div style="height: 150px;"></div>
<!-- footer include -->
<%@include file="/WEB-INF/views/footer.jsp"%>

</body>
</html>