<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${rootPath}/resources/css/login.css?ver=202004090953">
<script>
	$(function(){
		$(document).on("click","#btn-join",function(){
			// 유효성검사
			// id, password가 입력되지 않았을 때 경고
			let username = $("#username")
			let password = $("#password")
			let re_password = $("#re_password")
			
			if(username.val() == "") {
				alert("아이디를 입력하세요")
				username.focus()
				return false
			}
			
			if(password.val() == "") {
				alert("비밀번호를 입력하세요")
				password.focus()
				return false
			}
			
			if(re_password.val() == "") {
				alert("비밀번호 확인을 입력하세요")
				re_password.focus()
				return false
			}
			
			if(password.val() != re_password.val()) {
				alert("비밀번호와 비밀번호 확인이 다릅니다")
				password.focus()
				return false
			}
			
			$("form").submit()
			
		})
		
		// 현재 입력박스에서 포커스가 벗어났을 때 발생하는 이벤트
		$(document).on("blur","#username",function(){
			let username = $(this).val()
			if(username == "") {
				$("#m_username").text("아이디는 반드시 입력해야 합니다")
				return false;
			}
			
			$.ajax({
				url : "${rootPath}/user/idcheck",
				method : "GET",
				data : {username : username},
				success : function(result) {
					
					if(result == "USE") {
						$("#m_username").text("* 이미 가입된 사용자 이름입니다.")
						$("#m_username").css("color","red")
						return false
					}
					
				},
				error:function(){
					//alert("서버와 통신 오류")
				}
				
			})
			
		})
		
	})
</script>
</head>
<body>
	<section class="container">
		<style>
			.message {
				font-weight: bold;
				font-size: 0.3rem;
			}
		</style>
		<form:form method="POST" action="${rootPath}/user/join">
			<div class="container p-3 my-3 bg-primary text-white">
				<h2>회원가입</h2>
			</div>
			<!-- 
			<input type="text" name="${_csrf.parameterName}" value="${_csrf.token}">
			-->
			<div class="form-group">
				<label for="username">User ID</label> 
				<input type="text"	class="form-control" id="username" name="username"	placeholder="User ID">
			</div>
			<div class="message" id="m_username"></div>
			<div class="form-group">
				<label for="password">비밀번호</label> 
				<input type="password"	class="form-control" id="password" name="password"	placeholder="비밀번호">
			</div>
			<div class="form-group">
				<label for="re_password">비밀번호 확인</label> 
				<input type="password"	class="form-control" id="re_password" name="re_password"	placeholder="비밀번호 확인">
			</div>
			<div class="mb-3">
				<button type="button" class="btn btn-primary" id="btn-join">회원가입</button>
				<button type="button" class="btn btn-success" id="btn-loss">ID/비밀번호 찾기</button>
			</div>
		</form:form>
	</section>
</body>
</html>