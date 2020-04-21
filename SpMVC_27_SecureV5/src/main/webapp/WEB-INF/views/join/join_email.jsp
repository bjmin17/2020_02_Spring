<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
<style>
	section.email_body {
		width: 600px;
		margin: 120px auto;
		display: flex;
		flex-flow: column;
		justify-content: center;
		align-items: flex-start;
		border: 1px solid gray;
		border-radius: 5px;
		padding:3px;
	}
	
	span#secret {
		display: none;
	}
	
	
</style>
<script>
$(function(){
	/* input박스는 val로 일반 태그에서는 text로 뽑아낼 수 있다. */
	$(document).on("click","#btn_email_ok",function(){
		let secret_key = $("span#secret").text()
		let secret_value = $("input#email_ok").val()
		if(secret_value == "") {
			alert("인증코드를 입력한 후 인증버튼을 클릭하세요")
			$("input#email_ok").focus()
			return false
		}
		$.ajax({
			url : "${rootPath}/join/email_token_check",
			method : "POST",
			data : {
				"${_csrf.parameterName}" : "${_csrf.token}",
				secret_id : "${username}",
				secret_key : secret_key,
				secret_value : secret_value
			},
			success : function(result) {
				document.location.replace("${rootPath}/user/login")
			},
			error : function(){
				alert("서버 통신 오류")
			}
		})
		
		
	})
	
})

</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
<section class="email_body">
	<div class="container p-3 my-3 bg-dark text-white">
		<h3>Email 인증</h3>
	
	</div>
	<div>회원가입을 완료하려면 Email 인증을 수행해야 합니다.</div>
	<form:form action="${rootPath}/join/join_last" modelAttribute="userVO">
		<div>
			<form:input class="form-control mt-3" type="email" path="email" placeholder="email"/>
		</div>
		<c:choose>
			<c:when test="${JOIN == 'EMAIL_OK'}">
				<button class="btn btn-primary mt-3 mb-3">Email 인증 다시 보내기</button>
				<p>E-mail을 열어서 인증코드를 확인한 후 아래 입력란에 입력하여 인증해주세요.
				<div>
					<span id="secret">${My_Email_Secret}</span>
					<input id="email_ok" class="form-control" placeholder="인증코드 입력">
					<button type="button" id="btn_email_ok"  class="btn btn-primary mt-3 mb-3">인증하기</button>
				</div>			
			</c:when>
			<c:otherwise>
				<button  class="btn btn-primary mt-3 mb-3">인증 Email 보내기</button>	
			</c:otherwise>
		</c:choose>
		
	</form:form>
</section>
</body>
</html>