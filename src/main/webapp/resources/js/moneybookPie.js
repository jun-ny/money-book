function moneybookColumn(){
	location.href = "/moneybook/moneybookColumn";
}

function pieGraphOut(){
	var arr;
	var month = $("#selMonth").val();
	
	$.ajax({
		url:"/moneybook/pieGraphOut"
		,type:"get"
		,dataType:'json'
		,data:{
			month:month
		}
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
	var month = $("#selMonth").val();
	
	$.ajax({
		url:"/moneybook/pieGraphIn"
		,type:"get"
		,dataType:'json'
		,data:{
			month:month
		}
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

function selectMonth(month){
	var month = $(month).val();
	location.href = "/moneybook/moneybookPie?month="+month;
}


$(function () {
	var currentMonth = $("#currentMonth").val();
	var month = $("#month").val();
	var txt = "";
	
	var item = "<select id='selMonth' onchange='selectMonth(this);'>";

	if(month == 0){
		month = currentMonth;
		txt = month + "월";
	}else if(month == 100){
		txt = "전체"
	}else{
		txt = month + "월";
	}

	
	for(var i = 1 ; i <= currentMonth ; i++){
		if(month==i){
			item += "<option value = "+"\'"+i+"\'"+" selected='selected' >"+i+"월</option>";		
		}else{
			item += "<option value = "+"\'"+i+"\'"+">"+i+"월</option>";
		}
	}

	if(month==100){
		item += "<option value ='100' selected='selected' >"+"전체</option>";
		item += "</select>";
	}else{
		item += "<option value ='100'>"+"전체</option>";
		item += "</select>";
	}
	

	$("#monthChange").append(item);
	
	var arr1 = pieGraphOut();
	var arr2 = pieGraphIn();

	Highcharts.chart('container1', {
	    chart: {
	        type: 'pie'
	    },
	    title: {
	        text: txt+' category별 지출'
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
	            data: arr1
	        }
	    ],
	});
	
	Highcharts.chart('container2', {
	    chart: {
	        type: 'pie'
	    },
	    title: {
	    	text: txt+' category별 수입'
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
	            data: arr2
	        }
	    ],
	});

	if(arr1.length == 0){
		$("#emptyBook1").text("등록된 가계부가 없습니다.");
	}

	if(arr2.length == 0){
		$("#emptyBook2").text("등록된 가계부가 없습니다.");
	}

	
});