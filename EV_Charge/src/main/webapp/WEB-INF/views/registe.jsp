<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Insert title here</title>
			<script src="${pageContext.request.contextPath}/js/region.js"></script>
		</head>

		<body>
			<form method="post" action="registe_user" onsubmit="return validateForm()">
				<table border="1" align="center">
					<tr height="50">
						<td colspan="3">
							<h1>회원 가입 신청</h1>
						</td>
					</tr>
					<tr height="30">
						<td width="80">
							아이디
						</td>
						<td>
							<input type="text" size="20" name="user_id" id="user_id" required
								oninvalid="this.setCustomValidity('아이디를 입력해주세요.')" oninput="this.setCustomValidity('')">
						</td>
						<td>
							<input type="button" id="user_id_check" value="중복확인">
						</td>
					</tr>
					<tr height="30">
						<td width="80">
							비번
						</td>
						<td>
							<input type="password" size="20" name="user_password" id="user_password" required
								oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')"
								oninput="this.setCustomValidity('')">
						</td>
						<td>
							<button id="pw_toggle">비번 보이기</button>
						</td>
					</tr>
					<tr height="30">
						<td width="80">
							비번확인
						</td>
						<td>
							<input type="password" size="20" name="user_password_check" id="user_password_check"
								required oninvalid="this.setCustomValidity('비밀번호를 한번 더 입력해주세요.')"
								oninput="this.setCustomValidity('')">
						</td>
						<td>
							<button id="pw_check_toggle">비번확인 보이기</button>
						</td>
					</tr>
					<!-- 비번 비번확인 비교 메세지 -->
					<tr height="30">
						<td width="80">
						</td>
						<td id="pw_match_msg" class="validation_message">
						</td>
					</tr>
					<tr height="30">
						<td width="80">
							이름
						</td>
						<td>
							<input type="text" size="20" name="user_name" required
								oninvalid="this.setCustomValidity('이름을 입력해주세요.')" oninput="this.setCustomValidity('')">
						</td>
					</tr>
					<tr height="30">
						<td width="80">
							이메일
						</td>
						<td>
							<input type="text" size="20" name="user_email" id="user_email">
						</td>
					</tr>
					<td>
						지역선택
					</td>
					<td>
						<!-- ========================================================================= -->
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
						<!-- ========================================================================= -->
					</td>
					</tr>
					<tr height="30">
						<td colspan="3">
							<input type="submit" value="등록">
						</td>
					</tr>
				</table>
			</form>
		</body>

		</html>

		<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
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
		</script>
		<script type="text/javascript">
			$(document).ready(function () {
				// 아이디 중복 체크
				$("#user_id_check").on("click", function () {
					var id = $("input[name='user_id']").val();
					if (id == "") {
						alert("아이디를 입력하세요!");
						return;
					}
					var userid = id.trim();


					// 아이디 4자 이상
					if (userid.length < 4) {
						alert("아이디는 4자 이상 입력해야 합니다.");
						return false;
					}
					$.ajax({
						type: "post",
						url: "user_id_check",
						data: { user_id: id },
						success: function (result) {
							if (result == "ok") {
								alert("사용 가능한 아이디입니다!");
								$("input[name='user_id']").prop("readonly", true).css({ "background-color": "#d7d7d7" });
							} else {
								alert("이미 사용중인 아이디입니다!");
							}
						},
						error: function () {
							alert("서버 에러!");
						}
					});
				});

				// 비번과 비번확인 비교
				$("#user_password, #user_password_check").on("input", function () {
					var pw = $("#user_password").val();
					var pw_check = $("#user_password_check").val();
					var msg = $("#pw_match_msg");

					if (pw_check.length === 0) {
						msg.text("");
						return;
					}

					if (pw === pw_check) {
						msg.text("비밀번호가 일치합니다.").css({ "color": "green" });
					} else {
						msg.text("비밀번호가 일치하지 않습니다.").css({ "color": "red" });
					}
				});

				// 비번과 비번확인 보이게하기
				$("#pw_toggle").on("click", function (e) {
					e.preventDefault();

					var pw = $("#user_password");

					if (pw.attr("type") === "password") {
						pw.attr("type", "text");
					} else {
						pw.attr("type", "password");
					}
				});

				$("#pw_check_toggle").on("click", function (e) {
					e.preventDefault();

					var pw_check = $("#user_password_check");

					if (pw_check.attr("type") === "password") {
						pw_check.attr("type", "text");
					} else {
						pw_check.attr("type", "password");
					}
				});

				// 아이디 중복 체크 후 비밀번호와 비밀번호 확인 비교 후 폼 제출
				$("form").on("submit", function (e) {
					var pw = $("#user_password").val();
					var pw_check = $("#user_password_check").val();

					if ($("input[name='user_id']").prop("readonly") !== true) {
						alert("아이디 중복체크를 해주세요.");
						e.preventDefault();
						return;
					}

					if (pw !== pw_check) {
						alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
						e.preventDefault();
					}
				});

				// 사는 지역 선택 옵션
				// 도 선택 후 시 목록 불러오기
				$("#area_ctpy_cd").on("change", function () {
					console.log("선택함");
					var province = $(this).val();
					console.log(province);

					if (province) {
						$.ajax({
							type: "get",
							url: "province_of_city",
							data: { area_ctpy_cd: province },
							success: function (cites) {
								console.log("@# cites => ", cites);
								$("#area_sgg_cd").empty().append("<option value=''>시 선택</option>");

								$.each(cites, function (index, city) {
									// 수정된 부분!
									$("#area_sgg_cd").append("<option value='" + city.area_sgg_cd + "'>" + city.area_sgg_nm + "</option>");
								});
							},
							error: function () {
								alert("서버 에러!");
							}
						});
					} else {
						$("#area_sgg_cd").empty().append("<option value=''>시 선택</option>");
					}
				});



				// 시 선택 후 읍면동 목록 불러오기
				$("#area_sgg_cd").on("change", function () {
					var cityCode = $(this).val();

					if (cityCode) {
						$.ajax({
							type: "get",
							url: "province_of_town",
							data: { area_sgg_cd: cityCode },
							success: function (towns) {
								$("#area_emd_cd").empty().append("<option value=''>읍면동 선택</option>");

								$.each(towns, function (index, town) {
									console.log("town 객체 확인: ", town);  // 각 객체 내용 출력
									console.log("읍면동 이름: ", town.area_emd_nm);  // 필드가 제대로 있는지 확인
									$("#area_emd_cd").append("<option value='" + town.area_emd_cd + "'>" + town.area_emd_nm + "</option>");
								});
							},
							error: function () {
								alert("서버 에러!");
							}
						});
					} else {
						$("#area_emd_cd").empty().append("<option value=''>읍면동 선택</option>");
					}
				});

				// 지역 선택 초기화 버튼
				$("#province_select_cancel").on("click", function (e) {
					e.preventDefault();
					$("#area_ctpy_cd").find("option[value='select']").prop("selected", true);
					$("#area_sgg_cd").empty().append("<option value=''>지역먼저 선택해주세요</option>");
					$("#area_emd_cd").empty().append("<option value=''>지역먼저 선택해주세요</option>");
				});
			});
			function validateForm() {
				var userid = document.getElementById("user_id").value.trim()
				var password = document.getElementById("user_password").value.trim()
				var email = document.getElementById("user_email").value.trim()
				var province = document.getElementById("area_ctpy_cd").value.trim()
				var city = document.getElementById("area_sgg_cd").value.trim()
				var town = document.getElementById("area_emd_cd").value.trim()

				// 아이디 4자 이상
				if (userid.length < 4) {
					alert("아이디는 4자 이상 입력해야 합니다.");
					return false;
				}

				// 비밀번호 6자 이상
				if (password.length < 6) {
					alert("비밀번호는 6자 이상 입력해야 합니다.");
					return false;
				}

				// 이메일 형식 체크
				var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
				if (!emailPattern.test(email)) {
					alert("올바른 이메일 형식을 입력하세요.");
					return false;
				}

				// 도, 시, 읍면동 선택 체크
				if (province === 'select' || city === '' || town === '') {
					alert("도/시/읍면동을 모두 선택해야 합니다.");
					return false;
				}

				return true;
			}
		</script>