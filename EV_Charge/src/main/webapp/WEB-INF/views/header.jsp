<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Header</title>
    <!-- Bootstrap CDN (선택) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<!-- 헤더 바 -->
<nav class="navbar navbar-expand-lg navbar-light bg-light px-4">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/main">EV충전소</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/main">홈</a></li>
            <li class="nav-item"><a class="nav-link" href="favorites">즐겨찾기</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/notice">공지사항</a></li>
        </ul>
        
        <!-- 검색창 -->
        <form class="d-flex me-3" action="${pageContext.request.contextPath}/search" method="get">
            <input class="form-control me-2" name="query" type="search" placeholder="검색어 입력">
            <button class="btn btn-outline-success" type="submit">검색</button>
        </form>

        <!-- 로그인/회원가입 or 마이페이지/로그아웃 -->
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span>${sessionScope.user.user_name}님 환영합니다.</span>
                <a href="mypage" class="btn btn-outline-secondary me-2">마이페이지</a>
                <a href="logout" class="btn btn-danger">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="login"><button>로그인</button></a>
        <a href="registe"><button>회원가입</button></a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

</body>
</html>