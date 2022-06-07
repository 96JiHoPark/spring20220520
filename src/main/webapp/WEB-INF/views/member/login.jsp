<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" integrity="sha512-GQGU0fMMi238uA+a/bdWJfpUGKUkBdgfFdgBm72SUQ6BeyWjoY/ton0tEjH+OSH9iP4Dfh+7HM0I9f5eR0L/4w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" referrerpolicy="no-referrer"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<title>Insert title here</title>
</head>
<body>
	<my:navBar current="login"></my:navBar>
	
	<div class="row justify-content-center">
		<div class="col-12 col-lg-6">
		
			<h1>로그인</h1>
			<form action="${appRoot }/login" method="post">
				<label for="usernameInput1" class="form-label">
					아이디 
				</label>
				<input class="form-control" id="usernameInput1" type="text" name="username" /> <br />
				<label for="passwordInput1" class="form-label">
					패스워드 
				</label>
				<input class="form-control" id="passwordInput1" type="password" name="password"/> <br />
				
				<div class="form-check">
					<input class="form-check-input" type="checkbox" name="remember-me" id="rememberMeCheck" /> 
					<label for="rememberMeCheck" class="form-check-label">
						자동 로그인
					</label>
					<input type="submit" class="btn btn-primary" value="로그인" />
				</div>
			</form>
			
		</div>
	</div>
</body>
</html>