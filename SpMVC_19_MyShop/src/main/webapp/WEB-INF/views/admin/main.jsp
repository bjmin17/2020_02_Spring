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
.in-errors {
	color:red;
	font-size: 8px;
}
/*
	col-md-7 col-12
	해상도가 768보다 크면 7칸만 차지하고
	그 이하이면 12칸을 차지하여 풀 width로 보여라

*/

tr,td,th {
	white-space: nowrap;
}

.list-body {
	overflow: auto;
}

.p_name {
	display:inline-block;
	width: 150px;
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

header.jumbotron {
	margin-bottom: 0px;
}

header.jumbotron h2{
	font-weight: bold;
}


div.main-body-out{
	background-color: #f4f4f4;
}

section.main-body{
	width: 80%;
	margin: 0 auto;
	background-color: white;
}

</style>
</head>
<body>
	<header class="jumbotron">
		<h2>마트 관리자 페이지</h2>
	
	</header>
	<nav class="navbar navbar-expand-sm bg-primary navbar-dark">
		<ul class="navbar-nav">
			<li class="navbar-item">
				<a class="nav-link" href="${rootPath}/user/product/list">Home</a>
			</li>
			<li class="navbar-item">
				<a class="nav-link" href="${rootPath}/admin/product/">상품정보</a>
			</li>
			<li class="navbar-item">
				<a class="nav-link" href="#">품목정보</a>
			</li>
			<li class="navbar-item">
				<a class="nav-link" href="${rootPath}/admin/dept">거래처정보</a>
			</li>
			<li class="navbar-item">
			<form:form action="${rootPath}/logout" name="logout_form">
				<a class="nav-link" onclick="document.logout_form.submit()" href="javascript:void(0)">로그아웃</a>
			</form:form>
			</li>
		</ul>
	</nav>
	<div class="main-body-out">
		<section class="main-body">
			<c:choose>
				<c:when test="${BODY == 'PRODUCT'}">
					<%@ include file="/WEB-INF/views/admin/product.jsp" %>
				</c:when>
				<c:when test="${BODY == 'DEPT'}">
					<%@ include file="/WEB-INF/views/dept/dept.jsp" %>
				</c:when>
				<c:when test="${BODY == 'B2C'}">
					<%@ include file="/WEB-INF/views/users/user_product_list.jsp" %>
				</c:when>
				<c:when test="${BODY == 'B2C_DETAIL'}">
					<%@ include file="/WEB-INF/views/users/user_product_detail.jsp" %>
				</c:when>
				
			</c:choose>
		</section>
	</div>
</body>
</html>