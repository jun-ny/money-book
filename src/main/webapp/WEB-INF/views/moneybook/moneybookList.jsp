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
</script>
</head>
<body>
	<h1>[가계부]</h1>
	<table>
		<tr>
			<td>날짜</td>
			<td>내용</td>
			<td>금액</td>
			<td>종류</td>
			<td>분류</td>
		</tr>
		
		<c:forEach items="${list }" var="list">
			<tr>
				<td>${list.moneybook_date }</td>
				<td>${list.moneybook_memo }</td>
				<td>${list.moneybook_amount }</td>
				<td>${list.moneybook_type }</td>
				<td>${list.moneybook_category }</td>
			</tr>
		</c:forEach>
		
	</table>
	
	<button onclick="writeMoneybook();">가계부 작성</button>
	
</body>
</html>