<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<meta charset="UTF-8">
<script type="text/javascript">
$(function () {
		Highcharts.chart('container', {
		    data: {
		        table: 'datatable'
		    },
		    chart: {
		        type: 'column'
		    },
		    title: {
		        text: '년도별 수입/지출'
		    },
		    
		    exporting: {
		        enabled: false
		    },

		    credits: {
	            enabled: false
	        },
		    
		    yAxis: {
		        allowDecimals: false,
		        title: {
		            text: '원'
		        }
		    },
		    tooltip: {
		        formatter: function () {
		            return '<b>' + this.series.name + '</b><br/>' +
		                this.point.y + ' ' + this.point.name.toLowerCase();
		        }
		    }
		});
	});

function moneybookPie(){
	location.href = "/moneybook/moneybookPie";
}
</script>
<style type="text/css">
#container {
    height: 400px;
}

.highcharts-figure, .highcharts-data-table table {
    min-width: 310px;
    max-width: 800px;
    margin: 1em auto;
}

#datatable {
    font-family: Verdana, sans-serif;
    border-collapse: collapse;
    border: 1px solid #EBEBEB;
    margin: 10px auto;
    text-align: center;
    width: 100%;
    max-width: 500px;
}
#datatable caption {
    padding: 1em 0;
    font-size: 1.2em;
    color: #555;
}
#datatable th {
	font-weight: 600;
    padding: 0.5em;
}
#datatable td, #datatable th, #datatable caption {
    padding: 0.5em;
}
#datatable thead tr, #datatable tr:nth-child(even) {
    background: #f8f8f8;
}
#datatable tr:hover {
    background: #f1f7ff;
}

 #font1{
        font-family: 'Yeon Sung', cursive;
        font-size:large;
      }
</style>
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css"
	rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<div align=center>
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
							<li class="nav-item"><a class="nav-link" href="/">Home
									<span class="sr-only">(current)</span>
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

	<figure class="highcharts-figure">
	<button id="font1" class="btn btn-success" onclick="moneybookPie();">카테고리 별</button>
    <div id="container"></div>
    <table id="datatable">
        <thead>
            <tr>
                <th></th>
                <th>${in }</th>
                <th>${out }</th>
            </tr>
        </thead>
    	<c:forEach items="${list }" var="list">
	        <tbody>
	            <tr>
	                <th>${list.period }</th>
	                <td>${list.inAmount }</td>
	                <td>${list.outAmount }</td>
	            </tr>
	        </tbody>
        </c:forEach>
    </table>
</figure>
</div>

</body>
</html>