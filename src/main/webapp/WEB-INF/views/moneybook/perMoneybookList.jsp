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
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">
	function changePerWeekMoneybook(no){
		var no = $(no).val();
		location.href = "/moneybook/perWeekMoneybookList?no="+no;
	}

	function moneybookList(){
		location.href = "/moneybook/moneybookList";
	}

	function perWeekMoneybookList(){
		location.href = "/moneybook/perWeekMoneybookList";
	}

	function perMonthMoneybookList(){
		location.href = "/moneybook/perMonthMoneybookList";
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

					<li class="nav-item"><a class="nav-link" href="/moneybook/moneybookCalendar">달력</a></li>

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
		
		<br>
		
		<span id="changeMonth"></span>
		<div class="card border-primary mb-3" style="width:30%; text-align: center;">
		<table border="1">
			<c:forEach items="${list }" var="list">
				<tr>
					<th colspan="4" style="text-align: center;">${list.period }</th>
				</tr>
				<tr>
					<td>${list.in }</td>
					<td>${list.inAmount }</td>
					<td>${list.out }</td>
					<td>${list.outAmount }</td>
				</tr>
			
			
			</c:forEach>
		</table>
		</div>

		
		<button class = "btn btn-outline-success" onclick="moneybookList();">일일</button>
		<button class = "btn btn-outline-info" onclick="perWeekMoneybookList();">주별</button>
		<button class = "btn btn-outline-danger" onclick="perMonthMoneybookList();">월별</button>
		
	</div>
	</div>	
	
	<input type="hidden" value="${no }" id="no">
	<input type="hidden" value="${month }" id="time">
	<input type="hidden" value="${type }" id="type">
	
	<script type="text/javascript">
		$(function(){
			var type = $("#type").val();

			if(type=="week"){
				var time = $("#time").val();
				var no = $("#no").val();
	
				if(no==0){
					no = time;
				}
	
				var item = "<select class='custom-select' style='width:10%; margin-bottom:10px;' onchange='changePerWeekMoneybook(this)'>";
					
				for(var i = 1 ; i <= time ; i++){
					if(no==i){
						item += "<option value = "+"\'"+i+"\'"+" selected='selected' >"+i+"월</option>";		
					}else{
						item += "<option value = "+"\'"+i+"\'"+">"+i+"월</option>";
					}
				}
				
				item += "</select>";
						
				$("#changeMonth").append(item);
			}
			
		});
	</script>
</body>
</html>