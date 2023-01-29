<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
	<style>
		.icon
		{
			height: 50px;
			width: 50px;
		}
	</style>
	<!-- 카카오맵 스크립트 -->
	<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
	
  <title>찾아오시는 길</title>

</head>

<body>
	<!-- header include -->
	<%@include file="/WEB-INF/views/header.jsp"%>
	
	<!-- 오시는길 -->
	<div class="container-lg mt-5">
		<table class="table">
			<thead>
				<tr>
					<th colspan="2"><h1>오시는 길</h1></th>
				</tr>
			</thead>
			<tbody class="table-group-divider align-middle">
				<tr>
					<td class="text-center"><img src="resources\img\map\bus_icon.png" class="icon"></td>
					<td>서울 서초구 서초대로77길 55 에이프로스퀘어 3층</td>
				</tr>
				<tr>
					<td class="text-center"><img src="resources\img\map\subway_icon.png" class="icon"></td>
					<td>2호선 강남역 하차<br>9호선/신분당선 신논현역 하차</td>
				</tr>
				<tr>
					<td class="text-center"><img src="resources\img\map\bus_icon.png" class="icon"></td>
					<td> 146번, 4312번, 9711번 하차  </td>
				</tr>
				<tr>
					<td class="text-center"><img src="resources\img\map\busstop_icon.png" class="icon"></td>
					<td>신논현역.구교보타워사거리/신논현역.씨티은행<br>신논현역.영신빌딩</td>
				</tr>
			</tbody>
		</table>

		<!-- * 카카오맵 - 지도퍼가기 -->
		<!-- 1. 지도 노드 -->
		<div id="daumRoughmapContainer1666269316508" class="root_daum_roughmap root_daum_roughmap_landing mx-auto w-100">
			<div class="list-group list-group-flush" style="d-flex"></div>
		</div>
	</div>

	<!-- 3. 실행 스크립트 -->
	<script charset="UTF-8">
		new daum.roughmap.Lander({
			"timestamp" : "1666269316508",
			"key" : "2c575",
			"mapWidth" : "640",
			"mapHeight" : "360"
		}).render();
	</script>
	

	<!-- footer include -->
	<%@include file="/WEB-INF/views/footer.jsp"%>
</body>

</html>