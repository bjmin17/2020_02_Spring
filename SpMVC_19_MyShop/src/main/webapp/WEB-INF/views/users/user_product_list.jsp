<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<script>
$(function(){
	
	$(".user_tr").click(function(){
	
		let id = $(this).data("id")
		
		document.location.href="${rootPath}/user/product/detail/" + id
		
	})
	
	
	
})
</script>
<div>
	<table class="table table-hover ml-5">
		<tr>
			<th>상품이름</th>
			<th>판매가격</th>
		</tr>
		<c:choose>
			<c:when test="${empty PRO_LIST}">
				<tr>
					<td colspan="2">상품정보가 없습니다.</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="PRO" items="${PRO_LIST}" varStatus="i">
				<tr class="user_tr"
						data-id="${PRO.id}">
					<td><span  class="p_name">${PRO.p_name}</span><span class="badge badge-danger">hot</span></td>
					<td style="font-size: 20px; font-weight: bold;">${PRO.p_oprice}원</td>
				</tr>		
				</c:forEach>	
			</c:otherwise>
		</c:choose>
	</table>
</div>