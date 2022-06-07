<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script>
	$(document).ready(function(){
		// 중복, 암호 확인 변수
		let idOk = false;
		let pwOk = false;
		let emailOk = false;
		let nickNameOk = false;
		
		// 아이디 중복 체크 버튼 클릭시
		$("#checkIdButton1").click(function(e){
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const idData = {
				id: $("#form1").find("[name=id]").val()		
			};
			
			idOk = false;
			
			$.ajax({
				url: "${appRoot}/member/check",
				type: "get",
				data: idData,
				success: function(data){
					switch(data){
					case "ok":
						$("#idMessage1").text("사용 가능한 아이디 입니다.");
						idOk = true;
						break;
					case "notOk":
						$("#idMessage1").text("사용 불가능한 아이디 입니다.");
						break;
					}
				},
				error: function(){
					$("#idMessage1").text("중복 확인중 문제 발생.");
				},
				complete: function(){
					$("#checkIdButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		$("#checkEmailButton1").click(function(e){
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const emailData = {
				email : $("#form1").find("[name=email]").val()
			}
			
			emailOk = false;
			
			$.ajax({
				url: "${appRoot}/member/check",
				type: "get",
				data: emailData,
				success: function(data){
					switch(data){
					case "ok":
						$("#emailMessage1").text("사용 가능한 이메일입니다.");
						emailOk = true;
						break;
					case "notOk":
						$("#emailMessage1").text("사용 불가능한 이메일입니다.");
						break;
					}
				},
				error: function(){
					$("#emailMessage1").text("이메일 중복확인중 문제 발생.");
				},
				complete: function(){
					$("#checkEmailButton1").removeAttr("disabled");
					enableSubmit();
				}
			});
		});
		
		
		$("#checkNickNameButton1").click(function(e){
			e.preventDefault();
			
			$(this).attr("disabled", "");
			
			const nickNameData = {
				nickName : $("#form1").find("[name=nickName]").val()
			};
			
			nickNameOk = false;
			
			$.ajax({
				url: "${appRoot}/member/check",
				type: "get",
				data: nickNameData,
				success: function(data){
					switch(data){
					case "ok":
						$("#nickNameMessage1").text("사용 가능한 닉네임 입니다.");
						nickNameOk = true;
						break;
					case "notOk":
						$("#nickNameMessage1").text("사용 불가능한 닉네임 입니다.");	
						break;
					}
					
				},
				error: function(){
					$("#nickNameMessage1").text("닉네임 중복확인중 문제 발생");
				},
				complete: function(){
					$("#checkNickNameButton1").removeAttr("disabled");
					enableSubmit();
				}
				
			});
		});
		
		//패스워드 오타 확인
		$("#passwordInput1, #passwordInput2").keyup(function(){
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			pwOk = false;
			
			if(pw1 === pw2){
				$("#passwordMessage1").text("패스워드가 일치합니다.");
				pwOk = true;
			}else{
				$("#passwordMessage1").text("패스워드가 일치하지 않습니다.");
			}
			
			enableSubmit();
		});
		
		// 회원가입 submit 버튼 활성화/비활성화 함수
		const enableSubmit = function(){
			if(idOk && pwOk && emailOk && nickNameOk){
				$("#submitButton1").removeAttr("disabled");
			}else{
				$("#submitButton1").attr("disabled", "");
			}
		}
		
		
	});
</script>
<title>Insert title here</title>

</head>
<body>
	<my:navBar current="signup"></my:navBar>
	
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-12 col-lg-6">
			
				<h1>회원가입</h1>
				
				<form id="form1" action="${appRoot }/member/signup" method="post">
					<label for="idInput1" class="form-label">
						아이디
					</label>
					<div class="input-group">					
						<input id="idInput1" class="form-control" type="text" name="id" />
						<button id="checkIdButton1" class="btn btn-secondary" type="button">아이디 중복 확인</button>
					</div>
					<p class="form-text" id="idMessage1"></p>
					<br />
					
					<label for="passwordInput1" class="form-label">
						패스워드
					</label>
					<input id="passwordInput1" class="form-control" type="password" name="password" /> <br />
					
					<label for="passwordInput2" class="form-label">
						패스워드 확인
					</label>
					<input id="passwordInput2" class="form-control" type="password" name="passwordConfirm" />
					<br />
					<p class="form-text" id="passwordMessage1"></p>
					
					<label for="emailInput1" class="form-label">
						이메일
					</label>
					<div class="input-group">					
						<input id="emailInput1" class="form-control" type="email" name="email" />
						<button id="checkEmailButton1" class="btn btn-secondary" type="button">이메일 중복 확인</button>
					</div>
					<p class="form-text" id="emailMessage1"></p>
					<br />
					
					<label for="nickNameInput1" class="form-label">
						닉네임
					</label>
					<div class="input-group">					
						<input id="nickNameInput1" class="form-control" type="text" name="nickName" />
						<button id="checkNickNameButton1" class="btn btn-secondary" type="button">닉네임 중복 확인</button>
					</div>
					<p class="form-text" id="nickNameMessage1"></p>
					<br />
					
					<button id="submitButton1" class="btn btn-primary" disabled>회원가입</button>
				</form>
				
			</div>
		</div>
	</div>		
				
	
</body>
</html>