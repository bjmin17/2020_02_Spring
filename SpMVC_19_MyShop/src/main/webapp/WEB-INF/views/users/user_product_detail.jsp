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

<div style="display:flex; justify-content: center;">
	<div class="card" style="text-align:center; width:400px; height: 600px;">
	  <div class="card-header" style="font-size: 40px; font-weight: bold;">${productVO.p_name}</div>
	  <div class="card-body pt-5 pb-5">그 림</div>
	  <div class="card-footer" style="font-size: 40px; font-weight: bold;">판매 가격 : ${productVO.p_oprice}원</div>
		<div class="user_button" style="text-align: right;">
			<button style="border: 1px solid black;">장바구니</button>
			<button style="border: 1px solid transparent; background-color: red; color:white;">구매하기</button>
		</div>
	</div>
</div>