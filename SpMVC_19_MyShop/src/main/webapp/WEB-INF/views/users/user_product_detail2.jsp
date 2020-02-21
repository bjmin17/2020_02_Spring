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
<style>
	div.product_detail {
		display: flex;
		justify-content: center;
	}
	
	div.product_detail div.product_detail_form{
		border: 1px solid black;
		width: 400px;
		height: 600px;
	
	}
	
	
	
	
	/* 여기는 카드 폼 */
	div.product_detail div.card{
		text-align: center;
		width: 400px;
		height: 600px;
		
	}

	div.product_detail div.card-header, 
	div.product_detail div.card-footer{
		font-size: 40px;
		font-weight: bold;
	}
	
	/* 여기까지 카드 폼 */

	
	div.product_detail div.product_image{
		border:1px solid black;
		width: 600px;
		height: 600px;
		background-color: #ccc;
	
	}
	
	div.product_detail div.product_detail_info{
		font-size: 40px;
	}
	
	
	div.product_detail p#product_price {
		font-size: 40px;
		font-weight: bold;
	}
	
	div.product_detail_info, div.product_detail_info_body{
		margin:12px 20px;
	}
	
	
	div.product_detail div.product_detail_info_body{
		height: 300px;
		border-top: 1px solid gray;
		border-bottom: 1px solid gray;
	}
	div.product_detail div.product_detail_form div.user_button{
 		margin: 120px 10px 0px 0px;
	}
	
	div.product_detail div.user_button {
		text-align: right;
	}
	
	div.product_detail div.user_button button.item-cart{
		border: 1px solid black;
		width: 140px;
		height: 60px;
	}
	
	div.product_detail div.user_button button.item-purchase{
		border: 1px solid transparent;
		background-color: #007bff;
		color:white;
		width: 140px;
		height: 60px;
	}
	
	
</style>
<div class="product_detail">
	<div class="product_image">
		<p>상품 이미지
		<p>${productVO.p_detail}
	</div>
	<div class="product_detail_form">
		<div class="product_detail_info">
			<span>${productVO.p_name}</span>
		</div>
		
		<div class="product_detail_info_body">
			<div class="container">
				<p id="product_price">판매 가격 : ${productVO.p_oprice}</p>
				<div class="dropdown ">
				  <button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">택배 - 500만원 이상 무료배송</button>
				  <div class="dropdown-menu">
				    <a class="dropdown-item" href="#">추가배송비 제주도 300,000원/기타도서 70,000원</a>
				    <a class="dropdown-item" href="#">묶음배송 가능</a>
				  </div>
				</div>
			</div>
		</div>
	
		<div class="user_button">
			<button class="item-cart">장바구니</button>
			<button class="item-purchase">구매하기</button>
		</div>
	</div>

</div>