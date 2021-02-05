<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>


<link href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/sketchy/bootstrap.min.css" rel="stylesheet">
<meta charset="UTF-8">
<title>가계부 작성</title>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">


	function checkForm(){

		var moneybook_amount = document.getElementById("moneybook_amount").value;
		var moneybook_type = document.getElementById("moneybook_type").value;
		var moneybook_category = document.getElementById("moneybook_category").value;
		var moneybook_memo = document.getElementById("moneybook_memo").value;

		if(moneybook_memo.length == 0){
			alert("메모를 입력해주세요.");
			return false;
		}else if(moneybook_amount.length == 0){
			alert("금액을 입력해주세요.");
			return false;
		}else{
			var txt = "내용 : "+moneybook_memo+"\n"
					+ "금액 : "+moneybook_amount+"\n"
					+ "종류 : "+moneybook_type+"\n"
					+ "분류 : "+moneybook_category+"\n"
					+ "해당 내용으로 작성하시겠습니까?";

			if(confirm(txt)){
				return true;
			}else{
				return false;
			}
		}
	}

	function changeCategory(type){
		var txt = "";
		
		if($(type).val()=="지출"){
			var txt = 	"<span id='changeCategory'>"
				txt += 	"<select class='custom-select' name='moneybook_category' id='moneybook_category' style='font-size:10px; width: 100px;'>"
				txt += 		"<option value='식비'>식비</option>"
				txt += 		"<option value='교통/차량'>교통/차량</option>"
				txt +=		"<option value='문화생활'>문화생활</option>"
				txt +=		"<option value='마트/편의점'>마트/편의점</option>"
				txt +=		"<option value='패션/미용'>패션/미용</option>"
				txt +=		"<option value='생활용품'>생활용품</option>"
				txt += 		"<option value='주거/통신'>주거/통신</option>"
				txt +=		"<option value='건강'>건강</option>"
				txt +=		"<option value='교육'>교육</option>"
				txt +=		"<option value='경조사/회비'>경조사/회비</option>"
				txt +=		"<option value='기타'>기타</option>"
				txt +=	"</select>"
				txt +=	"</span>";
	
				$("#changeCategory").replaceWith(txt);
		}else{
			var txt = 	"<span id='changeCategory'>"
				txt += 	"<select class='custom-select' name='moneybook_category' id='moneybook_category' style='font-size:10px; width: 100px;'>"
				txt += 		"<option value='월급'>월급</option>"
				txt += 		"<option value='부수입'>부수입</option>"
				txt +=		"<option value='용돈'>용돈</option>"
				txt +=		"<option value='상여'>상여</option>"
				txt +=		"<option value='금융소득'>금융소득</option>"
				txt +=		"<option value='기타'>기타</option>"
				txt +=	"</select>"
				txt +=	"</span>";
	
				$("#changeCategory").replaceWith(txt);
		}
		
	}


</script>

</head>

<body>
	<div align=center>
	<a href="/" class="display-3"><img
			src="/resources/image/moneybook_logo.png"
			style="width: 20%; display: block; padding-bottom: 20px; padding-top: 20px;"></a>
	<div class="jumbotron" style="width: 20%;">
	<div class="card border-primary mb-3" style="max-width: 20rem;">
  <div class="card-header" style="padding-bottom: 0px;"><marquee>💸</marquee></div>
  <div class="card-body">
	<form action="/moneybook/writeMoneybook" method="get" onsubmit="return checkForm();">
	
		<table style="margin-bottom:10px">
			<tr>
			<!-- 	<td>내용</td> -->
				<td style="padding-left:5px"><input type="text" name="moneybook_memo" id="moneybook_memo" style="width: 190px" placeholder="내용"></td>
			</tr>
			<tr>
			<!-- 	<td>금액</td> -->
				<td style="padding-left:5px"><input type="text" name="moneybook_amount" id="moneybook_amount" style="width: 190px" placeholder="금액"></td>
			</tr>		
			<tr>
			
			<!-- <td>종류</td> -->
			<td style="float:left; width:50%;">
				<select class="custom-select" onchange="changeCategory(this);" name="moneybook_type" id="moneybook_type" style="font-size:10px; width: 100px;">
					<option value="수입">수입</option>
					<option value="지출">지출</option>
				</select>
			</td>
			
			<!--<td>분류</td> -->
				<td	style="float:right; width:50%;">
					<span id="changeCategory">
						<select class="custom-select" name="moneybook_category" id="moneybook_category" style="font-size:10px; width: 100px;">
							<option value="월급">월급</option>
							<option value="부수입">부수입</option>
							<option value="용돈">용돈</option>
							<option value="상여">상여</option>
							<option value="금융소득">금융소득</option>
							<option value="기타">기타</option>
						</select>
					</span>
				</td>
			</tr>				
		</table>
					<a href="/" class="btn btn-outline-danger" style="height: 36px;" role="button">🔙</a>
					<input class="btn btn-outline-success" type="submit" style="height: 36px;" value="✏️">
	</form>
	
	</div>
	</div>
	</div>
	</div>
	
	
</body>
</html>