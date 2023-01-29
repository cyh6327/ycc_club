<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<!-- head & meta tag include -->
	<%@include file="/WEB-INF/views/metahead.jsp"%>
    
    <link href='/ycc/resources/css/courseSchedule.css' rel='stylesheet' />
    <script src='/ycc/resources/js/courseSchedule.js'></script>
    <script>

      document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
          initialView: 'dayGridMonth'
        });
        calendar.render();
      });

    </script>
<title>YOUNG문화체육센터</title>
</head>
<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	
	<div class="container">
		<h3 style="margin: 15px 0px 8px 10px;">강좌일정</h3>
		<hr>
	 	<div id='calendar' class="container"></div>
	</div>
	 
	 
	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>
</html>