<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Document</title>
		<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
		<script src="${pageContext.request.contextPath}/js/region.js"></script>
	</head>

	<body>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=109dd4a6fbdf108d896544146388b47e"></script>

		<jsp:include page="/WEB-INF/views/header.jsp" />
		<!-- 지도 표시 -->
		<div id="map" style="width:100%;height:700px;"></div>

		<!-- 추후에 사용자 세션 받아서 blind 및 display 처리 요망. -->
		<!-- 사용자 세션 받으면 center_lat과 center_lng는 사용자 가입시 설정되는 area 값으로 지정 -->
		<div id="sidebar">
			<h1>지역 선택</h1>

			<form id="address-form">
				<label for="area_ctpy_nm">시/도</label>
				<select id="area_ctpy_nm" name="area_ctpy_nm" onchange="updatearea_sgg_nm()">
					<option value="">선택하세요</option>
					<option value="서울특별시">서울특별시</option>
					<option value="부산광역시">부산광역시</option>
					<option value="대구광역시">대구광역시</option>
					<option value="인천광역시">인천광역시</option>
					<option value="광주광역시">광주광역시</option>
					<option value="대전광역시">대전광역시</option>
					<option value="울산광역시">울산광역시</option>
					<option value="경기도">경기도</option>
					<option value="강원도">강원도</option>
					<option value="충청북도">충청북도</option>
					<option value="충청남도">충청남도</option>
					<option value="전라북도">전라북도</option>
					<option value="전라남도">전라남도</option>
					<option value="경상북도">경상북도</option>
					<option value="경상남도">경상남도</option>
					<option value="제주도">제주도</option>
				</select>

				<label for="area_sgg_nm">군/구</label>
				<select id="area_sgg_nm" name="area_sgg_nm" onchange="updatearea_emd_nm()">
					<option value="">선택하세요</option>
					<!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
				</select>

				<label for="area_emd_nm">읍/면/동</label>
				<select id="area_emd_nm" name="area_emd_nm">
					<option value="">선택하세요</option>
					<!-- 읍/면/동 옵션이 여기에 동적으로 추가됩니다 -->
				</select>

				<input type="button" id="search_btn" value="검색하기">
			</form>
			<button id="update">새로고침</button>
		</div>

		<script type="text/javascript">
			var mapContainer = document.getElementById('map'); // 지도를 표시할 div  
			var markers = [];
			var center_lat; // 서버에서 전달된 위도
			var center_lng; // 서버에서 전달된 경도
			if (center_lat == null && center_lng == null) {
				center_lat = 37.5400456;
				center_lng = 126.9921017;
			};

			var mapOption = {
				center: new kakao.maps.LatLng(center_lat, center_lng), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			kakao.maps.event.addListener(map, 'center_changed', function () {
				var latlng = map.getCenter();
				center_lat = latlng.getLat();
				center_lng = latlng.getLng();
				console.log('현재 중심 좌표:', center_lat, center_lng);
			});
		</script>
		<script>
			// 군/구 옵션 업데이트 함수
			function updatearea_sgg_nm() {
				const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
				const area_sgg_nmSelect = document.getElementById("area_sgg_nm");
				const area_emd_nmSelect = document.getElementById("area_emd_nm");

				// 군/구와 읍/면/동 초기화
				area_sgg_nmSelect.innerHTML = '<option value="">선택하세요</option>';
				area_emd_nmSelect.innerHTML = '<option value="">선택하세요</option>';

				if (area_ctpy_nm && regions[area_ctpy_nm]) {
					// 군/구 옵션 추가
					for (const area_sgg_nm in regions[area_ctpy_nm]) {
						const option = document.createElement("option");
						option.value = area_sgg_nm;
						option.text = area_sgg_nm;
						area_sgg_nmSelect.appendChild(option);
					}
				}
			}

			// 읍/면/동 옵션 업데이트 함수
			function updatearea_emd_nm() {
				const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
				const area_sgg_nm = document.getElementById("area_sgg_nm").value;
				const area_emd_nmSelect = document.getElementById("area_emd_nm");

				// 읍/면/동 초기화
				area_emd_nmSelect.innerHTML = '<option value="">선택하세요</option>';

				if (area_ctpy_nm && area_sgg_nm && regions[area_ctpy_nm] && regions[area_ctpy_nm][area_sgg_nm]) {
					const area_emd_nms = regions[area_ctpy_nm][area_sgg_nm];
					area_emd_nms.forEach(area_emd_nm => {
						const option = document.createElement("option");
						option.value = area_emd_nm;
						option.text = area_emd_nm;
						area_emd_nmSelect.appendChild(option);
					});
				}
			}

			// 검색하기 버튼 클릭 시 실행되는 함수
			document.querySelector('input[type="button"]').addEventListener('click', function () {
				const area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
				const area_sgg_nm = document.getElementById("area_sgg_nm").value;
				const area_emd_nm = document.getElementById("area_emd_nm").value;

				if (area_ctpy_nm && area_sgg_nm && area_emd_nm) {
					// 폼 데이터를 서버로 전송
					fetch('/updateMapCoordinates', {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json'
						},
						body: JSON.stringify({
							area_ctpy_nm: area_ctpy_nm,
							area_sgg_nm: area_sgg_nm,
							area_emd_nm: area_emd_nm
						})
					})
						.then(response => response.json())
						.then(data => {
							// 서버에서 받은 위도와 경도로 지도 중심 좌표 갱신
							if (data.latitude && data.longitude) {
								center_lat = data.latitude;
								center_lng = data.longitude;
								var newCenter = new kakao.maps.LatLng(center_lat, center_lng);
								map.setCenter(newCenter);
								console.log("새로운 중심 좌표:", center_lat, center_lng);

								// //주변 충전소를 찾기위한 데이터 전송
								// fetch('/updateMapCoordinates/findStationsNear', {
								// 	method: 'POST',
								// 	headers: {
								// 		'Content-Type': 'application/json'
								// 	},
								// 	body: JSON.stringify({
								// 		center_lat: center_lat,
								// 		center_lng: center_lng
								// 	})
								// })
								// 	.then(response => response.json())
								// 	.then(data => {
								// 		removeMarkers(); // 기존 마커 제거
								// 		for (var i = 0; i < data.length; i++) {
								// 			addMarker(data[i].latitude, data[i].longitude, data[i].stationName);
								// 		}
								// 	})
								// 	.catch(error => console.error("에러 발생:", error));
							} else {
								alert("해당 정보는 없는 정보입니다.");
							}
						})
						.catch(error => {
							console.error("Error:", error);
							alert("위도 경도 변환 중 오류가 발생했습니다.");
						});
				} else {
					alert("모든 주소 항목을 선택해주세요.");
				}
			});

			// 백경흠
			//============================================
			$(document).ready(function () {
				$("#search_btn").on("click", function () {
					var area_ctpy_nm = document.getElementById("area_ctpy_nm").value;
					var area_sgg_nm = document.getElementById("area_sgg_nm").value;

					$.ajax({
						type: "post",
						url: "/findStationsNear",
						data: {
							area_ctpy_nm: area_ctpy_nm,
							area_sgg_nm: area_sgg_nm
						},
						success: function (station_list) {
							alert("갔다옴" + JSON.stringify(station_list));
						},
						error: function () {
							alert("오류");
						}
					});
				});

				$("#update").on("click", function () {
					$.ajax({
						type: "post",
						url: "/update",
						data: {
						},
						success: function () {
							alert("성공!");
						},
						error: function () {
							alert("오류");
						}
					});
				});
			});
			//============================================
			// 마커 찍기
			function addMarker(lat, lng, title) {
				var marker = new kakao.maps.Marker({
					position: new kakao.maps.LatLng(lat, lng),
					map: map,
					title: title
				});

				markers.push(marker);

				// 마커에 인포윈도우 달기 (클릭하면 이름 뜨게)
				var infowindow = new kakao.maps.InfoWindow({
					content: '<div style="padding:5px;font-size:12px;">' + title + '</div>'
				});

				kakao.maps.event.addListener(marker, 'click', function () {
					infowindow.open(map, marker);
				});
			}

			// 마커 지우기
			function removeMarkers() {
				for (var i = 0; i < markers.length; i++) {
					markers[i].setMap(null);
				}
				markers = [];
			}
		</script>
	</body>

	</html>