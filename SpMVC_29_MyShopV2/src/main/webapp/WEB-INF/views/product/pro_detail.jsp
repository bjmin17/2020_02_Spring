<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/include/include-head.jspf"%>
<style>
#body {
	height: 1000px;
}

form{
	width:100%;
}

section {
	width:100%;
	display: flex;
	border:1px solid red;
}

article {
	flex: 1px;
	margin: 5px;
	border: 1px solid blue;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/include/include-nav.jspf"%>

	<section class="container body">
	
		<p>상품 코드 : ${productVO.p_code}
		<p>상품명 : ${productVO.p_name}
		<p>품목코드 : ${productVO.p_bcode}
		<p>주매입처코드 : ${productVO.p_dcode}
		<p>매입가격 : ${productVO.p_iprice}
		<p>판매가격 : ${productVO.p_oprice}
		<p>과세여부 : ${productVO.p_vat}
		<p>대표이미지 : ${productVO.p_file}
		<img width="100px" src="${rootPath}/upload/${productVO.p_file}">
	
	</section>

</body>
</html>