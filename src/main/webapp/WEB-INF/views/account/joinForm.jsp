<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link
	href="https://stackpath.bootstrapcdn.com/bootswatch/4.5.2/cosmo/bootstrap.min.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript" src="/resources/jquery-3.4.1.js"></script>
<script type="text/javascript">
	function checkForm() {

		var account_id = document.getElementById("account_id").value;
		var account_pw = document.getElementById("account_pw").value;
		var account_pw_check = document.getElementById("account_pw_check").value;
		var checkResult = document.getElementById("checkResult").value;

		if (account_id.length == 0) {
			alert("아이디를 입력해주세요.");
			return false;
		} else if (account_id.length<5 || account_id.length>10) {
			alert("아이디는 5~10글자롤 입력해주세요.");
			return false;
		}

		if (checkResult == 0) {
			alert("아이디 중복검사를 해주세요.");
			return false;
		}

		if (account_pw.length == 0) {
			alert("비밀번호를 입력해주세요.");
			return false;
		} else if (account_pw.length<5 || account_pw.length>10) {
			alert("비밀번호는 5~10글자롤 입력해주세요.");
			return false;
		} else if (account_pw != account_pw_check) {
			alert("동일한 비밀번호를 입력해주세요.");
			return false;
		}

		return true;

	}

	function idCheck() {

		var account_id = document.getElementById("account_id").value;
		var txt = "사용가능한 아이디 입니다.\n" + "해당 아이디로 사용하시겠습니까.";

		if (account_id.length == 0) {
			alert("아이디를 입력해주세요.");
			return;
		} else if (account_id.length<5 || account_id.length>10) {
			alert("아이디는 5~10글자롤 입력해주세요.");
			return;
		}

		$.ajax({
			url : "/account/idCheck",
			type : "get",
			data : {
				account_id : account_id
			},
			success : function(data) {
				if (data == 0) {
					if (confirm(txt)) {
						$("#checkResult").val("1");
						$("#checkSuccess").hide();
						$("#account_id").attr("readonly", true);
					}
				} else {
					alert("사용중인 아이디입니다.");
				}
			},
			erorr : function(e) {
				console.log(e);
			}
		});

	}
</script>
</head>
<body>
	<div align=center>

		<a href="/" class="display-3"><img
			src="/resources/image/moneybook_logo.png"
			style="width: 20%; display: block; padding-bottom: 20px; padding-top: 20px;"></a>
		<input type="hidden" id="checkResult" value="0">


		<div class="card bg-light mb-3"
			style="max-width: 50%; padding-top: 20px; padding-bottom: 20px;">
			<form action="/account/join" method="post"
				onsubmit="return checkForm();">

				<table>
					<tr>

						<td><input type="text" name="account_id" id="account_id"
							placeholder="아이디"></td>
					</tr>
					<tr>

						<td><input type="password" name="account_pw" id="account_pw"
							placeholder="비밀번호"></td>
					</tr>
					<tr>

						<td><input type="password" id="account_pw_check"
							placeholder="비밀번호 확인"></td>
					</tr>

				</table>
				<span id="checkSuccess">
					<button type="button" onclick="idCheck();" class="btn btn-success"
						style="height: 30px; padding-top: 0px; padding-bottom: 0px; margin-top: 10px;">중복검사</button>
				</span> <input type="submit" class="btn btn-primary" role="button"
					style="height: 30px; padding-top: 0px; padding-bottom: 0px; margin-top: 10px;"
					value="가입하기">

			</form>
		</div>
	</div>

</body>
</html>