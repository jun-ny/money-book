<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<meta charset="UTF-8">
<title>graph</title>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript" src="/resources/js/moneybookPie.js"></script>
<script type="text/javascript"></script>
<style type="text/css">

#font1{
        font-family: 'Yeon Sung', cursive;
        color: green;
        font-size:large;
      }

.con {
	float: left;
	width: 50%;
	padding: 5px;
}

.align::after {
	content: "";
	clear: both;
	display: table;
}

.highcharts-figure, .highcharts-data-table table {

    min-width: 320px; 
    max-width: 660px;
    margin: 1em auto;
}

.highcharts-data-table table {

	border-collapse: collapse;
	border: 1px solid #EBEBEB;
	margin: 10px auto;
	text-align: center;
	width: 100%;
	max-width: 500px;
}
.highcharts-data-table caption {

    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
.highcharts-data-table th {
	font-weight: 600;
    padding: 0.5em;
}
.highcharts-data-table td, .highcharts-data-table th, .highcharts-data-table caption {
    padding: 0.5em;
}
.highcharts-data-table thead tr, .highcharts-data-table tr:nth-child(even) {
    background: #f8f8f8;
}
.highcharts-data-table tr:hover {
    background: #f1f7ff;
}
</style>
</head>
<body>
	<input type="hidden" value="${currentMonth }" id="currentMonth">
	<input type="hidden" value="${month }" id="month">
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

					<li class="nav-item"><a class="nav-link"
						href="/moneybook/moneybookList">가계부</a></li>

					<li class="nav-item"><a class="nav-link" href="/moneybook/moneybookCalendar">달력</a></li>

					<li class="nav-item active"><a class="nav-link" href="/moneybook/moneybookColumn">통계</a></li>
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
	
		<div class="jumbotron" id=font1 style="background-color: white">
			
			<span id="monthChange"></span>
			<button class="btn btn-success" onclick="moneybookColumn();">년도 별 수입/지출</button>
			<div class="align">
			<figure class="highcharts-figure">

		   <!--  <div class="con" id="emptyBook2"></div> -->
		    	<div class="con" id="container1"></div>
		   <!--  	<div class="con" id="emptyBook1"></div> -->
		    	<div class="con" id="container2"></div>
	
			</figure>
			</div>
		</div>
	</div>
</body>
</html>