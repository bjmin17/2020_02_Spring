<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<%@ include file="/WEB-INF/views/include/include-head.jspf" %>
	<script>
	$(function(){
		
	})
	</script>
	<style>
	table.table tr:nth-child(4) th, table.table tr:nth-child(4) td {
		
		height: 400px;
	}
	table.table tr:nth-child(4) td{
		overflow-y:scroll;
		
	}
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-header.jspf" %>
	<section class="container-fluid">
		<fieldset>
			<h2>게시글 상세보기</h2>
			<table class="table">
				<tr>
					<th>작성자</th><td>${BBS.b_writer}</td>
				</tr>
				<tr>
					<th>작성일시</th><td>${BBS.b_date_time}</td>
				</tr>
				<tr>
					<th>제목</th><td>${BBS.b_subject}</td>
				</tr>
				<tr>
					<th>내용</th><td>${BBS.b_content}</td>
				</tr>
				
			</table>
			
			<div class="d-flex justify-content-end">
				<a href="${rootPath}/"><button type="button" class="btn btn-success">목록으로</button></a>
			</div>
		</fieldset>
	</section>
</body>
</html>


