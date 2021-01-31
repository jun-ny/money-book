<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">
	function checkForm(){

		var account_id = document.getElementById("account_id").value;
		var account_pw = document.getElementById("account_pw").value;
		var account_pw_check = document.getElementById("account_pw_check").value;
		var checkResult = document.getElementById("checkResult").value;

		if(account_id.length==0){
			alert("아이디를 입력해주세요.");
			return false;
		}else if(account_id.length<5 || account_id.length>10){
			alert("아이디는 5~10글자롤 입력해주세요.");
			return false;
		}

		if(checkResult==0){
			alert("아이디 중복검사를 해주세요.");
			return false;
		}
		
		if(account_pw.length==0){
			alert("비밀번호를 입력해주세요.");
			return false;
		}else if(account_pw.length<5 || account_pw.length>10){
			alert("비밀번호는 5~10글자롤 입력해주세요.");
			return false;
		}else if(account_pw != account_pw_check){
			alert("동일한 비밀번호를 입력해주세요.");
			return false;
		}

		return true;
		
	}

	function idCheck(){

		var account_id = document.getElementById("account_id").value;
		var txt = "사용가능한 아이디 입니다.\n"
				+ "해당 아이디로 사용하시겠습니까.";
				
		if(account_id.length==0){
			alert("아이디를 입력해주세요.");
			return;
		}else if(account_id.length<5 || account_id.length>10){
			alert("아이디는 5~10글자롤 입력해주세요.");
			return;
		}

		$.ajax({
			url:"/account/idCheck"
			,type:"get"
			,data:{
					account_id:account_id
				}
			,success:function(data){
				if(data==0){
					if(confirm(txt)){
						$("#checkResult").val("1");
						$("#checkSuccess").hide();
						$("#account_id").attr("readonly",true);
					}
				}else{
					alert("사용중인 아이디입니다.");
				}
			}
			,erorr:function(e){
				console.log(e);
			}
		});

	}
</script>
</head>
<body>
	<input type="hidden" id="checkResult" value="0">
	
	<h1>[회원가입]</h1> 
	
	<form action="/account/join" method="post" onsubmit="return checkForm();">
		
		
		<table>
			<tr>
				<td>아이디</td>
				<td>
					<input type="text" name="account_id" id="account_id">
					
					<span id="checkSuccess">
						<button type="button" onclick="idCheck();">중복검사</button>
					</span>
				</td>
			</tr>		
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="account_pw" id="account_pw">
					
				</td>
			</tr>		
			<tr>
				<td>비밀번호 확인</td>
				<td>
					<input type="password" id="account_pw_check">
				</td>
			</tr>		
			<tr>
				<td>
					<input type="submit" value="가입하기">
				</td>
			</tr>		
		</table>
	</form>
</body>
</html>