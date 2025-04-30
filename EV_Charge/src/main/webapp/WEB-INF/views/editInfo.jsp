<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <title>회원정보 수정</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
            <script src="${pageContext.request.contextPath}/js/region.js"></script>
        </head>

        <body>
            <div class="container mt-5">
                <h2 class="mb-4">✏️ 회원정보 수정</h2>

                <form action="updateMember" method="post"
                    onsubmit="return validateForm();">
                    <input type="hidden" name="user_no" value="${memberDTO.user_no}" />

                    <div class="mb-3">
                        <label class="form-label">아이디</label>
                        <input type="text" class="form-control" id="user_id" name="user_id" value="${memberDTO.user_id}"
                            readonly style="background-color: #eee;" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="user_password" name="user_password"
                            value="${memberDTO.user_password}" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">비밀번호 확인</label>
                        <input type="password" class="form-control" id="user_password_check" />
                        <div id="pw_match_msg" class="form-text"></div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" class="form-control" name="user_name" value="${memberDTO.user_name}" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" class="form-control" id="user_email" name="user_email"
                            value="${memberDTO.user_email}" />
                    </div>
                    <div class="mb-3">
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
                    </div>
                    <div class="mb-3">
                        <label for="area_sgg_nm">군/구</label>
                        <select id="area_sgg_nm" name="area_sgg_nm" onchange="updatearea_emd_nm()">
                            <option value="">선택하세요</option>
                            <!-- 군/구 옵션이 여기에 동적으로 추가됩니다 -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="area_emd_nm">읍/면/동</label>
                        <select id="area_emd_nm" name="area_emd_nm">
                            <option value="">선택하세요</option>
                            <!-- 읍/면/동 옵션이 여기에 동적으로 추가됩니다 -->
                        </select>
                    </div>

                    <button type="submit" class="btn btn-success">수정 완료</button>
                    <a href="mypage" class="btn btn-secondary">취소</a>
                </form>
            </div>
        </body>
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
        <script>
            $(document).ready(function () {
                // 비밀번호 일치 검사
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
            });
        </script>

        <script>
            function validateForm() {
                var password = document.getElementById("user_password").value.trim();
                var passwordCheck = document.getElementById("user_password_check").value.trim();
                var email = document.getElementById("user_email").value.trim();
                var province = document.getElementById("area_ctpy_cd").value.trim();
                var city = document.getElementById("area_sgg_cd").value.trim();
                var town = document.getElementById("area_emd_cd").value.trim();

                if (password.length < 6) {
                    alert("비밀번호는 6자 이상 입력해야 합니다.");
                    return false;
                }

                if (password !== passwordCheck) {
                    alert("비밀번호가 일치하지 않습니다.");
                    return false;
                }

                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailPattern.test(email)) {
                    alert("올바른 이메일 형식을 입력하세요.");
                    return false;
                }

                if (province === 'select' || city === '' || town === '') {
                    alert("도/시/읍면동을 모두 선택해야 합니다.");
                    return false;
                }

                return true;
            }
        </script>

        </html>