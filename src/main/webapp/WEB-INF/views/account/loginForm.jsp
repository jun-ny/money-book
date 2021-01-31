<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">
	function login(){

		var account_id = document.getElementById("account_id").value;
		var account_pw = document.getElementById("account_pw").value;

		if(account_id.length==0){
			alert("아이디를 입력해주세요.");
			return;
		}else if(account_id.length<5 || account_id.length>10){
			alert("5~10글자로 입력해주세요.");
			return;
		}
		
		if(account_pw.length==0){
			alert("비밀번호를 입력해주세요.");
			return;
		}else if(account_pw.length<5 || account_pw.length>10){
			alert("5~10글자로 입력해주세요.");
			return;
		}

		$.ajax({
			url:"/account/login"
			,type:"post"
			,data:{
				account_id:account_id
				,account_pw:account_pw
			}
			,success:function(data){
				if(data==1){
					window.location.href = "/";
				}else{
					$("#loginFail").text("없는 아이디이거나 비밀번호가 틀렸습니다.");
				}
			}
			,erorr:function(e){
				console.log(e);
			}
		});

	}
</script>
<style type="text/css">
	#loginFail{
		color:red
	}
</style>
</head>
<body>
	<h1>[로그인]</h1>

	<table>
		<tr>
			<td>로그인</td>
			<td>
				<input type="text" name="account_id" id="account_id">
				<span id="loginFail"></span>
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="account_pw" id="account_pw">
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" onclick="login();" value="회원가입">
			</td>
		</tr>
	</table>

</body>
</html>