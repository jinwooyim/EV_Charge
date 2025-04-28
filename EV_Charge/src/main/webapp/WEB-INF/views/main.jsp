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
  <div id="map" style="width:100%;height:700px;"></div>

  <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=109dd4a6fbdf108d896544146388b47e"></script>
  <script>
    var mapContainer = document.getElementById('map'); // 지도를 표시할 div  

    var center_lat = 37.5400456;
    var center_lng = 126.9921017;

    var mapOption = {
      center: new kakao.maps.LatLng(center_lat, center_lng), // 지도의 중심좌표
      level: 4 // 지도의 확대 레벨
    };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    kakao.maps.event.addListener(map, 'center_changed', function () {
      var latlng = map.getCenter();
      center_lat = latlng.getLat();
      center_lng = latlng.getLng();
      console.log('현재 중심 좌표:', center_lat, center_lng);
    });

    var positions = [];
    var charge_lat, charge_lng;
    positions.push({
      title: '카카오',
      latlng: new kakao.maps.LatLng(charge_lat, charge_lng)
    });

    var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

    for (var i = 0; i < positions.length; i++) {
      var imageSize = new kakao.maps.Size(24, 35);
      var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
      var marker = new kakao.maps.Marker({
        map: map,
        position: positions[i].latlng,
        title: positions[i].title,
        image: markerImage
      });
    }
  </script>
<h1>지역 선택</h1>

<form id="">
	<label for="province">시/도</label>
	<select id="province" name="province" onchange="updateDistrict()">
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

	<label for="district">군/구</label>
	<select id="district" name="district" onchange="updateTown()">
		<option value="">선택하세요</option>
		<!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
	</select>

	<label for="town">읍/면/동</label>
	<select id="town" name="town">
		<option value="">선택하세요</option>
		<!-- 읍/면/동 옵션이 여기에 동적으로 추가됩니다 -->
	</select>
	<input type="button" value="검색하기">
</form>

  <script>
    function updateDistrict() {
            const province = document.getElementById('province').value;
            const districtSelect = document.getElementById('district');
            districtSelect.innerHTML = '<option value="">선택하세요</option>'; // 초기화

            if (province && regions[province]) {
                regions[province].forEach(district => {
                    const option = document.createElement('option');
                    option.value = district;
                    option.textContent = district;
                    districtSelect.appendChild(option);
                });
            }
            updateTown(); // 군/구 선택이 변경되었으므로 읍/면/동도 초기화
        }

        // 군/구 선택 시 읍/면/동 업데이트
        function updateTown() {
            const district = document.getElementById('district').value;
            const townSelect = document.getElementById('town');
            townSelect.innerHTML = '<option value="">선택하세요</option>'; // 초기화
            // 읍/면/동은 동적으로 추가되지 않지만, 필요한 경우 추가 작업을 할 수 있습니다.
        }
  </script>

  <a href="login"><button>로그인</button></a>
  <a href="registe"><button>회원가입</button></a>
</body>

</html>