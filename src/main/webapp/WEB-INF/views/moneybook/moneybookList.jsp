<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가계부</title>
<script type="text/javascript">
	function writeMoneybook(){
		location.href = "/moneybook/writeMoneybookForm";
	}

	function moneybookList(){
		location.href = "/moneybook/moneybookList";
	}

	function monthAgoMoneybook(){
		location.href = "/moneybook/monthAgoMoneybook";
	}

	function sixMonthAgoMoneybook(){
		location.href = "/moneybook/sixMonthAgoMoneybook";
	}
</script>
</head>
<body>
	<h1>[가계부]</h1>
	
		<button onclick="moneybookList();">1주일</button>
		
		<button onclick="monthAgoMoneybook();">1개월</button>
		
		<button onclick="sixMonthAgoMoneybook();">6개월</button>
		
		<br>
				
		<table border="1">
			<c:forEach items="${dateList }" var="date">
				<tr>
					<td colspan="3" style="text-align: center">${date }</td>						
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
	<button onclick="writeMoneybook();">가계부 작성</button>
	
</body>
</html>