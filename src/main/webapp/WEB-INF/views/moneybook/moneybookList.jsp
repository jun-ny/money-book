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
	function moneybookList(){
		location.href = "/moneybook/moneybookList";
	}

	function perWeekMoneybookList(){
		location.href = "/moneybook/perWeekMoneybookList";
	}

	function perMonthMoneybookList(){
		location.href = "/moneybook/perMonthMoneybookList";
	}

	function changeMoneybook(period){

		if($(period).val() == "week"){
			location.href = "/moneybook/moneybookList";
		}else if($(period).val() == "month"){
			location.href = "/moneybook/monthAgoMoneybook";
		}else{
			location.href = "/moneybook/sixMonthAgoMoneybook";
		}

	}
	var page = 1;  //페이징과 같은 방식이라고 생각하면 된다. 
	 
	$(function(){  //페이지가 로드되면 데이터를 가져오고 page를 증가시킨다.
	     getList(page);
	     page++;
	}); 
	 
	$(window).scroll(function(){   //스크롤이 최하단 으로 내려가면 리스트를 조회하고 page를 증가시킨다.
	     if($(window).scrollTop() >= $(document).height() - $(window).height()){
	          getList(page);
	           page++;   
	     } 
	});

	 <!-- 페이지 이동 스크립트-->
	function pagingFormSubmit(currentPage) {
		var form = document.getElementById('pagingForm');
		var page = document.getElementById('page');
		page.value = currentPage;
		form.submit();
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
		
		<c:choose>
			<c:when test="${type == 'week' }">
				<select class="custom-select" style="width:10%; margin-bottom:10px;" onchange="changeMoneybook(this);">
					<option value="week" selected="selected">1주일</option>
					<option value="month">1개월</option>
					<option value="sixMonth">6개월</option>
				</select>
		<div style="margin-bottom:10px">					
		<button class = "btn btn-outline-success" onclick="moneybookList();">일일</button>
		<button class = "btn btn-outline-info" onclick="perWeekMoneybookList();">주별</button>
		<button class = "btn btn-outline-danger" onclick="perMonthMoneybookList();">월별</button>
		</div>
					<h2>${cnt } 건의 내역이 있습니다.</h2>
			</c:when>
			<c:when test="${type == 'month' }">
				<select class="custom-select" style="width:10%; margin-bottom:10px;" onchange="changeMoneybook(this);">
					<option value="week">1주일</option>
					<option value="month" selected="selected">1개월</option>
					<option value="sixMonth">6개월</option>
				</select>
			</c:when>
			<c:otherwise>
				<select class="custom-select" style="width:10%; margin-bottom:10px;" onchange="changeMoneybook(this);">
					<option value="week">1주일</option>
					<option value="month">1개월</option>
					<option value="sixMonth" selected="selected">6개월</option>
				</select>
			</c:otherwise>
		</c:choose>
		
		<div>
	
		<div class="card border-primary mb-3" style="width:30%; text-align: center; margin-bottom:0px;">
		

		<table border="1"  >
			<c:forEach items="${dateList }" var="date">
				<tr>
					<th colspan="3" style="text-align: center">${date }</th>
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
		
		</div>
<div id=navigator align=center>
	<a href="javascript:pagingFormSubmit(${navi.currentPage - 1})" style="font-size: 30px;">👈🏻️️</a> &nbsp;&nbsp;
<a href="javascript:pagingFormSubmit(${navi.currentPage + 1})" style="font-size: 30px;">👉🏻️</a> 
 	<form id="pagingForm" method="get" action="moneybookList">
<input type="hidden" name="page" id="page" />
</form>
  </div>

	</div>
	</div>
	</div>
	
	

</body>
</html>