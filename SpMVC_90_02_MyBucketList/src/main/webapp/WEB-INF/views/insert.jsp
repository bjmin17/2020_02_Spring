<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>나의 홈페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script>
	$(function(){
		
		$(".btn-insert").click(function(){
			let b_name = $("#bucketlistname").val()
			
			if(b_name == "") {
				alert("할 일은 반드시 입력해야 합니다.")
				$("#bucketlistname").focus()
				return false
			}
			
			$("form").submit()
		})
		
		$(".btn-list").click(function(){
			document.location.href="${rootPath}/"
		})
	})
</script>
<style>
	
	body {
		width:90%;
		margin: auto;
	}
	@media screen and (max-width: 768px) {
		body{
			width: 90%;
			margin: auto;
		}
		.btn-group{
			display: block;
			text-align: right;
		}
	
	}
</style>
</head>
<header class="jumbotron">
	<h1>나의 버킷리스트</h1>
	<p> 꼭 한 번쯤은 해 보고 싶은 것</p>
</header>
<body>
	<fieldset>
		<legend>버킷리스트 작성</legend>
		<form method="POST">
			<div class="form-group">
				<label for="bucketlistname">할일:</label> <input type="text"
					value="${bVO.bucketlistname}" name="bucketlistname"
					class="form-control" id="bucketlistname">
			</div>
			<div class="form-group">
				<label for="bucketlistsdate">시작날짜:</label> <input type="date"
					value="${bVO.bucketlistsdate}" name="bucketlistsdate"
					class="form-control" id="bucketlistsdate">
			</div>
			<div class="form-group">
				<label for="bucketlistdeadline">마감기한:</label> <input type="date"
					value="${bVO.bucketlistdeadline}" name="bucketlistdeadline"
					class="form-control" id="bucketlistdeadline">
			</div>
			<div class="form-group">
				<label for="bucketlistachivedate">달성일:</label> <input type="date"
					value="${bVO.bucketlistachivedate}" name="bucketlistachivedate"
					class="form-control" id="bucketlistachivedate">
			</div>
			<c:if test="${BODY == 'UPDATE' }">
				<input type="hidden" name="checked" value="${bVO.checked}" >
			</c:if>
			<div class="btn-group" align="center">
				<button type="button" class="btn btn-outline-primary btn-insert">저장</button>
				<button type="button" class="btn btn-outline-success btn-list center">목록</button>
			</div>
		</form>
	</fieldset>
</body>
</html>