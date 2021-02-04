<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>graph</title>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">
function pieGraphOut(){
	var arr;
	
	$.ajax({
		url:"/moneybook/pieGraphOut"
		,type:"get"
		,dataType:'json'
		,async: false
		,success:function(data){
			console.log(data);
			arr = data;
		}
		,erorr:function(e){
			console.log(e);
		}
	});

	return arr;	
}


$(function () {
	var arr = pieGraphOut();
	
	Highcharts.chart('container', {
	    chart: {
	        type: 'pie'
	    },
	    title: {
	        text: 'category별 지출'
	    },

	    exporting: {
	        enabled: false
	    },

	    credits: {
            enabled: false
        },

		//퍼센티지 보이게 하는 부분
	    plotOptions: {
	        series: {
	            dataLabels: {
	                enabled: true,
	                format: '{point.name}: {point.y:.1f}%'
	            }
	        }
	    },

	    //마우스 올렸을 때 부가설명 나오게 하는 부분
	    tooltip: {
	        headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	        pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
	    },
	    
	    series: [
	        {
	            name: "Categories",
	            colorByPoint: true,
	            data: arr
	        }
	    ],
	});

	
});
</script>
<style type="text/css">
.highcharts-figure, .highcharts-data-table table {
    min-width: 320px; 
    max-width: 660px;
    margin: 1em auto;
}

.highcharts-data-table table {
	font-family: Verdana, sans-serif;
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
	<figure class="highcharts-figure">
    	<div id="container"></div>
	</figure>
</body>
</html>