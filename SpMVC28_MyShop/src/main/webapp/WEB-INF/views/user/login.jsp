<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html>
<html>
<head>
<%@ include file ="/WEB-INF/views/include/include-head.jspf" %>
<script>
	$(function(){
		$("#btn-join").click(function(){
			document.location.href="${rootPath}/user/join"
		})
	})
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/include/include-nav.jspf" %>
<div class="w3-container w3-blue">
  <h2>로그인</h2>
</div>

<form:form action="${rootPath}/login" class="w3-container" method="POST">
  <p>
  <label>ID</label>
  <input id="username" name="username" placeholder="User ID" class="w3-input" type="text"></p>
  <p>
  <label>PASSWORD</label>
  <input id="password" name="password" placeholder="비밀번호" class="w3-input" type="password"></p>
  
  <button>로그인</button>
  <button id="btn-join" type="button">회원가입</button>
</form:form>
</body>
</html>