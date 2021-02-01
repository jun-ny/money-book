<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css" rel="stylesheet">
	<title>HOME</title>
</head>
<body>
<div align=center>

<a href="/" class="display-3"><img
		src="/resources/image/moneybook_logo.png"
		style=" width:20%; display: block; padding-bottom: 20px;padding-top: 20px;"></a>

	<c:choose>
		<c:when test="${not empty sessionScope.loginId }">
		
		
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">${sessionScope.loginId }의 가계부</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor03" aria-controls="navbarColor03" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarColor03">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="/">Home
          <span class="sr-only">(current)</span>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">예비1</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">예비2</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">예비3</a>
      </li>	
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <a href="/account/logout" class="btn btn-secondary my-2 my-sm-0" type="submit">Logout</a>
    </form>
  </div>
</nav>
	
					
	
		</c:when>
		
		<c:otherwise>
		
					<a href="/account/joinForm" class="btn btn-primary" role="button">회원가입</a>
		
					<a href="/account/loginForm" class="btn btn-success" role="button">로그인</a>
		
		
		</c:otherwise>
	</c:choose>
	</div>

</body>
</html>
