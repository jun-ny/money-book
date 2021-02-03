<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.5.1/main.min.css">
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
	<div id='calendar'></div>
</body>
</html>