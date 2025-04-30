<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EV충전소</title>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500;700&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #10b981;
            --primary-dark: #059669;
            --primary-light: #d1fae5;
            --text-color: #1f2937;
            --text-light: #6b7280;
            --white: #ffffff;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-400: #9ca3af;
            --gray-500: #6b7280;
            --gray-600: #4b5563;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --red-500: #ef4444;
            --red-600: #dc2626;
        }
        
        body {
            font-family: 'Noto Sans KR', sans-serif;
            color: var(--text-color);
        }
        
        /* Header Styles */
        .ev-header {
            background-color: var(--white);
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .ev-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 1rem;
        }
        
        .ev-navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            height: 64px;
        }
        
        /* Logo Styles */
        .ev-brand {
            display: flex;
            align-items: center;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 700;
            font-size: 1.25rem;
            transition: color 0.2s;
        }
        
        .ev-brand:hover {
            color: var(--primary-dark);
        }
        
        .ev-brand i {
            font-size: 1.5rem;
            margin-right: 0.5rem;
        }
        
        /* Navigation Styles */
        .ev-nav {
            display: flex;
            align-items: center;
        }
        
        .ev-nav-item {
            display: flex;
            align-items: center;
            padding: 0.5rem 0.75rem;
            color: var(--gray-700);
            text-decoration: none;
            font-size: 0.875rem;
            font-weight: 500;
            border-radius: 0.375rem;
            transition: all 0.2s;
        }
        
        .ev-nav-item:hover {
            color: var(--primary-color);
            background-color: var(--gray-50);
        }
        
        .ev-nav-item i {
            margin-right: 0.5rem;
            font-size: 0.875rem;
        }
        
        /* Search Form Styles */
        .ev-search-form {
            position: relative;
            margin-right: 1rem;
        }
        
        .ev-search-input {
            padding: 0.5rem 0.75rem 0.5rem 2.25rem;
            border: 1px solid var(--gray-300);
            border-radius: 0.375rem;
            background-color: var(--gray-50);
            font-size: 0.875rem;
            transition: all 0.2s;
            width: 200px;
        }
        
        .ev-search-input:focus {
            outline: none;
            border-color: var(--primary-color);
            background-color: var(--white);
            box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        }
        
        .ev-search-icon {
            position: absolute;
            left: 0.75rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray-400);
            font-size: 0.875rem;
        }
        
        .ev-search-button {
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .ev-search-button:hover {
            background-color: var(--primary-dark);
        }
        
        /* User Section Styles */
        .ev-user-section {
            display: flex;
            align-items: center;
        }
        
        .ev-welcome-text {
            margin-right: 1rem;
            font-size: 0.875rem;
            color: var(--gray-700);
        }
        
        .ev-welcome-name {
            color: var(--primary-color);
            font-weight: 500;
        }
        
        /* Button Styles */
        .ev-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-decoration: none;
        }
        
        .ev-btn-ghost {
            background-color: transparent;
            color: var(--gray-700);
            border: 1px solid transparent;
        }
        
        .ev-btn-ghost:hover {
            background-color: var(--gray-100);
            color: var(--gray-900);
        }
        
        .ev-btn-primary {
            background-color: var(--primary-color);
            color: var(--white);
            border: 1px solid transparent;
        }
        
        .ev-btn-primary:hover {
            background-color: var(--primary-dark);
        }
        
        .ev-btn-outline {
            background-color: transparent;
            color: var(--gray-700);
            border: 1px solid var(--gray-300);
        }
        
        .ev-btn-outline:hover {
            border-color: var(--gray-400);
            background-color: var(--gray-50);
        }
        
        .ev-btn-danger {
            background-color: var(--red-500);
            color: var(--white);
            border: 1px solid transparent;
        }
        
        .ev-btn-danger:hover {
            background-color: var(--red-600);
        }
        
        .ev-btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
        }
        
        /* Mobile Menu Styles */
        .ev-mobile-menu-button {
            display: none;
            background: none;
            border: none;
            color: var(--gray-700);
            font-size: 1.25rem;
            cursor: pointer;
            padding: 0.5rem;
        }
        
        .ev-mobile-menu {
            display: none;
            padding: 1rem;
            border-top: 1px solid var(--gray-200);
            background-color: var(--white);
        }
        
        .ev-mobile-nav {
            display: flex;
            flex-direction: column;
            margin-bottom: 1rem;
        }
        
        .ev-mobile-search {
            margin-bottom: 1rem;
        }
        
        /* Avatar Styles */
        .ev-avatar {
            width: 2rem;
            height: 2rem;
            border-radius: 9999px;
            background-color: var(--primary-light);
            color: var(--primary-color);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.875rem;
            overflow: hidden;
        }
        
        .ev-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        /* Dropdown Styles */
        .ev-dropdown {
            position: relative;
        }
        
        .ev-dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            top: calc(100% + 0.5rem);
            background-color: var(--white);
            border-radius: 0.375rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            min-width: 14rem;
            z-index: 1000;
            border: 1px solid var(--gray-200);
            overflow: hidden;
        }
        
        .ev-dropdown-header {
            padding: 0.75rem 1rem;
            border-bottom: 1px solid var(--gray-200);
        }
        
        .ev-dropdown-item {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            color: var(--gray-700);
            text-decoration: none;
            transition: background-color 0.2s;
        }
        
        .ev-dropdown-item:hover {
            background-color: var(--gray-50);
        }
        
        .ev-dropdown-item i {
            margin-right: 0.5rem;
            font-size: 0.875rem;
        }
        
        .ev-dropdown-item.danger {
            color: var(--red-500);
        }
        
        .ev-dropdown-item.danger:hover {
            background-color: rgba(239, 68, 68, 0.05);
        }
        
        .ev-dropdown.active .ev-dropdown-content {
            display: block;
        }
        
        /* Responsive Styles */
        @media (max-width: 768px) {
            .ev-nav, .ev-search-form, .ev-welcome-text {
                display: none;
            }
            
            .ev-mobile-menu-button {
                display: block;
            }
            
            .ev-mobile-menu.active {
                display: block;
            }
            
            .ev-search-input {
                width: 100%;
            }
            
            .ev-mobile-search {
                display: flex;
            }
            
            .ev-mobile-search .ev-search-form {
                display: block;
                flex: 1;
                margin-right: 0.5rem;
            }
        }
    </style>
