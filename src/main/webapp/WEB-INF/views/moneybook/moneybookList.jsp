<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css"
	rel="stylesheet">

<style>
  #font1{
        font-family: 'Yeon Sung', cursive;
        color: green;
        font-size:large;
      }
      #font2{
        font-family: 'Indie Flower', cursive;
      }
      
        table {
    width: 100%;
    border-top: 1px solid #3fb618;
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #3fb618;
    padding: 10px;
  }
</style>


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

	function selectBeforeMoneybook(){
	    var arr;
	    var period = $("#period").val();
	    
	    $.ajax({
	        contentType:'application/json',
	        dataType:'json',
	        url:'/moneybook/selectBeforeMoneybook',
	        type:'get',
	        data:{
				period : period
		    },
	        async: false,
	        success:function(resp){
				console.log(resp);
	        	arr = resp;
	        }
	    });
	    
	    return arr;
	}

	function selectBeforeMoneybookDate(){
	    var arr;
	    var period = $("#period").val();
	    
	    $.ajax({
	        contentType:'application/json',
	        dataType:'json',
	        url:'/moneybook/selectBeforeMoneybookDate',
	        type:'get',
	        data:{
				period : period
		    },
	        async: false,
	        success:function(resp){
				console.log(resp);
	        	arr = resp;
	        }
	    });
	    
	    return arr;
	}

	$(function(){

		var flag = true;
		var list = selectBeforeMoneybook();
		var dateList = selectBeforeMoneybookDate();
	    var i = 3; //처음에 보여주는 갯수
	    var j = 5; //i-j는 보여주고 싶은 갯수
	    var rowitem="";

		//3개면 스크롤 할 필요가 없으므로 false 즉, 3개 이상부터 스크롤 기능 활성화
	    if(dateList.length<4){
			flag = false;
		}

	    console.log(Math.ceil($(window).scrollTop() + $(window).height())+"="+$(document).height());

		//스크롤이 변경될때 마다 이벤트 발생시킴    
	    $(window).scroll(function() {
			//스크롤 창의 끝(scrollTop) == 문서 높이(document) - 브라우저창높이(window)
	        if (Math.ceil($(window).scrollTop() + $(window).height()) == $(document).height()) {
		        if(flag){
					for(; i<j ; i++){
						var date = dateList[i];

						rowitem += 	'<tr style="background-color: #d1f5b4">';
				        rowitem += 		'<th colspan="3" style="text-align: center;">'+date+'</th>';
		                rowitem += 	'</tr>';

		                for(var k=0 ; k<list.length ; k++){
							if(date==list[k].moneybook_date){
								rowitem +=  '<tr style="background-color: #edffe080">'
								rowitem +=  	'<td>'+list[k].moneybook_memo+'</td>'
								rowitem +=  	'<td>'+list[k].moneybook_amount+'</td>'
								rowitem +=  	'<td>'+list[k].moneybook_type+'</td>'
								rowitem +=  '</tr>'
							}
			            }

						//i가 리스트의 길이-1과 똑같다는 것은 더 이상 리스트가 없다는 뜻이므로 반복문 종료
		                if(dateList.length-1 == i){
							flag = false;
							break;
				        }
					}
		        }

		        $("#font1").append(rowitem);
		        //다음에 또 반복문 돌리기 위해서 j 증가
				j += 3;
				//다음 삽입할 코드를 위해 초기화
		        rowitem = "";
		        
			}
	    });
   	});

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

		<div class="jumbotron" style="background-color: #edffe0">
		
		<c:choose>
			<c:when test="${type == 'week' }">
				<select class="custom-select" id="period" style="width:10%; margin-bottom:10px;" onchange="changeMoneybook(this);">
					<option value="week" selected="selected">1주일</option>
					<option value="month">1개월</option>
					<option value="sixMonth">6개월</option>
				</select>
			</c:when>
			
			<c:when test="${type == 'month' }">
				<select class="custom-select" id="period" style="width:10%; margin-bottom:10px;" onchange="changeMoneybook(this);">
					<option value="week">1주일</option>
					<option value="month" selected="selected">1개월</option>
					<option value="sixMonth">6개월</option>
				</select>
				
				
			</c:when>
			
			<c:otherwise>
				<select class="custom-select" id="period" style="width:10%; margin-bottom:10px;" onchange="changeMoneybook(this);">
					<option value="week">1주일</option>
					<option value="month">1개월</option>
					<option value="sixMonth" selected="selected">6개월</option>
				</select>
			</c:otherwise>
		</c:choose>
		
		<div style="margin-bottom:10px">					
			<button class = "btn btn-outline-success" onclick="moneybookList();">일일</button>
			<button class = "btn btn-outline-info" onclick="perWeekMoneybookList();">주별</button>
			<button class = "btn btn-outline-danger" onclick="perMonthMoneybookList();">월별</button>
		</div>
					
		<h2>${cnt } 건의 내역이 있습니다.</h2>
		
		<div>
	
		<div class="card border-success mb-3" style="width:30%; text-align: center; margin-bottom:0px;">
		

		<table id="font1">
			<c:forEach items="${dateList }" var="date">
				<tr style="background-color: #d1f5b4">
					<th colspan="3" style="text-align: center;">${date }</th>
				</tr>
				<c:forEach items="${list }" var="list">
					<c:if test="${date == list.moneybook_date }">
						<tr style="background-color: #edffe080">
							<td>${list.moneybook_memo }</td>
							<td>${list.moneybook_amount }</td>
							<td>${list.moneybook_type }</td>
						</tr>
					</c:if>
				</c:forEach>
			</c:forEach>
		</table>
		
		</div>
	</div> 
 	</div>

	</div>

</body>
</html>