<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css"
	integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"
	referrerpolicy="no-referrer"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<script>
	$(document).ready(function(){
		
		// 패스워드 일치 여부
		let pwOk = false;
		// 이메일 중복 여부 // 중복이 아닐 때에 OK
		let emailOk = true;
		// 닉네임 중복 여부 // 중복이 아닐 때에 OK
		let nickNameOk = true;
		const oldEmail = $("#emailInput1").val();
		const oldNickName = $("#nickNameInput1").val();
		
		// 비밀번호 일치 확인
		
		$("#passwordInput1, #passwordInput2").keyup(function(){
			const pw1 = $("#passwordInput1").val();
			const pw2 = $("#passwordInput2").val();
			
			if(pw1 === pw2){
				$("#passwordCheckText").text("비밀번호가 일치합니다.");
				pwOk = true;
			} else{
				$("#passwordCheckText").text("비밀번호가 일치하지 않습니다.");
				pwOk = false;
			}
			
			isConditionFullfilled();
		});
		
		// 이메일, 닉네임 수정시 버튼 활성화
		
		$("#emailInput1").keyup(function(){
			const newEmail = $("#emailInput1").val();
			
			if( oldEmail === newEmail ){
				$("#emailCheckButton1").attr("disabled","");
				$("#emailCheckText").text("");
			} else{
				$("#emailCheckButton1").removeAttr("disabled");
			}
		});
		
		$("#nickNameInput1").keyup(function(){
			const newNickName = $("#nickNameInput1").val();
			
			if(oldNickName === newNickName){
				$("#nickNameCheckButton1").attr("disabled","");
				$("#nickNameCheckText").text("");
			} else{				
				$("#nickNameCheckButton1").removeAttr("disabled");				
			}
		});
		
		
		// 중복확인 버튼 클릭시 ajax요청
		$("#emailCheckButton1").click(function(e){
			e.preventDefault();
			
			emailOk = false;
			
			const data = {email : $("#emailInput1").val()};
			$.ajax({
				url: "${appRoot}/member/check2",
				type: "get",
				data: data,
				success: function(data){
					switch(data){
					case "ok":
						$("#emailCheckText").text("사용할 수 있는 이메일 입니다");
						emailOk = true;
						break;
					case "notOk":
						$("#emailCheckText").text("이미 사용 중인 이메일 입니다");
						break;
					}
				},
				error: function(){
					console.log("이메일 중복확인 중 문제발생");
				},
				complete: function(){
					console.log("이메일 중복확인 완료");
					isConditionFullfilled();
				}
			});
		});
		
		$("#nickNameCheckButton1").click(function(e){
			e.preventDefault();
			
			nickNameOk = false;
			
			const data = {nickName : $("#nickNameInput1").val()};
			$.ajax({
				url: "${appRoot}/member/check2",
				type: "get",
				data: data,
				success: function(data){
					switch(data){
					case "ok":
						$("#nickNameCheckText").text("사용 가능한 닉네임 입니다.");
						nickNameOk = true;
						break;
					case "notOk":
						$("#nickNameCheckText").text("이미 사용중인 닉네임 입니다.");
						break;
					}
				},
				error: function(){
					console.log("닉네임 중복확인 중 문제 발생");
				},
				complete: function(){
					console.log("닉네임 중복확인 완료");
					isConditionFullfilled();
				}
			});
		});
		
		
		// 비밀번호 일치 여부, 이메일과 닉네임 중복 여부 확인 function
		const isConditionFullfilled = function(){
			if(pwOk && emailOk && nickNameOk){
				$("#modifyButton1").removeAttr("disabled");
			} else{
				$("#modifyButton1").attr("disabled", "");
			}
		}
		
		// 초기화면 수정버튼 활성화
		isConditionFullfilled();
		
		// 수정 submit 버튼 ("#modifySubmitButton2") 클릭시
		$("#modifySubmitButton2").click(function(e){
			e.preventDefault();
			const form2 = $("#form2");
			
			// input 값 옮기기
			form2.find("[name=password]").val($("#passwordInput1").val());
			form2.find("[name=email]").val($("#emailInput1").val());
			form2.find("[name=nickName]").val($("#nickNameInput1").val());
			
			//submit
			form2.submit();
		});
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<my:navBar></my:navBar>
	
	<div>
		<p>${message }</p>
	</div>
	
	<div>
		아이디: <input type="text" value="${member.id }" readonly /> <br /> 
		암호:<input id="passwordInput1" type="text" value="" />
		<br /> 
		암호확인: <input id="passwordInput2" type="text" value="" /> <br />
		<p id="passwordCheckText"></p>
		이메일: <input id="emailInput1" type="text" value="${member.email }" />
		<button id="emailCheckButton1" type="button" disabled>이메일중복확인</button>
		<p id="emailCheckText"></p>
		<br /> 닉네임: <input id="nickNameInput1" type="text"
			value="${member.nickName }" />
		<button id="nickNameCheckButton1" type="button" disabled>닉네임중복확인</button>
		<p id="nickNameCheckText"></p>
		<br /> 가입일시: <input type="text" value="${member.inserted }" readonly />
		<br />
	</div>

	<%--
	1. 이메일 input 변경 발생시 '이메일중복확인버튼 활성화' -> 버튼 클릭시 ajax로 요청/응답, 적절한 메시지 출력
	2. 닉네임 input 변경 발생시 '닉네임중복확인버튼 활성화' -> 버튼 클릭시 ajax로 요청/응답, 적절한 메시지 출력
	3. 암호/암호확인일치, 이메일 중복확인 완료, 닉네임 중복확인 완료시에만 수정버튼 활성화
	 --%>

	<div>
		<button id="modifyButton1" data-bs-toggle="modal" data-bs-target="#modal2" disabled >수정</button>
		<button data-bs-toggle="modal" data-bs-target="#modal1">삭제</button>
	</div>

	<!-- Modal 탈퇴 -->
	<div class="modal fade" id="modal1" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form1" action="${appRoot }/member/remove" method="post">
						<input type="hidden" value="${member.id }" name="id" /> 암호 : <input
							type="text" name="password" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button form="form1" type="submit" class="btn btn-danger">탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- Modal 수정-->
	<div class="modal fade" id="modal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="form2" action="${appRoot }/member/modify" method="post">
						<input type="hidden" value="${member.id }" name="id" />
						<input type="hidden" name="password" />
						<input type="hidden" name="email" />
						<input type="hidden" name="nickName" /> 
						기존 암호 : <input type="text" name="oldPassword" />
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
					<button id="modifySubmitButton2" form="form2" type="submit" class="btn btn-danger">수정</button>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>