</head>
<body>

<!-- EV충전소 헤더 -->
<header class="ev-header">
    <div class="ev-container">
        <div class="ev-navbar">
            <!-- 로고 및 브랜드 -->
            <a href="${pageContext.request.contextPath}/main" class="ev-brand">
                <i class="fas fa-charging-station"></i>
                <span>EV충전소</span>
            </a>
            
            <!-- 데스크톱 네비게이션 -->
            <nav class="ev-nav">
                <a href="${pageContext.request.contextPath}/main" class="ev-nav-item">
                    <i class="fas fa-home"></i>홈
                </a>
                <a href="${pageContext.request.contextPath}/favorites" class="ev-nav-item">
                    <i class="fas fa-heart"></i>즐겨찾기
                </a>
                <a href="${pageContext.request.contextPath}/notice" class="ev-nav-item">
                    <i class="fas fa-bell"></i>공지사항
                </a>
            </nav>
            
            <!-- 검색, 로그인, 프로필 섹션 -->
            <div class="ev-user-section">
                <!-- 검색 폼 -->
                <form action="${pageContext.request.contextPath}/search" method="get" class="ev-search-form">
                    <i class="fas fa-search ev-search-icon"></i>
                    <input type="search" name="address" placeholder="충전소 검색" class="ev-search-input">
                    <input type="hidden" name="radiusKm" value="3">
                    <button type="submit" class="ev-search-button">검색</button>
                </form>
                
                <!-- 사용자 인증 -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="ev-welcome-text">
                            <span class="ev-welcome-name">${sessionScope.user.user_name}</span>님 환영합니다
                        </span>
                        <div class="ev-dropdown" id="userDropdown">
                            <button class="ev-btn ev-btn-ghost ev-btn-sm" onclick="toggleDropdown()">
                                <div class="ev-avatar">
                                    <!-- 이미지 제거됨 -->
                                </div>
                            </button>
                            <div class="ev-dropdown-content">
                                <div class="ev-dropdown-header">
                                    <div class="font-medium">${sessionScope.user.user_name}</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/mypage" class="ev-dropdown-item">
                                    <i class="fas fa-user"></i>
                                    <span>마이페이지</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/logout" class="ev-dropdown-item danger">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>로그아웃</span>
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="ev-auth-buttons">
                            <a href="${pageContext.request.contextPath}/login" class="ev-btn ev-btn-ghost ev-btn-sm">로그인</a>
                            <a href="${pageContext.request.contextPath}/registe" class="ev-btn ev-btn-primary ev-btn-sm">회원가입</a>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <!-- 모바일 메뉴 버튼 -->
                <button class="ev-mobile-menu-button" id="mobileMenuButton">
                    <i class="fas fa-bars"></i>
                </button>
            </div>
        </div>
    </div>
    
    <!-- 모바일 메뉴 -->
    <div class="ev-mobile-menu" id="mobileMenu">
        <nav class="ev-mobile-nav">
            <a href="${pageContext.request.contextPath}/main" class="ev-nav-item">
                <i class="fas fa-home"></i>홈
            </a>
            <a href="${pageContext.request.contextPath}/favorites" class="ev-nav-item">
                <i class="fas fa-heart"></i>즐겨찾기
            </a>
            <a href="${pageContext.request.contextPath}/notice" class="ev-nav-item">
                <i class="fas fa-bell"></i>공지사항
            </a>
        </nav>
        
        <!-- 모바일 검색 -->
        <div class="ev-mobile-search">
            <form action="${pageContext.request.contextPath}/evse" method="get" class="d-flex">
                <div class="ev-search-form">
                    <i class="fas fa-search ev-search-icon"></i>
                    <input type="search" name="query" placeholder="충전소 검색" class="ev-search-input">
                </div>
                <button type="submit" class="ev-search-button">검색</button>
            </form>
        </div>
    </div>
</header>

<!-- Bootstrap JS 및 Popper.js -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- 자바스크립트 -->
<script>
    // 모바일 메뉴 토글
    const mobileMenuButton = document.getElementById('mobileMenuButton');
    const mobileMenu = document.getElementById('mobileMenu');
    
    mobileMenuButton.addEventListener('click', function() {
        mobileMenu.classList.toggle('active');
        
        // 아이콘 변경 (메뉴/닫기)
        const icon = mobileMenuButton.querySelector('i');
        if (mobileMenu.classList.contains('active')) {
            icon.classList.remove('fa-bars');
            icon.classList.add('fa-times');
        } else {
            icon.classList.remove('fa-times');
            icon.classList.add('fa-bars');
        }
    });
    
    // 사용자 드롭다운 토글
    function toggleDropdown() {
        const dropdown = document.getElementById('userDropdown');
        dropdown.classList.toggle('active');
    }
    
    // 드롭다운 외부 클릭 시 닫기
    document.addEventListener('click', function(event) {
        const dropdown = document.getElementById('userDropdown');
        const isClickInside = dropdown.contains(event.target);
        
        if (!isClickInside && dropdown.classList.contains('active')) {
            dropdown.classList.remove('active');
        }
    });
</script>

</body>
</html>