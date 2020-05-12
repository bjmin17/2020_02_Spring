<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file ="/WEB-INF/views/include/include-head.jspf" %>
<script>
		$(function(){
			$("input").prop("readonly",true)
			
			
			$(document).on("click",".btn_update",function(){
				let pass = $("#password").val()
				if(pass == "") {
					alert("수정하려면 비밀번호를 입력한 후 \n"
							+"다시 수정하기 버튼을 클릭하세요")
					$("div.password").css("display","block")
					$("#password").prop("readonly",false)
					$("#password").focus()
					return false
				}
				/* 보낼 데이터가 하나 뿐이라면 data뒤에 JSON 쓰지 않고 data값 하나만 넘겨줘도 된다.*/
				if(pass != "") {
					
					let token = $()
					
					$.ajax({
						url : '${rootPath}/user/password',
						method : 'POST',
						data : {
							password:pass,
							"${_csrf.parameterName}" : "${_csrf.token}"
						},
						success : function(result) {
							if(result == "PASS_OK") {
								alert("비밀번호 일치")
								$("input").prop("readonly",false)
								$("input").css("color","blue")
								$("button#btn_save").prop("disabled",false)
								//$("button.btn_save").prop("disabled",false)
								$("button#btn_update").prop("disabled",true)
								//$("button.btn_update").prop("disabled",true)
							} else {
								alert("비밀번호가 일치하지 않습니다")
							}
						}, 
						error : function() {
							$("#password").focus()
							alert("서버 통신 오류")
						}
					})
				}
				
			})
			
		})
	</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
	<div class="container" style="margin-top:30px">
		<div class="w3-card-4">
		
		<div class="w3-container w3-green">
		  <h2>${userVO.username}의 MYPAGE</h2>
		</div>
		<hr/>
		
		<form:form class="w3-container" modelAttribute="userVO">
	
			<div class="paswword-div">
					<div class="password">
						<div class="input-group mb-3 input-group-sm">
							<div class="input-group-prepend">
								<span class="input-group-text">비밀번호</span>
							</div>
							<input type="password" id="password" class="form-control " placeholder="비밀번호를 입력!!">
						</div>
					</div>
				</div>
				<p>
			<label>아이디 : ${userVO.username}</label>
			<input type="hidden" name="username" value="${userVO.username}">
			<p>
			<label>이메일</label>
			<input type="email" name="email" class="w3-input" placeholder="이메일" value="${userVO.email}">
			
			<label>전화번호</label>
			<input type="text" name="phone"  class="w3-input" placeholder="전화번호"  value="${userVO.phone}">
			
			<label>주소</label>
			<input type="text" name="address"  class="w3-input" placeholder="주소" value="${userVO.address}">
		
			<button class="w3-button w3-white w3-border w3-border-blue w3-round-large btn_update mt-3" type="button">수정하기</button>
			<button class="w3-button w3-white w3-border w3-border-green w3-round-large btn_save mt-3">저장</button>
		</form:form>
	
		</div>
	</div>
</body>
</html>