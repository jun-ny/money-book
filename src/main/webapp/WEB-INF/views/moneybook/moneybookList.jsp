<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css"
	rel="stylesheet">

<meta charset="UTF-8">
<title>가계부</title>
<script type="text/javascript">
	function writeMoneybook(){
		location.href = "/moneybook/writeMoneybookForm";
	}

	function moneybookList(){
		location.href = "/moneybook/moneybookList";
	}

	function monthAgoMoneybook(){
		location.href = "/moneybook/monthAgoMoneybook";
	}

	function sixMonthAgoMoneybook(){
		location.href = "/moneybook/sixMonthAgoMoneybook";
	}
</script>
</head>
<body>
	<div align="center">
		<a href="/" class="display-3"><img
			src="/resources/image/moneybook_logo.png"
			style="width: 20%; display: block; padding-bottom: 20px; padding-top: 20px;"></a>
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<a class="navbar-brand" href="#">${sessionScope.loginId }의 가계부</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarColor03" aria-controls="navbarColor03"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor03">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="/">Home <span
							class="sr-only">(current)</span>
					</a></li>

					<li class="nav-item active"><a class="nav-link"
						href="/moneybook/moneybookList">가계부</a></li>

					<li class="nav-item"><a class="nav-link" href="#">예비2</a></li>

					<li class="nav-item"><a class="nav-link" href="#">예비3</a></li>
				</ul>
				<form class="form-inline my-2 my-lg-0" style="padding-left: 5px;">
					<a href="/moneybook/writeMoneybookForm" class="btn btn-warning my-2 my-sm-0"
						type="submit">가계부 작성</a>
				</form>
				<form class="form-inline my-2 my-lg-0" style="padding-left: 5px;">
					<a href="/account/logout" class="btn btn-secondary my-2 my-sm-0"
						type="submit">로그아웃</a>
				</form>
			</div>
		</nav>

		<div class="jumbotron">
		
		<button onclick="moneybookList();">1주일</button>
		<button onclick="monthAgoMoneybook();">1개월</button>
		<button onclick="sixMonthAgoMoneybook();">6개월</button>
	
		<br>

		<table border="1">
			<c:forEach items="${dateList }" var="date">
				<tr>
					<td colspan="3" style="text-align: center">${date }</td>
				</tr>
				<c:forEach items="${list }" var="list">
					<c:if test="${date == list.moneybook_date }">
						<tr>
							<td>${list.moneybook_memo }</td>
							<td>${list.moneybook_amount }</td>
							<td>${list.moneybook_type }</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:forEach>
		</table>
		<button onclick="writeMoneybook();">가계부 작성</button>
	</div>
	</div>	

</body>
</html>