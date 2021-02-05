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

function pieGraphIn(){
	var arr;
	
	$.ajax({
		url:"/moneybook/pieGraphIn"
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
	
	Highcharts.chart('container1', {
	    chart: {
	        type: 'pie'
	    },
	    title: {
	        text: '전체 category별 지출'
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

$(function () {
	var arr = pieGraphIn();
	
	Highcharts.chart('container2', {
	    chart: {
	        type: 'pie'
	    },
	    title: {
	        text: '전체 category별 수입'
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

</style>
</head>
<body>
	<div id="maincontainer">
    	<div id="container1"></div>
    	<div id="container2"></div>
	</div >
</body>
</html>