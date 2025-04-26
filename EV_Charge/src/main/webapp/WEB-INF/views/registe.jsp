<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
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
					} else {
						alert("이미 사용중인 아이디입니다!");
					}
				}
				,error: function() {
					alert("서버 에러!");
				}
			});
		});
	});
</script>
</head>
<body>
	<form method="post" action="registe_user">
		<table border="1" align="center">
			<tr height="50">
				<td colspan="2">
					<h1>회원 가입 신청</h1>
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					아이디
				</td>
				<td>
					<input type="text" size="20" name="user_id" required oninvalid="this.setCustomValidity('아이디를 입력해주세요.')" oninput="this.setCustomValidity('')"><input type="button" id="user_id_check" value="중복확인">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					비번
				</td>
				<td>
					<input type="password" size="20" name="user_password" required oninvalid="this.setCustomValidity('비밀번호를 입력해주세요.')" oninput="this.setCustomValidity('')">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					비번확인
				</td>
				<td>
					<input type="password" size="20" name="user_password_check" required oninvalid="this.setCustomValidity('비밀번호를 한번 더 입력해주세요.')" oninput="this.setCustomValidity('')">
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
					<input type="text" size="20" name="user_province">
				</td>
			</tr>
			<tr height="30">
				<td width="80">
					시
				</td>
				<td>
					<input type="text" size="20" name="user_city">
				</td>
			</tr>
			<tr height="30">
				<td colspan="2">
					<input type="submit" value="등록">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>