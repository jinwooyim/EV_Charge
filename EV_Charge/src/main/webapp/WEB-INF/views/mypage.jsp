<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">👤 마이페이지 - 회원 정보</h2>

    <table class="table table-bordered">
        <tr>
            <th>아이디</th>
            <td>${memberDTO.user_id}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${memberDTO.user_name}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${memberDTO.user_email}</td>
        </tr>
        <tr>
            <th>시/도</th>
            <td>${memberDTO.area_ctpy_nm}</td>
        </tr>
        <tr>
            <th>군/구</th>
            <td>${memberDTO.area_sgg_nm}</td>
        </tr>
        <tr>
            <th>읍/면/동</th>
            <td>${memberDTO.area_emd_nm}</td>
        </tr>
    </table>

    <div class="mt-3">
        <a href="editInfo" class="btn btn-primary">회원정보 수정</a>
        <a href="logout" class="btn btn-danger">로그아웃</a>
    </div>
</div>
</body>
</html>