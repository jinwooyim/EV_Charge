<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form method="post" action="registe_user">
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
					<input type="text" size="20" name="user_id" required oninvalid="this.setCustomValidity('아이디를 입력해주세요.')" oninput="this.setCustomValidity('')">
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
					<input type="password" size="20" name="user_password" id="user_password" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput="this.setCustomValidity('')">
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
					<input type="password" size="20" name="user_password_check" id="user_password_check" required oninvalid="this.setCustomValidity('비밀번호를 한번 더 입력해주세요.')" oninput="this.setCustomValidity('')">
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
					<input type="text" size="20" name="user_name" required oninvalid="this.setCustomValidity('이름을 입력해주세요.')" oninput="this.setCustomValidity('')">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					이메일
				</td>
				<td>
					<input type="text" size="20" name="user_email">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					도
				</td>
				<td>
					<!-- 충전소 위치 테이블에서 도 컬럼만 가져오기 -->
					<select name="user_province" id="user_province">
							<option value="select" selected>지역선택</option>
						<c:forEach var="province" items="${erea_province_list}">
							<option value="${province.erea_province}">${province.erea_province}</option>
						</c:forEach>
					</select>
				</td>
				<td>
					<button id="province_select_cancel">지역선택 초기화</button>
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					시
				</td>
				<td>
					<!-- 충전소 위치 테이블에서 도에 맞는 시 컬럼만 가져오기 -->
					<select name="user_city" id="user_city">
						<option value=''>지역먼저 선택해주세요</option>
					</select>
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
<script type="text/javascript">
	$(document).ready(function() {
		// 아이디 중복 체크
		$("#user_id_check").on("click", function() {
			var id=$("input[name='user_id']").val();
			if(id == "") {
				alert("아이디를 입력하세요!");
				return;
			}

			$.ajax({
				 type:"post"
				,url:"user_id_check"
				,data: { user_id: id }
				,success: function(result) {
					if(result == "ok") {
						alert("사용 가능한 아이디입니다!");
						$("input[name='user_id']").prop("readonly", true).css({"background-color":"#d7d7d7"});
					} else {
						alert("이미 사용중인 아이디입니다!");
					}
				}
				,error: function() {
					alert("서버 에러!");
				}
			});
		});

		// 비번과 비번확인 비교
		$("#user_password, #user_password_check").on("input", function(){
			var pw = $("#user_password").val();
			var pw_check = $("#user_password_check").val();
			var msg = $("#pw_match_msg");

			if (pw_check.length === 0) {
				msg.text("");
				return;
			}

			if (pw === pw_check) {
				msg.text("비밀번호가 일치합니다.").css({"color":"green"});
			} else {	
				msg.text("비밀번호가 일치하지 않습니다.").css({"color":"red"});
			}
		});

		// 비번과 비번확인 보이게하기
		$("#pw_toggle").on("click", function (e) {
			e.preventDefault();

			var pw = $("#user_password");

			if (pw.attr("type") === "password") {
				console.log("text로 변경");
				pw.attr("type", "text");
			} else {
				console.log("password로 변경");
				pw.attr("type", "password");
			}
		});

		$("#pw_check_toggle").on("click", function (e) {
			e.preventDefault();

			var pw_check = $("#user_password_check");

			if (pw_check.attr("type") === "password") {
				// console.log("text로 변경");
				pw_check.attr("type", "text");
			} else {
				// console.log("password로 변경");
				pw_check.attr("type", "password");
			}
		});

		// 아이디 중복 체크를 하고 비번과 비번확인이 같을 경우만 폼 넘기기
		$("form").on("submit", function (e) {
			var pw = $("#user_password").val();
			var pw_check = $("#user_password_check").val();

			// 중복체크했는지 확인
			if ($("input[name='user_id']").prop("readonly") !== true) {
				alert("아이디 중복체크를 해주세요.");
				e.preventDefault();
				return;
			}

			// 비번과 비번확인이 같은지 확인
			if (pw !== pw_check) {
				alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
				e.preventDefault();
			}
		});

		// 사는 지역 선택 옵션
		$("#user_province").on("change", function () {
			console.log("선택함");
			var province = $(this).val();
			console.log(province);

			if (province) {
				$.ajax({
					 type: "get"
					,url: "province_of_city"
					,data: { user_province: province }
					,success: function(cites) {
						console.log("@# cites => " + cites);
						$("#user_city").empty().append("<option value=''>시 선택</option>");

						$.each(cites, function(index, city) {
							$("#user_city").append("<option value='" + city.erea_city + "'>" + city.erea_city + "</option>");
						});
					}
					,error: function() {
						alert("서버 에러!");
					}
				});
			} else {
				$("#user_city").empty().append("<option value=''>시 선택</option>");
			}
		});

		// 지역선택 초기화 버튼
		$("#province_select_cancel").on("click", function (e) {
			e.preventDefault();
			$("#user_province").find("option[value='select']").prop("selected", true);
			$("#user_city").empty().append("<option value=''>지역먼저 선택해주세요</option>");
		});

	});
</script>