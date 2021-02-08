<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');

     var calendar = new FullCalendar.Calendar(calendarEl, {

     });

     var inMoneybook = getCalendarDataIn();
	     $.each(inMoneybook, function(index, item){
	      calendar.addEvent( item );
     });
	     
     var outMoneybook = getCalendarDataOut();
	     $.each(outMoneybook, function(index, item){
	      calendar.addEvent( item );
     });

     calendar.render();
 });

function getCalendarDataIn(){
    var arr;
    
    $.ajax({
        contentType:'application/json',
        dataType:'json',
        url:'/moneybook/selectInMoneybook',
        type:'post',
        async: false,
        success:function(data){
			console.log(data);
        	arr = data;
        },
        error:function(){
            alert('저장 중 에러가 발생했습니다. 다시 시도해 주세요.');
        }
    });
    
    return arr;
}

function getCalendarDataOut(){
    var arr;
    
    $.ajax({
        contentType:'application/json',
        dataType:'json',
        url:'/moneybook/selectOutMoneybook',
        type:'post',
        async: false,
        success:function(data){
			console.log(data);
        	arr = data;
        },
        error:function(){
            alert('저장 중 에러가 발생했습니다. 다시 시도해 주세요.');
        }
    });
    
    return arr;
}
</script>
<style type="text/css">
#calendar{
		margin:0 auto;
		width: 800px;
		color: black;
		height: 600px;
	}
</style>
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

					<li class="nav-item"><a class="nav-link"
						href="/moneybook/moneybookList">가계부</a></li>

					<li class="nav-item active"><a class="nav-link" href="/moneybook/moneybookCalendar">달력</a></li>

					<li class="nav-item"><a class="nav-link" href="/moneybook/moneybookColumn">통계</a></li>
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
			</div>
				<div class="jumbotron" style="background-color: white">
	<div id='calendar'></div>
	</div>
</body>
</html>