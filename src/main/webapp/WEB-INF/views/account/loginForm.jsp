<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css" rel="stylesheet">

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
<div align="center">
	<a href="/" class="display-3"><img
		src="/resources/image/moneybook_logo.png"
		style="width:20%; display: block; padding-bottom: 20px;padding-top: 20px;"></a>
<div class="card bg-light mb-3" style="max-width: 50%; padding-top: 20px; padding-bottom: 20px; align: center;">
	<form>
	<table>
		<tr>

			<td>
				<input type="text" name="account_id" placeholder="아이디" id="account_id">
				<span id="loginFail"></span>
			</td>
		</tr>
		<tr>
			<td>
				<input type="password" name="account_pw" placeholder="비밀번호" id="account_pw">
			</td>
		</tr>
		
	</table>
				<input type="button" onclick="login();" style="margin-top:10px;" class="btn btn-success" value="로그인">
			
		</form>
	</div>
	</div>

</body>
</html>