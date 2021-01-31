<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>HOME</title>
</head>
<body>
<h1>가계부</h1>
	<c:choose>
		<c:when test="${not empty sessionScope.loginId }">
		
			<h2>${sessionScope.loginId }님 환영합니다</h2>
		
			<ul>
				<li>
					<a href="">가계부</a>
				</li>
				<li>
					<a href="/account/logout">로그아웃</a>
				</li>
			</ul>
		</c:when>
		
		<c:otherwise>
			<ul>
				<li>
					<a href="/account/joinForm">회원가입</a>
				</li>
				<li>
					<a href="/account/loginForm">로그인</a>
				</li>
			</ul>
		</c:otherwise>
	</c:choose>
</body>
</html>
